#pragma once
#include "CFG.hpp"
#include "LoopInfo.hpp"
#include "PassManagerBase.hpp"
#include "dominant.hpp"

class LcSSA : public PassManagerBase {
public:
  LcSSA(Function *func, dominance *dom) : m_func(func), m_dom(dom) {
  }
  void RunOnFunction();
  void PrintPass(){}
  void DFSLoops(LoopInfo* l);
  void FormalLcSSA(LoopInfo* l);
private:
  Function *m_func;
  LoopAnalysis *loops;
  dominance *m_dom;
};