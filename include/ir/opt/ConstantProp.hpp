#pragma once
#include "ConstantFold.hpp"
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"
class _AnalysisManager;
class ConstantProp : public _PassManagerBase<ConstantProp, Function>
{
    bool RunOnBlock(BasicBlock *block);

  private:
    ConstantFolding *ConstFold;
    bool ChangeCmpOp(User *inst);
    Function *_func;
    _AnalysisManager &AM;

  public:
    ConstantProp(Function *func_, _AnalysisManager &AM) : _func(func_), AM(AM)
    {
    }
    bool Run();
};
