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
    for(auto inst = block->rbegin();inst != block->rend(); ++inst)
    {
      OpType Opcode = (*inst)->GetOpcode();
      if((*inst)->GetOpcode() == OpType::_j)
        continue;
      else if(Opcode == OpType::_beq || Opcode == OpType::_bne || Opcode == OpType::_blt || \
      Opcode == OpType::_bge || Opcode == OpType::_bltu || Opcode == OpType::_bgeu)
      {
        RISCVMOperand* val1 = (*inst)->GetOperand(0);
        RISCVMOperand* val2 = (*inst)->GetOperand(1);
        if(!dynamic_cast<Imm*>(val1))
        {
          BlockLivein[block].insert(val1); 
          Uses[block].insert(val1);
        }
        if(!dynamic_cast<Imm*>(val2))
        {
          BlockLivein[block].insert(val2); 
          Uses[block].insert(val2);
        }
        continue;
      }
      else
      {
        RISCVMOperand* val1 = (*inst)->GetOperand(0);
        RISCVMOperand* val2 = (*inst)->GetOperand(1);
        if(dynamic_cast<Imm*>(val1))
        {
            BlockLivein[block].insert(val1); 
            Uses[block].insert(val1);
        }
        if(!dynamic_cast<Imm*>(val2))
        {
          BlockLivein[block].insert(val2); 
          Uses[block].insert(val2);
        }
        if(RISCVMOperand* DefValue = (*inst)->GetDef())
        {
            BlockLivein[block].erase(DefValue);
            Uses[block].erase(DefValue);
            Defs[block].insert(DefValue);
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
      RISCVBasicBlock* _block_Succ = dynamic_cast<RISCVBasicBlock*>(inst->GetOperand(0));
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
  for(auto BB = func->rbegin(); BB != func->rend(); ++BB)
  {
    RISCVBasicBlock* _Block = *BB;
    std::set<RISCVMOperand*> old_BlockLivein = BlockLivein[_Block];
    std::set<RISCVMOperand*> old_BlockLiveout = BlockLiveout[_Block];
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
  for(RISCVMIR* inst : *block)
  {
    std::set<RISCVMOperand*> Live = blockinfo->BlockLiveout[block];
    {
      RISCVMOperand* val1 = inst->GetOperand(0);
      RISCVMOperand* val2 = inst->GetOperand(1);
      if(!dynamic_cast<Imm*>(val1))
      {
        Live.insert(val1);
        if(dynamic_cast<PhyRegister*>(val1))
          Precolored.insert(val1);
      }
      if(!dynamic_cast<Imm*>(val2))
      {
        Live.insert(val2);
        if(dynamic_cast<PhyRegister*>(val2))
          Precolored.insert(val2);
      }
    }
    if(RISCVMOperand* DefValue = inst->GetDef())
      Live.erase(DefValue);
    blockinfo->InstLive[inst] = Live;
  }
}
void GraphColor::CalcmoveList(RISCVBasicBlock* block)
{
  for(RISCVMIR* inst : *block)
  {
    OpType Opcode = inst->GetOpcode();
    if(Opcode == OpType::mv)
    {
        moveList[inst->GetOperand(0)].insert(inst);
        moveList[inst->GetOperand(1)].insert(inst);
    }
  }
}

void GraphColor::CalcIG(RISCVBasicBlock* block)
{
  for(RISCVMIR* inst : *block)
  {
    for(RISCVMOperand* Op1 : blockinfo->InstLive[inst])
    {
      for(RISCVMOperand* Op2: blockinfo->InstLive[inst])
      {
        if(Op2 != Op1)
          PushVecSingleVal(IG[Op1], Op2);
      }
    }
  }
}
void BlockInfo::PrintPass()
{
  std::cerr << "--------BlockLiveInfo--------" << std::endl;
  for(RISCVBasicBlock* _block : *F)
  {
    std::cerr << "--------Block:"<< _block->GetName() << "--------" << std::endl;
    std::cerr << "        Livein" << std::endl;
    for(RISCVMOperand* _value:BlockLivein[_block])
    {
      if(dynamic_cast<VirRegister*>(_value))
        std::cerr << "%" << _value->GetName() << " ";
      else
        std::cerr << _value->GetName() << " ";
    }
    std::cerr << std::endl;
    std::cerr << "        Liveout" << std::endl;
    for(RISCVMOperand* _value:BlockLiveout[_block])
    {
      if(dynamic_cast<VirRegister*>(_value))
        std::cerr << "%" << _value->GetName() << " ";
      else
        std::cerr << _value->GetName() << " ";
    }
    std::cerr << std::endl;
  }
}

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
    std::unordered_map<RISCVMOperand*, std::vector<Interval>> CurrentRegLiveinterval;
    int begin = -1;
    for(RISCVMIR* inst : *block)
    {
      int Curr = instNum[inst];
      if(inst == block->front())
        begin = instNum[inst];
      for(RISCVMOperand* Op : blockinfo.get()->InstLive[inst])
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

bool InterVal::verify(std::unordered_map<RISCVMOperand*, std::vector<Interval>> Liveinterval)
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
  std::cerr << "--------LiveInterval--------" << std::endl;
  for(RISCVBasicBlock* block : *func)
  {
    for(RISCVMIR* inst : *block)
    {
        std::cerr << "inst" << instNum[inst] << "Liveness:";
        for(RISCVMOperand* Op : blockinfo.get()->InstLive[inst])
        {
          if(dynamic_cast<VirRegister*>(Op))
            std::cerr << "%" << Op->GetName() << ", ";
          else
            std::cerr << Op->GetName() << ", ";
        }
        std::cerr<<std::endl;
    }
  }
  for(RISCVBasicBlock* block : *func)
  {
    std::cerr << "--------Block:" << block->GetName() << "--------" << std::endl;
    for(auto& [op, intervals] : RegLiveness[block])
    {
      if(dynamic_cast<VirRegister*>(op))
      std::cerr << "% "<< op->GetName() << ":";
      else
        std::cerr << op->GetName() << ":";
      for(auto& i : intervals)
        std::cerr << "[" << i.start << "," << i.end << "]";
      std::cerr << std::endl;
    }
  }
}

void InterVal::RunOnFunc()
{
  init();
  computeLiveIntervals();
}