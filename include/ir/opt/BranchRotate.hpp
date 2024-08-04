#pragma once
#include "../../lib/BaseCFG.hpp"
#include "../../lib/CFG.hpp"
#include "../Analysis/LoopInfo.hpp"
#include "../Analysis/SideEffect.hpp"
#include "../Analysis/dominant.hpp"
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"

class _AnalysisManager;
class BranchRotate : public _PassManagerBase<BranchRotate, Function>
{
  private:
    Function *func;
    _AnalysisManager &AM;
    std::unordered_map<BasicBlock*, std::set<BasicBlock*>> Successors;
    void ReWritePhi(std::vector<std::pair<BasicBlock*, std::set<PhiInst*>>>& NeedHandle);
    void CalCulateCycle();
    bool Handle(std::vector<std::pair<BasicBlock*, std::set<PhiInst*>>> &NeedHandle);
  public:
    BranchRotate(Function *func, _AnalysisManager &_AM) : func(func), AM(_AM)
    {
    }
    bool Run();
};