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
  auto inst = block->back();
  if(auto _CondInst = dynamic_cast<CondInst *>(inst))
  {
    auto &_Use = inst->Getuselist(); 
    auto _block_Succ1 = dynamic_cast<BasicBlock *>(_Use[1]->GetValue());
    auto _block_Succ2 = dynamic_cast<BasicBlock *>(_Use[2]->GetValue());
    BlockLiveout[block].insert(BlockLivein[_block_Succ1].begin(), BlockLivein[_block_Succ1].end());
    BlockLiveout[block].insert(BlockLivein[_block_Succ2].begin(), BlockLivein[_block_Succ2].end());
  }
  if(auto _UnCondInst = dynamic_cast<UnCondInst *>(inst))
  {
    auto &_Use = inst->Getuselist();
    auto _block_Succ = dynamic_cast<BasicBlock *>(_Use[0]->GetValue());
    BlockLiveout[block].insert(BlockLivein[_block_Succ].begin(),BlockLivein[_block_Succ].end());
  }
}

void LivenessAnalysis::pass(Function *func)
{
  for(auto &_block:func->GetBasicBlock())
  {
    BlockLivein[_block.get()].clear();
    BlockLiveout[_block.get()].clear();
    GetBlockLivein(_block.get());
    GetBlockLiveout(_block.get());
  }
  iterate(func); 
  while(isChanged)
    iterate(func);
}

void LivenessAnalysis::iterate(Function *func)
{
  RunOnFunction(func);  
  bool isChanged = false;
  for(auto &_block:func->GetBasicBlock())
  {
    if(!UnChanged[_block.get()])
    {
      isChanged = true;
      break;
    }
  }
}

void LivenessAnalysis::RunOnFunction(Function *func)
{
  auto& _block = func->GetBasicBlock();
  for(auto __block = _block.rbegin(); __block != _block.rend(); ++__block)
  {
    auto _Block = (*__block).get();
    auto old_BlockLivein = BlockLivein[_Block];
    auto old_BlockLiveout = BlockLiveout[_Block];
    GetBlockLiveout(_Block);
    BlockLivein[_Block] = BlockLiveout[_Block];
    GetBlockLivein(_Block);
    if(BlockLivein[_Block] == old_BlockLivein)
      UnChanged[_Block] = true;
    else
      UnChanged[_Block] = false;
}
}
