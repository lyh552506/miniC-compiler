#pragma once
#include "../../lib/CFG.hpp"
#include "../opt/New_passManager.hpp"
#include "../opt/PassManagerBase.hpp"
class SideEffect : public _AnalysisManagerBase<SideEffect, Module>
{
    std::map<Function*, std::set<Function*>> CalleeFuncs;
    std::map<Function*, std::set<Function*>> CallingFuncs;
    std::set<Function*> RecursiveFuncs;
    Module* module;
private:
    bool Judge = false;
    void CreateCallMap(Function* func);
    void VisitFunc(Function* entry, std::set<Function*>& visited);
    void DetectRecursive();
    bool FuncHasSideEffect(Function* func);
    void CreateSideEffectFunc();
    bool RunOnModule(Module* mod);
public:
    SideEffect(Module* mod,bool Judge_Recursive=true) : module(mod),Judge(Judge_Recursive) {}
    void* GetResult() { RunOnModule(module); return this; }
};