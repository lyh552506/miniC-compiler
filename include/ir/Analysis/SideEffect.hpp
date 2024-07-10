#include "CFG.hpp"
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"
class SideEffect : public _AnalysisManager
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
    bool RunOnModule(Module& mod, _AnalysisManager &AM);
};