#include "DeadStoreElimination.hpp"
#include "CFG.hpp"
#include "PassManagerBase.hpp"
#include "dominant.hpp"
#include "my_stl.hpp"

bool DeadStoreElimination::Run()
{
    dom = AM.get<dominance>(func);
    bool changed = false;
    for (BasicBlock* block : *func)
    {
        if(dom->dominates(dom->GetNode(0).thisBlock, block))
            changed |= EliminateDeadStores(block);
    }
    return changed;
}

bool DeadStoreElimination::EliminateDeadStores(BasicBlock* block)
{
    
}
