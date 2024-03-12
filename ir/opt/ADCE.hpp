#include "CFG.hpp"

class ADCE
{
public:
    void Pass();
    ADCE(Function* func) : _func(func) {}
private:
    Function* _func;
    void AgressiveDCE(Function* func);
    bool IsInstHandleConst(User* inst);
};