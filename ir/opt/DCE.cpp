#include "DCE.hpp"

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

// void DeadCodeEliminate::deleteDeadFunc(Module *m) {
//   func_counter = 0;
//   auto &funcs = m->getFunctions();
//   for (auto iter = funcs.begin(); iter != funcs.end();) {
//     auto func = *iter;
//     if (func->getBasicBlocks().empty()) {
//       ++iter;
//       continue;
//     }
//     if (func->getUseList().empty() && func != m_->getMainFunction()) {
//       func_counter++;
//       iter = funcs.erase(iter);
//     } else
//       ++iter;
//   }
// }
void DeadCodeEliminate::deleteDeadFunc(Module* module)
{
    func_counter = 0;
    for(auto &_func : module->GetFuncTion()) 
    {
        Function* func = _func.get();
        if(func->GetBasicBlock().empty())
            continue;
        if((func->GetUserlist())->is_empty() && func != module->getMainFunc())
    }
}
bool DeadCodeEliminate::isInstructionTriviallyDead(User* inst)
{
    if(!inst->GetUserlist().is_empty() || inst->IsTerminateInst())
        return false;
    if(isSideEffectAndCall(inst)) return false;
}




void DeadCodeEliminate::detectNotSideEffectFunc(Module* module)
{
    for(auto &_func : module->GetFuncTion()) 
    {
        Function* func = _func.get();
        if(func->GetBasicBlock().empty() || func == module->getMainFunc())
            continue;
        bool sideEffect = false;
        for(BasicBlock* block : func->GetBasicBlock())
        {
            for(User* inst : *block)
            {
                // if(auto Call = dynamic_cast<CallInst*>(inst))
                // {
                //     if(Call->hasSideEffect())
                //     {
                //     sideEffect = true;
                //     break;
                //     }
                // }

                // if(auto Store = dynamic_cast<StoreInst*>(inst))
                // {
                //     if(Store->hasSideEffect())
                //     {
                //         sideEffect = true;
                //         break;
                //     }
                // }
            }
        }
        if(sideEffect == false)
            notSideEffectFunc.insert(func);
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
    if(dynamic_cast<CallInst*>(inst))
        return true;
    else if(dynamic_cast<AllocaInst*>(inst))
        return false;
    else if(dynamic_cast<LoadInst*>(inst))
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