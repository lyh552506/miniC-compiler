#pragma once
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"

// This will only do a simple one with return func, which will not deal with return func + acc
class TailRecurseEliminator : public _PassManagerBase<TailRecurseEliminator, Function>{
    Function* func;
    static std::vector<std::pair<CallInst*,RetInst*>> CanTailRecurseTransform(Function*);
    std::pair<BasicBlock*,BasicBlock*> SeparateAllocaIntoEntryBlock();
    public:
    bool Run();
    TailRecurseEliminator(Function* _m,_AnalysisManager &AM):func(_m){}
};