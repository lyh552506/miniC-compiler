#include "CFG.hpp"

class DCE
{
public:
    void RunOnFunction();
    void PrintPass();
    DCE(Function* f) : func(f) {}
private:
    bool DelF = false;
    Function* func;
    bool isDeadInst(User* inst);
    void DCEInst(User* inst, std::vector<User*> &Worklist);
    Value* RVACC(Function* func);
    bool FuncHasSideEffect(Function* func);
};