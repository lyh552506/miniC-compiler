#include "lcssa.hpp"
#include "CFG.hpp"
#include "my_stl.hpp"
#include <cassert>
#include <utility>

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

  std::vector<User *> FormingInsts; //记录inst
  ContainBB.insert(l->GetHeader());
  std::vector<BasicBlock *> exit = loops->GetExitingBlock(l);
  assert(exit.size() > 0);
  std::vector<User *> WorkLists;
  for (auto bb : ContainBB) {
    for (auto exitBB : exit)
      if (bb != exitBB && m_dom->dominates(bb, exitBB)) {
        for (auto inst : *bb) {
          std::vector<Use *> Rewrite; //记录inst的所有在外部use
          if (inst->GetUserListSize() == 0)
            continue;
          for (auto user = inst->GetUserlist().begin();
               user != inst->GetUserlist().end(); ++user) {
            auto pbb = (*user)->GetUser()->GetParent();
            if (auto phi = dynamic_cast<PhiInst *>((*user)->GetUser())) {
              assert(0 && "this case is waiting to deal");
            }
            if (!ContainBB.count(pbb)) {
              FormingInsts.push_back(inst);
              Rewrite.push_back(*user);
            }
          }
          UseRerite[inst] = std::move(Rewrite);
        }
      }
  }
  if (FormingInsts.empty() || UseRerite.empty())
    return;
  while (!FormingInsts.empty()) {
    auto inst = FormingInsts.back();
    FormingInsts.pop_back();
    std::vector<Use *> Rewrite = UseRerite[inst];
    for (auto use : Rewrite) {
      auto ex = use->GetUser()->GetParent();
      assert(m_dom->dominates(inst->GetParent(), ex));
      if (dynamic_cast<PhiInst *>(use->GetUser())) {
        assert(0 && "Find a situation");
      }
      _DEBUG(std::cerr << "Insert a lcssa Phi: " << inst->GetName() + ".lcssa"
                       << std::endl;);
      auto phi = PhiInst::NewPhiNode(ex->front(), ex, inst->GetType(),
                                     inst->GetName() + ".lcssa");
      for (auto rev : m_dom->GetNode(ex->num).rev)
        phi->updateIncoming(inst, m_dom->GetNode(rev).thisBlock);
      if (auto subloop = loops->LookUp(ex))
        if (l->Contain(subloop)) {
          assert(0 && "Find a situation");
        }
      // now do RAUW
      use->GetValue();
    }
  }
}
