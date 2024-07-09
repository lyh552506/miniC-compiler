#pragma once
#include "ConstantFold.hpp"
#include "PassManagerBase.hpp"
#include "New_passManager.hpp"
class ConstantProp : public FunctionPassManager
{  
    bool RunOnBlock(BasicBlock* block);
private:
    ConstantFolding* ConstFold;
public:
    bool RunOnFunction(Function* _func, _AnalysisManager& AM);
};
