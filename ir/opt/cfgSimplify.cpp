#include "cfgSimplify.hpp"

#include "CFG.hpp"
#include "Singleton.hpp"

void cfgSimplify::RunOnFunction() {
  simplify_Block();
  DealBrInst();
}

void cfgSimplify::simplify_Block() {
  for (auto bb : m_func->GetBasicBlock()) {
    int pred_num = std::distance(m_dom->GetNode(bb->num).rev.begin(),
                                 m_dom->GetNode(bb->num).rev.end());
    if ((pred_num == 0 && m_dom->GetNode(bb->num).idom != bb->num) ||
        (pred_num == 1 && m_dom->GetNode(bb->num).rev.front() == bb->num)) {
      bb->EraseFromParent();
      continue;
    }
  }
}

void cfgSimplify::DealBrInst() {
  for (auto bb : m_func->GetBasicBlock()) {
    User* x = bb->back();
    if (auto cond = dynamic_cast<CondInst*>(x)) {
      Value* Bool = cond->Getuselist()[0]->GetValue();
    }
  }
}

void cfgSimplify::PrintPass() {
  std::cout << "-------cfgsimplify--------\n";
  Singleton<Module>().Test();
}