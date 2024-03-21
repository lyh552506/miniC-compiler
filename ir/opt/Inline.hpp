#include "CFG.hpp"
#include "LoopInfo.hpp"

class Inline
{
public:
    void RunOnFunction();
    void PrintPass();
    Inline(Function* f) : func(f) {}
private:
    Function* func;
};