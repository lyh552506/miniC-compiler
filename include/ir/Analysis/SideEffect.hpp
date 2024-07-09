#include "CFG.hpp"

class SideEffect
{
    std::map<Function*, std::set<Function*>> CalleeFuncs;
    std::map<Function*, std::set<Function*>> CallingFuncs;
    std::set<Function*> RecursiveFuncs;
    Module& module;
private:
    void CreateCallMap(Function* func);
    void VisitFunc(Function* entry, std::set<Function*>& visited);
    void DetectRecursive();
    bool FuncHasSideEffect(Function* func);
    void CreateSideEffectFunc();
public:
    SideEffect(Module& m) : module(m) { CalleeFuncs.clear(); CallingFuncs.clear(); RecursiveFuncs.clear(); }
    void RunOnModule();
};