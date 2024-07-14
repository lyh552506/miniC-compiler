#pragma once
#include "CFG.hpp"
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"
class SideEffect : public _AnalysisManagerBase<SideEffect, Module>
{
    std::map<Function*, std::set<Function*>> CalleeFuncs;
    std::map<Function*, std::set<Function*>> CallingFuncs;
    std::set<Function*> RecursiveFuncs;
    Module* module;
private:
    void CreateCallMap(Function* func);
    void VisitFunc(Function* entry, std::set<Function*>& visited);
    void DetectRecursive();
    bool FuncHasSideEffect(Function* func);
    void CreateSideEffectFunc();
    bool RunOnModule(Module* mod);
public:
    explicit SideEffect(Module* mod) : module(mod) {}
    void* GetResult() { RunOnModule(module); return this; }
};