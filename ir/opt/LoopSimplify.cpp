#include "LoopSimplify.hpp"
#include "CFG.hpp"
#include "dominant.hpp"

void LoopSimplify::RunOnFunction() {
  loopAnlay->RunOnFunction();
  //先处理内层循环
  for (auto iter = loopAnlay->begin(); iter != loopAnlay->end(); iter++)
    SimplifyLoosImpl(*iter);
}

void LoopSimplify::SimplifyLoosImpl(LoopInfo *loop) {
  std::vector<LoopInfo *> WorkLists;
  WorkLists.push_back(loop);
  //将子循环递归的加入进来
  for (int i = 0; i < WorkLists.size(); i++) {
    LoopInfo *tmp = WorkLists[i];
    for (auto sub : *tmp)
      WorkLists.push_back(sub);
  }
  while (!WorkLists.empty()) {
    LoopInfo *L = WorkLists.back();
    WorkLists.pop_back();
    // step 1: deal with preheader
    BasicBlock *preheader = loopAnlay->GetPreHeader(L);
    if (!preheader)
      InsertPreHeader(L);
    // step 2: deal with exit
    auto exit = loopAnlay->GetExit(L);
    for (int index = 0; index < exit.size(); ++index) {
      bool NeedToFormat = false;
      BasicBlock *bb = exit[index];
      for (auto rev : m_dom->GetNode(bb->num).rev) {
        if (!loopAnlay->IsLoopIncludeBB(L,rev))
          NeedToFormat = true;
      }
      if (!NeedToFormat)
        vec_pop(exit, index);
    }
    for (int index = 0; index < exit.size(); index++) {
      FormatExit(L, exit[index]);
      vec_pop(exit, index);
    }
    // step 3: deal with latch/back-edge
    BasicBlock *header = L->GetHeader();
    std::vector<BasicBlock *> Latch;
    for (auto rev : m_dom->GetNode(header->num).rev) {
      auto B = m_dom->GetNode(rev).thisBlock;
      if (B != preheader && loopAnlay->LookUp(B) == L)
        Latch.push_back(m_dom->GetNode(rev).thisBlock);
    }
    if (Latch.size() > 1) {
      // if (Latch.size() < 8) {
      //   SplitNewLoop(loop);

      // }
      FormatLatch(loop, preheader, Latch);
    }
  }
}

void LoopSimplify::InsertPreHeader(LoopInfo *loop) {
  // phase 1：collect ouside block and inside block
  std::vector<BasicBlock *> OutSide;
  BasicBlock *Header = loop->GetHeader();
  for (auto rev : m_dom->GetNode(Header->num).rev)
    if (loopAnlay->LookUp(m_dom->GetNode(rev).thisBlock) != loop)
      OutSide.push_back(m_dom->GetNode(rev).thisBlock);
  assert(OutSide.size() > 1);
  // phase 2: insert the preheader
  BasicBlock *preheader = new BasicBlock();
  preheader->SetName(preheader->GetName() + "_preheader");
  m_func->InsertBlock(Header, preheader);
  dominance::Node Node;
  Node.thisBlock = preheader;
#ifdef DEBUG
  std::cerr << "insert a preheader: " << preheader->GetName() << std::endl;
#endif
  // phase 3: update the rev and des
  for (auto target : OutSide) {
    auto condition = target->back();
    if (auto cond = dynamic_cast<CondInst *>(condition)) {
      for (int i = 0; i <= 2; i++)
        if (GetOperand(cond, i) == Header)
          cond->RSUW(i, preheader);
    } else if (auto uncond = dynamic_cast<UnCondInst *>(condition))
      uncond->RSUW(0, preheader);
  }
  m_dom->node.push_back(Node);
  // phase 4: update the phiNode
  std::set<BasicBlock *> work{OutSide.begin(), OutSide.end()};
  for (auto inst : *Header) {
    if (auto phi = dynamic_cast<PhiInst *>(inst))
      UpdatePhiNode(phi, work, preheader);
    else
      break;
  }
  // phase 5: update the rev and des
  UpdateInfo(OutSide, preheader, Header);
  loop->setPreHeader(preheader);
}

void LoopSimplify::FormatExit(LoopInfo *loop, BasicBlock *exit) {
  std::vector<BasicBlock *> OutSide, Inside;
  for (auto rev : m_dom->GetNode(exit->num).rev) {
    if (loopAnlay->LookUp(m_dom->GetNode(rev).thisBlock) != loop)
      OutSide.push_back(m_dom->GetNode(rev).thisBlock);
    else
      Inside.push_back(m_dom->GetNode(rev).thisBlock);
  }
  BasicBlock *new_exit = new BasicBlock();
  new_exit->SetName(new_exit->GetName() + "_exit");
  m_func->InsertBlock(exit, new_exit);
  // update the node info
  dominance::Node Node;
  Node.thisBlock = new_exit;
  Node.des.push_front(exit->num);
#ifdef DEBUG
  std::cerr << "insert a exit: " << new_exit->GetName() << std::endl;
#endif
  for (auto bb : Inside) {
    auto condition = bb->back();
    Node.rev.push_front(bb->num);
    if (auto cond = dynamic_cast<CondInst *>(condition)) {
      for (int i = 0; i < 3; i++)
        if (GetOperand(cond, i) == exit)
          cond->RSUW(i, new_exit);
    } else if (auto uncond = dynamic_cast<UnCondInst *>(condition)) {
      uncond->RSUW(0, new_exit);
    }
  }
  m_dom->node.push_back(Node);
  std::set<BasicBlock *> work{Inside.begin(), Inside.end()};
  for (auto inst : *exit) {
    if (auto phi = dynamic_cast<PhiInst *>(inst))
      UpdatePhiNode(phi, work, new_exit);
    else
      break;
  }
  UpdateInfo(Inside, new_exit, exit);
}

void LoopSimplify::UpdatePhiNode(PhiInst *phi, std::set<BasicBlock *> &worklist,
                                 BasicBlock *target) {
  Value *ComingVal = nullptr;
  for (auto &[_1, tmp] : phi->PhiRecord) {
    if (worklist.find(tmp.second) != worklist.end()) {
      if (ComingVal == nullptr) {
        ComingVal = tmp.first;
        continue;
      }
      if (ComingVal != tmp.second) {
        ComingVal = nullptr;
        break;
      }
    }
  }
  // outside传入的数据流对应的值为一个
  if (ComingVal) {
    std::vector<int> Erase;
    for (auto &[_1, tmp] : phi->PhiRecord) {
      if (worklist.find(tmp.second) != worklist.end()) {
        Erase.push_back(_1);
      }
    }
    for (auto i : Erase)
      phi->Del_Incomes(i);
    phi->updateIncoming(ComingVal, target);
    phi->FormatPhi();
    return;
  }
  //对应的传入值有多个
  std::vector<std::pair<int, std::pair<Value *, BasicBlock *>>> Erase;
  for (auto &[_1, tmp] : phi->PhiRecord) {
    if (worklist.find(tmp.second) != worklist.end()) {
      Erase.push_back(std::make_pair(_1, tmp));
    }
  }
  PhiInst *pre_phi =
      PhiInst::NewPhiNode(target->front(), target, phi->GetType());
  for (auto &[i, v] : Erase) {
    pre_phi->updateIncoming(v.first, v.second);
    phi->Del_Incomes(i);
  }
  phi->updateIncoming(pre_phi, target);
  phi->FormatPhi();
  return;
}

void LoopSimplify::FormatLatch(LoopInfo *loop, BasicBlock *PreHeader,
                               std::vector<BasicBlock *> &latch) {
  BasicBlock *head = loop->GetHeader();
  BasicBlock *new_latch = new BasicBlock();
  new_latch->SetName(new_latch->GetName() + "_latch");
  dominance::Node Node;
  Node.thisBlock = new_latch;
#ifdef DEBUG
  std::cerr << "insert a latch: " << new_latch->GetName() << std::endl;
#endif
  m_func->InsertBlock(head, new_latch);
  std::set<BasicBlock *> work{latch.begin(), latch.end()};
  for (auto inst : *head) {
    if (auto phi = dynamic_cast<PhiInst *>(inst))
      UpdatePhiNode(phi, work, new_latch);
    else
      break;
  }
  for (auto bb : latch) {
    auto condition = bb->back();
    if (auto cond = dynamic_cast<CondInst *>(condition)) {
      for (int i = 0; i < 3; i++)
        if (GetOperand(cond, i) == head)
          cond->RSUW(i, new_latch);
    } else if (auto uncond = dynamic_cast<UnCondInst *>(condition)) {
      uncond->RSUW(0, new_latch);
    }
  }
  m_dom->node.push_back(Node);
  UpdateInfo(latch, new_latch, head);
  loop->setLatch(new_latch);
}
// need to ReAnlaysis loops （暂时先不使用这个功能）
LoopInfo *LoopSimplify::SplitNewLoop(LoopInfo *L) {
  BasicBlock *prehead = loopAnlay->GetPreHeader(L);
  PhiInst *target = nullptr;
  bool FindOne = false;
  for (auto inst : *(L->GetHeader())) {
    if (auto phi = dynamic_cast<PhiInst *>(inst)) {
      for (auto &[_1, val] : phi->PhiRecord) {
        if (val.first == phi) {
          target = phi;
          FindOne = true;
          break;
        }
      }
    } else
      return nullptr;
    if (FindOne)
      break;
  }
  assert(target && "phi in there must be a nullptr");
  std::vector<BasicBlock *> Outer;
  for (auto &[_1, val] : target->PhiRecord) {
    if (val.first != target)
      Outer.push_back(val.second);
  }
  BasicBlock *out = new BasicBlock();
  m_func->InsertBlock(L->GetHeader(), out);
  out->SetName(out->GetName() + "_out");
#ifdef DEBUG
  std::cerr << "insert a out: " << out->GetName() << std::endl;
#endif
  for (auto bb : Outer) {
    auto condition = bb->back();
    if (auto cond = dynamic_cast<CondInst *>(condition)) {
      for (int i = 0; i < 3; i++)
        if (GetOperand(cond, i) == L->GetHeader())
          cond->RSUW(i, out);
    } else if (auto uncond = dynamic_cast<UnCondInst *>(condition)) {
      uncond->RSUW(0, out);
    }
  }
  UpdateInfo(Outer, out, L->GetHeader());
  // TODO
}

void LoopSimplify::UpdateInfo(std::vector<BasicBlock *> &bbs,
                              BasicBlock *insert, BasicBlock *head) {
  for (auto bb : bbs) {
    m_dom->GetNode(bb->num).des.remove(head->num);
    m_dom->GetNode(head->num).rev.remove(bb->num);
    m_dom->GetNode(bb->num).des.push_front(insert->num);
    m_dom->GetNode(insert->num).rev.push_front(bb->num);
  }
  m_dom->GetNode(head->num).rev.push_front(insert->num);
  m_dom->GetNode(insert->num).des.push_front(head->num);
}