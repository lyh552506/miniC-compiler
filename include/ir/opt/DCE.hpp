#include "CFG.hpp"

class DCE
{
public:
    void RunOnFunction();
    void PrintPass();
    static bool isDeadInst(User* inst);
    DCE(Function* f) : func(f) {}
private:
    std::set<Function*> Recursive_Funcs;
    bool DelF = false;
    Function* func;
    void DCEInst(User* inst, std::vector<User*> &Worklist);
    Value* RVACC(Function* func);
};