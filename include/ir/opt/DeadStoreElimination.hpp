#include "CFG.hpp"
#include "dominant.hpp"
#include "PassManagerBase.hpp"
#include  "New_passManager.hpp"
class DSE : public FunctionPassManager
{
public:
    bool RunOnFunction(Function* func, _AnalysisManager &AM);
private:
};