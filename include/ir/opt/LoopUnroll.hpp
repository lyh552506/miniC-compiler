#pragma once
#include "CFG.hpp"
#include "CSE.hpp"
#include "LoopInfo.hpp"
#include "New_passManager.hpp"
#include "dominant.hpp"

class LoopUnroll : public _PassManagerBase<LoopUnroll, Function> {
public:
  LoopUnroll(Function *func, _AnalysisManager &_AM) : m_func(func), AM(_AM) {}
  bool Run();
  Function* ExtractLoopBody(LoopInfo *loop);
private:
  Function *m_func;
  dominance* dom;
  LoopAnalysis* loopAnaly;
  _AnalysisManager &AM;
};