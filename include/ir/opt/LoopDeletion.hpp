#include "CFG.hpp"
#include "PassManagerBase.hpp"
#include "New_passManager.hpp"
#include "dominant.hpp"
#include "my_stl.hpp"
#include "LoopInfo.hpp"


class LoopDeletion : public _PassManagerBase<LoopDeletion, Function>
{
public:
    LoopDeletion(Function* m_func, _AnalysisManager &_AM) : func(m_func), AM(_AM) {}
    bool DetectDeadLoop(LoopInfo* loop);
    bool TryDeleteLoop(LoopInfo* loop);
    bool CanBeDelete(LoopInfo* loop);
    bool IsSafeToMove(User* inst);
    bool makeLoopInvariant(User* inst, LoopInfo* loop, User* Termination);
    bool makeLoopInvariant_val(Value* val, LoopInfo* loop, User* Termination);
    bool Run();
private:
    LoopAnalysis* loop;
    Function* func;
    dominance* dom;
    _AnalysisManager &AM;
};
