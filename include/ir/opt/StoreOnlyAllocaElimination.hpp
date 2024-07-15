#pragma once
#include "../../lib/CFG.hpp"
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"
class _AnalysisManager;

class StoreOnlyAllocaElimination : public _PassManagerBase<StoreOnlyAllocaElimination, Function>
{
  private:
    std::vector<AllocaInst *> storeOnlyAllocas;
    Function *func;
    _AnalysisManager &AM;
    bool DetectStoreOnlyAlloca();

  public:
    bool Run();
    StoreOnlyAllocaElimination(Function *f, _AnalysisManager &AM) : func(f), AM(AM)
    {
        storeOnlyAllocas.clear();
    }
};