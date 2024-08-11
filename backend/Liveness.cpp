#include "../include/backend/RISCVMIR.hpp"
#include "../include/backend/RISCVMOperand.hpp"
#include "../include/backend/RISCVRegister.hpp"
#include "../include/backend/Liveness.hpp"
#include "../util/my_stl.hpp"
#include <algorithm>
#include <map>
#include <regex>
#include <set>
using BlockInfo = Liveness;
using InterVal = LiveInterval;
using OpType = RISCVMIR::RISCVISA;

void BlockInfo::RunOnFunction()
{
    for (RISCVBasicBlock *block : *m_func)
    {
        BlockLivein[block].clear();
        BlockLiveout[block].clear();
        GetBlockLivein(block);
        GetBlockLiveout(block);
    }

    bool modified = true;
    while (modified)
    {
        modified = false;
        for (auto block = m_func->rbegin(); block != m_func->rend(); --block)
        {
            RISCVBasicBlock *cur = *block;
            std::unordered_set<MOperand> oldin = BlockLivein[cur];
            GetBlockLiveout(cur);
            BlockLivein[cur] = BlockLiveout[cur];
            GetBlockLivein(cur);
            if (BlockLivein[cur] != oldin)
                modified = true;
        }
    }
}

void BlockInfo::CalCulateSucc(RISCVBasicBlock *block)
{
    for (auto inst = block->rbegin(); inst != block->rend();)
    {
        OpType Opcode = (*inst)->GetOpcode();
        if (Opcode == OpType::_j)
        {
            RISCVBasicBlock *succ = dynamic_cast<RISCVBasicBlock *>((*inst)->GetOperand(0));
            SuccBlocks[block].push_front(succ);
            --inst;
            continue;
        }
        else if (Opcode == OpType::_beq || Opcode == OpType::_bne || Opcode == OpType::_blt || Opcode == OpType::_bge ||
                 Opcode == OpType::_bltu || Opcode == OpType::_bgeu || Opcode == OpType::_bgt || Opcode == OpType::_ble)
        {
            RISCVBasicBlock *succ = dynamic_cast<RISCVBasicBlock *>((*inst)->GetOperand(2));
            SuccBlocks[block].push_front(succ);
            --inst;
            continue;
        }
        else
            return;
    }
}
void BlockInfo::GetBlockLiveout(RISCVBasicBlock *block)
{
    for (RISCVBasicBlock *succ : SuccBlocks[block])
        BlockLiveout[block].insert(BlockLivein[succ].begin(), BlockLivein[succ].end());
}
void BlockInfo::GetBlockLivein(RISCVBasicBlock *block)
{

    for (auto inst = block->rbegin(); inst != block->rend(); --inst)
    {   
        OpType Opcode = (*inst)->GetOpcode();
        if (auto def = (*inst)->GetDef())
        {
            if (auto reg = def->ignoreLA())
            {

                BlockLivein[block].erase(reg);
                if (dynamic_cast<VirRegister *>(reg))
                    initial.insert(reg);
                else if (auto phy = dynamic_cast<PhyRegister *>(reg))
                {
                    Precolored.insert(phy);
                    color[phy] = phy;
                }
            }
        }
        if (Opcode == OpType::_j)
            continue;
        else if (Opcode == OpType::_beq || Opcode == OpType::_bne || Opcode == OpType::_blt || Opcode == OpType::_bge ||
                 Opcode == OpType::_bltu || Opcode == OpType::_bgeu || Opcode == OpType::_bgt ||
                 Opcode == OpType ::_ble)
        {
            if (auto val1 = (*inst)->GetOperand(0)->ignoreLA())
            {
                BlockLivein[block].insert(val1);
                if (dynamic_cast<VirRegister *>(val1))
                    initial.insert(val1);
                else if (auto phy = dynamic_cast<PhyRegister *>(val1))
                {
                    Precolored.insert(phy);
                    color[phy] = phy;
                }
            }
            if (auto val2 = (*inst)->GetOperand(1)->ignoreLA())
            {
                BlockLivein[block].insert(val2);
                if (dynamic_cast<VirRegister *>(val2))
                    initial.insert(val2);
                else if (auto phy = dynamic_cast<PhyRegister *>(val2))
                {
                    Precolored.insert(phy);
                    color[phy] = phy;
                }
            }
        }
        else if (Opcode == OpType::ret)
        {
            if ((*inst)->GetOperandSize() != 0)
            {
                auto phy = (*inst)->GetOperand(0)->as<PhyRegister>();
                assert(phy != nullptr &&
                       (phy->Getregenum() == PhyRegister::a0 || phy->Getregenum() == PhyRegister::fa0));
                BlockLivein[block].insert(phy);
                color[phy] = phy;
                Precolored.insert(phy);
            }
        }
        else
        {
            if(Opcode == OpType::call)
            {
                for(auto reg : reglist.GetReglistCaller())
                {
                    Precolored.insert(reg);
                    color[reg]=reg;
                }
            }
            for (int i = 0; i < (*inst)->GetOperandSize(); i++)
            {
                if ((*inst)->GetOperand(i))
                {
                    if(auto reg = (*inst)->GetOperand(i)->ignoreLA())
                    {
                        BlockLivein[block].insert(reg);
                        if (dynamic_cast<VirRegister *>(reg))
                            initial.insert(reg);
                        else if (auto phy = dynamic_cast<PhyRegister *>(reg))
                        {
                            Precolored.insert(phy);
                            color[phy] = phy;
                        }
                    }
                }
            }
        }
    }
}

void BlockInfo::Build()
{
    for (RISCVBasicBlock *block : *m_func)
    {
        std::unordered_set<MOperand> live = BlockLiveout[block];
        for (auto inst_ = block->rbegin(); inst_ != block->rend();)
        {
            RISCVMIR *inst = *inst_;
            OpType op = inst->GetOpcode();
                        if (op == OpType::mv || op == OpType::_fmv_s)
            {
                if (auto val = inst->GetOperand(0)->ignoreLA())
                {
                    live.erase(val);
                    if(!NotMove.count(inst))
                        moveList[val].insert(inst);
                }
                if (auto def = inst->GetDef()->ignoreLA())
                {
                    if(!NotMove.count(inst))
                        moveList[def].insert(inst);
                }
                if(!NotMove.count(inst))
                    worklistMoves.push_back(inst);
            }
            else if (op == OpType::call)
            {
                // for (auto reg : reglist.GetReglistCaller())
                // {
                //     for (auto v : live)
                //         AddEdge(reg, v);
                // }
                for (auto reg : reglist.GetReglistCaller())
                    live.insert(reg);
                for (auto reg : reglist.GetReglistCaller())
                {
                    for (auto v : live)
                        AddEdge(reg, v);
                }
                for (auto reg : reglist.GetReglistCaller())
                    live.erase(reg);
            }
            if (auto def_val = inst->GetDef())
            {
                if(auto def = def_val->ignoreLA())
                {
                live.insert(def);
                for (auto v : live)
                    AddEdge(def, v);
                live.erase(def);
                }
            }
            for (int i = 0; i < inst->GetOperandSize(); i++)
            {
                if (auto val = inst->GetOperand(i)->ignoreLA())
                    live.insert(val);
            }
            InstLive[inst] = live;
            --inst_;
        }
    }
}
void BlockInfo::PrintEdge()
{
    for (auto &[key, val] : adjSet)
    {
        std::cout << "--------%" << key->GetName() << " Edge --------" << std::endl;
        int count = 0;
        for (auto v : val)
        {
            if (dynamic_cast<VirRegister *>(v))
                std::cout << "%" << v->GetName() << " ";
        }
        std::cout << std::endl;
    }
}
void BlockInfo::AddEdge(Register *u, Register *v)
{
    if (u == v)
        return;
    if (adjSet[u].count(v))
        return;
    adjSet[v].insert(u);
    adjSet[u].insert(v);
    if (Precolored.find(v) == Precolored.end())
    {
        AdjList[v].insert(u);
        Degree[v]++;
    }
    if (Precolored.find(u) == Precolored.end())
    {
        AdjList[u].insert(v);
        Degree[u]++;
    }
}

void BlockInfo::PrintPass()
{
    std::cout << "--------BlockLiveInfo--------" << std::endl;
    for (RISCVBasicBlock *_block : *m_func)
    {
        std::cout << "--------Block:" << _block->GetName() << "--------" << std::endl;
        std::cout << "        Livein" << std::endl;
        for (RISCVMOperand *_value : BlockLivein[_block])
        {
            if (dynamic_cast<VirRegister *>(_value))
                _value->print();
            else
                _value->print();
            std::cout << " ";
        }
        std::cout << std::endl;
        std::cout << "        Liveout" << std::endl;
        for (RISCVMOperand *_value : BlockLiveout[_block])
        {
            if (dynamic_cast<VirRegister *>(_value))
                _value->print();
            else
                _value->print();
            std::cout << " ";
        }
        std::cout << std::endl;
    }
}
void InterVal::init()
{
    int curr = 0;
    for (RISCVBasicBlock *block : *func)
    {
        for (RISCVMIR *inst : *block)
        {
            instNum[inst] = curr;
            curr++;
        }
    }
}

void InterVal::computeLiveIntervals()

{
    for (RISCVBasicBlock *block : *func)
    {
        std::unordered_map<MOperand, std::vector<Interval>> CurrentRegLiveinterval;
        int begin = -1;
        for (RISCVMIR *inst : *block)
        {
            int Curr = instNum[inst];
            if (inst == block->front())
                begin = instNum[inst];
            for (MOperand Op : InstLive[inst])
            {
                if (!CurrentRegLiveinterval.count(Op))
                {
                    Interval interval;
                    interval.start = Curr;
                    interval.end = -1;
                    CurrentRegLiveinterval[Op].push_back(interval);
                }
                else
                {
                    if (CurrentRegLiveinterval[Op].back().end == -1 && inst == block->back())
                        CurrentRegLiveinterval[Op].back().end = Curr;
                    else if (CurrentRegLiveinterval[Op].back().end != -1 && count(Op, inst))
                    {
                        Interval interval;
                        interval.start = Curr;
                        interval.end = -1;
                        CurrentRegLiveinterval[Op].push_back(interval);
                    }
                }
            }
            for (auto &[Op, intervals] : CurrentRegLiveinterval)
            {
                if (intervals.back().end == -1 && inst == block->back() && !count(Op, inst))
                    CurrentRegLiveinterval[Op].back().end = Curr - 1;
                else if (intervals.back().end == -1 && inst == block->back())
                    CurrentRegLiveinterval[Op].back().end = Curr;
                else if (intervals.back().end == -1 && !count(Op, inst))
                    intervals.back().end = Curr - 1;
                else if (intervals.back().end == -1 && count(Op, inst))
                    continue;
            }
        }
        if (verify(CurrentRegLiveinterval))
        {
            for (auto &[op, intervals] : CurrentRegLiveinterval)
            {
                auto curr = intervals.begin();
                for (auto iter = intervals.begin(); iter != intervals.end(); ++iter)
                {
                    if (iter == curr)
                        continue;
                    if (curr->start < iter->start)
                    {
                        ++curr;
                        *curr = *iter;
                    }
                    else
                        curr->end = std::max(curr->end, iter->end);
                }
                intervals.erase(std::next(curr), intervals.end());
            }
            RegLiveness[block] = CurrentRegLiveinterval;
        }
    }
}

bool InterVal::verify(std::unordered_map<MOperand, std::vector<Interval>> Liveinterval)
{
    int num = 0;
    for (auto &[op, intervals] : Liveinterval)
    {
        for (auto &i : intervals)
        {
            if (i.start > i.end)
                return false;
            if (num > i.end)
                return false;
        }
    }
    return true;
}

// void InterVal::PrintAnalysis()
// {
//   std::cerr << "--------LiveInterval--------" << std::endl;
//   for(RISCVBasicBlock* block : *func)
//   {
//     for(RISCVMIR* inst : *block)
//     {
//         std::cerr << "inst" << instNum[inst] << "Liveness:";
//         for(RISCVMOperand* Op : blockinfo.get()->InstLive[inst])
//         {
//           if(dynamic_cast<VirRegister*>(Op))
//             Op->print();
//           else
//             Op->print();
//         }
//         std::cerr<<std::endl;
//     }
//   }
//   for(RISCVBasicBlock* block : *func)
//   {
//     std::cerr << "--------Block:" << block->GetName() << "--------" <<
//     std::endl; for(auto& [op, intervals] : RegLiveness[block])
//     {
//       if(dynamic_cast<VirRegister*>(op))
//       op->print();
//       else
//         op->print();
//       for(auto& i : intervals)
//         std::cerr << "[" << i.start << "," << i.end << "]";
//       std::cerr << std::endl;
//     }
//   }
// }

void InterVal::PrintAnalysis()
{
    std::cout << "--------InstLive--------" << std::endl;
    for (RISCVBasicBlock *block : *func)
    {
        std::cout << "-----Block " << block->GetName() << "-----" << std::endl;
        for (RISCVMIR *inst : *block)
        {
            std::cout << "inst" << instNum[inst] << "Liveness:";
            for (RISCVMOperand *Op : InstLive[inst])
            {
                if (dynamic_cast<VirRegister *>(Op))
                    Op->print();
                else
                    Op->print();
            }
            std::cout << std::endl;
        }
    }
    for (RISCVBasicBlock *block : *func)
    {
        std::cout << "--------LiveInterval--------" << std::endl;
        std::cout << "--------Block:" << block->GetName() << "--------" << std::endl;
        for (auto &[op, intervals] : RegLiveness[block])
        {
            if (dynamic_cast<VirRegister *>(op))
                op->print();
            else
                op->print();
            for (auto &i : intervals)
                std::cout << "[" << i.start << "," << i.end << "]";
            std::cout << std::endl;
        }
    }
}
void InterVal::RunOnFunc_()
{
    init();
    computeLiveIntervals();
}