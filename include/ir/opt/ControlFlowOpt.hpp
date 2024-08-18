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

class ControlFlowOpt : public _PassManagerBase<ControlFlowOpt, Function>
{
  private:
    Function *func;
    dominance *DomTree;
    _AnalysisManager &AM;
    void init();
    bool RunOnBlock(BasicBlock* block);
  public:
    ControlFlowOpt(Function *func_, _AnalysisManager &AM_) : func(func_), AM(AM_)
    {
        init();
    }
    bool Run();
};