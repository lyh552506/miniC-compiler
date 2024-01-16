#include "LivenessAnalysis.hpp"
#include <algorithm>
#include <iostream>

void LivenessAnalysis::pass(Function* func)
{
  for(auto &BB:func->getBlockList())
  {
    GetBlockLiveout(BB.get());
    GetBlockLivein(BB.get());
  }
  iterate(func);
}

void LivenessAnalysis::GetBlockLivein(BasicBlock* block)
{
  for(auto inst = block->getInstList().rbegin();inst != block->getInstList().rend(); ++inst)
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
  auto inst = block->getInstList().back().get();
  if(auto _CondInst = dynamic_cast<CondInst *>(inst))
  {
    auto _Use = inst->Getuselist(); 
    BlockLivein[block].insert(_Use[1]->GetValue());
    auto _block_Succ1 = dynamic_cast<BasicBlock *>(_Use[1]->GetValue());
    auto _block_Succ2 = dynamic_cast<BasicBlock *>(_Use[2]->GetValue());
    BlockLiveout[block].insert(BlockLivein[_block_Succ1].begin(), BlockLivein[_block_Succ1].end());
    BlockLiveout[block].insert(BlockLivein[_block_Succ2].begin(), BlockLivein[_block_Succ2].end());
  }
  if(auto _UnCondInst = dynamic_cast<UnCondInst *>(inst))
  {
    auto _Use = inst->Getuselist();
    auto _block_Pred = dynamic_cast<BasicBlock *>(_Use[0]->GetValue());
    BlockLiveout[block].insert(BlockLivein[_block_Pred].begin(),BlockLivein[_block_Pred].end());
  }
}


void LivenessAnalysis::iterate(Function* func)
{
  std::set<BasicBlock*> worklist;
  for(auto &block : func->getBlockList())
  {
    auto _block = block.get();
    BlockLivein[_block].clear();
    worklist.insert(_block);
  }

  while(!worklist.empty())
  {
    auto _block = *worklist.begin();
    worklist.erase(worklist.begin());
    BlockLiveout[_block].clear();
    auto old_BlockLivein = BlockLivein[_block];
    GetBlockLiveout(_block);
    GetBlockLivein(_block);
    if(old_BlockLivein != BlockLivein[_block])
    {
      auto inst = _block->getInstList().back().get();
      if(auto _CondInst = dynamic_cast<CondInst*>(inst))
        {
          auto _Use = inst->Getuselist();
          worklist.insert(dynamic_cast<BasicBlock*>(_Use[1]->GetValue()));
          worklist.insert(dynamic_cast<BasicBlock*>(_Use[2]->GetValue()));
        }
      if(auto _UnCondInst = dynamic_cast<UnCondInst*>(inst))
      {
        auto _Use = inst->Getuselist();
        worklist.insert(dynamic_cast<BasicBlock*>(_Use[0]->GetValue()));
      }
    }
  }
}
