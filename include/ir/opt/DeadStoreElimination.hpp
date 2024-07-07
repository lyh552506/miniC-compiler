#include "CFG.hpp"
#include "dominant.hpp"
#include "PassManagerBase.hpp"

class DSE : public PassManagerBase
{
public:
    void RunOnFunction();
    void PrintPass();
    static bool isDeadInst(User* inst);
    DSE(Function* f) : func(f) {}
private:
    Function* func;
    void DSEInst(User* inst, std::vector<User*> &Worklist);
    void DetectRecursive();
    void VisitFunc(Function* entry, std::set<Function*>& visited);
    Value* RVACC(Function* func);
    bool FuncHasSideEffect(Function* func);
    void CreateCallMap();
    void CreateSideEffectFunc();
    std::set<Function*> Recursive_Funcs;
    bool DelF = false;
};