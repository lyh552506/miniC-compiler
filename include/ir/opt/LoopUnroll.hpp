#pragma once
#include "../../lib/CFG.hpp"
#include "../Analysis/LoopInfo.hpp"
#include "../Analysis/dominant.hpp"
#include "CSE.hpp"
#include "New_passManager.hpp"

class LoopUnroll : public _PassManagerBase<LoopUnroll, Function> {
public:
  LoopUnroll(Function *func, _AnalysisManager &_AM) : m_func(func), AM(_AM) {}
  bool Run();

private:
  CallInst *ExtractLoopBody(LoopInfo *loop);
  void Unroll(LoopInfo *loop, CallInst *UnrollBody);
  void CanBeUnroll();
  Function *m_func;
  dominance *dom;
  LoopAnalysis *loopAnaly;
  _AnalysisManager &AM;
  int cost = 0; // gep: 4 ; load: 4 ;binary: 1; phi: 2
  const int MaxCost = 800;
};