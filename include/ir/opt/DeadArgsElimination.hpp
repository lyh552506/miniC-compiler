#include "CFG.hpp"
#include "PassManagerBase.hpp"
#include "New_passManager.hpp"
class DeadArgsElimination : public _PassManagerBase<DeadArgsElimination, Module>
{
private:
    std::vector<std::pair<Value*, int>> wait_del;
    Module& mod;
    _AnalysisManager& AM;
public:
    bool Run();
    bool Detect_Dead_Args(Function* func);
    DeadArgsElimination(Module& m, _AnalysisManager& AM) : mod(m), AM(AM) {}
};