#include "CFG.hpp"
#include "LoopInfo.hpp"
#include "dominant.hpp"
class Inline : public dominance
{
public:
    void RunOnFunction();
    void PrintPass();
    Inline(Function* f, int num) : func(f), dominance(f, num){}
private:
    int BlockNum;
    Function* func;
    void RemoveDeadFunction(Function* func);
    void inlineCalls(CallInst* call);
    bool shouldInline(CallInst* call);
    std::stack<CallInst*> callStack;
};