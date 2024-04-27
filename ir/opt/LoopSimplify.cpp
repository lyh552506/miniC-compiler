#include "LoopSimplify.hpp"

#include <cassert>
#include <set>
#include <vector>

#include "CFG.hpp"
#include "LoopInfo.hpp"
#include "my_stl.hpp"

void LoopSimplify::RunOnFunction() {
  loopAnlay->RunOnFunction();
  //先处理内层循环
  for (auto iter = loopAnlay->begin(); iter != loopAnlay->end(); iter++)
    SimplifyLoosImpl(*iter);
}

void LoopSimplify::SimplifyLoosImpl(LoopInfo* loop) {
  std::vector<LoopInfo*> WorkLists;
  WorkLists.push_back(loop);
  //将子循环递归的加入进来
  for (int i = 0; i < WorkLists.size(); i++) {
    LoopInfo* tmp = WorkLists[i];
    for (auto sub : *tmp) WorkLists.push_back(sub);
  }
  while (!WorkLists.empty()) {
    LoopInfo* L = WorkLists.back();
    WorkLists.pop_back();
    BasicBlock* preheader = loopAnlay->GetPreHeader(L);
    if (!preheader) InsertPreHeader(L);
  }
}

void LoopSimplify::InsertPreHeader(LoopInfo* loop) {
  // phase 1：collect ouside block and inside block
  std::vector<BasicBlock*> OutSide;
  BasicBlock* Header = loop->GetHeader();
  for (auto rev : m_dom->GetNode(Header->num).rev)
    if (loopAnlay->LookUp(m_dom->GetNode(rev).thisBlock) != loop)
      OutSide.push_back(m_dom->GetNode(rev).thisBlock);
  assert(OutSide.size() > 1);
  // phase 2: insert the preheader
  BasicBlock* preheader = new BasicBlock();
  preheader->SetName(preheader->GetName() + "_preheader");
  m_func->InsertBlock(Header, preheader);
#ifdef DEBUG
  std::cerr << "insert a preheader: " << preheader->GetName() << std::endl;
#endif
  // phase 3: update the rev and des
  for (auto target : OutSide) {
    auto condition = target->back();
    if (auto cond = dynamic_cast<CondInst*>(condition)) {
      for (int i = 0; i <= 2; i++)
        if (GetOperand(cond, i) == Header) cond->RSUW(i, preheader);
    } else if (auto uncond = dynamic_cast<UnCondInst*>(condition))
      uncond->RSUW(0, preheader);
  }
  // phase 4: update the phiNode
  std::set<BasicBlock*> work{OutSide.begin(), OutSide.end()};
  for (auto inst : *Header) {
    if (auto phi = dynamic_cast<PhiInst*>(inst)) {
      for (int i = 0; i < phi->PhiRecord.size(); i++) {
        if (work.find(phi->GetBlock(i)) == work.end()) continue;
        UpdatePhiNode(phi, work);
      }
    } else
      break;
  }
}

void LoopSimplify::UpdatePhiNode(PhiInst* phi, std::set<BasicBlock*>& outside) {
  
}