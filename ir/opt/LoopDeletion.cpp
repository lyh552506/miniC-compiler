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
      changed |= DetectDeadLoop(loop);
    }
}

bool LoopDeletion::RunOnFunc() {
  if(func->GetName() == "next_token")
    int c = 1;
    bool changed = false;
    loop = new LoopAnalysis(func, dom);
    loop->RunOnFunction();
    for (auto loop_ : *loop)
      changed |= DetectDeadLoop(loop_);
    return changed;
}
bool LoopDeletion::DetectDeadLoop(LoopInfo* loopInfo)
{
  // if(loopInfo->Ge)
    bool modified = false;
    BasicBlock* preheader = loop->GetPreHeader(loopInfo);
    if(loopInfo->GetHeader()->GetName() == ".79wc17")
      int c= 1;
    if(!preheader)
        return false;
    
    // bool flag = false;
    std::vector<BasicBlock*> exitblocks = loop->GetExit(loopInfo);
    auto test = loop->GetExitingBlock(loopInfo);
    // for(BasicBlock* block : exitblocks)
    // {
    //     for(Use* User_ : block->GetUserlist())
    //     {
    //         if(dynamic_cast<CondInst*>(User_->GetUser()) || dynamic_cast<UnCondInst*>(User_->GetUser()))
    //         {
    //             BasicBlock* pred = User_->GetUser()->GetParent();
    //             std::vector<BasicBlock*> LoopBody = loopInfo->GetLoopBody();
    //             if(std::find(LoopBody.begin(), LoopBody.end(), pred) == LoopBody.end())
    //             {
    //                 flag &= true;
    //             }
    //         }
    //     }
    //     if(flag)
    //         return false;
    // }

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
        std::vector<BasicBlock*> exitingBlocks = loop->GetExitingBlock(loopInfo);
        Value* firstval = Phi->ReturnValIn(exitingBlocks[0]);

        flag_common = std::all_of(exitingBlocks.begin(), exitingBlocks.end(),
        [Phi, firstval](BasicBlock* block) 
        { return Phi->ReturnValIn(block) == firstval; });

        if(!flag_common)
            break;
        
        if(auto Inst_Com = dynamic_cast<User*>(firstval))
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
    bool flag = false;
    if(LoopAnalysis::IsLoopInvariant(contain, inst, loopinfo))
      flag = true;
    if(!IsSafeToMove(inst))
      flag = false;
    if(!flag)
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
      if(!makeLoopInvariant_val(use->usee, loopinfo, Termination))
        return false;
    }
    {
      BasicBlock* block = Termination->GetParent();
      auto iter = block->begin();
      while(*iter != Termination)
        ++iter;
      // inst->ClearRelation();
      inst->EraseFromParent();
      iter.insert_before(inst);
    }

    return true;
}

bool LoopDeletion::makeLoopInvariant_val(Value* val, LoopInfo* loopinfo, User* Termination)
{
  if(auto inst = dynamic_cast<User*>(val))
    return makeLoopInvariant(inst, loopinfo, Termination);
  return true;
}

bool LoopDeletion::TryDeleteLoop(LoopInfo* loopInfo)
{
  _DEBUG(std::cerr<< "Try to delete loop:" << loopInfo->GetHeader()->GetName() << 
  "in func:" << func->GetName() <<"\n";)
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
  _DEBUG(std::cerr<<"Has Changed In Function:" << func->GetName() << "\n";)
  return true;
}

bool LoopDeletion::IsSafeToMove(User* inst)
{
  auto instid = inst->GetInstId();
  if(instid == User::OpID::Phi)
    return false;
  if(instid == User::OpID::Div)
  {
    if(auto CONST = dynamic_cast<ConstantData*>(inst->GetOperand(1)))
    {
      if(CONST->getNullValue(CONST->GetType()))
        return false;
    }
  }
  if(instid == User::OpID::Mod)
  {
    if(auto CONST = dynamic_cast<ConstantData*>(inst->GetOperand(1)))
    {
      if(CONST->getNullValue(CONST->GetType()))
        return false;
      if(auto INT = dynamic_cast<ConstIRInt*>(CONST))
      {
        if(INT->GetVal() == -1)
          return false;
      }
    }
  }
  if(instid == User::OpID::Load)
    return false;
  
  if(instid == User::OpID::Call)
  {
    if(inst->HasSideEffect())
      return false;
  }

  if(instid == User::OpID::Alloca || instid == User::OpID::Phi || instid == User::OpID::Store
  || instid == User::OpID::Ret || instid == User::OpID::UnCond || instid == User::OpID::Cond)
    return false;
  return true;
}