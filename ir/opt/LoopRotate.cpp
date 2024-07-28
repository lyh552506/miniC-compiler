#include "../../include/ir/opt/LoopRotate.hpp"
#include "../../include/ir/Analysis/LoopInfo.hpp"
#include "../../include/ir/Analysis/SideEffect.hpp"
#include "../../include/ir/Analysis/dominant.hpp"
#include "../../include/ir/opt/ConstantFold.hpp"
#include "../../include/ir/opt/PassManagerBase.hpp"
#include "../../include/lib/BaseCFG.hpp"
#include "../../include/lib/CFG.hpp"
#include "Singleton.hpp"
#include <cassert>
#include <cstdlib>
#include <iterator>

bool LoopRotate::Run() {
  bool changed = false;
  m_dom = AM.get<dominance>(m_func);
  auto sideeffect = AM.get<SideEffect>(&Singleton<Module>());
  m_loopAnlasis = AM.get<LoopAnalysis>(m_func, m_dom);
  for (auto loop : *m_loopAnlasis) {
    changed |= TryRotate(loop);
    changed |= RotateLoop(loop);
  }
  return changed;
}

bool LoopRotate::RotateLoop(LoopInfo *loop) {
  if (loop->RotateTimes > 8)
    return false;
  if (loop->GetLoopBody().size() == 1)
    return false;
  loop->RotateTimes++;
  bool changed = false;
  m_dom = AM.get<dominance>(m_func);
  auto loopAnlasis = AM.get<LoopAnalysis>(m_func, m_dom);
  auto prehead = loopAnlasis->GetPreHeader(loop);
  auto header = loop->GetHeader();
  auto latch = loopAnlasis->GetLatch(loop);
  assert(latch && prehead && header && "After Simplify Loop Must Be Conon");
  if (!loopAnlasis->IsLoopExiting(loop, header)) {
    return false;
  }
  auto cond = dynamic_cast<CondInst *>(header->back());
  assert(cond && "Header Must have 2 succ: One is exit ,another is body");
  auto New_header = dynamic_cast<BasicBlock *>(cond->GetOperand(1));
  auto Exit = dynamic_cast<BasicBlock *>(cond->GetOperand(2));
  std::unordered_map<Value *, Value *> PreHeaderValue;
  // phase1: change th edge
  if (loop->Contain(Exit))
    std::swap(New_header, Exit);
  auto It = prehead->rbegin();
  assert(dynamic_cast<UnCondInst *>(*It));
  for (auto iter = header->begin(); iter != header->end();) {
    // condition提取到preheader，顺便做一些不变量提取
    auto inst = *iter;
    ++iter;
    if (auto phi = dynamic_cast<PhiInst *>(inst)) {
      PreHeaderValue[phi] = phi->ReturnValIn(prehead);
      continue;
    }
    const std::set<BasicBlock *> contain{loop->GetLoopBody().begin(),
                                         loop->GetLoopBody().end()};
    if (LoopAnalysis::IsLoopInvariant(contain, inst, loop) && CanBeMove(inst)) {
      inst->EraseFromParent();
      It.insert_before(inst);
      It = prehead->rbegin();
      continue;
    } else {
      auto new_inst = inst->CloneInst();
      //可能从phi提取出循环后变为了可简化的指令
      Value *simplify = nullptr;
      for (int i = 0; i < new_inst->Getuselist().size(); i++) {
        auto &use = new_inst->Getuselist()[i];
        if (PreHeaderValue.count(use->GetValue())) {
          auto tmp = PreHeaderValue[use->GetValue()];
          new_inst->RSUW(i, tmp);
        }
      }
      if (dynamic_cast<BinaryInst *>(new_inst) &&
          new_inst->GetOperand(0)->isConst() &&
          new_inst->GetOperand(1)->isConst()) {
        simplify = ConstantFolding::ConstFoldBinary(
            dynamic_cast<BinaryInst *>(new_inst)->getopration(),
            dynamic_cast<ConstantData *>(new_inst->GetOperand(0)),
            dynamic_cast<ConstantData *>(new_inst->GetOperand(1)));
      }
      if (simplify) {
        delete new_inst;
        PreHeaderValue[inst] = simplify;
        CloneMap[inst] = simplify;
      } else {
        PreHeaderValue[inst] = new_inst;
        new_inst->SetParent(prehead);
        It.insert_before(new_inst);
        It = prehead->rbegin();
        CloneMap[inst] = new_inst;
      }
    }
  }
  delete *It;
  prehead->back()->RSUW(1, New_header);
  prehead->back()->RSUW(2, Exit);
  m_dom->GetNode(Exit->num).rev.push_front(prehead->num);
  m_dom->GetNode(prehead->num).des.push_front(Exit->num);
  m_dom->GetNode(prehead->num).des.remove(header->num);
  m_dom->GetNode(header->num).rev.remove(prehead->num);
  m_dom->GetNode(New_header->num).rev.push_front(prehead->num);
  m_dom->GetNode(prehead->num).des.push_front(New_header->num);
  // Deal With Phi In header
  PreservePhi(header, loop, prehead, New_header, PreHeaderValue, loopAnlasis);
  if (dynamic_cast<CondInst *>(prehead->back()) &&
      dynamic_cast<ConstIRBoolean *>(prehead->back()->GetOperand(0))) {
    auto cond = dynamic_cast<CondInst *>(prehead->back());
    auto Bool =
        dynamic_cast<ConstIRBoolean *>(cond->Getuselist()[0]->GetValue());
    BasicBlock *nxt =
        dynamic_cast<BasicBlock *>(cond->Getuselist()[1]->GetValue());
    BasicBlock *ignore =
        dynamic_cast<BasicBlock *>(cond->Getuselist()[2]->GetValue());
    if (Bool->GetVal() == false) {
      std::swap(nxt, ignore);
    }
    for (auto iter = ignore->begin();
         iter != ignore->end() && dynamic_cast<PhiInst *>(*iter); ++iter) {
      auto phi = dynamic_cast<PhiInst *>(*iter);
      for (int i = 0; i < phi->PhiRecord.size(); i++) {
        if (phi->PhiRecord[i].second == prehead)
          phi->Del_Incomes(i);
      }
      phi->FormatPhi();
    }
    auto uncond = new UnCondInst(nxt);
    m_dom->GetNode(ignore->num).rev.remove(prehead->num);
    m_dom->GetNode(prehead->num).des.remove(ignore->num);
    prehead->rbegin().insert_before(uncond);
    delete cond;
  }
  loop->setHeader(New_header);
  SimplifyBlocks(header, loop);
  return changed;
}

bool LoopRotate::CanBeMove(User *I) {
  if (auto call = dynamic_cast<CallInst *>(I)) {
    if (!call->HasSideEffect())
      return true;
  } else if (auto bin = dynamic_cast<BinaryInst *>(I)) {
    return true;
  } else if (auto gep = dynamic_cast<GetElementPtrInst *>(I)) {
    return true;
  }
  return false;
}

void LoopRotate::PreservePhi(
    BasicBlock *header, LoopInfo *loop, BasicBlock *preheader,
    BasicBlock *new_header,
    std::unordered_map<Value *, Value *> &PreHeaderValue,
    LoopAnalysis *loopAnlasis) {
  // bool = true ---> outside the loop
  std::map<PhiInst *, std::map<bool, Value *>> RecordPhi;
  std::map<Value *, PhiInst *> NewInsertPhi;
  std::map<PhiInst *, PhiInst *> PhiInsert;
  for (auto des : m_dom->GetNode(header->num).des) {
    auto succ = m_dom->GetNode(des).thisBlock;
    for (auto iter = succ->begin();
         iter != succ->end() && dynamic_cast<PhiInst *>(*iter); ++iter) {
      auto phi = dynamic_cast<PhiInst *>(*iter);
      if (PreHeaderValue.find(phi->ReturnValIn(header)) != PreHeaderValue.end())
        phi->updateIncoming(PreHeaderValue[phi->ReturnValIn(header)],
                            preheader);
      else
        phi->updateIncoming(phi->ReturnValIn(header), preheader);
    }
  }
  // clear phi
  for (auto iter = header->begin();
       (iter != header->end()) && dynamic_cast<PhiInst *>(*iter); ++iter) {
    auto phi = dynamic_cast<PhiInst *>(*iter);
    for (int i = 0; i < phi->PhiRecord.size(); i++) {
      if (phi->PhiRecord[i].second == preheader) {
        RecordPhi[phi][true] = phi->PhiRecord[i].first;
        phi->Del_Incomes(i--);
        phi->FormatPhi();
        continue;
      }
      RecordPhi[phi][false] = phi->PhiRecord[i].first;
    }
  }
  //去掉preheader到header的边之后，现在loop有两个是数据流入口，需要更新phi
  // lcssa保证user在loop内
  for (auto inst : *header) {
    for (auto iter = inst->GetUserlist().begin();
         iter != inst->GetUserlist().end();) {
      auto use = *iter;
      ++iter;
      auto user = use->GetUser();
      auto targetBB = user->GetParent();
      if (targetBB == header)
        continue;
      if (!loop->Contain(targetBB))
        continue;
      if (targetBB == preheader) {
        continue;
      }
      if (auto phi = dynamic_cast<PhiInst *>(use->GetValue())) {
        if (PhiInsert.find(phi) == PhiInsert.end()) {
          assert(phi->PhiRecord.size() == 1);
          auto new_phi = PhiInst::NewPhiNode(new_header->front(), new_header,
                                             inst->GetType());
          for (auto [flag, val] : RecordPhi[phi]) {
            if (flag)
              new_phi->updateIncoming(RecordPhi[phi][flag], preheader);
            else
              new_phi->updateIncoming(RecordPhi[phi][flag], header);
          }
          user->RSUW(use, new_phi);
          PhiInsert[phi] = new_phi;
        } else {
          user->RSUW(use, PhiInsert[phi]);
        }
        if (auto p = dynamic_cast<PhiInst *>(use->GetUser())) {
          for (int i = 0; i < p->PhiRecord.size(); i++) {
            if (p->PhiRecord[i].first == phi) {
              p->PhiRecord[i].first = use->SetValue();
            }
          }
        }
        for (auto ex : loopAnlasis->GetExit(loop))
          for (auto _inst : *ex)
            if (auto p = dynamic_cast<PhiInst *>(_inst)) {
              auto it = std::find_if(
                  p->PhiRecord.begin(), p->PhiRecord.end(),
                  [new_header](
                      const std::pair<const int,
                                      std::pair<Value *, BasicBlock *>> &ele) {
                    return ele.second.second == new_header;
                  });
              if (it != p->PhiRecord.end()) {
                p->RSUW(it->first, PhiInsert[phi]);
                it->second.first = PhiInsert[phi];
                continue;
              }
              for (int i = 0; i < p->PhiRecord.size(); i++)
                if (p->PhiRecord[i].first == inst &&
                    p->PhiRecord[i].second != header) {
                  p->RSUW(i, PhiInsert[phi]);
                  p->PhiRecord[i].first = PhiInsert[phi];
                }
            }
      } else {
        auto usee = use->GetValue();
        if (NewInsertPhi.find(usee) == NewInsertPhi.end()) {
          auto cloned = CloneMap[usee];
          if (!cloned)
            continue;
          auto tmp = header;
          while (std::distance(m_dom->GetNode(tmp->num).rev.begin(),
                               m_dom->GetNode(tmp->num).rev.end()) == 1) {
            tmp = m_dom->GetNode((m_dom->GetNode(tmp->num).rev.front()))
                      .thisBlock;
          }
          auto new_phi =
              PhiInst::NewPhiNode(tmp->front(), tmp, inst->GetType());
          new_phi->updateIncoming(cloned, preheader);
          new_phi->updateIncoming(usee, header);
          user->RSUW(use, new_phi);
          NewInsertPhi[usee] = new_phi;
        } else {
          user->RSUW(use, NewInsertPhi[usee]);
        }
      }
    }
  }
}

void LoopRotate::SimplifyBlocks(BasicBlock *Header, LoopInfo *loop) {
  BasicBlock *Latch = nullptr;
  for (auto rev : m_dom->GetNode(Header->num).rev) {
    if (!Latch)
      Latch = m_dom->GetNode(rev).thisBlock;
    else {
      Latch = nullptr;
      break;
    }
  }
  assert(Latch && "Must Have One Latch!");
  for (auto iter = Header->begin();
       iter != Header->end() && dynamic_cast<PhiInst *>(*iter);) {
    auto phi = dynamic_cast<PhiInst *>(*iter);
    ++iter;
    if (phi->PhiRecord.size() == 1) {
      auto repl = (*(phi->PhiRecord.begin())).second.first;
      if (repl != phi) {
        phi->RAUW(repl);
        delete phi;
      }
    }
  }
  for (auto des : m_dom->GetNode(Header->num).des) {
    auto succ = m_dom->GetNode(des).thisBlock;
    for (auto inst : *succ) {
      if (auto phi = dynamic_cast<PhiInst *>(inst)) {
        // if (phi->GetName() == ".89.lcssa.0") {
        //   int a = 0;
        // }
        auto iter = std::find_if(
            phi->PhiRecord.begin(), phi->PhiRecord.end(),
            [Header](auto &ele) { return ele.second.second == Header; });
        if (iter == phi->PhiRecord.end())
          continue;
        iter->second.second = Latch;
      } else {
        break;
      }
    }
  }
  Header->RAUW(Latch);

  delete *(Latch->rbegin());
  auto iter = Header->begin();
  for (;;) {
    iter = Header->begin();
    if (iter == Header->end())
      break;
    auto inst = *iter;
    inst->EraseFromParent();
    inst->SetParent(Latch);
    Latch->push_back(inst);
  }
  m_loopAnlasis->DeleteBlock(Header);

  auto it = std::find(m_func->GetBasicBlock().begin(),
                      m_func->GetBasicBlock().end(), Header);
  m_func->GetBasicBlock().erase(it);
  delete Header;
  FunctionChange(m_func)
}

void LoopRotate::PreserveLcssa(BasicBlock *new_exit, BasicBlock *old_exit,
                               BasicBlock *pred) {
  for (auto inst : *old_exit)
    if (auto phi = dynamic_cast<PhiInst *>(inst))
      for (auto &[_1, val] : phi->PhiRecord)
        if (val.second == pred) {
          auto Insert =
              PhiInst::NewPhiNode(new_exit->front(), new_exit, phi->GetType());
          Insert->SetName(Insert->GetName() + ".lcssa");
          Insert->updateIncoming(val.first, pred);
          phi->RSUW(_1, Insert);
          phi->ModifyBlock(val.second, new_exit);
          phi->PhiRecord[_1] = std::make_pair(Insert, new_exit);
        }
}

bool LoopRotate::TryRotate(LoopInfo *loop) {
  bool Legal = false;
  auto latch = m_loopAnlasis->GetLatch(loop);
  auto head = loop->GetHeader();
  assert(latch);
  int pred = std::distance(m_dom->GetNode(latch->num).rev.begin(),
                           m_dom->GetNode(latch->num).rev.end());
  if (pred != 1)
    return false;
  auto PredBB =
      m_dom->GetNode(m_dom->GetNode(latch->num).rev.front()).thisBlock;
  for (auto des : m_dom->GetNode(PredBB->num).des) {
    auto succ = m_dom->GetNode(des).thisBlock;
    if (!loop->Contain(succ))
      Legal = true;
  }
  if (!Legal)
    return false;
  Legal = false;
  for (auto iter = latch->begin(); iter != latch->end();) {
    auto inst = *iter;
    ++iter;
    if (dynamic_cast<BinaryInst *>(inst))
      for (auto use : inst->GetUserlist()) {
        auto user = use->GetUser();
        if (loop->Contain(user->GetParent()))
          Legal = true;
      }
  }
  if (!Legal)
    return false;
  for (auto inst : *latch) {
    if (dynamic_cast<CondInst *>(inst) || dynamic_cast<UnCondInst *>(inst))
      break;
    auto it = PredBB->rbegin();
    inst->EraseFromParent();
    it.insert_before(inst);
  }
  auto cond = dynamic_cast<CondInst *>(PredBB->back());
  assert(cond);
  for (int i = 0; i < cond->Getuselist().size(); i++) {
    if (cond->GetOperand(i) == latch) {
      cond->RSUW(i, PredBB);
      m_loopAnlasis->DeleteBlock(latch);
      m_dom->GetNode(PredBB->num).des.remove(latch->num);
      m_dom->GetNode(head->num).rev.remove(latch->num);
      m_dom->GetNode(head->num).rev.push_front(PredBB->num);
      m_dom->GetNode(PredBB->num).des.push_front(head->num);
      for (auto inst : *head)
        if (auto phi = dynamic_cast<PhiInst *>(inst))
          phi->ModifyBlock(latch, PredBB);
      break;
    }
  }
  auto iter = std::find(m_func->GetBasicBlock().begin(),
                        m_func->GetBasicBlock().end(), latch);
  m_func->GetBasicBlock().erase(iter);
  delete latch;
  FunctionChange(m_func) return true;
}