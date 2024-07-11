#include "CFG.hpp"
#include "PassManagerBase.hpp"
#include "New_passManager.hpp"

class StoreOnlyGlobalElimination : public _PassManagerBase<StoreOnlyGlobalElimination, Module>
{
private:
    std::vector<Variable*> storeOnlyGlobals;
    Module& module;
    _AnalysisManager &AM;
    void DetectStoreOnlyGlobal();
public:
    bool Run();
    StoreOnlyGlobalElimination(Module& m, _AnalysisManager &AM) : module(m), AM(AM) {storeOnlyGlobals.clear();}
};