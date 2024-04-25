#include "RegAlloc.hpp"
#include "my_stl.hpp"
#include <algorithm>
#include <map>
#include <regex>
using BlockInfo = GraphColor::BlockLiveInfo;
using InterVal = GraphColor::LiveInterval;
void BlockInfo::GetBlockLivein(MachineBasicBlock* block)
{
    for(auto inst = block->getMachineInsts().rbegin();inst != block->getMachineInsts().rend(); ++inst)
    {
      if((*inst)->GetOpcode() == "j")
        continue;
      if((*inst)->GetOpcode() == "ble" || (*inst)->GetOpcode() == "bgt" || (*inst)->GetOpcode() == "beqz")
      {
        Operand val = (*inst)->GetUses()[0];
        if(!val->isConst())
        {
          BlockLivein[block].insert(val); 
          Uses[block].insert(val);
        }
        continue;
      }
      for(Operand val : (*inst)->GetUses())
      {
          if(!val->isConst())
          {
              BlockLivein[block].insert(val); 
              Uses[block].insert(val);
          }
      }
      if(Operand DefValue = (*inst)->GetDef())
      {
          BlockLivein[block].erase(DefValue);
          Uses[block].erase(DefValue);
          Defs[block].insert(DefValue);
      }
   }
}

void BlockInfo::GetBlockLiveout(MachineBasicBlock* block)
{
  for(MachineInst* inst : block->getMachineInsts())
  {
    std::string Opcode = inst->GetOpcode();
    if(Opcode == "j")
    {
      MachineBasicBlock* _block_Succ = F->GetBlock(inst->GetUses()[0]->GetName());
      BlockLiveout[block].insert(BlockLivein[_block_Succ].begin(), BlockLivein[_block_Succ].end());
    }
    else if(Opcode == "ble" || Opcode == "bgt" || Opcode == "beqz")
    {
      MachineBasicBlock* _block_Succ1 = F->GetBlock(inst->GetUses()[1]->GetName());
      BlockLiveout[block].insert(BlockLivein[_block_Succ1].begin(), BlockLivein[_block_Succ1].end());
    }
  }
}

void BlockInfo::RunOnFunction()
{
  for(MachineBasicBlock* _block : F->getMachineBasicBlocks())
  {
    BlockLivein[_block].clear();
    BlockLiveout[_block].clear();
    GetBlockLivein(_block);
    GetBlockLiveout(_block);
  }
  PrintPass();
  iterate(F); 
  while(isChanged)
    iterate(F);
  PrintPass();
}

void BlockInfo::iterate(MachineFunction *func)
{
  RunOnFunc(func);  
  bool isChanged = false;
  for(MachineBasicBlock *_block : func->getMachineBasicBlocks())
  {
    if(!UnChanged[_block])
    {
      isChanged = true;
      break;
    }
  }
}

void BlockInfo::RunOnFunc(MachineFunction *func)
{
  for(auto BB = func->getMachineBasicBlocks().rbegin(); BB != func->getMachineBasicBlocks().rend(); ++BB)
  {
    MachineBasicBlock* _Block = *BB;
    std::set<Value*> old_BlockLivein = BlockLivein[_Block];
    std::set<Value*>old_BlockLiveout = BlockLiveout[_Block];
    GetBlockLiveout(_Block);
    BlockLivein[_Block] = BlockLiveout[_Block];
    GetBlockLivein(_Block);
    if(BlockLivein[_Block] == old_BlockLivein)
      UnChanged[_Block] = true;
    else
      UnChanged[_Block] = false;
  }
}

void GraphColor::CalInstLive(MachineBasicBlock* block)
{
  for(MachineInst* inst : block->getMachineInsts())
  {
    std::set<Value*> Live = blockinfo->BlockLiveout[block];
    for(Operand val : inst->GetUses())
    {
      if(!val->isConst())
      {
        Live.insert(val);
        if(!inst->isVirtual(val))
          Precolored.insert(val);
      }
    }
    if(Operand DefValue = inst->GetDef())
      Live.erase(DefValue);
    blockinfo->InstLive[inst] = Live;
  }
}
void GraphColor::CalcmoveList(MachineBasicBlock* block)
{
  for(MachineInst* inst : block->getMachineInsts())
  {
    std::string Opcode = inst->GetOpcode();
    std::regex mvRegex("mv"); 
    if(std::regex_match(Opcode, mvRegex))
    {
        for (Operand Op : inst->GetUses())
            moveList[Op].insert(inst);
        if(Operand Op = inst->GetDef())
            moveList[Op].insert(inst);
    }
  }
}

void GraphColor::CalcIG(MachineBasicBlock* block)
{
  for(MachineInst* inst : block->getMachineInsts())
  {
    for(Value* Op1 : blockinfo->InstLive[inst])
    {
      for(Value* Op2: blockinfo->InstLive[inst])
      {
        if(Op2 != Op1)
          PushVecSingleVal(IG[Op1], Op2);
      }
    }
  }
}
void BlockInfo::PrintPass()
{
  std::cout << "--------BlockLiveInfo--------" << std::endl;
  for(MachineBasicBlock* _block : F->getMachineBasicBlocks())
  {
    std::cout << "--------Block:"<< _block->get_name() << "--------" << std::endl;
    std::cout << "        Livein" << std::endl;
    for(Value* _value:BlockLivein[_block])
    {
      if(_value->isVirtual())
        std::cout << "%" << _value->GetName() << " ";
      else
        std::cout << _value->GetName() << " ";
    }
    std::cout << std::endl;
    std::cout << "        Liveout" << std::endl;
    for(Value* _value:BlockLiveout[_block])
    {
      if(_value->isVirtual())
        std::cout << "%" << _value->GetName() << " ";
      else
        std::cout << _value->GetName() << " ";
    }
    std::cout << std::endl;
  }
}

void InterVal::init()
{
  int curr = 0;
  for(MachineBasicBlock* block : func->getMachineBasicBlocks())
  {
    for(MachineInst* inst : block->getMachineInsts())
    {
      instNum[inst] = curr;
      curr++;
    }
  }
}

void InterVal::computeLiveIntervals()
{
  for (MachineBasicBlock* block : func->getMachineBasicBlocks())
  {
    std::unordered_map<Operand, std::vector<Interval>> CurrentRegLiveinterval;
    int begin = -1;
    for(MachineInst* inst : block->getMachineInsts())
    {
      int Curr = instNum[inst];
      if(inst == block->getMachineInsts().front())
        begin = instNum[inst];
      for(Operand Op : blockinfo.get()->InstLive[inst])
      {
        if(!CurrentRegLiveinterval.count(Op))
        {
          Interval interval;
          interval.start = Curr;
          interval.end = -1;
          CurrentRegLiveinterval[Op].push_back(interval);
        }
        else
        {
          if(CurrentRegLiveinterval[Op].back().end == -1 && inst == block->getMachineInsts().back())
            CurrentRegLiveinterval[Op].back().end = Curr;
          else if(CurrentRegLiveinterval[Op].back().end != -1 && blockinfo.get()->count(Op, inst))
          {
            Interval interval;
            interval.start = Curr;
            interval.end = -1;
            CurrentRegLiveinterval[Op].push_back(interval);
          }
        }
      }
      for(auto& [Op, intervals] : CurrentRegLiveinterval)
      {
        if(intervals.back().end == -1 && inst == block->getMachineInsts().back())
            CurrentRegLiveinterval[Op].back().end = Curr;
        else if(intervals.back().end == -1 && !blockinfo.get()->count(Op, inst))
            intervals.back().end = Curr - 1;
        else if(intervals.back().end == -1 && blockinfo.get()->count(Op, inst))
            continue;
      }
    }
    if(verify(CurrentRegLiveinterval))
    {
      for(auto& [op, intervals] : CurrentRegLiveinterval)
      {
        auto curr = intervals.begin();
        for(auto iter = intervals.begin(); iter != intervals.end(); ++iter)
        {
          if(iter == curr)
            continue;
          if(curr->start < iter->start)
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

bool InterVal::verify(std::unordered_map<Operand, std::vector<Interval>> Liveinterval)
{
  int num = 0;
  for(auto& [op, intervals] : Liveinterval)
  {
      for(auto& i : intervals)
      {
          if(i.start > i.end)
            return false;
          if(num > i.end)
            return false;
      }
  }
  return true;
}

void InterVal::PrintAnalysis()
{
  std::cout << "--------LiveInterval--------" << std::endl;
  for(MachineBasicBlock* block : func->getMachineBasicBlocks())
  {
    for(MachineInst* inst : block->getMachineInsts())
    {
        std::cout << "inst" << instNum[inst] << "Liveness:";
        for(Operand Op : blockinfo.get()->InstLive[inst])
        {
          if(!Op->isVirtual())
            std::cout << "%" << Op->GetName() << ", ";
          else
            std::cout << Op->GetName() << ", ";
        }
        std::cout<<std::endl;
    }
  }
  for(MachineBasicBlock* block : func->getMachineBasicBlocks())
  {
    std::cout << "--------Block:" << block->get_name() << "--------" << std::endl;
    for(auto& [op, intervals] : RegLiveness[block])
    {
      if(!op->isVirtual())
      std::cout << "% "<< op->GetName() << ":";
      else
        std::cout << op->GetName() << ":";
      for(auto& i : intervals)
        std::cout << "[" << i.start << "," << i.end << "]";
      std::cout << std::endl;
    }
  }
}

void InterVal::RunOnFunc()
{
  blockinfo = std::make_unique<BlockLiveInfo>(func);
  blockinfo->RunOnFunction();
  blockinfo->PrintPass();
  init();
  computeLiveIntervals();
  PrintAnalysis();
}