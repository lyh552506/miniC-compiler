#pragma once
#include "CFG.hpp"
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"
#include "dominant.hpp"
#include "my_stl.hpp"

class _AnalysisManager;
class DeadStoreElimination : public _PassManagerBase<DeadStoreElimination, Function>
{
  private:
    Function *func;
    _AnalysisManager &AM;
    dominance* dom;
    bool EliminateDeadStores(BasicBlock* block);
    bool HandleCall(CallInst* call);
    bool EliminateNoopStore(User* inst);
    bool IsRemovable(User* inst);
  public:
    DeadStoreElimination(Function *func_, _AnalysisManager &_AM) : func(func_), AM(_AM)
    {
    }
    bool Run();
};