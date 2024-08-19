#include "../../include/ir/opt/DCE.hpp"
#include "../../include/ir/Analysis/SideEffect.hpp"
#include "../../util/my_stl.hpp"
#include <algorithm>
bool DCE::Run() {
  bool mody = true;
  while (mody) {
    mody = false;
    AM.get<SideEffect>(&Singleton<Module>());
    Value *C = RVACC(func);
    if (dynamic_cast<UndefValue *>(C) && !func->HasSideEffect) {
      for (auto iter = func->rbegin(); iter != func->rend(); --iter) {
        bool NDelBlock = false;
        for (auto iter1 = (*iter)->rbegin(); iter1 != (*iter)->rend();
             --iter1) {
          if (!dynamic_cast<RetInst *>(*iter1)) {
            (*iter1)->ClearRelation();
            (*iter1)->EraseFromParent();
          } else
            NDelBlock = true;
        }
        if (!NDelBlock)
          (*iter)->EraseFromParent();
      }
      mody = true;
      PassChanged = true;
      continue;
    }
    if (C && !func->HasSideEffect) {
      for (auto user : func->GetUserlist()) {
        User *inst = user->GetUser();
        if (dynamic_cast<CallInst *>(inst)) {
          inst->RAUW(C);
          _DEBUG(std::cerr << "Delete Inst:" << inst->GetName() << "In Func:"
                           << inst->GetParent()->GetParent()->GetName()
                           << std::endl;)
          delete inst;
          mody = true;
          PassChanged = true;
          break;
        }
      }
      if (mody)
        continue;
      if (func->GetUserlist().is_empty() && func->GetBasicBlock().size() > 1) {
        func->clear();
        func->init_bbs();
        auto Block = new BasicBlock;
        auto ret = new RetInst(C);
        Block->push_back(ret);
        func->add_block(Block);
        func->GetBasicBlock().push_back(Block);
        mody = true;
        PassChanged = true;
      }
      if (mody)
        continue;
    }
    std::vector<User *> WorkList;
    for (BasicBlock *block : *func) {
      for (auto inst = block->rbegin(); inst != block->rend();) {
        auto in = *inst;
        --inst;
        if (std::find(WorkList.begin(), WorkList.end(), in) == WorkList.end())
          mody |= DCEInst(in, WorkList);
      }
    }
    while (!WorkList.empty()) {
      User *inst = WorkList.back();
      WorkList.pop_back();
      mody |= DCEInst(inst, WorkList);
    }
    if (mody) {
      PassChanged = true;
      continue;
    }
  }
  // AM.get<SideEffect>(&Singleton<Module>());
  // Value *C = RVACC(func);
  // if (dynamic_cast<UndefValue *>(C) && !func->HasSideEffect) {
  //   for (auto iter = func->rbegin(); iter != func->rend(); --iter) {
  //     bool NDelBlock = false;
  //     for (auto iter1 = (*iter)->rbegin(); iter1 != (*iter)->rend(); --iter1)
  //     {
  //       if (!dynamic_cast<RetInst *>(*iter1)) {
  //         (*iter1)->ClearRelation();
  //         (*iter1)->EraseFromParent();
  //       } else
  //         NDelBlock = true;
  //     }
  //     if (!NDelBlock)
  //       (*iter)->EraseFromParent();
  //   }
  //   return true;
  // }
  // if (C && !func->HasSideEffect) {
  //   bool changed = false;
  //   for (auto user : func->GetUserlist()) {
  //     User *inst = user->GetUser();
  //     if (dynamic_cast<CallInst *>(inst)) {
  //       inst->RAUW(C);
  //       _DEBUG(std::cerr << "Delete Inst:" << inst->GetName() << "In Func:"
  //                        << inst->GetParent()->GetParent()->GetName()
  //                        << std::endl;)
  //       delete inst;
  //       changed = true;
  //     }
  //   }
  //   if (func->GetUserlist().is_empty() && func->GetBasicBlock().size() > 1) {
  //     // for(auto iter = func->rbegin(); iter != func->rend(); --iter)
  //     // {
  //     //     auto block = (*iter);
  //     //     delete block;
  //     // }
  //     func->clear();
  //     func->init_bbs();
  //     auto Block = new BasicBlock;
  //     auto ret = new RetInst(C);
  //     Block->push_back(ret);
  //     func->add_block(Block);
  //     func->GetBasicBlock().push_back(Block);
  //     changed = true;
  //   }
  //   return changed;
  // }
  // bool modified = false;
  // std::vector<User *> WorkList;
  // for (BasicBlock *block : *func) {
  //   for (auto inst = block->rbegin(); inst != block->rend(); --inst) {
  //     if (std::find(WorkList.begin(), WorkList.end(), (*inst)) ==
  //         WorkList.end())
  //       modified |= DCEInst((*inst), WorkList);
  //   }
  // }
  // while (!WorkList.empty()) {
  //   User *inst = WorkList.back();
  //   WorkList.pop_back();
  //   modified |= DCEInst(inst, WorkList);
  // }
  return PassChanged;
}

bool DCE::DCEInst(User *inst, std::vector<User *> &Worklist) {
  if (isDeadInst(inst)) {
    for (auto &use_ : inst->Getuselist()) {
      Value *op = use_->usee;
      if (User *inst_ = dynamic_cast<User *>(op)) {
        if (isDeadInst(inst_))
          Worklist.push_back(inst_);
      }
    }
    // inst->ClearRelation();
    // inst->EraseFromParent();
    delete inst;
    return true;
  }
  return false;
}

bool DCE::isDeadInst(User *inst) {
  if (auto phi = dynamic_cast<PhiInst *>(inst)) {
    if (HandlePhi(phi)) {
      _DEBUG(std::cerr << "Handle Phi:" << phi->GetName()
                       << "in func :" << func->GetName() << std::endl;)
      return true;
    }
    return false;
  }
  if (!inst->GetUserlist().is_empty() || inst->IsTerminateInst())
    return false;
  if (!inst->HasSideEffect())
    return true;
  return false;
}

Value *DCE::RVACC(Function *func) {
  Value *RetVal = nullptr;
  for (BasicBlock *block : *func) {
    for (User *inst : *block) {
      if (auto PHiInst = dynamic_cast<PhiInst *>(inst)) {
        Value *CommonValue = nullptr;
        for (Value *income : PHiInst->GetAllPhiVal()) {
          if (auto _UndefValue = dynamic_cast<UndefValue *>(income))
            return nullptr;
          if (CommonValue && income != CommonValue)
            return nullptr;
          CommonValue = income;
        }
        if (CommonValue)
          inst->RAUW(CommonValue);
      }

      if (auto REtInst = dynamic_cast<RetInst *>(inst)) {
        if (inst->Getuselist().size() == 0)
          RetVal = nullptr;
        else {
          Value *Val = inst->Getuselist()[0]->usee;
          if (RetVal && RetVal != Val)
            return nullptr;
          RetVal = Val;
        }
      }
    }
  }
  if (RetVal && dynamic_cast<ConstantData *>(RetVal))
    return RetVal;
  return nullptr;
}

bool DCE::HandlePhi(PhiInst *inst) {
  if (inst->GetUserlist().GetSize() == 0)
    return true;
  if (inst->GetUserlist().GetSize() == 1) {
    User *user = inst->GetUserlist().Front()->GetUser();
    if (auto phi = dynamic_cast<PhiInst *>(user)) {
      std::set<PhiInst *> PotentiallyDeadPhis;
      PotentiallyDeadPhis.insert(inst);
      if (DeadPhiCycle(phi, PotentiallyDeadPhis)) {
        inst->RAUW(UndefValue::get(inst->GetType()));
        return true;
      }
    }

    if (user->GetUserlist().GetSize() == 1 &&
        (dynamic_cast<BinaryInst *>(user) ||
         dynamic_cast<GetElementPtrInst *>(user)) &&
        user->GetUserlist().Front()->GetUser() == inst) {
      inst->RAUW(UndefValue::get(inst->GetType()));
      return true;
    }
    return false;
  }
  return false;
}
bool DCE::DeadPhiCycle(PhiInst *phi, std::set<PhiInst *> &PotentiallyDeadPhis) {
  if (phi->GetUserlist().is_empty())
    return true;
  if (phi->GetUserlist().GetSize() != 1)
    return false;

  if (!PotentiallyDeadPhis.insert(phi).second)
    return true;
  if (PotentiallyDeadPhis.size() == 16)
    return false;
  User *user = phi->GetUserlist().Front()->GetUser();
  if (auto phi_ = dynamic_cast<PhiInst *>(user))
    return DeadPhiCycle(phi_, PotentiallyDeadPhis);
  return false;
}