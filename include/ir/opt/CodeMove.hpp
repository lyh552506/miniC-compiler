#pragma once
#include "../../../util/my_stl.hpp"
#include "../../lib/CFG.hpp"
#include "../Analysis/LoopInfo.hpp"
#include "../Analysis/SideEffect.hpp"
#include "../Analysis/dominant.hpp"
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"
class _AnalysisManager;

class CodeMove : public _PassManagerBase<CodeMove, Function>
{
  private:
    dominance *DomTree;
    Function *func;
    LoopAnalysis *Loop;
    _AnalysisManager &AM;
    std::vector<LoopInfo *> DeleteLoops;
    std::vector<LoopInfo *> Loops;
    std::unordered_map<BasicBlock*, std::vector<User*>> WaitHandle;
    std::vector<User*> MoveOut;
    std::unordered_set<Value*> MoveOutSet;
    void init();
    bool CodeMotion();
    void Collect();
    bool CanHandle(User* inst);
  public:
    CodeMove(Function *func_, _AnalysisManager &AM_) : func(func_), AM(AM_)
    {
        init();
    }
    ~CodeMove()
    {
        for(auto loop : Loops)
            delete loop;
    }
    bool Run();
};