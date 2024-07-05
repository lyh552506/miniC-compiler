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
    bool DetectDeadLoop(LoopInfo* loop, dominance* dom);
    bool DeleteLoop(LoopInfo* loop);
    bool CanBeDelete(LoopInfo* loop);
    bool makeLoopInvariant(User* inst, LoopInfo* loop, User* Termination);
    bool makeLoopInvariant(Value* val, LoopInfo* loop, User* Termination);
private:
    LoopAnalysis* loop;
    Function* func;
    dominance* dom;
};