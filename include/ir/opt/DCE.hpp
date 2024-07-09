#include "CFG.hpp"
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"
class DCE : public FunctionPassManager
{
public:
    bool RunOnFunction(Function* func, _AnalysisManager &AM);
    static bool isDeadInst(User* inst);
private:
    bool DelF = false;
    Function* func;
    bool DCEInst(User* inst, std::vector<User*> &Worklist);
    Value* RVACC(Function* func);
};