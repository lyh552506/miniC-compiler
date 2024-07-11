#pragma once
#include "ConstantFold.hpp"
#include "PassManagerBase.hpp"
#include "New_passManager.hpp"
class _AnalysisManager;
class ConstantProp : public _PassManagerBase<ConstantProp, Function>
{  
    bool RunOnBlock(BasicBlock* block);
private:
    ConstantFolding* ConstFold;
    Function* _func;
    _AnalysisManager& AM;
public:
    ConstantProp(Function* func_, _AnalysisManager &AM) : _func(func_), AM(AM) {}
    bool Run();
};
