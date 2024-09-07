#pragma once
#include "../../../util/my_stl.hpp"
#include "../../include/lib/BaseCFG.hpp"
#include "../../include/lib/CFG.hpp"
#include "../Analysis/LoopInfo.hpp"
#include "../Analysis/dominant.hpp"
#include "LoopSimplify.hpp"
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"
class _AnalysisManager;

class Select2Branch : public _PassManagerBase<Select2Branch, Function>
{
  private:
    Function *func;
    _AnalysisManager &AM;
    std::vector<SelectInst*> Selects;
    void Collect();
    void HandleSelect(SelectInst* inst);
  public:
    Select2Branch(Function *func_, _AnalysisManager &AM_) : func(func_), AM(AM_)
    {
    }
    bool Run();
};