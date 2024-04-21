#include "LivenessAnalysis.hpp"
#include <algorithm>
#include <map>

void LivenessAnalysis::GetBlockLivein(MachineBasicBlock* block)
{
    for(auto inst = block->getMachineInsts().rbegin();inst != block->getMachineInsts().rend(); --inst)
    {
        for(auto val : (*inst)->GetVector_used())
        {
            if(!val->isConst())
                BlockLivein[block].insert(val); 
        }
        Value* DefValue = (*inst)->GetVector_used()[0];
        BlockLivein[block].erase(DefValue);
    }
}

void LivenessAnalysis::GetBlockLiveout(MachineBasicBlock* block)
{
    MachineInst* inst = block->getMachineInsts().back();
  if(CondInst* _CondInst = dynamic_cast<CondInst *>(inst))
  {
    auto &_Use = inst->Getuselist(); 
    BasicBlock* _block_Succ1 = dynamic_cast<BasicBlock *>(_Use[1]->GetValue());
    BasicBlock* _block_Succ2 = dynamic_cast<BasicBlock *>(_Use[2]->GetValue());
    BlockLiveout[block].insert(BlockLivein[_block_Succ1].begin(), BlockLivein[_block_Succ1].end());
    BlockLiveout[block].insert(BlockLivein[_block_Succ2].begin(), BlockLivein[_block_Succ2].end());
  }
  if(UnCondInst* _UnCondInst = dynamic_cast<UnCondInst *>(inst))
  {
    auto &_Use = inst->Getuselist();
    BasicBlock* _block_Succ = dynamic_cast<BasicBlock *>(_Use[0]->GetValue());
    BlockLiveout[block].insert(BlockLivein[_block_Succ].begin(),BlockLivein[_block_Succ].end());
  }
}

void LivenessAnalysis::RunOnFunction()
{
  for(MachineBasicBlock* _block:*F)
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

void LivenessAnalysis::iterate(MachineFunction *func)
{
  RunOnFunc(func);  
  bool isChanged = false;
  for(BasicBlock *_block:(*func))
  {
    if(!UnChanged[_block])
    {
      isChanged = true;
      break;
    }
  }
}

void LivenessAnalysis::RunOnFunc(MachineFunction *func)
{
  for(auto BB = (*func).rbegin(); BB != (*func).rend(); ++BB)
  {
    BasicBlock*_Block = *BB;
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

void LivenessAnalysis::PrintPass()
{
  std::cout << "--------LivenessAnalysis--------" << std::endl;
  for(MachineBasicBlock* _block:*F)
  {
    std::cout << "--------Block:"<< _block->GetName() << "--------" << std::endl;
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