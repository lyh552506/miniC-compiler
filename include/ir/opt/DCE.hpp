#include "CFG.hpp"

class DCE
{
public:
    void RunOnFunction();
    void PrintPass();
    static bool isDeadInst(User* inst);
    DCE(Function* f) : func(f) {}
private:
    bool DelF = false;
    Function* func;
    void DCEInst(User* inst, std::vector<User*> &Worklist);
    Value* RVACC(Function* func);
    bool FuncHasSideEffect(Function* func);
};