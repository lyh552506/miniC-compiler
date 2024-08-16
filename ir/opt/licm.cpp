#include "../../include/ir/opt/licm.hpp"
#include "../../include/ir/Analysis/LoopInfo.hpp"
#include "../../include/lib/CFG.hpp"
#include <algorithm>
#include <cassert>
#include <cstdlib>

bool LICMPass::Run() {
  m_dom = AM.get<dominance>(m_func);
  loop = AM.get<LoopAnalysis>(m_func, m_dom, std::ref(DeleteLoop));
  alias = AM.get<AliasAnalysis>(m_func);
  auto side = AM.get<SideEffect>(&Singleton<Module>());
  bool changed = false;
  for (auto l = loop->begin(); l != loop->end(); l++) {
    changed |= RunOnLoop(*l);
  }
  return changed;
}

bool LICMPass::RunOnLoop(LoopInfo *l) {
  std::set<BasicBlock *> contain{l->GetLoopBody().begin(),
                                 l->GetLoopBody().end()};
  contain.insert(l->GetHeader());
  auto head = l->GetHeader();
  change |= licmSink(contain, l, head);
  change |= licmHoist(contain, l, head);
  return change;
}
// user在外部
bool LICMPass::licmSink(const std::set<BasicBlock *> &contain, LoopInfo *l,
                        BasicBlock *bb) {
  bool changed = false;
  if (contain.find(bb) == contain.end())
    return changed;
  //找到支配最低节点
  for (auto des : m_dom->GetNode(bb->num).idom_child) {
    auto child = m_dom->GetNode(des).thisBlock;
    change |= licmSink(contain, l, child);
  }
  //只处理当前循环bb
  if (loop->LookUp(bb) != l)
    return changed;
  for (auto iter = bb->rbegin(); iter != bb->rend(); --iter) {
    auto inst = *iter;
    if (UserOutSideLoop(contain, inst, l) && CanBeMove(l, inst)) {
      _DEBUG(std::cerr << "LICM START TO SINK CODE: " << inst->GetName()
                       << std::endl;)
      std::map<BasicBlock *, User *> InsertNew; //记录每个exit对应的
      for (auto user : inst->GetUserlist()) {
        auto phi = user->GetUser();
        assert(dynamic_cast<PhiInst *>(phi) &&
               "after lcssa user must be PhiInst");
        auto PBB = phi->GetParent();
        User *CloneInst = nullptr;
        if (InsertNew.find(PBB) == InsertNew.end()) {
          CloneInst = inst->CloneInst();
          CloneInst->SetName(inst->GetName() + ".licm");
          for (auto it = PBB->begin(); it != PBB->end(); ++it) {
            if (!dynamic_cast<PhiInst *>(*it)) {
              _DEBUG(std::cerr
                         << "LICM Move Invariant: " << CloneInst->GetName()
                         << " To ExitBlock" << PBB->GetName() << std::endl;)
              it.insert_before(CloneInst);
              break;
            }
          }
          InsertNew[PBB] = CloneInst;
        } else {
          CloneInst = InsertNew[PBB];
        }
        phi->RAUW(CloneInst);
        delete phi;
        changed = true;
      }
      assert(inst->GetUserListSize() == 0);
      delete inst;
    }
  }
  return changed;
}
// use都是不变量
bool LICMPass::licmHoist(const std::set<BasicBlock *> &contain, LoopInfo *l,
                         BasicBlock *bb) {
  bool changed = false;
  if (contain.find(bb) == contain.end())
    return changed;
  //只处理当前循环bb
  if (loop->LookUp(bb) != l)
    return changed;
  for (auto iter = bb->begin(); iter != bb->end(); ++iter) {
    auto inst = *iter;
    if (LoopAnalysis::IsLoopInvariant(contain, inst, l) && CanBeMove(l, inst)) {
      auto exit = loop->GetExit(l);
      if (!IsDomExit(inst, exit) && !UserInsideLoop(inst, l))
        continue;
      _DEBUG(std::cerr << "LICM START TO HOIST CODE: " << inst->GetName()
                       << std::endl;)
      auto prehead = loop->GetPreHeader(l, LoopAnalysis::Loose);
      assert(prehead);
      auto New_inst = inst->CloneInst();
      auto it = prehead->rbegin();
      _DEBUG(std::cerr << "LICM Move Invariant: " << inst->GetName()
                       << " To PreHeader" << prehead->GetName() << std::endl;)
      it.insert_before(New_inst);
      inst->RAUW(New_inst);
      delete inst;
      changed = true;
    }
  }
  for (auto des : m_dom->GetNode(bb->num).idom_child) {
    auto child = m_dom->GetNode(des).thisBlock;
    change |= licmHoist(contain, l, child);
  }
  return changed;
}

bool LICMPass::UserOutSideLoop(const std::set<BasicBlock *> &contain, User *I,
                               LoopInfo *curloop) {
  for (auto use : I->GetUserlist()) {
    auto userbb = use->GetUser()->GetParent();
    if (auto phi = dynamic_cast<PhiInst *>(use->GetUser())) {
      // check lcssa form
      bool IsLcssaPhi =
          std::all_of(phi->PhiRecord.begin(), phi->PhiRecord.end(),
                      [I](const auto &val) { return I == val.second.first; });
      if (IsLcssaPhi)
        continue;
      // true phi form
      bool IsPhiMoveable =
          std::all_of(phi->PhiRecord.begin(), phi->PhiRecord.end(),
                      [I, &contain](const auto &val) {
                        if (I == val.second.first)
                          if (contain.find(val.second.second) != contain.end())
                            return false;
                        return true;
                      });
      if (!IsPhiMoveable)
        return false;
    }
    if (contain.find(userbb) != contain.end())
      return false;
  }
  return true;
}

bool LICMPass::IsDomExit(User *I, std::vector<BasicBlock *> &exit) {
  assert(!exit.empty());
  auto targetbb = I->GetParent();
  for (auto ex : exit) {
    if (!m_dom->dominates(targetbb, ex))
      return false;
  }
  return true;
}

bool LICMPass::CanBeMove(LoopInfo *curloop, User *I) {
  if (auto ld = dynamic_cast<LoadInst *>(I)) {
    bool HaveSideEffect = false;
    for (auto use : ld->GetUserlist()) {
      auto user = use->GetUser();
      if (!curloop->Contain(user->GetParent()))
        continue;
      HaveSideEffect |= (!CanBeMove(curloop, user));
      if (HaveSideEffect)
        return false;
    }
    return HaveSideEffect;
  } else if (dynamic_cast<StoreInst *>(I)) {
    return false;
  } else if (dynamic_cast<PhiInst *>(I)) {
    return false;
  } else if (auto call = dynamic_cast<CallInst *>(I)) {
    auto target_func = dynamic_cast<Function *>(call->GetOperand(0));
    if (call->HasSideEffect())
      return false;
    if (target_func->MemRead())
      return false;
    if (target_func->MemWrite())
      return false;
  } else if (auto bin = dynamic_cast<BinaryInst *>(I)) {
    if (bin->IsAtomic())
      return false;
    return true;
  } else if (auto gep = dynamic_cast<GetElementPtrInst *>(I)) {
    auto hash = AliasAnalysis::GetHash(gep);
    auto ValueSet = alias->FindHashVal(hash);
    bool HaveSideEffect = false;
    for (auto g : ValueSet) {
      for (auto use : g->GetUserlist()) {
        auto user = use->GetUser();
        if (!curloop->Contain(user->GetParent()))
          continue;

        HaveSideEffect |= !CanBeMove(curloop, user);
        if (HaveSideEffect)
          return false;
      }
    }
    return HaveSideEffect;
  } else {
    return false;
  }
  return true;
}

bool LICMPass::UserInsideLoop(User *I, LoopInfo *curloop) {
  for (auto use : I->GetUserlist()) {
    if (!curloop->Contain(use->GetUser()->GetParent()))
      return false;
  }
  return true;
}