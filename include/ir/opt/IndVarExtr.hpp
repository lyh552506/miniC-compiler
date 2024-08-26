#pragma once
#include "../../lib/BaseCFG.hpp"
#include "../../lib/CFG.hpp"
#include "../Analysis/LoopInfo.hpp"
#include "../Analysis/dominant.hpp"
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"
#include "lcssa.hpp"
#include <unordered_map>
#include <vector>
class _AnalysisManager;
class IndVarExtr : public _PassManagerBase<IndVarExtr, Function>
{
  public:
    IndVarExtr(Function *func_, _AnalysisManager &_AM) : func(func_), AM(_AM)
    {
        module = &Singleton<Module>();
    }
    bool Run();
    ~IndVarExtr()
    {
        for (auto l : DeleteLoop)
            delete l;
    }

  private:
    LoopAnalysis *loopAnlasis;
    Function *func;
    Function* curfunc;
    dominance *DomTree;
    _AnalysisManager &AM;
    Module* module;
    std::vector<LoopInfo *> DeleteLoop;
    std::vector<LoopInfo*> Loops;
    std::pair<User*, BasicBlock*> Judge(LoopInfo* loop);
    void HandleLoop(LoopInfo* loop, std::pair<User*, BasicBlock*> pair);
};