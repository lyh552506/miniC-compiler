#pragma once
#include "CFG.hpp"
#include "LoopInfo.hpp"
#include "PassManagerBase.hpp"
#include "dominant.hpp"

class LoopRotate : public PassManagerBase {
public:
  LoopRotate(Function *func, dominance *dom) : m_func(func), m_dom(dom) {}
  void RunOnFunction() override;
  void PrintPass() override{};
  bool RotateLoop(LoopInfo *loop);
  bool CanBeMove(User *I);
private:
  LoopAnalysis *loopAnlasis;
  Function *m_func;
  dominance *m_dom;
  const int Heuristic = 8;
};