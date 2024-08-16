#include "../../include/ir/opt/LoopSimplify.hpp"
#include "../../include/ir/Analysis/LoopInfo.hpp"
#include "../../include/ir/Analysis/dominant.hpp"
#include "../../include/lib/BaseCFG.hpp"
#include "../../include/lib/CFG.hpp"
#include "../../include/lib/Type.hpp"
#include "../../util/my_stl.hpp"
#include <algorithm>
#include <cassert>
#include <set>

bool LoopSimplify::Run() {
  bool changed = false;
  // if (m_func->tag != Function::Normal)
  //   return false;
  m_dom = AM.get<dominance>(m_func);
  loopAnlay = AM.get<LoopAnalysis>(m_func, m_dom, std::ref(DeleteLoop));
  //先处理内层循环
  for (auto iter = loopAnlay->begin(); iter != loopAnlay->end(); iter++) {
    auto loop = *iter;
    changed |= SimplifyLoopsImpl(loop);
    AM.AddAttr(loop->GetHeader(), Simplified);
  }
  SimplifyPhi();
  return changed;
}

void LoopSimplify::SimplifyPhi() {
  for (auto bb : *m_func)
    for (auto iter = bb->begin();
         iter != bb->end() && dynamic_cast<PhiInst *>(*iter);) {
      auto phi = dynamic_cast<PhiInst *>(*iter);
      ++iter;
      int num = 0;
      Value *Rep = nullptr;
      for (const auto &[index, val] : phi->PhiRecord) {
        if (val.first != phi) {
          num++;
          Rep = val.first;
          if (num > 1)
            break;
        }
      }
      if (num == 1) {
        phi->RAUW(Rep);
        delete phi;
      }
    }
}

bool LoopSimplify::SimplifyLoopsImpl(LoopInfo *loop) {
  bool changed = false;
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
    if (!preheader) {
      InsertPreHeader(L);
      changed |= true;
    }
    // step 2: deal with exit
    auto exit = loopAnlay->GetExit(L);
    for (int index = 0; index < exit.size(); ++index) {
      bool NeedToFormat = false;
      BasicBlock *bb = exit[index];
      for (auto rev : m_dom->GetNode(bb->num).rev) {
        if (!loopAnlay->IsLoopIncludeBB(L, rev))
          NeedToFormat = true;
      }
      if (!NeedToFormat)
        vec_pop(exit, index);
    }
    for (int index = 0; index < exit.size(); index++) {
      FormatExit(L, exit[index]);
      changed |= true;
      vec_pop(exit, index);
    }
    // step 3: deal with latch/back-edge
    BasicBlock *header = L->GetHeader();
    std::set<BasicBlock *> contain{L->GetLoopBody().begin(),
                                   L->GetLoopBody().end()};
    contain.insert(L->GetHeader());
    std::vector<BasicBlock *> Latch;
    for (auto rev : m_dom->GetNode(header->num).rev) {
      auto B = m_dom->GetNode(rev).thisBlock;
      if (B != preheader && contain.find(B) != contain.end())
        Latch.push_back(m_dom->GetNode(rev).thisBlock);
    }
    assert(!Latch.empty());
    if (Latch.size() > 1) {
      FormatLatch(loop, preheader, Latch);
      changed |= true;
    } else {
      loop->setLatch(Latch[0]);
    }
  }
  return changed;
}

void LoopSimplify::InsertPreHeader(LoopInfo *loop) {
  // phase 1：collect ouside block and inside block
  std::vector<BasicBlock *> OutSide;
  BasicBlock *Header = loop->GetHeader();
  std::set<BasicBlock *> contain{loop->GetLoopBody().begin(),
                                 loop->GetLoopBody().end()};
  for (auto rev : m_dom->GetNode(Header->num).rev)
    if (contain.find(m_dom->GetNode(rev).thisBlock) == contain.end())
      OutSide.push_back(m_dom->GetNode(rev).thisBlock);
  //  phase 2: insert the preheader
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
  UpdateInfo(OutSide, preheader, Header, loop);
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
  UpdateInfo(Inside, new_exit, exit, loop);
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
  // 传入的数据流对应的值为一个
  if (ComingVal) {
    // std::vector<int> Erase;
    for (auto &[_1, tmp] : phi->PhiRecord) {
      if (worklist.find(tmp.second) != worklist.end()) {
        tmp.second = target;
      }
    }
    // for (auto i : Erase)
    //   phi->Del_Incomes(i);
    // phi->updateIncoming(ComingVal, target);
    // phi->FormatPhi();

    return;
  }
  //对应的传入值有多个
  std::vector<std::pair<int, std::pair<Value *, BasicBlock *>>> Erase;
  for (auto &[_1, tmp] : phi->PhiRecord) {
    if (worklist.find(tmp.second) != worklist.end()) {
      Erase.push_back(std::make_pair(_1, tmp));
    }
  }
  bool same = std::all_of(Erase.begin(), Erase.end(), [&Erase](auto &ele) {
    return ele.second.first == Erase.front().second.first;
  });
  Value *sameval = Erase.front().second.first;
  if (same) {
    for (auto &[i, v] : Erase) {
      phi->Del_Incomes(i);
    }
    phi->updateIncoming(sameval, target);
    phi->FormatPhi();
    return;
  }
  PhiInst *pre_phi =
      PhiInst::NewPhiNode(target->front(), target, phi->GetType());
  for (auto &[i, v] : Erase) {
    pre_phi->updateIncoming(v.first, v.second);
    phi->Del_Incomes(i);
  }
  phi->updateIncoming(pre_phi, target);
  phi->FormatPhi();
  // if (phi->PhiRecord.size() == 1) {
  //   auto repl = GetOperand(phi, 0);
  //   phi->RAUW(repl);
  //   delete phi;
  // }
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
  UpdateInfo(latch, new_latch, head, loop);
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
  // UpdateInfo(Outer, out, L->GetHeader());
  //  TODO
  return nullptr;
}

void LoopSimplify::UpdateInfo(std::vector<BasicBlock *> &bbs,
                              BasicBlock *insert, BasicBlock *head,
                              LoopInfo *loop) {
  for (auto bb : bbs) {
    m_dom->GetNode(bb->num).des.remove(head->num);
    m_dom->GetNode(head->num).rev.remove(bb->num);
    m_dom->GetNode(bb->num).des.push_front(insert->num);
    m_dom->GetNode(insert->num).rev.push_front(bb->num);
  }
  m_dom->GetNode(head->num).rev.push_front(insert->num);
  m_dom->GetNode(insert->num).des.push_front(head->num);
  UpdateLoopInfo(head, insert, bbs);
}

void LoopSimplify::CaculateLoopInfo(LoopInfo *loop, LoopAnalysis *Anlay) {
  const auto Header = loop->GetHeader();
  const auto Latch = Anlay->GetLatch(loop);
  const auto br = dynamic_cast<CondInst *>(*(Latch->rbegin()));
  assert(br);
  const auto cmp = dynamic_cast<BinaryInst *>(GetOperand(br, 0));
  loop->trait.cmp = cmp;
  PhiInst *indvar = nullptr;
  auto indvarJudge = [&](User *val) -> PhiInst * {
    if (auto phi = dynamic_cast<PhiInst *>(val))
      return phi;
    for (auto &use : val->Getuselist()) {
      if (auto phi = dynamic_cast<PhiInst *>(use->GetValue())) {
        if (phi->GetParent() != Header)
          return nullptr;
        return phi;
      }
    }
    return nullptr;
  };
  for (auto &use : cmp->Getuselist()) {
    if (auto val = dynamic_cast<User *>(use->GetValue())) {
      if (dynamic_cast<PhiInst *>(val) && val->GetParent() != Header) {
        return;
      }
      if (auto phi = indvarJudge(val)) {
        if (!indvar) {
          indvar = phi;
          auto bin = dynamic_cast<BinaryInst *>(use->GetValue());
          if (!bin)
            return;
          loop->trait.change = bin;
          for (auto &use : bin->Getuselist()) {
            if (dynamic_cast<PhiInst *>(use->GetValue()))
              continue;
            if (auto con = dynamic_cast<ConstIRInt *>(use->GetValue()))
              loop->trait.step = con->GetVal();
          }
          continue;
        }
        if (indvar)
          assert(0 && "What happen?");
      }
    }
    if (!indvar)
      return;
    if (use->GetValue() != loop->trait.change) {
      loop->trait.boundary = use->GetValue();
    }
  }
  loop->trait.indvar = indvar;
  loop->trait.initial =
      indvar->ReturnValIn(Anlay->GetPreHeader(loop, LoopAnalysis::Loose));
}

void LoopSimplify::UpdateLoopInfo(BasicBlock *Old, BasicBlock *New,
                                  const std::vector<BasicBlock *> &pred) {
  auto l = loopAnlay->LookUp(Old);
  if (!l)
    return;
  LoopInfo *InnerOutside = nullptr;
  for (const auto pre : pred) {
    auto curloop = loopAnlay->LookUp(pre);
    while (curloop != nullptr && !curloop->Contain(Old))
      curloop = curloop->GetParent();
    if (curloop && curloop->Contain(Old) &&
        (!InnerOutside ||
         InnerOutside->GetLoopDepth() < curloop->GetLoopDepth()))
      InnerOutside = curloop;
    if (InnerOutside) {
      loopAnlay->setLoop(New, InnerOutside);
      while (InnerOutside != nullptr) {
        InnerOutside->InsertLoopBody(New);
        InnerOutside = InnerOutside->GetParent();
      }
    }
  }
}