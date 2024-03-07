#include "DeadCodeEliminate.hpp"

void DeadCodeEliminate::Pass(Module* module)
{
    deleteDeadFunc(module);
    detectNotSideEffectFunc(module);
    for(auto &_func : module->GetFuncTion()) 
    {
        Function* func = _func.get();
        if(func != module->getMainFunc())
            deleteDeadRet(func);   
    }
    for(auto &_func : module->GetFuncTion()) 
    {
        Function* func = _func.get();
        deleteDeadInst(func);
        deleteDeadStore(func);
        deleteDeadInst(func);
    }
}

void DeadCodeEliminate::deleteDeadFunc(Module* module)
{
    func_counter = 0;
    for(auto &_func : module->GetFuncTion()) 
    {
        Function* func = _func.get();
        if(func->GetBasicBlock().empty())
            continue;
    }
}

void DeadCodeEliminate::detectNotSideEffectFunc(Module* module)
{
    for(auto &_func : module->GetFuncTion()) 
    {
        Function* func = _func.get();

    }
}

void DeadCodeEliminate::deleteDeadInst(Function* func)
{

}

void DeadCodeEliminate::deleteDeadStore(Function* func)
{

}

void DeadCodeEliminate::deleteDeadRet(Function* func)
{

}

bool DeadCodeEliminate::isSideEffectAndCall(User* inst)
{

}

bool DeadCodeEliminate::isLocalStore(StoreInst* inst)
{

}

bool DeadCodeEliminate::isDeadInstruction(User* inst)
{

}

bool DeadCodeEliminate::isEqualStoreLoadPtr(StoreInst* store, LoadInst* load)
{

}

bool DeadCodeEliminate::isEqualStorePtr(StoreInst* store_a, StoreInst* store_b)
{

}