#include "CFG.hpp"
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"
class DCE : public _PassManagerBase<DCE, Function>
{
public:
    bool Run();
    static bool isDeadInst(User* inst);
    DCE(Function* func_, _AnalysisManager &AM) : func(func_), AM(AM) {}
private:
    bool DelF = false;
    Function* func;
    bool DCEInst(User* inst, std::vector<User*> &Worklist);
    Value* RVACC(Function* func);
    _AnalysisManager& AM;
};