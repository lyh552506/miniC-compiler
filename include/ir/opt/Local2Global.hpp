#pragma once
#include "CFG.hpp"
#include "LoopInfo.hpp"
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"
#include "dominant.hpp"
class _AnalysisManager;

class Local2Global : public _PassManagerBase<Local2Global, Module>
{
  private:
    Module *module;
    _AnalysisManager &AM;
    dominance *dom_info;
    LoopAnalysis *loopAnalysis;
    size_t MinSize = 419400;
    std::vector<Value *> Wait_Hoist;

  private:
    void CreateHoist();
    void RunPass();

  public:
    bool Run();
    Local2Global(Module *m, _AnalysisManager &AM) : module(m), AM(AM)
    {
    }
};