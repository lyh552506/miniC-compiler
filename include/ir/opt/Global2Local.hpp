#include "CFG.hpp"

class Global2Local
{
    protected:
    std::vector<User*> insts;
    std::map<Function*, std::set<Function*>> SuccFuncs;
    std::set<Function*> RecursiveFunctions;
    private:
    Module& module;
    void init();
    void createSuccFuncs();
    void DetectRecursive();
    void visit(Function* func, std::set<Function*>& visited);
    void RunPass();
    void LocalGlobalVariable(Variable* val, Function* func);
    bool GetArrayinit(Variable* ptr, ConstantData* val);
    void LocalGep(Variable* val, Function* func);

    public:
    Global2Local(Module& m) :  module(m), insts{}, SuccFuncs{}, \
    RecursiveFunctions{} {}
    void RunOnModule();
};
