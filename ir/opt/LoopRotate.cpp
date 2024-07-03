#include "LoopRotate.hpp"
#include "BaseCFG.hpp"
#include "CFG.hpp"
#include "ConstantFold.hpp"
#include "LoopInfo.hpp"
#include "PassManagerBase.hpp"
#include "dominant.hpp"
#include <algorithm>
#include <cassert>
#include <optional>
#include <set>
#include <unordered_map>
#include <variant>

void LoopRotate::RunOnFunction() {
  bool changed = false;
  loopAnlasis = new LoopAnalysis(m_func, m_dom);
  loopAnlasis->RunOnFunction();
  for (auto loop : *loopAnlasis) {
    changed |= RotateLoop(loop);
  }
}

bool LoopRotate::RotateLoop(LoopInfo *loop) {
  if (loop->RotateTimes > 8)
    return false;
  bool changed = false;
  auto prehead = loopAnlasis->GetPreHeader(loop);
  auto header = loop->GetHeader();
  auto latch = loopAnlasis->GetLatch(loop);
  assert(latch && prehead && header && "After Simplify Loop Must Be Conon");
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
  for (auto iter = header->begin(); iter != header->end(); ++iter) {
    // condition提取到preheader，顺便做一些不变量提取
    auto inst = *iter;
    if (auto phi = dynamic_cast<PhiInst *>(inst)) {
      PreHeaderValue[phi] = phi->ReturnValIn(prehead);
      continue;
    }
    const std::set<BasicBlock *> contain{loop->GetLoopBody().begin(),
                                         loop->GetLoopBody().end()};
    if (LoopAnalysis::IsLoopInvariant(contain, inst, loop) && CanBeMove(inst)) {
      inst->EraseFromParent();
      It.insert_before(inst);
      continue;
    } else {
      auto new_inst = inst->CloneInst();
      //可能从phi提取出循环后变为了可简化的指令
      Value *simplify = nullptr;
      for (auto &use : new_inst->Getuselist()) {
        if (PreHeaderValue.count(use->GetValue())) {
          use->SetValue() = PreHeaderValue[use->GetValue()];
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
      if (simplify)
        PreHeaderValue[inst] = simplify;
      else {
        PreHeaderValue[inst] = new_inst;
        It.insert_before(new_inst);
      }
    }
  }
  delete *It;
  prehead->back()->Getuselist()[1]->SetValue() = header;
  prehead->back()->Getuselist()[2]->SetValue() = Exit;
  m_dom->GetNode(Exit->num).rev.push_front(prehead->num);
  m_dom->GetNode(prehead->num).des.push_front(Exit->num);
  m_dom->GetNode(prehead->num).des.remove(header->num);
  m_dom->GetNode(header->num).rev.remove(prehead->num);
  if (dynamic_cast<CondInst *>(prehead->back()) &&
      !dynamic_cast<ConstIRBoolean *>(prehead->back()->GetOperand(0))) {
    for (auto des : m_dom->GetNode(header->num).des) {
      auto succ = m_dom->GetNode(des).thisBlock;
      for (auto inst : *succ) {
        if (auto phi = dynamic_cast<PhiInst *>(inst)) {
          phi->updateIncoming(phi->ReturnValIn(header), prehead);
        }
      }
    }
    auto lr_ph = new BasicBlock();
    lr_ph->SetName(lr_ph->GetName() + ".lr_ph");
    m_func->push_back(lr_ph);

    //补充dom里面的node信息
    auto node = new dominance::Node;
    node->init();
    node->thisBlock = lr_ph;
    lr_ph->num = m_dom->node.size();
    node->des.push_front(header->num);
    node->rev.push_front(prehead->num);
    m_dom->GetNode(prehead->num).des.push_front(m_dom->node.size());
    m_dom->GetNode(header->num).rev.push_front(m_dom->node.size());

    m_dom->node.push_back(*node);

    m_func->InsertBlock(prehead, header, lr_ph);
    for (auto iter = header->begin();
         iter != header->end() && dynamic_cast<PhiInst *>(*iter) != nullptr;
         ++iter) {
      auto phi = dynamic_cast<PhiInst *>(*iter);
      phi->ModifyBlock(prehead, lr_ph);
    }
    // Form Exit
    for (auto rev : m_dom->GetNode(Exit->num).rev) {
      auto l = loopAnlasis->LookUp(m_dom->GetNode(rev).thisBlock);
      if (!l || l->Contain(Exit))
        continue;
      auto loopexit = new BasicBlock();
      loopexit->SetName(loopexit->GetName() + ".loopexit");
      m_func->push_back(loopexit);
      m_func->InsertBlock(header, Exit, loopexit);

      auto Node = new dominance::Node;
      Node->init();
      Node->thisBlock = loopexit;
      loopexit->num = m_dom->node.size();
      Node->des.push_front(Exit->num);
      Node->rev.push_front(header->num);
      m_dom->GetNode(header->num).des.remove(Exit->num);
      m_dom->GetNode(Exit->num).rev.remove(header->num);
      m_dom->GetNode(Exit->num).rev.push_front(loopexit->num);
      m_dom->GetNode(header->num).des.push_front(loopexit->num);
    }
  } else {
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
    auto uncond = new UnCondInst(nxt);
    m_dom->GetNode(ignore->num).rev.remove(prehead->num);
    m_dom->GetNode(prehead->num).des.remove(ignore->num);
    prehead->rbegin().insert_before(uncond);
    delete cond;
  }
  loop->setHeader(New_header);
  // Deal With Phi In header
  for (auto inst : *header) {
    for (auto use : inst->GetUserlist()) {
      auto user = use->GetUser();
      auto targetBB = user->GetParent();
      if (targetBB == header)
        continue;
    }
  }
  // clear phi
  // for (auto iter = header->begin();
  //      (iter != header->end()) && dynamic_cast<PhiInst *>(*iter); ++iter) {
  //   auto phi = dynamic_cast<PhiInst *>(*iter);
  //   for (int i = 0; i < phi->PhiRecord.size(); i++) {
  //     if (phi->PhiRecord[i].second == prehead) {
  //       phi->Del_Incomes(i);
  //     }
  //   }
  // }
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
  } else {
    return false;
  }
}

void LoopRotate::SimplifyBlocks(BasicBlock *Header, LoopInfo *loop) {
  BasicBlock *Latch = nullptr;
  for (auto rev : m_dom->GetNode(Header->num).rev) {
    if (!Latch)
      Latch = m_dom->GetNode(rev).thisBlock;
    else
      break;
  }
  assert(Latch && "Must Have One Latch!");
  for (auto iter = Header->begin();
       iter != Header->end() && dynamic_cast<PhiInst *>(*iter); ++iter) {
    auto phi = dynamic_cast<PhiInst *>(*iter);
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
    auto insert_iter = Latch->rbegin();
    inst->EraseFromParent();
    inst->SetParent(Latch);
    insert_iter.insert_after(inst);
  }

  delete Header;
}