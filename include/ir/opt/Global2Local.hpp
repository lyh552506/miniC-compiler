#include "CFG.hpp"

class Global2Local
{
    protected:
    int MaxNum = 5;
    std::map<Function*, std::set<Function*>> SuccFuncs;
    std::set<Function*> RecursiveFunctions;
    std::map<Variable*, std::set<Function*>> Global2Funcs;  // 哪些func 用了这个 globalvalue
    std::vector<User*> insert_insts;
    std::map<Function*, int> CallTimes;
    private:
    Module& module;
    void init();
    void createSuccFuncs();
    void DetectRecursive();
    void CalGlobal2Funcs();
    void visit(Function* func, std::set<Function*>& visited);
    void RunPass();
    void LocalGlobalVariable(Variable* val, Function* func);
    void LocalArray(Variable* arr, AllocaInst* alloca, BasicBlock* block);
    bool CanLocal(Variable* val, Function* func);
    bool CanLocal(Variable* val);
    void CreateCallNum();
    public:
    Global2Local(Module& m) :  module(m), insert_insts{}, SuccFuncs{}, \
    RecursiveFunctions{} {}
    void RunOnModule();
};
