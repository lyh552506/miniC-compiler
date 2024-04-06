#include "cfgSimplify.hpp"

#include <algorithm>
#include <iterator>

#include "BaseCFG.hpp"
#include "CFG.hpp"
#include "Singleton.hpp"

void cfgSimplify::RunOnFunction() {
  mergeRetBlock();
  simplify_Block();
  DealBrInst();
  DelSamePhis();
  //mergeSpecialBlock();
}

void cfgSimplify::mergeSpecialBlock() {
  int index = 0;
  while (index < m_func->GetBasicBlock().size()) {
    auto bb = m_func->GetBasicBlock()[index++];
    int pred_num = std::distance(m_dom->GetNode(bb->num).rev.begin(),
                                 m_dom->GetNode(bb->num).rev.end());
    if (pred_num == 0 || pred_num > 1) continue;
    BasicBlock* pred =
        m_dom->GetNode(m_dom->GetNode(bb->num).rev.front()).thisBlock;
    if (pred == bb) continue;
    ///@warning 此处暂时不考虑单个前驱依然存在phi函数的情况

    //确保前驱也只有一个后继
    auto& node = m_dom->GetNode(pred->num);
    int succ_num = std::distance(node.des.begin(), node.des.end());
    if (succ_num != 1 || node.des.front() != bb->num) continue;
    bb->RAUW(pred);
    User* cond = pred->back();
    cond->EraseFromParent();
    delete cond;
    //将后续的指令转移
    auto lastInstrIter = pred->rbegin();
    lastInstrIter.splice(bb->front());
    int length = m_func->GetBasicBlock().size();
    m_func->GetBasicBlock()[index - 1] = m_func->GetBasicBlock()[length - 1];
    m_func->GetBasicBlock().pop_back();
    bb->EraseFromParent();
  }
}

void cfgSimplify::mergeRetBlock() {
  BasicBlock* RetBlock = nullptr;
  int i = 0;
  while (i < m_func->GetBasicBlock().size()) {
    BasicBlock* bbs = m_func->GetBasicBlock()[i++];
    RetInst* ret = dynamic_cast<RetInst*>(bbs->back());
    if (!ret) continue;
    //找到对应的迭代器
    auto ret_iter = bbs->rbegin();
    if (ret != bbs->front()) {
      --ret_iter;
      if (!dynamic_cast<PhiInst*>(*ret_iter) || ret_iter != bbs->begin() ||
          ret->Getuselist().size() == 0 ||
          ret->Getuselist()[0]->GetValue() != *ret_iter)
        continue;
    }
    if (!RetBlock) {
      RetBlock = bbs;
      continue;
    }
    //找到了第二个符合条件的retblock
    if (ret->Getuselist().size() == 0 ||
        ret->Getuselist()[0]->GetValue() ==
            RetBlock->back()->Getuselist()[0]->GetValue()) {
      bbs->RAUW(RetBlock);
      bbs->EraseFromParent();
      m_func->GetBasicBlock()[i - 1] =
          m_func->GetBasicBlock()[m_func->GetBasicBlock().size() - 1];
      m_func->GetBasicBlock().pop_back();
      continue;
    }
    PhiInst* insert = dynamic_cast<PhiInst*>(RetBlock->front());
    if (!insert) {
      insert=PhiInst::NewPhiNode(
          RetBlock->front(), RetBlock,
          RetBlock->back()->Getuselist()[0]->GetValue()->GetType());
      Value* val=RetBlock->back()->Getuselist()[0]->GetValue();
      auto& node=m_dom->GetNode(RetBlock->num);
      for(int rev:node.rev){
        BasicBlock* pre=m_dom->node[rev].thisBlock;
        insert->updateIncoming(val,pre);
      }
      RetBlock->back()->RSUW(0,insert);
    }
    insert->updateIncoming(ret->Getuselist()[0]->GetValue(), bbs);
    ret->EraseFromParent();
    UnCondInst* uncond=new UnCondInst(RetBlock);
    bbs->push_back(uncond);
  }
}

void cfgSimplify::DelSamePhis() {
  int i = 0;
  BasicBlock* bb = m_func->GetBasicBlock()[i++];
  std::vector<PhiInst*>& phis = BlockToPhis[bb];
  for (auto iter = bb->begin(); iter != bb->end(); ++iter) {
    if (auto phi = dynamic_cast<PhiInst*>(*iter)) {
      if (std::find(phis.begin(), phis.end(), phi) == phis.end())
        phis.push_back(phi);
    } else
      break;

    if (phis.empty()) continue;
    //查找是否有相同phiinst
    for (int i = 0; i < phis.size(); ++i)
      for (int j = i + 1; j < phis.size(); ++j)
        if (phis[i]->IsSame(phis[j])) {
          phis[j]->ClearRelation();
          phis[j]->RAUW(phis[i]);
          phis[j]->EraseFromParent();
          //替换了phi后可能会对其他的phi造成影响，此处我们记录并在后续再进行循环
          i--;
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
          UnCondInst* uncond = new UnCondInst(ignore);
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