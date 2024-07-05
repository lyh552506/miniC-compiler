#include "LoopDeletion.hpp"
#include "BaseCFG.hpp"
#include "CFG.hpp"
#include "ConstantFold.hpp"
#include "LoopInfo.hpp"
#include "PassManagerBase.hpp"
#include "dominant.hpp"
#include <algorithm>
#include <cassert>
#include <optional>
#include <set>
#include <unordered_map>

void LoopDeletion::RunOnFunction() {
    bool changed = false;
    loop = new LoopAnalysis(func, dom);
    loop->RunOnFunction();
    for (auto loop : *loop)
    {
      if(DetectDeadLoop(loop))
        changed |= TryDeleteLoop(loop);
    }
}

bool LoopDeletion::RunOnFunc() {
    bool changed = false;
    loop = new LoopAnalysis(func, dom);
    loop->RunOnFunction();
    for (auto loop : *loop)
    {
      if(DetectDeadLoop(loop))
      {
        changed |= TryDeleteLoop(loop);
        _DEBUG(std::cerr << "LoopDeletion\n"<< "In function: " << func->GetName() << " " << changed << std::endl;)
      }

    }
    return changed;
}
bool LoopDeletion::DetectDeadLoop(LoopInfo* loopInfo)
{
    bool modified = false;
    BasicBlock* preheader = loop->GetPreHeader(loopInfo);
    if(!preheader)
        return false;
    
    bool flag = false;
    std::vector<BasicBlock*> exitblocks = loop->GetExit(loopInfo);
    for(BasicBlock* block : exitblocks)
    {
        for(Use* User_ : block->GetUserlist())
        {
            if(dynamic_cast<CondInst*>(User_->GetUser()) || dynamic_cast<UnCondInst*>(User_->GetUser()))
            {
                BasicBlock* pred = User_->GetUser()->GetParent();
                std::vector<BasicBlock*> LoopBody = loopInfo->GetLoopBody();
                if(std::find(LoopBody.begin(), LoopBody.end(), pred) == LoopBody.end())
                {
                    flag = true;
                    break;
                }
            }
        }
        if(flag)
            return false;
    }

    if(!loopInfo->GetSubLoop().empty())
        return false;
    
    if(exitblocks.size() != 1)
        return false;

    if(CanBeDelete(loopInfo))
        modified |= TryDeleteLoop(loopInfo);
    return modified;
}

bool LoopDeletion::CanBeDelete(LoopInfo* loopInfo)
{
    BasicBlock* ExitBlock = loop->GetExit(loopInfo)[0];

    Value * CommonValue;
    bool flag_common = true;
    bool flag_invariant = true;
    auto inst = ExitBlock->begin();
    while(auto Phi = dynamic_cast<PhiInst*>(*inst))
    {
        for(BasicBlock* block : loop->GetExitingBlock(loopInfo))
        {
            auto val = Phi->GetVal(block->num);
            if(CommonValue && val != CommonValue)
            {
                flag_common = false;
                break;
            }
            CommonValue = val;
        }
        if(!flag_common)
            break;
        
        if(auto Inst_Com = dynamic_cast<User*>(CommonValue))
        {
            if(!makeLoopInvariant(Inst_Com, loopInfo, loop->GetPreHeader(loopInfo)->back()))
            {
                flag_invariant = false;
                break;
            }
        }
        ++inst;
    }

    if(!flag_common || !flag_invariant)
        return false;

    for(User* inst : *loopInfo->GetHeader())
    {
      if(inst->HasSideEffect())
        return false;
    }
    
    for(BasicBlock* block : loopInfo->GetLoopBody())
    {
        for(User* inst : *block)
        {
            if(inst->HasSideEffect())
                return false;
        }
    }

    for(BasicBlock* block : loop->GetExitingBlock(loopInfo))
    {
      for(User* inst : *block)
      {
        if(inst->HasSideEffect())
          return false;
      }
    }

    for(User* inst : *loop->GetExit(loopInfo)[0])
    {
      if (inst->HasSideEffect())
        return false;
    }

  return true;
}

bool LoopDeletion::makeLoopInvariant(User* inst, LoopInfo* loopinfo, User* Termination)
{
    const std::set<BasicBlock*> contain{loopinfo->GetLoopBody().begin(), loopinfo->GetLoopBody().end()};
    if(LoopAnalysis::IsLoopInvariant(contain, inst, loopinfo))
      return true;
    if(dynamic_cast<LoadInst*>(inst))
      return false;
    if(!Termination)
    {
      BasicBlock* preheader = loop->GetPreHeader(loopinfo);
      if(!preheader)
        return false;
      Termination = preheader->back();
    }

    for(auto& use : inst->Getuselist())
    {
      if(!makeLoopInvariant(use->usee, loopinfo, Termination))
        return false;
    }

    {
      BasicBlock* block = Termination->GetParent();
      auto iter = block->begin();
      while(*iter != Termination)
        ++iter;
      inst->EraseFromParent();
      iter.insert_before(inst);
    }

    return true;
}

bool LoopDeletion::makeLoopInvariant(Value* val, LoopInfo* loopinfo, User* Termination)
{
  if(auto inst = dynamic_cast<User*>(val))
    return makeLoopInvariant(inst, loopinfo, Termination);
  return true;
}

bool LoopDeletion::TryDeleteLoop(LoopInfo* loopInfo)
{
  BasicBlock* Header = loopInfo->GetHeader();
  BasicBlock* exitblock = loop->GetExit(loopInfo)[0];
  loop->DeleteLoop(loopInfo);
  User* inst = exitblock->back();
  delete inst;
  UnCondInst* new_br = new UnCondInst(exitblock);
  Header->push_back(new_br);
  Function* func_ = Header->GetParent(); 
  for(BasicBlock* block : loopInfo->GetLoopBody())
  {
    func_->GetBasicBlock().erase(std::remove(func_->GetBasicBlock().begin(), 
    func_->GetBasicBlock().end(), block), func_->GetBasicBlock().end());
    // for(auto inst = block->rbegin(); inst != block->rend(); ++inst)
    // {

    //     (*inst)->ClearRelation();
    //     (*inst)->EraseFromParent();
    //     delete *inst;
    // }
    delete block;
  }
  return true;
}