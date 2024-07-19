#include "../include/backend/RISCVMIR.hpp"
#include "../include/backend/RISCVMOperand.hpp"
#include "../include/backend/RISCVRegister.hpp"
#include "../include/backend/RegAlloc.hpp"
#include "../util/my_stl.hpp"
#include <algorithm>
#include <map>
#include <regex>
#include <set>
using BlockInfo = BlockLiveInfo;
using InterVal = LiveInterval;
using OpType = RISCVMIR::RISCVISA;

void BlockInfo::RunOnFunction() {
  for (RISCVBasicBlock *block : *m_func) {
    BlockLivein[block].clear();
    BlockLiveout[block].clear();
    GetBlockLivein(block);
    GetBlockLiveout(block);
  }
  bool modified = true;
  while (modified) {
    modified = false;
    for (auto block = m_func->rbegin(); block != m_func->rend(); --block) {
      RISCVBasicBlock *cur = *block;
      std::set<MOperand> oldin = BlockLivein[cur];
      GetBlockLiveout(cur);
      BlockLivein[cur] = BlockLiveout[cur];
      GetBlockLivein(cur);
      if (BlockLivein[cur] != oldin)
        modified = true;
    }
  }
}

void BlockInfo::GetBlockLiveout(RISCVBasicBlock *block) {
  for (RISCVMIR *inst : *block) {
    OpType Opcode = inst->GetOpcode();
    if (Opcode == OpType::_j) {
      RISCVBasicBlock *succ =
          dynamic_cast<RISCVBasicBlock *>(inst->GetOperand(0));
      BlockLiveout[block].insert(BlockLivein[succ].begin(),
                                 BlockLivein[succ].end());
      SuccBlocks[block].push_front(succ);
    } else if (Opcode == OpType::_beq || Opcode == OpType::_bne ||
               Opcode == OpType::_blt || Opcode == OpType::_bge ||
               Opcode == OpType::_bltu || Opcode == OpType::_bgeu ||
               Opcode == OpType::_bgt || Opcode == OpType::_ble) {
      RISCVBasicBlock *succ =
          dynamic_cast<RISCVBasicBlock *>(inst->GetOperand(2));
      BlockLiveout[block].insert(BlockLivein[succ].begin(),
                                 BlockLivein[succ].end());
      SuccBlocks[block].push_front(succ);
    }
  }
}
void BlockInfo::GetBlockLivein(RISCVBasicBlock *block) {
  for (auto inst = block->rbegin(); inst != block->rend(); --inst) {
    OpType Opcode = (*inst)->GetOpcode();
    if (auto def = (*inst)->GetDef()) {
      if (auto reg = def->ignoreLA())
        BlockLivein[block].erase(reg);
    }
    if (Opcode == OpType::_j)
      continue;
    else if (Opcode == OpType::_beq || Opcode == OpType::_bne ||
             Opcode == OpType::_blt || Opcode == OpType::_bge ||
             Opcode == OpType::_bltu || Opcode == OpType::_bgeu ||
             Opcode == OpType::_bgt || Opcode == OpType ::_ble) {
      if (auto val1 = (*inst)->GetOperand(0)->ignoreLA())
        BlockLivein[block].insert(val1);
      if (auto val2 = (*inst)->GetOperand(1)->ignoreLA())
        BlockLivein[block].insert(val2);
    } else if (Opcode == OpType::ret) {
      if ((*inst)->GetOperandSize() != 0) {
        RISCVMOperand *val = (*inst)->GetOperand(0);
        if (val->GetType() == RISCVType::riscv_i32) {
          PhyRegister *Phy = PhyRegister::GetPhyReg(PhyRegister::PhyReg::a0);
          BlockLivein[block].insert(Phy);
        } else if (val->GetType() == RISCVType::riscv_float32) {
          PhyRegister *Phy = PhyRegister::GetPhyReg(PhyRegister::PhyReg::fa0);
          BlockLivein[block].insert(Phy);
        }
      }
    } else {
      for (int i = 0; i < (*inst)->GetOperandSize(); i++) {
        if (auto reg = (*inst)->GetOperand(i)->ignoreLA())
          BlockLivein[block].insert(reg);
      }
    }
  }
}

void GraphColor::CalInstLive(RISCVBasicBlock *block) {
  std::set<MOperand> Live = BlockLiveout[block];
  for (auto inst = block->rbegin(); inst != block->rend(); --inst) {
    RISCVMIR *cur = *inst;
    OpType op = cur->GetOpcode();
    if (auto def = cur->GetDef()) {
      auto defreg = def->ignoreLA();
      if (dynamic_cast<VirRegister *>(defreg)) {
        initial.insert(defreg);
      } else if (auto phy = dynamic_cast<PhyRegister *>(defreg)) {
        Precolored.insert(phy);
        color[phy] = phy;
      }
      Live.erase(defreg);
    }
    if (op == OpType::ret) {
      if (cur->GetOperandSize() > 0) {
        Live.insert(static_cast<Register *>(cur->GetOperand(0)));
      } else {
        PhyRegister *Phy = PhyRegister::GetPhyReg(PhyRegister::PhyReg::a0);
        Live.insert(Phy);
      }
    } else if (op == OpType::call) {
      InstLive[cur] = Live;
      for (auto reg : reglist.GetReglistCaller()) {
        Precolored.insert(reg);
        color[reg] = reg;
        Live.erase(reg);
        InstLive[cur].insert(reg);
      }
      for (int i = 0; i < cur->GetOperandSize(); i++) {
        if (auto reg = cur->GetOperand(i)->ignoreLA()) {
          if (auto phy = dynamic_cast<PhyRegister *>(reg)) {
            Precolored.insert(phy);
            color[phy] = phy;
            initial.erase(reg);
          }
          Live.insert(reg);
          InstLive[cur].insert(reg);
        }
      }
      CalcIG(cur);
      continue;
    } else if (op == OpType::mv || op == OpType::_fmv_s) {
      auto reg1 = cur->GetOperand(0)->ignoreLA();
      auto reg2 = cur->GetDef()->ignoreLA();
      if (reg1) {
        if (dynamic_cast<VirRegister *>(reg1))
          initial.insert(reg1);
        else if (auto phy = dynamic_cast<PhyRegister *>(reg1)) {
          Precolored.insert(reg1);
          color[reg1] = phy;
        }
        Live.insert(reg1);
        if (reg2) {
          if (dynamic_cast<VirRegister *>(reg2))
            initial.insert(reg2);
          moveList[reg1].insert(cur);
          moveList[reg2].insert(cur);
          PushVecSingleVal(worklistMoves, cur);
        }
      }
    } else {
      for (int i = 0; i < cur->GetOperandSize(); i++) {
        if (auto reg = cur->GetOperand(i)->ignoreLA()) {
          // if (dynamic_cast<VirRegister *>(reg))
          initial.insert(reg);
          if (auto phy = dynamic_cast<PhyRegister *>(reg)) {
            Precolored.insert(reg);
            color[phy] = phy;
            initial.erase(reg);
          }
          Live.insert(reg);
        }
      }
    }
    InstLive[cur] = Live;
    CalcIG(cur);
  }
}

void GraphColor::CalcIG(RISCVMIR *inst) {
  if (InstLive[inst].size() > 1) {
    for (auto *Op1 : InstLive[inst]) {
      for (auto *Op2 : InstLive[inst]) {
        if (Op1 && Op2 && Op2 != Op1)
          TmpIG[Op1].insert(Op2);
      }
    }
  } else if (InstLive[inst].size() == 1) {
    auto op1 = *InstLive[inst].begin();
    if (op1)
      TmpIG[op1];
  } else
    return;
}

void BlockInfo::PrintPass() {
  std::cout << "--------BlockLiveInfo--------" << std::endl;
  for (RISCVBasicBlock *_block : *m_func) {
    std::cout << "--------Block:" << _block->GetName() << "--------"
              << std::endl;
    std::cout << "        Livein" << std::endl;
    for (RISCVMOperand *_value : BlockLivein[_block]) {
      if (dynamic_cast<VirRegister *>(_value))
        _value->print();
      else
        _value->print();
      std::cout << " ";
    }
    std::cout << std::endl;
    std::cout << "        Liveout" << std::endl;
    for (RISCVMOperand *_value : BlockLiveout[_block]) {
      if (dynamic_cast<VirRegister *>(_value))
        _value->print();
      else
        _value->print();
      std::cout << " ";
    }
    std::cout << std::endl;
  }
}
void InterVal::init() {
  int curr = 0;
  for (RISCVBasicBlock *block : *func) {
    for (RISCVMIR *inst : *block) {
      instNum[inst] = curr;
      curr++;
    }
  }
}

void InterVal::computeLiveIntervals()

{
  for (RISCVBasicBlock *block : *func) {
    std::unordered_map<MOperand, std::vector<Interval>> CurrentRegLiveinterval;
    int begin = -1;
    for (RISCVMIR *inst : *block) {
      int Curr = instNum[inst];
      if (inst == block->front())
        begin = instNum[inst];
      for (MOperand Op : InstLive[inst]) {
        if (!CurrentRegLiveinterval.count(Op)) {
          Interval interval;
          interval.start = Curr;
          interval.end = -1;
          CurrentRegLiveinterval[Op].push_back(interval);
        } else {
          if (CurrentRegLiveinterval[Op].back().end == -1 &&
              inst == block->back())
            CurrentRegLiveinterval[Op].back().end = Curr;
          else if (CurrentRegLiveinterval[Op].back().end != -1 &&
                   count(Op, inst)) {
            Interval interval;
            interval.start = Curr;
            interval.end = -1;
            CurrentRegLiveinterval[Op].push_back(interval);
          }
        }
      }
      for (auto &[Op, intervals] : CurrentRegLiveinterval) {
        if (intervals.back().end == -1 && inst == block->back() &&
            !count(Op, inst))
          CurrentRegLiveinterval[Op].back().end = Curr - 1;
        else if (intervals.back().end == -1 && inst == block->back())
          CurrentRegLiveinterval[Op].back().end = Curr;
        else if (intervals.back().end == -1 && !count(Op, inst))
          intervals.back().end = Curr - 1;
        else if (intervals.back().end == -1 && count(Op, inst))
          continue;
      }
    }
    if (verify(CurrentRegLiveinterval)) {
      for (auto &[op, intervals] : CurrentRegLiveinterval) {
        auto curr = intervals.begin();
        for (auto iter = intervals.begin(); iter != intervals.end(); ++iter) {
          if (iter == curr)
            continue;
          if (curr->start < iter->start) {
            ++curr;
            *curr = *iter;
          } else
            curr->end = std::max(curr->end, iter->end);
        }
        intervals.erase(std::next(curr), intervals.end());
      }
      RegLiveness[block] = CurrentRegLiveinterval;
    }
  }
}

bool InterVal::verify(
    std::unordered_map<MOperand, std::vector<Interval>> Liveinterval) {
  int num = 0;
  for (auto &[op, intervals] : Liveinterval) {
    for (auto &i : intervals) {
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

void InterVal::PrintAnalysis() {
  std::cout << "--------InstLive--------" << std::endl;
  for (RISCVBasicBlock *block : *func) {
    std::cout << "-----Block " << block->GetName() << "-----" << std::endl;
    for (RISCVMIR *inst : *block) {
      std::cout << "inst" << instNum[inst] << "Liveness:";
      for (RISCVMOperand *Op : InstLive[inst]) {
        if (dynamic_cast<VirRegister *>(Op))
          Op->print();
        else
          Op->print();
      }
      std::cout << std::endl;
    }
  }
  for (RISCVBasicBlock *block : *func) {
    std::cout << "--------LiveInterval--------" << std::endl;
    std::cout << "--------Block:" << block->GetName() << "--------"
              << std::endl;
    for (auto &[op, intervals] : RegLiveness[block]) {
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
void InterVal::RunOnFunc_() {
  init();
  computeLiveIntervals();
}

void GraphColor::LiveInfoInit() {
  TmpIG.clear();
  BlockLivein.clear();
  BlockLiveout.clear();
  BlockInfo.clear();
  RegLiveness.clear();
  instNum.clear();
  Uses.clear();
  Defs.clear();
  InstLive.clear();
  IG.clear();
  ValsInterval.clear();
  freezeWorkList.clear();
  worklistMoves.clear();
  simplifyWorkList.clear();
  spillWorkList.clear();
  spillWorkList.clear();
  spilledNodes.clear();
  initial.clear();
  coalescedNodes.clear();
  constrainedMoves.clear();
  coalescedMoves.clear();
  frozenMoves.clear();
  coloredNode.clear();
  AdjList.clear();
  selectstack.clear();
  belongs.clear();
  activeMoves.clear();
  alias.clear();
  RegType.clear();
  AlreadySpill.clear();
  InstLive.clear();
  Precolored.clear();
  color.clear();
  moveList.clear();
  IG.clear();
  instNum.clear();
  RegLiveness.clear();
  assist.clear();
}