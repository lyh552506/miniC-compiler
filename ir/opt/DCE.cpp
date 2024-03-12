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
        if((func->GetUserlist()).is_empty() && func != module->getMainFunc())
        {
            func_counter++;
            module->EraseFunction(func);
        }
        else
            continue;
    }
}
bool DeadCodeEliminate::isInstructionTriviallyDead(User* inst)
{
    if(!inst->GetUserlist().is_empty() || inst->IsTerminateInst())
        return false;
    // if(isSideEffectAndCall(inst)) return false;
}




void DeadCodeEliminate::detectNotSideEffectFunc(Module* module)
{
    for(auto &_func : module->GetFuncTion()) 
    {
        Function* func = _func.get();
        if(func->GetBasicBlock().empty() || func == module->getMainFunc())
            continue;
        bool sideEffect = false;
        if(FunchasSideEffect(func))
            sideEffect=true;
        if(sideEffect == false)
            notSideEffectFunc.insert(func);
    }
}

bool DeadCodeEliminate::FunchasSideEffect(Function *func) {
    auto &params = func->GetParams();
    for (auto &param : params) 
    {
        if (param->GetTypeEnum() == InnerDataType::IR_PTR)
            return true;
    }
    for (auto it = func->begin(); it != func->end(); ++it) 
    {
    BasicBlock *bb = *it;
    for (auto iter = bb->begin(); iter != bb->end(); ++iter) 
    {
        User *inst = *iter;
        if(auto STore = dynamic_cast<StoreInst*>(inst))
        {
            if(isLocalStore(STore))
                continue;
            return true;
        }
        //如果在函数内又有call，此时含有副作用
        if(auto tmp = dynamic_cast<CallInst *>(inst))
            return true;
        //遍历每条指令的use关系，如果存在global value，此时含有副作用
        auto &vec = inst->Getuselist();
        for (auto &_val : vec)
        {
            if (_val->GetValue()->isGlobVal()) // TODO isGlobVal() to be added
                return true;
        }
    }
    }
    return false;
}

void DeadCodeEliminate::deleteDeadInst(Function* func)
{
    std::unordered_set<User*> worklist;
    for(BasicBlock* block : *func)
    {
        for(User* inst : *block)
        {
            if(isSideEffect(inst))
                markUse(inst, worklist);
        }
    }
    for(BasicBlock* block : *func)
    {
        std::unordered_set<User*> removelist;
        for(User* inst : *block)
        {
            if(worklist.find(inst) == worklist.end())
                removelist.insert(inst);
            else
        }
    }
}

void DeadCodeEliminate::deleteDeadStore(Function* func)
{

}

void DeadCodeEliminate::deleteDeadRet(Function* func)
{
    bool flag = true;
    for(Use* user_ : func->GetUserlist())
    {
        Value* user = user_->GetValue();
        if(user->GetUserlist().is_empty())
            flag = false;
    }
    if(flag)
    {
        for(BasicBlock* block : *func)
        {
            for(User* inst : *block)
            {
                if(dynamic_cast<RetInst*>(inst) && inst->Getuselist().size() == 1)
                    inst->RAUW(ConstIRInt::GetNewConstant(0));
            }
        }
    }
}

void DeadCodeEliminate::markUse(User* inst, std::unordered_set<User*>& worklist)
{
    if(worklist.find(inst) != worklist.end())
        return;
    worklist.insert(inst);
    for(auto& op : inst->Getuselist()) // Fix: Use a reference instead of copying
    {
        if(User* user = dynamic_cast<User*>(op->usee))
            markUse(user, worklist);
    }
}

bool DeadCodeEliminate::isSideEffect(User* inst)
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