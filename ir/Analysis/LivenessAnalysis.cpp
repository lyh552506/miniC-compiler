#include "LivenessAnalysis.hpp"
#include <algorithm>
#include <map>

void BlockLiveInfo::GetBlockLivein(MachineBasicBlock* block)
{
    for(auto inst = block->getMachineInsts().rbegin();inst != block->getMachineInsts().rend(); --inst)
    {
        for(auto val : (*inst)->GetVector_used())
        {
            if(!val->isConst())
            {
              BlockLivein[block].insert(val); 
              Uses[block].insert(val);
            }
        }
        Value* DefValue = (*inst)->GetVector_used()[0];
        BlockLivein[block].erase(DefValue);
        Uses[block].erase(DefValue);
        Defs[block].insert(DefValue);
    }
}

void BlockLiveInfo::GetBlockLiveout(MachineBasicBlock* block)
{
  for(MachineInst* inst : block->getMachineInsts())
  {
    std::string Opcode = inst->GetOpcode();
    if(Opcode == "j")
    {
      MachineBasicBlock* _block_Succ = F->GetBlock(inst->GetVector_used()[0]->GetName());
      BlockLiveout[block].insert(BlockLivein[_block_Succ].begin(), BlockLivein[_block_Succ].end());
    }
    else if(Opcode == "ble" || Opcode == "bgt" || Opcode == "beqz")
    {
      MachineBasicBlock* _block_Succ1 = F->GetBlock(inst->GetVector_used()[1]->GetName());
      BlockLiveout[block].insert(BlockLivein[_block_Succ1].begin(), BlockLivein[_block_Succ1].end());
    }
  }
}

void BlockLiveInfo::RunOnFunction()
{
  for(MachineBasicBlock* _block : F->getMachineBasicBlocks())
  {
    BlockLivein[_block].clear();
    BlockLiveout[_block].clear();
    GetBlockLivein(_block);
    GetBlockLiveout(_block);
  }
  iterate(F); 
  while(isChanged)
    iterate(F);
  for(MachineBasicBlock* _block : F->getMachineBasicBlocks())
  {
    CalInstLive(_block);
    CalcReg2Mov(_block);
    CalcReg2Reg(_block);
  }
}

void BlockLiveInfo::iterate(MachineFunction *func)
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

void BlockLiveInfo::RunOnFunc(MachineFunction *func)
{
  for(auto BB = func->getMachineBasicBlocks().rbegin(); BB != func->getMachineBasicBlocks().rend(); --BB)
  {
    MachineBasicBlock*_Block = *BB;
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

void BlockLiveInfo::CalInstLive(MachineBasicBlock* block)
{
  for(MachineInst* inst : block->getMachineInsts())
  {
    std::set<Value*> Live = BlockLiveout[block];
    for(Operand val : inst->GetVector_used())
    {
      if(!val->isConst())
      {
        Live.insert(val);
        if(!inst->isVirtual(val))
          Regs.insert(val);
      }
    }
    Value* DefValue = inst->GetVector_used()[0];
    Live.erase(DefValue);
    InstLive[inst] = Live;
  }
}
void BlockLiveInfo::CalcReg2Mov(MachineBasicBlock* block)
{
  for(MachineInst* inst : block->getMachineInsts())
  {
    std::string Opcode = inst->GetOpcode();
    if(Opcode == "mov")
    {
      for(Operand Op : inst->GetVector_used())
        Reg2Mov[Op].push_back(inst);
    }
  }
}

void BlockLiveInfo::CalcReg2Reg(MachineBasicBlock* block)
{
  for(MachineInst* inst : block->getMachineInsts())
  {
    for(Value* Op1 : InstLive[inst])
    {
      for(Value* Op2: InstLive[inst])
      {
        if(Op2 != Op1)
          Reg2Reg[Op1].push_back(Op2);
      }
    }
  }
}
void BlockLiveInfo::PrintPass()
{
  std::cout << "--------BlockLiveInfo--------" << std::endl;
  for(MachineBasicBlock* _block : F->getMachineBasicBlocks())
  {
    std::cout << "--------Block:"<< _block->get_name() << "--------" << std::endl;
    std::cout << "        Livein" << std::endl;
    for(Value* _value:BlockLivein[_block])
      std::cout << "%" << _value->GetName() << " ";
    std::cout << std::endl;
    std::cout << "        Liveout" << std::endl;
    for(Value* _value:BlockLiveout[_block])
      std::cout << "%" << _value->GetName() << " ";
    std::cout << std::endl;
  }
}

void LiveInterval::init()
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

// void LiveInterval::computeLiveIntervals()
// {
//   for (MachineBasicBlock* block : func->getMachineBasicBlocks())
//   {
//     std::unordered_map<Operand, std::vector<RegLiveInterval>> CurrentRegLiveinterval;
//     BlockLiveInfo blockinfo = BlockLiveInfo(func);
//     std::map<Operand, int> laseUse;
//     int begin = -1;
//     for(MachineInst* inst : block->getMachineInsts())
//     {
//       int Curr = instNum[inst];
//       if(inst == block->getMachineInsts().front())
//         begin = instNum[inst];
//       for(Operand Op : InstLive[inst])
//       {
//         if(!CurrentRegLiveinterval.count(Op))
//         {
//           RegLiveInterval interval;
//           interval.start = Curr;
//           interval.end = -1;
//           CurrentRegLiveinterval[Op].push_back(interval);
//         }
//         else
//         {
//           if(CurrentRegLiveinterval[Op].back().end == -1 && count(Op))
//             CurrentRegLiveinterval[Op].back().end = Curr;
//           else
//           {
//             RegLiveInterval interval;
//             interval.start = Curr;
//             interval.end = -1;
//             CurrentRegLiveinterval[Op].push_back(interval);
//           }
//         }
//         if(!Op->isConst())
//         {
//           if(!CurrentRegLiveinterval.count(Op))
//           {
//             RegLiveInterval interval;
//             interval.start = Curr;
//             interval.end = Curr;
//             CurrentRegLiveinterval[Op] = interval;
//           }
//           else
//           {
//             CurrentRegLiveinterval[Op].end = Curr;
//           }
//           if(laseUse.count(Op) > 0)
//           {
//             RegLiveInterval interval;
//             interval.start = laseUse[Op];
//             interval.end = Curr;
//             AddRegLiveInterval(interval, Op);
//           }
//           laseUse[Op] = Curr;
//         }
//       }
//     }
//     for (Instruction* inst : block->getInstructions())
//     {
//       InstInfo* instInfo = inst->getInstInfo();
//       int instNum = instInfo->getInstNum();

//       if (firstInstNum == -1)
//         firstInstNum = instNum;
//       lastInstNum = instNum;

//       for (Operand* operand : inst->getOperands())
//       {
//         bool isUse = operand->isUse();
//         bool isDef = operand->isDef();
//         Value* value = operand->getValue();
//         int regNum = operand->getRegNum();

//         if (value->isVirtualRegister())
//         {
//           if (isUse)
//           {
//             currentSegment[value] = std::make_pair(firstInstNum, lastInstNum);
//             lastUse[value] = lastInstNum;
//           }
//           if (isDef)
//           {
//             currentSegment[value] = std::make_pair(firstInstNum, lastInstNum);
//             if (lastUse.count(value) > 0)
//             {
//               value->setDead(true);
//               lastUse.erase(value);
//             }
//           }
//         }
//       }
//     }

//     for (auto& segment : currentSegment)
//     {
//       Value* value = segment.first;
//       std::pair<int, int> interval = segment.second;
//       if (blockInfo->getOutputSet().count(value) > 0)
//       {
//         interval.second = lastInstNum;
//         value->addInterval(interval);
//       }
//     }

//     for (auto& lastUseEntry : lastUse)
//     {
//       Value* value = lastUseEntry.first;
//       if (blockInfo->getOutputSet().count(value) == 0)
//       {
//         value->setDead(true);
//       }
//     }

//     for (Value* value : blockInfo->getOutputSet())
//     {
//       if (currentSegment.count(value) == 0)
//       {
//         std::pair<int, int> interval(firstInstNum, lastInstNum);
//         value->addInterval(interval);
//       }
//     }
//   }

//   for (Value* value : func->getValues())
//   {
//     value->optimizeIntervals();
//     value->verifyIntervals();
//   }
// }
