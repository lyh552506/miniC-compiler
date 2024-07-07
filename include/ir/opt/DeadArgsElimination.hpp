#include "CFG.hpp"
#include "PassManagerBase.hpp"

class DeadArgsElimination
{
private:
    Module& module;
    std::vector<std::pair<Value*, int>> wait_del;
public:
    bool RunOnModule();
    void Detect_Dead_Args(Function* func);
    DeadArgsElimination(Module& m) : module(m) { wait_del.clear(); }
};