#pragma once
#include "../../lib/CFG.hpp"
#include "CSE.hpp"
#include "../Analysis/LoopInfo.hpp"
#include "New_passManager.hpp"
#include "../Analysis/dominant.hpp"

class LoopUnroll : public _PassManagerBase<LoopUnroll, Function> {
public:
  LoopUnroll(Function *func, _AnalysisManager &_AM) : m_func(func), AM(_AM) {}
  bool Run();

private:
  CallInst *ExtractLoopBody(LoopInfo *loop);
  void Unroll(LoopInfo *loop, CallInst *UnrollBody);
  Function *m_func;
  dominance *dom;
  LoopAnalysis *loopAnaly;
  _AnalysisManager &AM;
};