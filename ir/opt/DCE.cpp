#include "DCE.hpp"

void DeadCodeEliminate::Pass()
{
    if(Flist.size() > 1)
    {
        for(Function* _func : Flist)
        {
            detectSideEffectFunc(_func); 
        }
        deleteDeadFunc();
        for(Function* _func : Flist)
        {
            deleteDeadRet(_func);   
            deleteDeadInst(_func);
            deleteDeadStore(_func);
            deleteDeadInst(_func);
        }
    }
    else
    {
        for(Function* _func : Flist)
        {
            deleteDeadInst(_func);
            deleteDeadStore(_func);
            deleteDeadInst(_func);
        }
    }

    std::cout << "--------DCE--------" << std::endl;
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
void DeadCodeEliminate::deleteDeadFunc()
{
    if(!DelFunc.empty())
    {
        for(Function* func : DelFunc)
        {
            m.EraseFunction(func);
            for(auto it = Flist.begin(); it != Flist.end();)
            {
                if(*it == func)
                    it = Flist.erase(it);
                else
                    ++it;
            }
        }
    }
    else
        return;
}
// bool DeadCodeEliminate::isInstructionTriviallyDead(User* inst)
// {
//     if(!inst->GetUserlist().is_empty() || inst->IsTerminateInst())
//         return false;
//     // if(isSideEffectAndCall(inst)) return false;
// }

void DeadCodeEliminate::detectSideEffectFunc(Function* func)
{
    if(func->GetBasicBlock().empty())
        DelFunc.push_back(func);
    if(!FunchasSideEffect(func))
        DelFunc.push_back(func);
    else
        return;
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
        if(StoreInst* STore = dynamic_cast<StoreInst*>(inst))
        {
            if(isLocalStore(STore))
                continue;
            return true;
        }
        //如果在函数内又有call，此时含有副作用
        if(CallInst* tmp = dynamic_cast<CallInst *>(inst))
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
    if(!func->GetUserlist().is_empty())
        return true;
    return false;
}

void DeadCodeEliminate::deleteDeadInst(Function* func)
{
    for(BasicBlock* block : *func)
    {
        for(User* inst : *block)
        {
            if(inst->HasSideEffect() || inst->IsTerminateInst())
                markUse(inst, worklist);
        }
    }
    for(BasicBlock* block : *func)
    {
        for(User* inst : *block)
        {
            if(worklist.find(inst) == worklist.end())
                removelist.insert(inst);
            else
            {
                if(isDeadInstruction(inst))
                    removelist.insert(inst);
                else
                    continue;
            }
        }
        for(User* inst : removelist)
        {
            inst->ClearRelation();
            inst->EraseFromParent();
            removelist.erase(inst);
        }
        removelist.clear();
    }
}

void DeadCodeEliminate::deleteDeadStore(Function* func)
{
    for(BasicBlock* block : func->GetBasicBlock())
    {
        std::unordered_set<StoreInst*> storelist;
        std::vector<User*> removelist;
        for(User* inst : *block)
        {
            if(auto store = dynamic_cast<StoreInst*>(inst))
            {
                StoreInst* pre_store = nullptr;
                for(StoreInst* pre : storelist)
                {
                    if(isEqualStorePtr(pre, store))
                    {
                        removelist.push_back(pre);
                        pre_store = pre;
                        break;
                    }
                }
                if(pre_store)
                    storelist.erase(pre_store);
                storelist.insert(store);
            }
            else if(auto load = dynamic_cast<LoadInst*>(inst))
            {
                std::vector<StoreInst*> removelist_;
                for(auto pre : storelist)
                {
                    if(isStrictEqualStoreLoadPtr(pre, load))
                        load->RAUW(pre->Getuselist()[0]->usee);
                    
                }
            }
        }
    }
}

void DeadCodeEliminate::deleteDeadRet(Function* func)
{
    bool flag = true;
    for(Use* user_ : func->GetUserlist())
    {
        Value* user = user_->GetValue();
        if(!user->GetUserlist().is_empty())
            flag = false;
    }
    if(flag)
    {
        for(BasicBlock* block : *func)
        {
            for(User* inst : *block)
            {
                if(dynamic_cast<RetInst*>(inst) && inst->Getuselist().size() == 1)
                {
                    ConstantData* Const = dynamic_cast<ConstantData*>(inst->Getuselist()[0]->usee);
                    if(Const)
                    {
                        inst->RAUW(Const);
                        inst->ClearRelation();
                        inst->EraseFromParent();
                    }  
                }
            }
        }
    }
}

void DeadCodeEliminate::markUse(User* inst, std::unordered_set<User*>& worklist)
{
    if(worklist.find(inst) != worklist.end())
        return;
    worklist.insert(inst);
    for(auto& op : inst->Getuselist()) 
    {
        if(User* user = dynamic_cast<User*>(op->usee))
            markUse(user, worklist);
    }
}

// bool DeadCodeEliminate::isSideEffect(User* inst)
// {
//     if(dynamic_cast<CallInst*>(inst))
//         return true;
//     else if(dynamic_cast<AllocaInst*>(inst))
//         return false;
//     else if(dynamic_cast<LoadInst*>(inst))
//         return true;
// }

bool DeadCodeEliminate::isLocalStore(StoreInst* inst)
{
    auto addr = dynamic_cast<User*>(GetAddress(inst->Getuselist()[1]->usee));
    if(addr && dynamic_cast<AllocaInst*>(addr))
        return true;
    return false;
}

bool DeadCodeEliminate::isDeadInstruction(User* inst)
{
    if(inst->GetUserlist().is_empty())
    {
        if(dynamic_cast<CallInst*>(inst))
            return false;
        else if(dynamic_cast<CondInst*>(inst))
            return false;
        else if(dynamic_cast<UnCondInst*>(inst))
            return false;
        else if(dynamic_cast<StoreInst*>(inst))
            return false;
        else if(dynamic_cast<RetInst*>(inst))
            return false;
        else
            return true;
    }
    return false;
}
Value* DeadCodeEliminate::GetAddress(Value* val)
{
    auto inst = dynamic_cast<User*>(val);
    if(inst)
    {
        if(dynamic_cast<AllocaInst*>(inst))
            return inst;
        else if(dynamic_cast<GetElementPtrInst*>(inst))
            return GetAddress(inst->Getuselist()[0]->usee);
        else if(dynamic_cast<LoadInst*>(inst))
            return val;
        else
        {
            for(auto& op : inst->Getuselist())
            {
                Value* operand = op.get()->GetValue();
                if(operand->GetTypeEnum() == InnerDataType::IR_PTR)
                    return GetAddress(operand);
            }
        }
    }
    return val;
}

bool DeadCodeEliminate::isEqualStoreLoadPtr(StoreInst* store, LoadInst* load)
{
    if(dynamic_cast<GetElementPtrInst*>(store->Getuselist()[1]->usee) \
    && dynamic_cast<GetElementPtrInst*>(load->Getuselist()[0]->usee))
    {
        if(store->Getuselist()[1] != load->Getuselist()[0])
            return (GetAddress(store->Getuselist()[1]->usee) == \
            GetAddress(load->Getuselist()[0]->usee));
    }
    return true;
}

bool DeadCodeEliminate::isEqualStorePtr(StoreInst* store_a, StoreInst* store_b)
{
    Value* store_a_ptr = store_a->Getuselist()[1].get()->GetValue();
    Value* store_b_ptr = store_b->Getuselist()[1].get()->GetValue();
    auto gep1 = dynamic_cast<GetElementPtrInst*>(store_a_ptr);
    auto gep2 = dynamic_cast<GetElementPtrInst*>(store_b_ptr);
    if(gep1 && gep2)
    {
        if(gep1->Getuselist()[0] != gep2->Getuselist()[0])
            return false;
        else
        {
            if(CalPtrIndex(gep1) == CalPtrIndex(gep2))
                return true;
        }
    }
    else if(gep1 || gep2)
        return false;
    return true;
}

bool DeadCodeEliminate::isStrictEqualStoreLoadPtr(StoreInst* store, LoadInst* load)
{
    Value* inst_store = store->Getuselist()[1]->usee;
    Value* inst_load = load->Getuselist()[0]->usee;
    if(GetAddress(inst_store) != GetAddress(inst_load))
        return false;
    auto gep1 = dynamic_cast<GetElementPtrInst*>(inst_store);
    auto gep2 = dynamic_cast<GetElementPtrInst*>(inst_load);
    if(gep1 && gep2)
    {
        if(CalPtrIndex(gep1) != CalPtrIndex(gep2))
            return false;
    }
    else if(gep1 || gep2)
        return false;
    return true;
}

std::string DeadCodeEliminate::CalPtrIndex(GetElementPtrInst* inst)
{
    std::string Index;
    for(int i = 1; i < inst->Getuselist().size(); i++)
    {
        Index += inst->Getuselist()[i]->GetValue()->GetName();
        Index += '#';
    }
    return Index;
}