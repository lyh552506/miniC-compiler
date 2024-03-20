#pragma once
#include "CFG.hpp"
#include <set>
class ADCE
{
public:
    void RunOnFunction();
    void PrintPass();
private:
    Function* _func;
    void SetInstAliveRelation(User* inst);
public:
    ADCE(Function* func) : _func(func) {}
};