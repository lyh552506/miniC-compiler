#pragma once
#include "../../lib/CFG.hpp"
#include "../Analysis/LoopInfo.hpp"
#include "BaseCFG.hpp"
#include "CSE.hpp"
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"
class _AnalysisManager;
class LoopParallel : public _PassManagerBase<LoopParallel, Function> {
public:
  LoopParallel(Function *func, _AnalysisManager &_AM) : m_func(func), AM(_AM) {}
  bool Run();
  Function& GetParallelFunc();
private:
  bool CanBeParallel(LoopInfo* loop);
  CallInst *ExtractLoopParallelBody(LoopInfo *loop);
  void ClearLoop(LoopInfo *loop);
  bool DependencyAnalysis(LoopInfo *loop);
  Value *FindPointBase(Value *val);
  LoopAnalysis *loop;
  Function *m_func;
  dominance *dom;
  _AnalysisManager &AM;
  LoopAnalysis *loopAnaly;
};
