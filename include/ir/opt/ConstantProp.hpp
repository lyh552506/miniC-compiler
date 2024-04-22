#pragma once
#include "ConstantFold.hpp"

class ConstantProp
{  
    void RunOnBlock(BasicBlock* block);
private:
    ConstantFolding* ConstFold;
    Function* _func;
public:
    void RunOnFunction();
    void PrintPass();

    ConstantProp(Function* func) : _func(func) {}
};
