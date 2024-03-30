#include "cfgSimplify.hpp"

void cfgSimplify::RunOnFunction() {
  simplify_Block();


}

void cfgSimplify::simplify_Block() {
  for (auto bb : m_func->GetBasicBlock()) {
    int pred_num = std::distance(m_dom->GetNode(bb->num).rev.begin(),
                                 m_dom->GetNode(bb->num).rev.end());
    if (pred_num == 0 ||
        (pred_num == 1 && m_dom->GetNode(bb->num).rev.front() == bb->num)) {
      bb->EraseFromParent();
      continue;
    }
  }
}

void cfgSimplify::DealBrInst(){
  
}