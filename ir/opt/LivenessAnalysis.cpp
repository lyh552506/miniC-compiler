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
      if(!useValue->isConst())
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

void LivenessAnalysis::RunOnFunction()
{
  for(BasicBlock* _block:*F)
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

void LivenessAnalysis::iterate(Function *func)
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

void LivenessAnalysis::RunOnFunc(Function *func)
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
  for(BasicBlock* _block:*F)
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