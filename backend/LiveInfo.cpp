#include "RISCVMIR.hpp"
#include "RISCVMOperand.hpp"
#include "RISCVRegister.hpp"
#include "RegAlloc.hpp"
#include "my_stl.hpp"
#include <algorithm>
#include <map>
#include <regex>
using BlockInfo = GraphColor::BlockLiveInfo;
using InterVal = GraphColor::LiveInterval;
using OpType = RISCVMIR::RISCVISA;
void BlockInfo::GetBlockLivein(RISCVBasicBlock* block)
{
    for(auto inst = block->rbegin();inst != block->rend(); --inst)
    {
      OpType Opcode = (*inst)->GetOpcode();
      if(Opcode == OpType::_j)
        continue;
      else if(Opcode == OpType::_beq || Opcode == OpType::_bne || Opcode == OpType::_blt || \
      Opcode == OpType::_bge || Opcode == OpType::_bltu || Opcode == OpType::_bgeu)
      {
        RISCVMOperand* val1 =(*inst)->GetOperand(0);
        RISCVMOperand* val2 = (*inst)->GetOperand(1);
        if(!val1->ignoreLA())
        {
          BlockLivein[block].insert(dynamic_cast<MOperand>(val1)); 
          Uses[block].insert(dynamic_cast<MOperand>(val1));
        }
        if(!val2->ignoreLA())
        {
          BlockLivein[block].insert(dynamic_cast<MOperand>(val2)); 
          Uses[block].insert(dynamic_cast<MOperand>(val2));
        }
      }
      else if(Opcode == OpType::ret)
      {
        RISCVMOperand* val1 = (*inst)->GetOperand(0);
        if(!val1->ignoreLA())
        {
            BlockLivein[block].insert(dynamic_cast<MOperand>(val1)); 
            Uses[block].insert(dynamic_cast<MOperand>(val1));
        }
      }
      else if((*inst)->GetOperandSize() == 1)
      {
        RISCVMOperand* val = (*inst)->GetOperand(0);
        if(!val->ignoreLA())
        {
            BlockLivein[block].insert(dynamic_cast<MOperand>(val)); 
            Uses[block].insert(dynamic_cast<MOperand>(val));
        }
      }
      else if((*inst)->GetOperandSize() == 2)
      {
        RISCVMOperand* val1 = (*inst)->GetOperand(0);
        RISCVMOperand* val2 = (*inst)->GetOperand(1);
        if(!val1->ignoreLA())
        {
            BlockLivein[block].insert(dynamic_cast<MOperand>(val1)); 
            Uses[block].insert(dynamic_cast<MOperand>(val1));
        }
        if(!val2->ignoreLA())
        {
          BlockLivein[block].insert(dynamic_cast<MOperand>(val2)); 
          Uses[block].insert(dynamic_cast<MOperand>(val2));
        }
        if(RISCVMOperand* DefValue = (*inst)->GetDef())
        {
          if(!DefValue->ignoreLA())
          {
            BlockLivein[block].erase(dynamic_cast<MOperand>(DefValue));
            Uses[block].erase(dynamic_cast<MOperand>(DefValue));
            Defs[block].insert(dynamic_cast<MOperand>(DefValue));
          }
        }
      }
   }
}

void BlockInfo::GetBlockLiveout(RISCVBasicBlock* block)
{
  for(RISCVMIR* inst : *block)
  {
    OpType Opcode = inst->GetOpcode();
    if(Opcode == OpType::_j)
    {
      RISCVBasicBlock* _block_Succ;
      if(inst->GetDef())
        _block_Succ = dynamic_cast<RISCVBasicBlock*>(inst->GetDef());
      else if(inst->GetOperand(0))
        _block_Succ = dynamic_cast<RISCVBasicBlock*>(inst->GetOperand(0));
      BlockLiveout[block].insert(BlockLivein[_block_Succ].begin(), BlockLivein[_block_Succ].end());
    }
    else if(Opcode == OpType::_beq || Opcode == OpType::_bne || Opcode == OpType::_blt || \
    Opcode == OpType::_bge || Opcode == OpType::_bltu || Opcode == OpType::_bgeu)
    {
      RISCVBasicBlock* _block_Succ1 = dynamic_cast<RISCVBasicBlock*>(inst->GetOperand(2));
      BlockLiveout[block].insert(BlockLivein[_block_Succ1].begin(), BlockLivein[_block_Succ1].end());
    }
  }
}

void BlockInfo::RunOnFunction()
{
  for(RISCVBasicBlock* _block : *F)
  {
    BlockLivein[_block].clear();
    BlockLiveout[_block].clear();
    GetBlockLivein(_block);
    GetBlockLiveout(_block);
  }
  iterate(F); 
  while(isChanged)
    iterate(F);
}

void BlockInfo::iterate(RISCVFunction *func)
{
  RunOnFunc(func);  
  bool isChanged = false;
  for(RISCVBasicBlock *_block : *func)
  {
    if(!UnChanged[_block])
    {
      isChanged = true;
      break;
    }
  }
}

void BlockInfo::RunOnFunc(RISCVFunction *func)
{
  for(auto BB = func->rbegin(); BB != func->rend(); --BB)
  {
    RISCVBasicBlock* _Block = *BB;
    std::set<MOperand> old_BlockLivein = BlockLivein[_Block];
    std::set<MOperand> old_BlockLiveout = BlockLiveout[_Block];
    GetBlockLiveout(_Block);
    BlockLivein[_Block] = BlockLiveout[_Block];
    GetBlockLivein(_Block);
    if(BlockLivein[_Block] == old_BlockLivein)
      UnChanged[_Block] = true;
    else
      UnChanged[_Block] = false;
  }
}

void GraphColor::CalInstLive(RISCVBasicBlock* block)
{
  std::set<MOperand> Live = liveinterval->blockinfo->BlockLiveout[block];
  for(auto inst_ = block->rbegin(); inst_ != block->rend(); --inst_)
  {
    RISCVMIR* inst = *inst_;
    {
      if(inst->GetOperandSize() == 1)
      {
        RISCVMOperand* val1 = inst->GetOperand(0);
        if(!val1->ignoreLA())
        {
          Live.insert(dynamic_cast<MOperand>(val1));
          if(dynamic_cast<PhyRegister*>(dynamic_cast<MOperand>(val1)))
            Precolored.insert(dynamic_cast<MOperand>(val1));
        }
      }
      else if(inst->GetOperandSize() == 2)
      {
        RISCVMOperand* val1 = inst->GetOperand(0);
        RISCVMOperand* val2 = inst->GetOperand(1);
        if(!val1->ignoreLA())
        {
          Live.insert(dynamic_cast<MOperand>(val1));
          if(dynamic_cast<PhyRegister*>(val1))
            Precolored.insert(dynamic_cast<MOperand>(val1));
        }
        if(!val2->ignoreLA())
        {
          Live.insert(dynamic_cast<MOperand>(val2));
          if(dynamic_cast<PhyRegister*>(val2))
            Precolored.insert(dynamic_cast<MOperand>(val2));
        }
      }
    }
    if(RISCVMOperand* DefValue = inst->GetDef())
    {
      if(!DefValue->ignoreLA())
        Live.erase(dynamic_cast<MOperand>(DefValue));
    } 
    liveinterval->blockinfo->InstLive[inst] = Live;
  }
}
void GraphColor::CalcmoveList(RISCVBasicBlock* block)
{
  for(RISCVMIR* inst : *block)
  {
    OpType Opcode = inst->GetOpcode();
    if(Opcode == OpType::mv)
    {
        moveList[dynamic_cast<MOperand>(inst->GetOperand(0))].insert(inst);
        moveList[dynamic_cast<MOperand>(inst->GetDef())].insert(inst);
    }
  }
}

void GraphColor::CalcIG(RISCVBasicBlock* block)
{
  for(RISCVMIR* inst : *block)
  {
    for(RISCVMOperand* Op1 : liveinterval->blockinfo->InstLive[inst])
    {
      for(RISCVMOperand* Op2: liveinterval->blockinfo->InstLive[inst])
      {
        if(Op2 != Op1 &&dynamic_cast<Register*>(Op1)&&dynamic_cast<Register*>(Op2))
          PushVecSingleVal(IG[dynamic_cast<Register*>(Op1)], dynamic_cast<Register*>(Op2));
      }
    }
  }
}
void BlockInfo::PrintPass()
{
  std::cout << "--------BlockLiveInfo--------" << std::endl;
  for(RISCVBasicBlock* _block : *F)
  {
    std::cout << "--------Block:"<< _block->GetName() << "--------" << std::endl;
    std::cout << "        Livein" << std::endl;
    for(RISCVMOperand* _value:BlockLivein[_block])
    {
      if(dynamic_cast<VirRegister*>(_value))
        _value->print();
      else
        _value->print();
      std::cout<<" ";
    }
    std::cout << std::endl;
    std::cout << "        Liveout" << std::endl;
    for(RISCVMOperand* _value:BlockLiveout[_block])
    {
      if(dynamic_cast<VirRegister*>(_value))
        _value->print();
      else
        _value->print();
      std::cout<<" ";
    }
    std::cout << std::endl;
  }
}

// void BlockInfo::PrintPass()
// {
//   std::cerr << "--------BlockLiveInfo--------" << std::endl;
//   for(RISCVBasicBlock* _block : *F)
//   {
//     std::cerr << "--------Block:"<< _block->GetName() << "--------" << std::endl;
//     std::cerr << "        Livein" << std::endl;
//     for(RISCVMOperand* _value:BlockLivein[_block])
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

void InterVal::init()
{
  int curr = 0;
  for(RISCVBasicBlock* block : *func)
  {
    for(RISCVMIR* inst : *block)
    {
      instNum[inst] = curr;
      curr++;
    }
  }
}

void InterVal::computeLiveIntervals()

{
  for (RISCVBasicBlock* block : *func)
  {
    std::unordered_map<MOperand, std::vector<Interval>> CurrentRegLiveinterval;
    int begin = -1;
    for(RISCVMIR* inst : *block)
    {
      int Curr = instNum[inst];
      if(inst == block->front())
        begin = instNum[inst];
      for(MOperand Op : blockinfo.get()->InstLive[inst])
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
          if(CurrentRegLiveinterval[Op].back().end == -1 && inst == block->back())
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
        if(intervals.back().end == -1 && inst == block->back())
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

bool InterVal::verify(std::unordered_map<MOperand, std::vector<Interval>> Liveinterval)
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
//     std::cerr << "--------Block:" << block->GetName() << "--------" << std::endl;
//     for(auto& [op, intervals] : RegLiveness[block])
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
  for(RISCVBasicBlock* block : *func)
  {
    for(RISCVMIR* inst : *block)
    {
        std::cout << "inst" << instNum[inst] << "Liveness:";
        for(RISCVMOperand* Op : blockinfo.get()->InstLive[inst])
        {
          if(dynamic_cast<VirRegister*>(Op))
            Op->print();
          else
            Op->print();
        }
        std::cout<<std::endl;
    }
  }
  for(RISCVBasicBlock* block : *func)
  {
    std::cout << "--------LiveInterval--------" << std::endl;
    std::cout << "--------Block:" << block->GetName() << "--------" << std::endl;
    for(auto& [op, intervals] : RegLiveness[block])
    {
      if(dynamic_cast<VirRegister*>(op))
      op->print();
      else
        op->print();
      for(auto& i : intervals)
        std::cout << "[" << i.start << "," << i.end << "]";
      std::cout << std::endl;
    }
  }
}
void InterVal::RunOnFunc()
{
  init();
  computeLiveIntervals();
}

    