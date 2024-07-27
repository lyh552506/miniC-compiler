#pragma once
#include "CFG.hpp"
#include "CSE.hpp"
#include "LoopInfo.hpp"
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"
class _AnalysisManager;
class LoopParallel : public _PassManagerBase<LoopParallel, Function> {
public:
  LoopParallel(Function *func, _AnalysisManager &_AM) : m_func(func), AM(_AM) {}
  bool Run();
  void ExtractLoopParallelBody(LoopInfo *loop);
  void ClearLoop(LoopInfo* loop);
private:
  LoopAnalysis *loop;
  Function *m_func;
  dominance *dom;
  _AnalysisManager &AM;
  LoopAnalysis *loopAnaly;
};
