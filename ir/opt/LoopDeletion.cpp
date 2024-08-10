#include "../../include/ir/opt/LoopDeletion.hpp"
#include "../../include/ir/Analysis/LoopInfo.hpp"
#include "../../include/ir/Analysis/SideEffect.hpp"
#include "../../include/ir/Analysis/dominant.hpp"
#include "../../include/ir/opt/ConstantFold.hpp"
#include "../../include/ir/opt/PassManagerBase.hpp"
#include "../../include/lib/BaseCFG.hpp"
#include "../../include/lib/CFG.hpp"
#include <algorithm>
#include <cassert>
#include <optional>
#include <set>
#include <unordered_map>
bool LoopDeletion::Run() {
  bool changed = false;
  dom = AM.get<dominance>(func);
  loop = AM.get<LoopAnalysis>(func, dom, std::ref(DeleteLoop));
  AM.get<SideEffect>(&Singleton<Module>());
  for (auto loop_ : loop->GetLoops())
    changed |= DetectDeadLoop(loop_);
  changed |= DeleteUnReachable();
  return changed;
}

bool LoopDeletion::DetectDeadLoop(LoopInfo *loopInfo) {
  bool modified = false;
  if (!loop->GetPreHeader(loopInfo))
    return false;

  if (!loopInfo->GetSubLoop().empty())
    return false;

  if (loop->GetExit(loopInfo).size() != 1)
    return false;

  if (CanBeDelete(loopInfo))
    modified |= TryDeleteLoop(loopInfo);
  return modified;
}

bool LoopDeletion::CanBeDelete(LoopInfo *loopInfo) {
  BasicBlock *ExitBlock = loop->GetExit(loopInfo)[0];

  Value *CommonValue;
  bool flag_common = true;
  bool flag_invariant = true;
  auto inst = ExitBlock->begin();
  while (auto Phi = dynamic_cast<PhiInst *>(*inst)) {
    std::vector<BasicBlock *> exitingBlocks = loop->GetExitingBlock(loopInfo);
    Value *firstval = Phi->ReturnValIn(exitingBlocks[0]);

    flag_common = std::all_of(exitingBlocks.begin(), exitingBlocks.end(),
                              [Phi, firstval](BasicBlock *block) {
                                return Phi->ReturnValIn(block) == firstval;
                              });

    if (!flag_common)
      break;

    if (auto Inst_Com = dynamic_cast<User *>(firstval)) {
      if (makeLoopInvariant(Inst_Com, loopInfo,
                            loop->GetPreHeader(loopInfo)->back()))
        Phi->ModifyBlock(exitingBlocks[0], loop->GetPreHeader(loopInfo));
      else {
        flag_invariant = false;
        break;
      }
    }
    ++inst;
  }

  if (!flag_common || !flag_invariant)
    return false;

  for (User *inst : *loopInfo->GetHeader()) {
    if (inst->HasSideEffect())
      return false;
  }

  for (BasicBlock *block : loopInfo->GetLoopBody()) {
    for (User *inst : *block) {
      if (inst->HasSideEffect())
        return false;
    }
  }

  for (BasicBlock *block : loop->GetExitingBlock(loopInfo)) {
    for (User *inst : *block) {
      if (inst->HasSideEffect())
        return false;
    }
  }

  for (User *inst : *loop->GetExit(loopInfo)[0]) {
    if (inst->HasSideEffect())
      return false;
  }

  return true;
}

bool LoopDeletion::isLoopInvariant(std::set<BasicBlock *> &blocks, User *inst) {
  for (auto user : inst->GetUserlist()) {
    if (user->GetUser() == inst)
      continue;
    if (blocks.count(user->GetUser()->GetParent()))
      return false;
  }
  return true;
}
bool LoopDeletion::makeLoopInvariant(User *inst, LoopInfo *loopinfo,
                                     User *Termination) {
  std::set<BasicBlock *> contain{loopinfo->GetLoopBody().begin(),
                                 loopinfo->GetLoopBody().end()};
  bool flag = false;
  if (!IsSafeToMove(inst))
    flag = false;
  if (isLoopInvariant(contain, inst))
    flag = true;
  if (!flag)
    return false;
  for (auto &use : inst->Getuselist()) {
    if (use->usee == inst && dynamic_cast<PhiInst *>(inst)) {
      auto phi = dynamic_cast<PhiInst *>(inst);
      if (phi->PhiRecord.size() == 2) {
        Value *val = nullptr;
        for (auto &[key, value] : phi->PhiRecord) {
          if (value.first != inst) {
            val = value.first;
            break;
          }
        }
        if (val) {
          phi->RAUW(val);
        }
      }
      continue;
    }

    if (!makeLoopInvariant_val(use->usee, loopinfo, Termination))
      return false;
  }

  return true;
}

bool LoopDeletion::makeLoopInvariant_val(Value *val, LoopInfo *loopinfo,
                                         User *Termination) {
  if (auto inst = dynamic_cast<User *>(val))
    return makeLoopInvariant(inst, loopinfo, Termination);
  return true;
}

bool LoopDeletion::TryDeleteLoop(LoopInfo *loopInfo) {
  _DEBUG(std::cerr << "Try to delete loop:" << loopInfo->GetHeader()->GetName()
                   << "in func:" << func->GetName() << "\n";)
  BasicBlock *Header = loopInfo->GetHeader();
  BasicBlock *Pre_Header = loop->GetPreHeader(loopInfo);
  BasicBlock *exitblock = loop->GetExit(loopInfo)[0];
  std::vector<BasicBlock *> exiting_blocks = loop->GetExitingBlock(loopInfo);
  User *Pre_Header_Exit = Pre_Header->back();
  for (auto &use : Pre_Header_Exit->Getuselist()) {
    auto exit = dynamic_cast<BasicBlock *>(use->usee);
    if (exit && exit == Header) {
      Pre_Header_Exit->RSUW(use.get(), exitblock);
    }
  }

  // handle exit phi
  auto exit_iter = exitblock->begin();
  while (auto phi = dynamic_cast<PhiInst *>(*exit_iter)) {
    phi->ModifyBlock(exiting_blocks[0], Pre_Header);
    for (int i = 1; i < exiting_blocks.size(); i++) {
      phi->EraseRecordByBlock(exiting_blocks[i]);
    }
    ++exit_iter;
  }

  Function *func_ = Pre_Header->GetParent();
  for (BasicBlock *block : loopInfo->GetLoopBody()) {
    // for(auto inst = block->rbegin(); inst != block->rend(); ++inst)
    // {

    //     (*inst)->ClearRelation();
    //     (*inst)->EraseFromParent();
    //     delete *inst;
    // }
    delete block;
  }
  loop->DeleteLoop(loopInfo);
  _DEBUG(std::cerr << "Has Changed In Function:" << func->GetName() << "\n";)
  return true;
}

bool LoopDeletion::IsSafeToMove(User *inst) {
  auto instid = inst->GetInstId();
  if (instid == User::OpID::Load)
    return false;

  if (instid == User::OpID::Call) {
    if (inst->HasSideEffect())
      return false;
  }

  if (instid == User::OpID::Alloca || instid == User::OpID::Phi ||
      instid == User::OpID::Store || instid == User::OpID::Ret ||
      instid == User::OpID::UnCond || instid == User::OpID::Cond)
    return false;
  return true;
}

bool LoopDeletion::DeleteUnReachable() {
  bool changed = false;
  std::vector<BasicBlock *> Erase;
  std::set<BasicBlock *> visited;
  std::vector<BasicBlock *> assist;
  assist.push_back(func->front());
  visited.insert(func->front());
  while (!assist.empty()) {
    auto bb = PopBack(assist);
    auto condition = bb->back();
    if (auto cond = dynamic_cast<CondInst *>(condition)) {
      auto nxt_1 = dynamic_cast<BasicBlock *>(cond->GetOperand(1));
      auto nxt_2 = dynamic_cast<BasicBlock *>(cond->GetOperand(2));
      if (visited.insert(nxt_1).second)
        assist.push_back(nxt_1);
      if (visited.insert(nxt_2).second)
        assist.push_back(nxt_2);
    } else if (auto uncond = dynamic_cast<UnCondInst *>(condition)) {
      auto nxt = dynamic_cast<BasicBlock *>(uncond->GetOperand(0));
      if (visited.insert(nxt).second)
        assist.push_back(nxt);
    }
  }
  for (auto it = func->begin(); it != func->end();) {
    auto bb = *it;
    ++it;
    if (visited.find(bb) == visited.end()) {
      _DEBUG(std::cerr << "Delete Unreachable block: " << bb->GetName()
                       << std::endl;)
      DeletDeadBlock(bb);
      changed = true;
    }
  }
  return changed;
}

void LoopDeletion::DeletDeadBlock(BasicBlock *bb) {
  auto &node = dom->GetNode(bb->num);
  // 维护后续的phi关系
  for (int des : node.des) {
    BasicBlock *succ = dom->GetNode(des).thisBlock;
    succ->RemovePredBB(bb);
  }
  for (auto iter = bb->begin(); iter != bb->end();) {
    User *inst = *iter;
    ++iter;
    inst->RAUW(UndefValue::get(inst->GetType()));
  }
  updateDTinfo(bb);
  // loopAnlaysis->DeleteBlock(bb);
  bb->Delete();
  dom->updateBlockNum()--;
}

void LoopDeletion::updateDTinfo(BasicBlock *bb) {
  auto &node = dom->GetNode(bb->num);
  std::vector<int> Erase;
  for (int rev : node.rev) {
    auto &pred = dom->GetNode(rev);
    pred.des.remove(bb->num);
  }
  for (int des : node.des) {
    auto &succ = dom->GetNode(des);
    succ.rev.remove(bb->num);
  }
}