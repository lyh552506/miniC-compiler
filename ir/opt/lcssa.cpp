#include "lcssa.hpp"
#include "CFG.hpp"
#include "my_stl.hpp"
#include <cassert>

void LcSSA::RunOnFunction() {
  loops = new LoopAnalysis(m_func, m_dom);
  loops->RunOnFunction();
  for (auto l = loops->begin(); l != loops->end(); l++) {
    DFSLoops(*l);
  }
}

void LcSSA::DFSLoops(LoopInfo *l) {
  for (auto sub : *l) {
    DFSLoops(sub);
  }
  _DEBUG(std::cerr << "Start To Formal Loop: " << l->GetHeader()->GetName()
                   << std::endl;)
  FormalLcSSA(l);
}

void LcSSA::FormalLcSSA(LoopInfo *l) {
  std::set<BasicBlock *> ContainBB{l->GetLoopBody().begin(),
                                   l->GetLoopBody().end()};
  std::vector<User *> Rewrite;
  ContainBB.insert(l->GetHeader());
  std::vector<BasicBlock *> exit = loops->GetExitingBlock(l);
  assert(exit.size() > 0);
  std::vector<BasicBlock *> WorkLists;
  for (auto bb : ContainBB) {
    for (auto exitBB : exit)
      if (bb != exitBB && m_dom->dominates(bb, exitBB))
        WorkLists.push_back(bb);
  }
  if (WorkLists.empty())
    return;
  while (!WorkLists.empty()) {
    auto target = WorkLists.back();
    WorkLists.pop_back();
    for (auto inst : *target) {
      if (inst->GetUserListSize() == 0)
        continue;
      if (inst->GetUserListSize() == 1 &&
          inst->GetUserlist().Front()->GetUser()->GetParent() == target)
        continue;
      for (auto user = inst->GetUserlist().begin();
           user != inst->GetUserlist().end(); ++user) {
        auto pbb = (*user)->GetUser()->GetParent();
        if (auto phi = dynamic_cast<PhiInst *>((*user)->GetUser())) {
          assert(0 && "this case is waiting to deal");
        }
        if (!ContainBB.count(pbb)) {
          Rewrite.push_back(inst);
          break;
        }
      }
    }
  }
  if (Rewrite.empty())
    return;
  for (auto inst : Rewrite) {
    for (auto ex : exit) {
      if (!m_dom->dominates(inst->GetParent(), ex))
        continue;
      _DEBUG(std::cerr << "Insert a lcssa Phi: " << inst->GetName() + ".lcssa"
                       << std::endl;);
      auto phi = PhiInst::NewPhiNode(ex->front(), ex, inst->GetType(),
                                     inst->GetName() + ".lcssa");
      for (auto rev : m_dom->GetNode(ex->num).rev)
        phi->updateIncoming(inst, m_dom->GetNode(rev).thisBlock);
      if (loops->LookUp(ex) != l) {
        assert(0 && "Find a situation");
      }
    }
  }
  // now do RAUW
  
}
