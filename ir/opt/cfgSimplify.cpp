#include "cfgSimplify.hpp"

#include "BaseCFG.hpp"
#include "CFG.hpp"
#include "Singleton.hpp"

void cfgSimplify::RunOnFunction() {
  DealBrInst();
  simplify_Block();
  DelSamePhis();
}

void cfgSimplify::DelUndefBlock(){
  
}

void cfgSimplify::DelSamePhis() {
  for (auto bb : m_func->GetBasicBlock()) {
    std::vector<PhiInst*> phis;
    for (auto iter = bb->begin(); iter != bb->end(); ++iter) {
      if (auto phi = dynamic_cast<PhiInst*>(*iter))
        phis.push_back(phi);
      else
        break;
    }
    if (phis.empty()) continue;
    for (int i = 0; i < phis.size(); ++i)
      for (int j = i + 1; j < phis.size(); ++j)
        if (phis[i]->IsSame(phis[j])) {
          phis[j]->ClearRelation();
          phis[j]->RAUW(phis[i]);
          phis[j]->EraseFromParent();
        }
  }
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
      auto Bool =
          dynamic_cast<ConstIRBoolean*>(cond->Getuselist()[0]->GetValue());
      BasicBlock* pred = bb;
      BasicBlock* nxt =
          dynamic_cast<BasicBlock*>(cond->Getuselist()[1]->GetValue());
      BasicBlock* ignore =
          dynamic_cast<BasicBlock*>(cond->Getuselist()[2]->GetValue());
      if (Bool != nullptr) {
        if (Bool->GetVal() == true) {
          UnCondInst* uncond = new UnCondInst(nxt);
          auto tmp = pred->begin();
          for (auto iter = pred->begin();; ++iter) {
            if (iter == pred->end()) break;
            tmp = iter;
          }
          tmp.insert_before(uncond);
          cond->ClearRelation();
          cond->EraseFromParent();
          ignore->RemovePredBB(pred);
          m_dom->update();
        } else {
          UnCondInst* uncond = new UnCondInst(nxt);
          auto tmp = pred->begin();
          for (auto iter = pred->begin();; ++iter) {
            if (iter == pred->end()) break;
            tmp = iter;
          }
          tmp.insert_before(uncond);
          cond->ClearRelation();
          cond->EraseFromParent();
          ignore->RemovePredBB(pred);
          m_dom->update();
        }
        return;
      } else if (nxt == ignore) {
        UnCondInst* uncond = new UnCondInst(nxt);
        auto tmp = pred->begin();
        for (auto iter = pred->begin();; ++iter) {
          if (iter == pred->end()) break;
          tmp = iter;
        }
        tmp.insert_before(uncond);
        cond->ClearRelation();
        cond->EraseFromParent();
        return;
      }
    }
  }
}

void cfgSimplify::PrintPass() {
  std::cout << "-------cfgsimplify--------\n";
  Singleton<Module>().Test();
}