#include "CFG.hpp"
#include "dominant.hpp"
#include "LoopInfo.hpp"
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"
class Global2Local : public ModulePassManager
{
    protected:
    dominance* dom_info;
    LoopAnalysis* loopAnalysis;
    int MaxNum = 5;
    size_t CurrSize = 0;
    size_t MaxSize = 7864320;
    std::map<Function*, std::set<Function*>> SuccFuncs;
    std::set<Function*> RecursiveFunctions;
    std::map<Variable*, std::set<Function*>> Global2Funcs;  // 哪些func 用了这个 globalvalue
    std::vector<User*> insert_insts;
    std::map<Function*, int> CallTimes;
    private:
    void init(Module& module);
    void createSuccFuncs(Module& module);
    void DetectRecursive(Module& module);
    void CalGlobal2Funcs(Module& module);
    void visit(Function* func, std::set<Function*>& visited);
    void RunPass(Module& module);
    void LocalGlobalVariable(Variable* val, Function* func);
    void LocalArray(Variable* arr, AllocaInst* alloca, BasicBlock* block);
    bool CanLocal(Variable* val, Function* func);
    bool CanLocal(Variable* val);
    bool hasChanged(int index, Function* func);
    void CreateCallNum(Module& module);
    public:
    bool RunOnModule(Module& module, _AnalysisManager& AM);
};
