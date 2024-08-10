#include "../../include/ir/opt/BlockMerge.hpp"
#include "../../include/ir/Analysis/LoopInfo.hpp"
#include "../../include/lib/CFG.hpp"
#include "../../include/lib/Singleton.hpp"
#include <algorithm>
#include <cassert>
#include <cstdlib>
#include <iostream>
#include <iterator>
#include <memory>
#include <ostream>
#include <vector>

bool BlockMerge::Run() {
  bool keep_loop = true;
  FunctionChange(m_func) m_dom = AM.get<dominance>(m_func);
  while (keep_loop) {
    keep_loop = false;
    keep_loop |= simplify_Block(); 
    keep_loop |= DealBrInst();
    keep_loop |= simplify_Block();
    keep_loop |= DeleteUnReachable();
    keep_loop |= mergeSpecialBlock();
    keep_loop |= SimplifyUncondBr();
    keep_loop |= mergeRetBlock();
  }
  return false;
}

bool BlockMerge::EliminateDeadLoop() {
  bool changed = false;
  for (auto iter = loopAnlaysis->begin(); iter != loopAnlaysis->end(); iter++) {
    auto loop = *iter;
    auto header = loop->GetHeader();
    assert(header);
    bool ShoudDelet = true;
    for (auto rev : m_dom->GetNode(header->num).rev) {
      auto revbb = m_dom->GetNode(rev).thisBlock;
      if (!loop->Contain(revbb)) {
        ShoudDelet = false;
        break;
      }
    }
    // dead loop
    if (ShoudDelet) {
      _DEBUG(std::cerr << "EliminateLoop: " << loop->GetHeader()->GetName()
                       << std::endl;)
      for (auto loopbody : loop->GetLoopBody()) {
        auto it = std::find(m_func->GetBasicBlock().begin(),
                            m_func->GetBasicBlock().end(), loopbody);
        assert(it != m_func->GetBasicBlock().end());
        m_func->GetBasicBlock().erase(it);
        DeletDeadBlock(loopbody);
      }
      loopAnlaysis->DeleteLoop(loop);
      changed = true;
      break;
    }
  }
  return changed;
}

bool BlockMerge::mergeSpecialBlock() {
  bool changed = false;
  int index = 0;
  while (index < m_func->GetBasicBlock().size()) {
    auto bb = m_func->GetBasicBlock()[index++];
    int pred_num = std::distance(m_dom->GetNode(bb->num).rev.begin(),
                                 m_dom->GetNode(bb->num).rev.end());
    if (pred_num == 0 || pred_num > 1)
      continue;
    BasicBlock *pred =
        m_dom->GetNode(m_dom->GetNode(bb->num).rev.front()).thisBlock;
    if (pred == bb)
      continue;
    //确保前驱也只有一个后继,并且排除循环情况
    auto &node = m_dom->GetNode(pred->num);
    int succ_num = std::distance(node.des.begin(), node.des.end());
    if (succ_num != 1 || node.des.front() != bb->num)
      continue;
    auto iter = std::find(m_dom->GetNode(bb->num).des.begin(),
                          m_dom->GetNode(bb->num).des.end(), pred->num);
    if (iter != m_dom->GetNode(bb->num).des.end())
      continue;
    if (bb->back()->IsCondInst()) {
      if (dynamic_cast<PhiInst *>(bb->front()))
        continue;
      auto cond = dynamic_cast<CondInst *>(bb->back());
      BasicBlock *succ_1 =
          dynamic_cast<BasicBlock *>(cond->Getuselist()[1]->GetValue());
      BasicBlock *succ_2 =
          dynamic_cast<BasicBlock *>(cond->Getuselist()[2]->GetValue());
      if (dynamic_cast<PhiInst *>(succ_1->front()) ||
          dynamic_cast<PhiInst *>(succ_2->front()))
        continue;
      m_dom->GetNode(succ_1->num).rev.remove(bb->num);
      m_dom->GetNode(succ_2->num).rev.remove(bb->num);
      m_dom->GetNode(pred->num).des.remove(bb->num);
      m_dom->GetNode(succ_1->num).rev.push_front(pred->num);
      m_dom->GetNode(succ_2->num).rev.push_front(pred->num);
      m_dom->GetNode(pred->num).des.push_front(succ_1->num);
      m_dom->GetNode(pred->num).des.push_front(succ_2->num);
    } else if (bb->back()->IsUncondInst()) {
      BasicBlock *succ =
          dynamic_cast<BasicBlock *>(bb->back()->Getuselist()[0]->GetValue());
      if (dynamic_cast<PhiInst *>(succ->front()))
        continue;
      m_dom->GetNode(succ->num).rev.remove(bb->num);
      m_dom->GetNode(pred->num).des.remove(bb->num);
      m_dom->GetNode(succ->num).rev.push_front(pred->num);
      m_dom->GetNode(pred->num).des.push_front(succ->num);
    }
    User *cond = pred->back();
    delete cond;
    //将后续的指令转移
    for (auto i = bb->begin(); i != bb->end();) {
      auto inst = *i;
      ++i;
      inst->EraseFromParent();
      pred->push_back(inst);
    }
    _DEBUG(std::cerr << "Merge bb :" << bb->GetName()
                     << "to bb :" << pred->GetName() << std::endl;);
    int length = m_func->GetBasicBlock().size();
    m_func->GetBasicBlock()[index - 1] = m_func->GetBasicBlock()[length - 1];
    m_func->GetBasicBlock().pop_back();
    index--;
    DeletDeadBlock(bb);
    // if (nxt != nullptr) {
    //   m_dom->GetNode(nxt->num).rev.push_front(pred->num);
    //   m_dom->GetNode(pred->num).des.push_front(nxt->num);
    // }
    changed |= true;
  }
  return changed;
}

void BlockMerge::updateDTinfo(BasicBlock *bb) {
  auto &node = m_dom->GetNode(bb->num);
  std::vector<int> Erase;
  for (int rev : node.rev) {
    auto &pred = m_dom->GetNode(rev);
    pred.des.remove(bb->num);
  }
  for (int des : node.des) {
    auto &succ = m_dom->GetNode(des);
    succ.rev.remove(bb->num);
  }
}

bool BlockMerge::SimplifyUncondBr() {
  int index = 0;
  bool changed = false;
  while (index < m_func->GetBasicBlock().size()) {
    BasicBlock *bb = m_func->GetBasicBlock()[index++];
    User *inst = bb->back();
    if (dynamic_cast<UnCondInst *>(inst)) {
      //检查是否是empty block，在这里我们忽略其他phi存在情况，不值得花费太多时间
      if (*(bb->begin()) == inst)
        changed |= SimplifyEmptyUncondBlock(bb);
      else {
        auto To = dynamic_cast<BasicBlock *>(inst->GetOperand(0));
        int num = std::distance(m_dom->GetNode(To->num).rev.begin(),
                                m_dom->GetNode(To->num).rev.end());
        if (num == 1) {
          //  \  /
          //   bb
          //   |
          //   To
          delete bb->back();
          for (auto iter = To->begin(); iter != To->end();) {
            auto inst = *iter;
            if (auto phi = dynamic_cast<PhiInst *>(inst)) {
              // must be lcssa phi
              assert(phi->PhiRecord.size() == 1);
              //如果删除后还剩一个operand,检查是否是循环
              BasicBlock *b = phi->PhiRecord.begin()->second.second;
              if (b == To) {
                phi->RAUW(UndefValue::get(phi->GetType()));
                delete phi;
              } else {
                Value *repl = (*(phi->PhiRecord.begin())).second.first;
                if (repl == phi)
                  phi->RAUW(UndefValue::get(phi->GetType()));
                phi->RAUW(repl);
                delete phi;
              }
            }
            ++iter;
            inst->EraseFromParent();
            bb->push_back(inst);
          }
          for (auto des : m_dom->GetNode(To->num).des) {
            auto desBB = m_dom->GetNode(des).thisBlock;
            m_dom->GetNode(des).rev.push_front(bb->num);
            m_dom->GetNode(bb->num).des.push_front(des);
            for (auto iter = desBB->begin();
                 iter != desBB->end() && dynamic_cast<PhiInst *>(*iter);
                 ++iter) {
              auto phi = dynamic_cast<PhiInst *>(*iter);
              phi->ModifyBlock(To, bb);
            }
          }
          DeletDeadBlock(To);
          changed = true;
        }
      }
    } else
      continue;
  }
  return changed;
}

// 传入的bb满足：跳转语句是uncondbr，并且只有uncondinst这一条指令
bool BlockMerge::SimplifyEmptyUncondBlock(BasicBlock *bb) {
  if (bb->num == m_dom->GetNode(bb->num).idom)
    return false;
  BasicBlock *succ = dynamic_cast<BasicBlock *>(
      dynamic_cast<UnCondInst *>(bb->back())->GetOperand(0));
  assert(succ);
  for (int rev : m_dom->GetNode(bb->num).rev) {
    BasicBlock *pred = m_dom->GetNode(rev).thisBlock;
    //杜绝这种情况：
    //      pred
    //      / \
    //     bb  \
    //      \  /
    //      succ
    if (auto cond = dynamic_cast<CondInst *>(pred->back())) {
      BasicBlock *pred_succ_1 =
          dynamic_cast<BasicBlock *>(cond->Getuselist()[1]->GetValue());
      BasicBlock *pred_succ_2 =
          dynamic_cast<BasicBlock *>(cond->Getuselist()[2]->GetValue());
      if (pred_succ_1 == bb && pred_succ_2 == succ ||
          pred_succ_1 == succ && pred_succ_2 == bb)
        return false;
    }
  }
  //走到这里后能保证合并是安全的
  //  ... pred
  //    \ /  \
  //     bb  ...
  //     /
  //   succ
  if (std::distance(m_dom->GetNode(bb->num).rev.begin(),
                    m_dom->GetNode(bb->num).rev.end()) == 0)
    return true;
  for (auto iter = succ->begin(); iter != succ->end(); ++iter) {
    //更新succ的phi信息
    User *inst = *iter;
    if (auto phi = dynamic_cast<PhiInst *>(inst)) {
      auto it = std::find_if(
          phi->PhiRecord.begin(), phi->PhiRecord.end(),
          [bb](const std::pair<const int, std::pair<Value *, BasicBlock *>>
                   &ele) { return ele.second.second == bb; });
      if (it == phi->PhiRecord.end())
        continue;
      int times = 0;

      for (int rev : m_dom->GetNode(bb->num).rev) {
        if (times == 0)
          it->second.second = m_dom->GetNode(rev).thisBlock;
        else
          phi->updateIncoming(it->second.first, m_dom->GetNode(rev).thisBlock);
        times++;
      }
      phi->FormatPhi();
    } else
      break;
  }
  std::vector<std::pair<User *, int>> Erase;
  for (auto iter = bb->GetUserlist().begin(); iter != bb->GetUserlist().end();
       ++iter) {
    Use *tmp = *iter;
    auto pred = tmp->GetUser();
    int index;
    for (index = 0; index < pred->Getuselist().size(); index++)
      if (pred->Getuselist()[index]->GetValue() == bb) {
        Erase.push_back(std::make_pair(pred, index));
        break;
      }
  }
  for (int i = 0; i < Erase.size(); i++) {
    auto &[pred, index] = Erase[i];
    pred->RSUW(index, succ);
  }
  for (int rev : m_dom->GetNode(bb->num).rev) {
    m_dom->GetNode(succ->num).rev.push_front(rev);
    m_dom->GetNode(rev).des.push_front(succ->num);
  }
#ifdef DEBUG
  std::cerr << "Simplify Uncond Block" << bb->GetName() << std::endl;
#endif
  DeletDeadBlock(bb);
  return true;
}

bool BlockMerge::mergeRetBlock() {
  bool changed = false;
  BasicBlock *RetBlock = nullptr;
  int i = 0;
  while (i < m_func->GetBasicBlock().size()) {
    BasicBlock *bbs = m_func->GetBasicBlock()[i++];
    RetInst *ret = dynamic_cast<RetInst *>(bbs->back());
    if (!ret)
      continue;
    //找到对应的迭代器
    auto ret_iter = bbs->rbegin();
    if (ret != bbs->front()) {
      --ret_iter;
      if (!dynamic_cast<PhiInst *>(*ret_iter) || ret_iter != bbs->begin() ||
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
      std::vector<BasicBlock *> pred;
      std::vector<std::pair<User *, int>> Erase;
      for (auto list = bbs->GetUserlist().begin();
           list != bbs->GetUserlist().end(); ++list) {
        User *tmp = (*list)->GetUser();
        pred.push_back(tmp->GetParent());
        for (int j = 0; j < tmp->Getuselist().size(); ++j)
          if (tmp->Getuselist()[j]->GetValue() == bbs)
            Erase.push_back(std::make_pair(tmp, j));
      }
      for (auto &[user, index] : Erase)
        user->RSUW(index, RetBlock);
      m_func->GetBasicBlock()[i - 1] =
          m_func->GetBasicBlock()[m_func->GetBasicBlock().size() - 1];
      i--;
      m_func->GetBasicBlock().pop_back();
      changed |= true;
      m_dom->GetNode(RetBlock->num).rev.remove(bbs->num);
      for (auto PredBB : pred) {
        m_dom->GetNode(PredBB->num).des.remove(bbs->num);
        m_dom->GetNode(PredBB->num).des.push_front(RetBlock->num);
        m_dom->GetNode(RetBlock->num).rev.push_front(PredBB->num);
      }
      DeletDeadBlock(bbs);
      continue;
    }
    PhiInst *insert = dynamic_cast<PhiInst *>(RetBlock->front());
    if (!insert) {
      insert = PhiInst::NewPhiNode(
          RetBlock->front(), RetBlock,
          RetBlock->back()->Getuselist()[0]->GetValue()->GetType());
      Value *val = RetBlock->back()->Getuselist()[0]->GetValue();
      auto &node = m_dom->GetNode(RetBlock->num);
      for (int rev : node.rev) {
        BasicBlock *pre = m_dom->node[rev].thisBlock;
        insert->updateIncoming(val, pre);
      }
      RetBlock->back()->RSUW(0, insert);
    }
    insert->updateIncoming(ret->Getuselist()[0]->GetValue(), bbs);
    delete ret;
    UnCondInst *uncond = new UnCondInst(RetBlock);
    bbs->push_back(uncond);
    changed |= true;
    m_dom->GetNode(RetBlock->num).rev.push_front(bbs->num);
    m_dom->GetNode(bbs->num).des.push_front(RetBlock->num);
  }
  return changed;
}

bool BlockMerge::simplify_Block() {
  bool changed = false;
  int index = 0;
  std::set<BasicBlock *> WorkList{m_func->GetBasicBlock().begin(),
                                  m_func->GetBasicBlock().end()};
  while (!WorkList.empty()) {
    // BasicBlock *bb = m_func->GetBasicBlock()[index++];
    auto bb = *(WorkList.begin());
    WorkList.erase(bb);
    int pred_num = std::distance(m_dom->GetNode(bb->num).rev.begin(),
                                 m_dom->GetNode(bb->num).rev.end());
    if ((pred_num == 0 &&
         m_dom->GetNode(bb->num).idom != bb->num)) { //自循环会有专门的函数处理
#ifdef DEBUG
      std::cerr << "simplify_Block :" << bb->GetName() << std::endl;
#endif
      auto it = std::find(m_func->GetBasicBlock().begin(),
                          m_func->GetBasicBlock().end(), bb);
      m_func->GetBasicBlock().erase(it);

      DeletDeadBlock(bb);
      WorkList.insert(m_func->GetBasicBlock().begin(),
                      m_func->GetBasicBlock().end());
      changed = true;
    }
  }
  return changed;
}

bool BlockMerge::DealBrInst() {
  bool changed = false;
  for (auto bb : m_func->GetBasicBlock()) {
    User *x = bb->back();
    if (auto cond = dynamic_cast<CondInst *>(x)) {
      auto Bool =
          dynamic_cast<ConstIRBoolean *>(cond->Getuselist()[0]->GetValue());
      BasicBlock *pred = bb;
      BasicBlock *nxt =
          dynamic_cast<BasicBlock *>(cond->Getuselist()[1]->GetValue());
      BasicBlock *ignore =
          dynamic_cast<BasicBlock *>(cond->Getuselist()[2]->GetValue());
      if (Bool != nullptr) {
        if (Bool->GetVal() == true) {
          UnCondInst *uncond = new UnCondInst(nxt);
          auto tmp = pred->rbegin();
          tmp.insert_before(uncond);
#ifdef DEBUG
          std::cerr << "DealBr Delet condInst in block" << bb->GetName()
                    << std::endl;
#endif
          delete cond;
          ignore->RemovePredBB(pred);

          //更新m_dom相关参数
          m_dom->GetNode(ignore->num).rev.remove(pred->num);
          m_dom->GetNode(pred->num).des.remove(ignore->num);
        } else {
          UnCondInst *uncond = new UnCondInst(ignore);
          auto tmp = pred->begin();
          for (auto iter = pred->begin();; ++iter) {
            if (iter == pred->end())
              break;
            tmp = iter;
          }
          tmp.insert_before(uncond);
#ifdef DEBUG
          std::cerr << "DealBr Delet condInst in block" << bb->GetName()
                    << std::endl;
#endif
          delete cond;
          nxt->RemovePredBB(pred);
          m_dom->GetNode(nxt->num).rev.remove(pred->num);
          m_dom->GetNode(pred->num).des.remove(nxt->num);
        }
        changed = true;
      } else if (nxt == ignore) {
        UnCondInst *uncond = new UnCondInst(nxt);
        auto tmp = pred->begin();
        for (auto iter = pred->begin();; ++iter) {
          if (iter == pred->end())
            break;
          tmp = iter;
        }
        tmp.insert_before(uncond);
#ifdef DEBUG
        std::cerr << "DealBr Delet condInst in block" << bb->GetName()
                  << std::endl;
#endif
        delete cond;
        changed = true;
      }
    }
  }
  return changed;
}

void BlockMerge::DeletDeadBlock(BasicBlock *bb) {
  auto &node = m_dom->GetNode(bb->num);
  //维护后续的phi关系
  for (int des : node.des) {
    BasicBlock *succ = m_dom->GetNode(des).thisBlock;
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
  m_dom->updateBlockNum()--;
}

bool BlockMerge::DeleteUnReachable() {
  bool changed = false;
  std::vector<BasicBlock *> Erase;
  std::set<BasicBlock *> visited;
  std::vector<BasicBlock *> assist;
  assist.push_back(m_func->front());
  visited.insert(m_func->front());
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
  for (auto it = m_func->begin(); it != m_func->end();) {
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