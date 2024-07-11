#include "CFG.hpp"
#include "PassManagerBase.hpp"
#include "dominant.hpp"
#include "my_stl.hpp"
#include "LoopInfo.hpp"


class LoopDeletion : public PassManagerBase
{
public:
    LoopDeletion(Function* m_func, dominance* m_dom) : func(m_func), dom(m_dom) {}
    void RunOnFunction() override;
    bool DetectDeadLoop(LoopInfo* loop);
    bool TryDeleteLoop(LoopInfo* loop);
    bool CanBeDelete(LoopInfo* loop);
    bool IsSafeToMove(User* inst);
    bool makeLoopInvariant(User* inst, LoopInfo* loop, User* Termination);
    bool makeLoopInvariant_val(Value* val, LoopInfo* loop, User* Termination);
    bool RunOnFunc();
    void PrintPass() override{};
private:
    LoopAnalysis* loop;
    Function* func;
    dominance* dom;
};
