#include "LoopSimplify.hpp"

#include <cassert>
#include <vector>

#include "CFG.hpp"
#include "LoopInfo.hpp"

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
    if (!preheader) SimplifyPreHeader(L);
  }
}

void LoopSimplify::SimplifyPreHeader(LoopInfo* loop) {
  // phase 1：collect ouside block
  std::vector<BasicBlock*> OutSide;
  BasicBlock* Header = loop->GetHeader();
  for (auto rev : m_dom->GetNode(Header->num).rev)
    if (loopAnlay->LookUp(m_dom->GetNode(rev).thisBlock) != loop)
      OutSide.push_back(m_dom->GetNode(rev).thisBlock);
  assert(OutSide.size()>1);
  // phase 2: insert the preheader
  BasicBlock* preheader=new BasicBlock();
  m_func->InsertBlock(Header,preheader);
}