#pragma once
#include "../../lib/BaseCFG.hpp"
#include "../../lib/CFG.hpp"
#include "../Analysis/LoopInfo.hpp"
#include "../Analysis/dominant.hpp"
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"
#include "lcssa.hpp"
#include "licm.hpp"

class _AnalysisManager;

class ScalarStrengthReduce : public _PassManagerBase<ScalarStrengthReduce, Function>
{
  private:
    Function *func;
    dominance *DomTree;
    LoopAnalysis *Loop;
    _AnalysisManager &AM;
    std::vector<LoopInfo *> DeleteLoop;
    std::vector<LoopInfo*> Loops;
    void init();
    bool RunOnLoop(LoopInfo* loop);
    Value* CaculateTimes(LoopInfo* loop);
  public:
    ScalarStrengthReduce(Function *func_, _AnalysisManager &AM_) : func(func_), AM(AM_)
    {
        init();
    }
    ~ScalarStrengthReduce()
    {
        for (auto Loop : DeleteLoop)
            delete Loop;
    }
    bool Run();
};