#include "lcssa.hpp"
#include "CFG.hpp"
#include "my_stl.hpp"
#include <cassert>
#include <utility>

void LcSSA::RunOnFunction() {
  loops = new LoopAnalysis(m_func, m_dom);
  loops->RunOnFunction();
  if (!loops->CanBeOpt())
    return;
  for (auto l = loops->begin(); l != loops->end(); l++) {
    DFSLoops(*l);
  }
}

void LcSSA::DFSLoops(LoopInfo *l) {
  std::vector<User *> FormingInsts;
  for (auto sub : *l) {
    DFSLoops(sub);
  }
  _DEBUG(std::cerr << "Start To Formal Loop: " << l->GetHeader()->GetName()
                   << std::endl;)
  std::set<BasicBlock *> ContainBB{l->GetLoopBody().begin(),
                                   l->GetLoopBody().end()};
  ContainBB.insert(l->GetHeader());
  for (const auto bb : ContainBB) {
    for (const auto inst : *bb) {
      if (inst->GetUserListSize() == 0)
        continue;
      for (const auto user : inst->GetUserlist()) {
        if (ContainBB.find(user->GetUser()->GetParent()) != ContainBB.end())
          FormingInsts.push_back(inst);
      }
    }
  }
  if (FormingInsts.empty())
    return;
  FormalLcSSA(l, ContainBB, FormingInsts);
}

void LcSSA::FormalLcSSA(LoopInfo *l, std::set<BasicBlock *> &ContainBB,
                        std::vector<User *> &FormingInsts) {
  std::vector<BasicBlock *> exit = loops->GetExitingBlock(l);
  std::vector<Use *> Rewrite; //记录inst的所有在外部use
  assert(exit.size() > 0);
  std::vector<User *> WorkLists;
  while (!FormingInsts.empty()) {
    auto target = PopBack(FormingInsts);
    for (auto use : target->GetUserlist()) {
      auto pbb = use->GetUser()->GetParent();
      if (auto phi = dynamic_cast<PhiInst *>(target)) {
        pbb = phi->ReturnBBIn(use);
      }
      if (!ContainBB.count(pbb))
        Rewrite.push_back(use);
    }
    if (Rewrite.empty())
      continue;
    for (auto ex : exit) {
      if (!m_dom->dominates(target->GetParent(), ex))
        continue;
      _DEBUG(std::cerr << "Insert a lcssa Phi: " << inst->GetName() + ".lcssa"
                       << std::endl;);
      auto phi = PhiInst::NewPhiNode(ex->front(), ex, target->GetType(),
                                     target->GetName() + ".lcssa");
      for (auto rev : m_dom->GetNode(ex->num).rev)
        phi->updateIncoming(target, m_dom->GetNode(rev).thisBlock);
      if (auto subloop = loops->LookUp(ex))
        if (l->Contain(subloop)) {
          assert(0 && "Find a situation");
        }
    }
    for (auto rewrite : Rewrite) {
      //TODO
    }
  }

  // while (!FormingInsts.empty()) {
  //   auto inst = FormingInsts.back();
  //   FormingInsts.pop_back();
  //   std::vector<Use *> Rewrite = UseRerite[inst];
  //   for (auto use : Rewrite) {
  //     auto ex = use->GetUser()->GetParent();
  //     if (m_dom->dominates(inst->GetParent(), ex)) {
  //       // if (dynamic_cast<PhiInst *>(use->GetUser())) {
  //       //   assert(0 && "Find a situation");
  //       // }
  //       _DEBUG(std::cerr << "Insert a lcssa Phi: " << inst->GetName() + ".lcssa"
  //                        << std::endl;);
  //       auto phi = PhiInst::NewPhiNode(ex->front(), ex, inst->GetType(),
  //                                      inst->GetName() + ".lcssa");
  //       for (auto rev : m_dom->GetNode(ex->num).rev)
  //         phi->updateIncoming(inst, m_dom->GetNode(rev).thisBlock);
  //       if (auto subloop = loops->LookUp(ex))
  //         if (l->Contain(subloop)) {
  //           assert(0 && "Find a situation");
  //         }
  //       // now do RAUW
  //       use->RemoveFromUserList(use->fat);
  //       use->SetValue() = phi;
  //       phi->GetUserlist().push_front(use);
  //     }
  //   }
  // }
}
