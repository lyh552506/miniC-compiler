#include "CFG.hpp"
#include "dominant.hpp"
#include "PassManagerBase.hpp"
#include  "New_passManager.hpp"
class DSE : public _PassManagerBase<DSE, Function>
{
public:
    bool Run();
    DSE(Function* func_, _AnalysisManager &AM) : func(func_), AM(AM) {}
private:
    Function* func;
    _AnalysisManager &AM;
};