#include "LivenessAnalysis.hpp"
#include <algorithm>
#include <map>

void LivenessAnalysis::GetBlockLivein(BasicBlock* block)
{
  for(auto inst = block->rbegin();inst != block->rend(); --inst)
  {
    for(auto &usePtr:(*inst)->Getuselist())
    {
      Value* useValue = usePtr->GetValue();
      BlockLivein[block].insert(useValue); 
    }
    Value* DefValue = (*inst)->GetDef();
    BlockLivein[block].erase(DefValue);
  }
}

void LivenessAnalysis::GetBlockLiveout(BasicBlock* block)
{
  User* inst = block->back();
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

void LivenessAnalysis::pass(Function *func)
{
  for(BasicBlock* _block:*func)
  {
    BlockLivein[_block].clear();
    BlockLiveout[_block].clear();
    GetBlockLivein(_block);
    GetBlockLiveout(_block);
  }
  iterate(func); 
  while(isChanged)
    iterate(func);
  // PrintInfo(func);
}

void LivenessAnalysis::iterate(Function *func)
{
  RunOnFunction(func);  
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

void LivenessAnalysis::RunOnFunction(Function *func)
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
void LivenessAnalysis::PrintInfo(Function* func)
{
  for(BasicBlock* _block:*func)
  {
    std::cout << "Block: " << std::endl;
    std::cout << "Livein: ";
    for(Value* _value:BlockLivein[_block])
      std::cout << _value->GetName() << " ";
    std::cout << std::endl;
    std::cout << "Liveout: ";
    for(Value* _value:BlockLiveout[_block])
      std::cout << _value->GetName() << " ";
    std::cout << std::endl;
  }
}