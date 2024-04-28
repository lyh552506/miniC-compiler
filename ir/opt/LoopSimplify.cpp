#include "LoopSimplify.hpp"

#include <cassert>
#include <set>
#include <utility>
#include <vector>

#include "BaseCFG.hpp"
#include "CFG.hpp"
#include "LoopInfo.hpp"
#include "my_stl.hpp"

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
    bool NeedToFormat = false;
    for (auto bb : exit) {
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
  // phase 4: update the phiNode
  std::set<BasicBlock *> work{OutSide.begin(), OutSide.end()};
  for (auto inst : *Header) {
    if (auto phi = dynamic_cast<PhiInst *>(inst))
      UpdatePhiNode(phi, work, preheader);
    else
      break;
  }
  // phase 5: update the rev and des
  for (auto bb : OutSide) {
    m_dom->GetNode(Header->num).rev.remove(bb->num);
    m_dom->GetNode(bb->num).des.remove(Header->num);
    m_dom->GetNode(bb->num).des.push_front(preheader->num);
  }
  m_dom->GetNode(Header->num).rev.push_front(preheader->num);
}

void LoopSimplify::FormatExit() {}

void LoopSimplify::UpdatePhiNode(PhiInst *phi, std::set<BasicBlock *> &outside,
                                 BasicBlock *PreHeader) {
  Value *ComingVal = nullptr;
  for (auto &[_1, tmp] : phi->PhiRecord) {
    if (outside.find(tmp.second) == outside.end()) {
      if (ComingVal == nullptr) {
        ComingVal = tmp.first;
        continue;
      }
      if (ComingVal != nullptr) {
        ComingVal = nullptr;
        break;
      }
    }
  }
  // outside传入的数据流对应的值为一个
  if (ComingVal) {
    std::vector<int> Erase;
    for (auto &[_1, tmp] : phi->PhiRecord) {
      if (outside.find(tmp.second) != outside.end()) {
        Erase.push_back(_1);
      }
    }
    for (auto i : Erase)
      phi->Del_Incomes(i);
    phi->updateIncoming(ComingVal, PreHeader);
    return;
  }
  //对应的传入值有多个
  std::vector<std::pair<int, std::pair<Value *, BasicBlock *>>> Erase;
  for (auto &[_1, tmp] : phi->PhiRecord) {
    if (outside.find(tmp.second) != outside.end()) {
      Erase.push_back(std::make_pair(_1, tmp));
    }
  }
  PhiInst *pre_phi =
      PhiInst::NewPhiNode(PreHeader->front(), PreHeader, phi->GetType());
  for (auto &[i, v] : Erase) {
    pre_phi->updateIncoming(v.first, v.second);
    phi->Del_Incomes(i);
  }
  phi->updateIncoming(pre_phi, PreHeader);
  return;
}