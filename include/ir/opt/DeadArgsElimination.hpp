#include "CFG.hpp"
#include "PassManagerBase.hpp"
#include "New_passManager.hpp"
class DeadArgsElimination : public ModulePassManager
{
private:
    std::vector<std::pair<Value*, int>> wait_del;
public:
    bool RunOnModule(Module &mod, _AnalysisManager &AM);
    bool Detect_Dead_Args(Function* func);
};