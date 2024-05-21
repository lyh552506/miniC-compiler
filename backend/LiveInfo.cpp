#include "RISCVMIR.hpp"
#include "RISCVMOperand.hpp"
#include "RISCVRegister.hpp"
#include "RegAlloc.hpp"
#include "my_stl.hpp"
#include <algorithm>
#include <map>
#include <regex>
using BlockInfo = BlockLiveInfo;
using InterVal = LiveInterval;
using OpType = RISCVMIR::RISCVISA;
bool BlockInfo::Count(Register *op) {
  if (op) {
    // if(color.find(op) != color.end() && color[op] == nullptr)
    //   int b =1;
    if(color.find(op) != color.end())
      return true;
    else
      return false;
  }
  return false;
}
void BlockInfo::UpdateInfo(RISCVMOperand *val, RISCVBasicBlock *block) {
  if (auto reg = val->ignoreLA()) {
    if (Count(reg)) {
      BlockLivein[block].insert(color[reg]);
      Uses[block].insert(color[reg]);
    } else {
      BlockLivein[block].insert(reg);
      Uses[block].insert(reg);
    }
  }
}
void BlockInfo::GetBlockLivein(RISCVBasicBlock *block) {
  for (auto inst = block->rbegin(); inst != block->rend(); --inst) {
    OpType Opcode = (*inst)->GetOpcode();
    if (Opcode == OpType::_j)
      continue;
    else if (Opcode == OpType::_beq || Opcode == OpType::_bne ||
             Opcode == OpType::_blt || Opcode == OpType::_bge ||
             Opcode == OpType::_bltu || Opcode == OpType::_bgeu) {
      RISCVMOperand *val1 = (*inst)->GetOperand(0);
      RISCVMOperand *val2 = (*inst)->GetOperand(1);
      UpdateInfo(val1, block);
      UpdateInfo(val2, block);
    } else if (Opcode == OpType::ret) {
      if ((*inst)->GetOperandSize() != 0) {
        RISCVMOperand *val1 = (*inst)->GetOperand(0);
        if (val1) {
          PhyRegister *Phy = PhyRegister::GetPhyReg(PhyRegister::PhyReg::a0);
          BlockLivein[block].insert(Phy);
          Uses[block].insert(Phy);
        }
      }
    } else if (Opcode == OpType::call) {
      for (int i = 0; i < (*inst)->GetOperandSize(); i++) {
        RISCVMOperand *val = (*inst)->GetOperand(i);
        if (val) {
          UpdateInfo(val, block);
        }
      }
    } else if ((*inst)->GetOperandSize() == 1) {
      RISCVMOperand *_val = (*inst)->GetOperand(0);
      UpdateInfo(_val, block);
      if (RISCVMOperand *_DefValue = (*inst)->GetDef()) {
        if (auto DefValue = _DefValue->ignoreLA()) {
          if (Count(DefValue)) {
            BlockLivein[block].erase(color[DefValue]);
            Uses[block].erase(color[DefValue]);
            Defs[block].insert(color[DefValue]);
          } else {
            BlockLivein[block].erase(DefValue);
            Uses[block].erase(DefValue);
            Defs[block].insert(DefValue);
          }
        }
      }
    } else if ((*inst)->GetOperandSize() == 2) {
      RISCVMOperand *_val1 = (*inst)->GetOperand(0);
      RISCVMOperand *_val2 = (*inst)->GetOperand(1);
      UpdateInfo(_val1, block);
      UpdateInfo(_val2, block);
      if (auto DefValue_ = (*inst)->GetDef()) {
        if (auto DefValue = DefValue_->ignoreLA()) {
          if (Count(DefValue)) {
            BlockLivein[block].erase(color[DefValue]);
            Uses[block].erase(color[DefValue]);
            Defs[block].insert(color[DefValue]);
          } else {
            BlockLivein[block].erase(DefValue);
            Uses[block].erase(DefValue);
            Defs[block].insert(DefValue);
          }
        }
      }
    }
  }
}

void BlockInfo::GetBlockLiveout(RISCVBasicBlock *block) {

  for (RISCVMIR *inst : *block) {
    OpType Opcode = inst->GetOpcode();
    if (Opcode == OpType::_j) {
      RISCVBasicBlock *_block_Succ;
      if (inst->GetDef())
        _block_Succ = dynamic_cast<RISCVBasicBlock *>(inst->GetDef());
      else if (inst->GetOperand(0))
        _block_Succ = dynamic_cast<RISCVBasicBlock *>(inst->GetOperand(0));
      BlockLiveout[block].insert(BlockLivein[_block_Succ].begin(),
                                 BlockLivein[_block_Succ].end());
    } else if (Opcode == OpType::_beq || Opcode == OpType::_bne ||
               Opcode == OpType::_blt || Opcode == OpType::_bge ||
               Opcode == OpType::_bltu || Opcode == OpType::_bgeu) {
      RISCVBasicBlock *_block_Succ1 =
          dynamic_cast<RISCVBasicBlock *>(inst->GetOperand(2));
      BlockLiveout[block].insert(BlockLivein[_block_Succ1].begin(),
                                 BlockLivein[_block_Succ1].end());
    }
  }
}

void BlockInfo::RunOnFunction() {
  for (RISCVBasicBlock *_block : *m_func) {
    BlockLivein[_block].clear();
    BlockLiveout[_block].clear();
    GetBlockLivein(_block);
    GetBlockLiveout(_block);
  }
  iterate(m_func);
  while (isChanged)
    iterate(m_func);
}

void BlockInfo::iterate(RISCVFunction *func) {
  RunOnFunc(func);
  bool isChanged = false;
  for (RISCVBasicBlock *_block : *func) {
    if (!UnChanged[_block]) {
      isChanged = true;
      break;
    }
  }
}

void BlockInfo::RunOnFunc(RISCVFunction *func) {
  for (auto BB = func->rbegin(); BB != func->rend(); --BB) {
    RISCVBasicBlock *_Block = *BB;
    std::set<MOperand> old_BlockLivein = BlockLivein[_Block];
    std::set<MOperand> old_BlockLiveout = BlockLiveout[_Block];
    GetBlockLiveout(_Block);
    BlockLivein[_Block] = BlockLiveout[_Block];
    GetBlockLivein(_Block);
    if (BlockLivein[_Block] == old_BlockLivein)
      UnChanged[_Block] = true;
    else
      UnChanged[_Block] = false;
  }
}

void GraphColor::CalInstLive(RISCVBasicBlock *block) {
  std::set<MOperand> Live = BlockLiveout[block];
  for (auto inst_ = block->rbegin(); inst_ != block->rend(); --inst_) {
    RISCVMIR *inst = *inst_;
    if (inst->GetOpcode() == OpType::call) {
      for (int i = 0; i < inst->GetOperandSize(); i++) {
        RISCVMOperand *val = inst->GetOperand(i);
        if (auto reg = val->ignoreLA()) {
          if (reg) {
            if (auto phy = dynamic_cast<PhyRegister *>(reg)) {
              Precolored.insert(phy);
              color[phy] = phy;
            }
            Live.insert(reg);
            InstLive[inst] = Live;
          }
        }
      }
      continue;
    } else if (inst->GetOperandSize() == 1) {
      if (inst->GetOpcode() == OpType::ret) {
        RISCVMOperand *val1 = inst->GetOperand(0);
        if (val1) {
          PhyRegister *Phy = PhyRegister::GetPhyReg(PhyRegister::PhyReg::a0);
          Live.insert(Phy);
          Precolored.insert(Phy);
          color[Phy] = Phy;
          InstLive[inst] = Live;
          continue;
        }
      } else {
        RISCVMOperand *_val1 = inst->GetOperand(0);
        if (auto val1 = _val1->ignoreLA()) {
          if (Count(val1)) {
            Precolored.insert(color[val1]);
            Live.insert(color[val1]);
          } else {
            Live.insert(val1);
            initial.insert(val1);
            if (auto phy = dynamic_cast<PhyRegister *>(val1)) {
              Precolored.insert(phy);
              color[phy] = phy;
              initial.erase(val1);
            }
          }
        }
      }
    } else if (inst->GetOperandSize() == 2) {
      RISCVMOperand *_val1 = inst->GetOperand(0);
      RISCVMOperand *_val2 = inst->GetOperand(1);
      if (auto val1 = _val1->ignoreLA()) {
        if (Count(val1)) {
          Precolored.insert(color[val1]);
          Live.insert(color[val1]);
        } else {
          Live.insert(val1);
          initial.insert(val1);
          if (auto phy = dynamic_cast<PhyRegister *>(val1)) {
            color[phy] = phy;
            Precolored.insert(phy);
            initial.erase(val1);
          }
        }
      }
      if (auto val2 = _val2->ignoreLA()) {
        if (Count(val2)) {
          Precolored.insert(color[val2]);
          Live.insert(color[val2]);
        } else {
          Live.insert(val2);
          initial.insert(val2);
          if (auto phy = dynamic_cast<PhyRegister *>(val2)) {
            color[phy] = phy;
            Precolored.insert(phy);
            initial.erase(val2);
          }
        }
      }
    }
    if (RISCVMOperand *_DefValue = inst->GetDef()) {
      if (auto DefValue = _DefValue->ignoreLA()) {
        if (dynamic_cast<VirRegister *>(DefValue)) {
          if (!Count(DefValue))
            initial.insert(DefValue);
        }

        if (Count(DefValue)) {
          Live.erase(color[DefValue]);
          Precolored.insert(color[DefValue]);
        } else {
          if(auto phy = dynamic_cast<PhyRegister*>(DefValue))
          {
            Precolored.insert(phy);
            Live.erase(DefValue);
          }
          else
            Live.erase(DefValue);
        }
      }
    }
    InstLive[inst] = Live;
  }
}
void GraphColor::CalcmoveList(RISCVBasicBlock *block) {
  for (RISCVMIR *inst : *block) {
    OpType Opcode = inst->GetOpcode();
    if (Opcode == OpType::mv) {
      auto op1 = inst->GetOperand(0)->ignoreLA();
      auto def = inst->GetDef()->ignoreLA();
      if (op1 && def) {
        if (Count(op1))
          moveList[color[op1]].insert(inst);
        else
          moveList[op1].insert(inst);
        if (Count(def))
          moveList[color[def]].insert(inst);
        else
          moveList[def].insert(inst);
        PushVecSingleVal(worklistMoves, inst);
      }
    }
  }
}

void GraphColor::CalcIG(RISCVBasicBlock *block) {
  for (RISCVMIR *inst : *block) {
    if (InstLive[inst].size() > 1) {
      for (auto *Op1 : InstLive[inst]) {
        for (auto *Op2 : InstLive[inst]) {
          if (Op1 && Op2 && Op2 != Op1)
            PushVecSingleVal(IG[Op1], Op2);
        }
      }
    } else if (InstLive[inst].size() == 1) {
      auto op1 = *InstLive[inst].begin();
      if (op1)
        IG[op1];
    } else
      continue;
  }
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

// void BlockInfo::PrintPass()
// {
//   std::cerr << "--------BlockLiveInfo--------" << std::endl;
//   for(RISCVBasicBlock* _block : *F)
//   {
//     std::cerr << "--------Block:"<< _block->GetName() << "--------" <<
//     std::endl; std::cerr << "        Livein" << std::endl; for(RISCVMOperand*
//     _value:BlockLivein[_block])
//     {
//       if(dynamic_cast<VirRegister*>(_value))
//         _value->print();
//       else
//         _value->print();
//     }
//     std::cerr << std::endl;
//     std::cerr << "        Liveout" << std::endl;
//     for(RISCVMOperand* _value:BlockLiveout[_block])
//     {
//       if(dynamic_cast<VirRegister*>(_value))
//         _value->print();
//       else
//         _value->print();
//     }
//     std::cerr << std::endl;
//   }
// }

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
