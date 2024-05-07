#include "Global2Local.hpp"
#include "Trival.hpp"
void Global2Local::init()
{
    createSuccFuncs();
    CreateCallNum();
    DetectRecursive();
    CalGlobal2Funcs();
}  

void Global2Local::createSuccFuncs()
{
    for(auto& func_ : module.GetFuncTion())
    {
        Function* func = func_.get();
        for(Use* user : func->GetUserlist())
        {
            if(auto inst = dynamic_cast<CallInst*>(user->GetUser()))
                SuccFuncs[func].insert(inst->GetParent()->GetParent());
        }
    }
}

void Global2Local::DetectRecursive()
{
    Function* entry = module.GetMainFunction();
    std::set<Function*> visited;
    visit(entry, visited);
}

void Global2Local::visit(Function* entry, std::set<Function*>& visited)
{
    visited.insert(entry);
    for(Function* Succ : SuccFuncs[entry])
    {
        if(visited.find(Succ) != visited.end())
            RecursiveFunctions.insert(Succ);
        else
            visit(Succ, visited);
    }
    visited.erase(entry);
}

void Global2Local::CalGlobal2Funcs()
{
    for(auto & global_ptr : module.GetGlobalVariable())
    {
        Variable* global = global_ptr.get();
        Value* val = module.GetValueByName(global->get_name());
        for(Use* user_ : val->GetUserlist())
        {
            if(User* inst = dynamic_cast<User*>(user_->GetUser()))
                Global2Funcs[global].insert(inst->GetParent()->GetParent());
        }
    }
}
void Global2Local::RunOnModule()
{
    init();
    RunPass();
}

void Global2Local::RunPass()
{
    Function* main = module.GetMainFunction();
    auto& globalvals = module.GetGlobalVariable();
    for(auto iter = globalvals.begin(); iter != globalvals.end();)
    {
        Variable* global = iter->get();
        if(Global2Funcs[global].size() == 0)
        {
            iter = globalvals.erase(iter);
        }
        else if(Global2Funcs[global].size() == 1)
        {
            Function* func = *Global2Funcs[global].begin();
            if(CanLocal(global, func))
            {
                LocalGlobalVariable(global, func);
                iter = globalvals.erase(iter);
            }
            else
                ++iter;
        }
        // FIXME : 适配多个func使用Global Array
        // else if(global->GetType()->GetTypeEnum() == InnerDataType::IR_ARRAY)
        // {
        //     for(Function* func : Global2Funcs[global])
        //     {
        //         if(RecursiveFunctions.find(func) == RecursiveFunctions.end())
        //             LocalGep(global, func); //todo 需要完善
        //     }
        //     ++iter;
        // }
        else if(global->GetType()->GetTypeEnum() == InnerDataType::IR_ARRAY)
        {
            ++iter;
            continue;
        }
        else
            ++iter;
    }
}


void Global2Local::LocalGlobalVariable(Variable* val, Function* func)
{
    AllocaInst* alloca = new AllocaInst(val->get_name(),val->GetType());
    BasicBlock* begin = func->front();
    alloca->SetParent(begin);
    begin->push_front(alloca);
    if(!val->GetInitializer())
        module.GetValueByName(val->get_name())->RAUW(alloca);
    else
    {
        if(val->GetType()->GetTypeEnum() == InnerDataType::IR_ARRAY)
        {
            LocalArray(val, alloca, begin);
            module.GetValueByName(val->get_name())->RAUW(alloca);
        }
        else
        {
            auto iter = begin->begin();
            for (; iter != begin->end(); ++iter) 
            {
                if (!dynamic_cast<AllocaInst*>(*iter))
                    break;
            }
            Operand init = val->GetInitializer();
            // LoadInst* load = new LoadInst(alloca->GetType());
            // load->add_use(alloca);
            // iter.insert_before(load);
            // --iter;
            StoreInst* store = new StoreInst(init, alloca);
            iter.insert_before(store);
            module.GetValueByName(val->get_name())->RAUW(alloca);
        }
    }
}

// void Global2Local::LocalGep(Variable* val, Function* func)
// {
//     BasicBlock* begin = func->front();
//     Value* Val = module.GetValueByName(val->get_name());
//     GetElementPtrInst* gep = new GetElementPtrInst(Val);
//     begin->GenerateGEPInst(gep);
//     for(Use* use_ : Val->GetUserlist())
//     {
//         if(User* inst = dynamic_cast<User*>(use_->GetUser()))
//         {
//             if(inst->GetParent()->GetParent() == func)
//                 inst->RSUW(inst->GetUseIndex(use_), gep);   //可能有问题
//         }
//     }
// }

void Global2Local::LocalArray(Variable* arr, AllocaInst* alloca, BasicBlock* block)
{
    Operand initializer = arr->GetInitializer();
    Value* val = module.GetValueByName(arr->get_name());
    Type* tp = val->GetType();
    std::vector<Operand> args;
    Operand src = module.GenerateMemcpyHandle(tp, initializer);
    args.push_back(alloca);
    args.push_back(src);
    if(auto subtp = dynamic_cast<HasSubType*>(tp)->GetSubType())
        args.push_back(ConstIRInt::GetNewConstant(subtp->get_size()));
    else
        args.push_back(ConstIRInt::GetNewConstant(tp->get_size()));
    args.push_back(ConstIRBoolean::GetNewConstant(false));
    User* inst = Trival::GenerateCallInst("llvm.memcpy.p0.p0.i32",args);
    auto iter = block->begin();
    for (; iter != block->end(); ++iter) 
    {
        if (!dynamic_cast<AllocaInst*>(*iter))
            break;
    }
    iter.insert_before(inst);
}

bool Global2Local::CanLocal(Variable* val, Function* func)
{
    if(val->GetType()->GetTypeEnum() == InnerDataType::IR_ARRAY \ 
    || val->GetType()->GetTypeEnum() == InnerDataType::IR_PTR)
    {
        size_t size;
        Type* tp = val->GetType();
        if(auto subtp = dynamic_cast<HasSubType*>(tp)->GetSubType())
            size = subtp->get_size();
        else
            size = tp->get_size();
        if(size > MaxSize)
            return false;
    }
    if(RecursiveFunctions.find(func) != RecursiveFunctions.end())
        return false;
    Value* Val = module.GetValueByName(val->get_name());
    if(val->GetType()->GetTypeEnum() != InnerDataType::IR_ARRAY)
    {
        bool changed = false;
        for(Use* use_ : Val->GetUserlist())
        {
            if(StoreInst* inst = dynamic_cast<StoreInst*>(use_->GetUser()))
                changed = true;
            else if(GetElementPtrInst* inst = dynamic_cast<GetElementPtrInst*>(use_->GetUser()))
            {
                for(Use* use__ : inst->GetUserlist())
                    if(dynamic_cast<StoreInst*>(use__->GetUser()))
                        changed = true;
            }
        }
        if(changed)
        {
            if(CallTimes[func] > 1)
                return false;
            else
            {
                dom_info = std::make_unique<dominance>(func, func->GetBasicBlock().size());
                dom_info->RunOnFunction();
                loopAnalysis = std::make_unique<LoopAnalysis>(func, dom_info.get());
                loopAnalysis->RunOnFunction();
                for(Use* use_ : func->GetUserlist())
                {
                    if(auto call = dynamic_cast<CallInst*>(use_->GetUser()))
                    {
                        BasicBlock* block = call->GetParent();
                        if(block->LoopDepth != 0)
                            return false;
                    }
                }
                return true;
            }
        }
        else
            return true;
    }
    else
    {
        for(Use* use_ : Val->GetUserlist())
        {
            if(GetElementPtrInst* inst = dynamic_cast<GetElementPtrInst*>(use_->GetUser()))
            {
                for(Use* use__ : inst->GetUserlist())
                    if(CallInst* call = dynamic_cast<CallInst*>(use__->GetUser()))
                    {
                        int index = call->GetUseIndex(use__);
                        Function* calleefunc = dynamic_cast<Function*>(call->Getuselist()[0]->usee);
                        if(calleefunc)
                        {
                            if(hasChanged(index - 1, calleefunc))
                                return false;
                            else
                                return true;
                        }
                    }
            }
        }
    }
    return true;
}

bool Global2Local::hasChanged(int index, Function* func)
{
    Value* val = func->GetParams()[index].get();
    for(Use* use_ : val->GetUserlist())
    {
        if(StoreInst* inst = dynamic_cast<StoreInst*>(use_->GetUser()))
                return true;
        else if(GetElementPtrInst* inst = dynamic_cast<GetElementPtrInst*>(use_->GetUser()))
        {
            for(Use* use__ : inst->GetUserlist())
            {
                if(StoreInst* inst_ = dynamic_cast<StoreInst*>(use__->GetUser()))
                    return true;
                else if(CallInst* call = dynamic_cast<CallInst*>(use__->GetUser()))
                {
                    int index_ = call->GetUseIndex(use__);
                    Function* calleefunc = dynamic_cast<Function*>(call->Getuselist()[0]->usee);
                    if(calleefunc)
                        return hasChanged(index_ - 1, calleefunc);
                }
            }
        }
        else if(CallInst* inst = dynamic_cast<CallInst*>(use_->GetUser()))
        {
            int index_ = inst->GetUseIndex(use_);
            Function* calleefunc = dynamic_cast<Function*>(inst->Getuselist()[0]->usee);
            if(calleefunc)
                return hasChanged(index_ - 1, calleefunc);
        }
        else
            return false;
    }
    //             {
    //                 if(inst_->GetParent()->GetParent() == func)
    //                     return true;
    //             }
    //         }
    //     }
    // }
    // return false;
}

// bool Global2Local::CanLocal(Variable* val)
// {
//     if((val->GetType()->GetTypeEnum() != InnerDataType::IR_ARRAY) && (val->GetType()->GetTypeEnum() != InnerDataType::IR_PTR) \
//     && val->GetInitializer())
//     {
//     Value* Val = module.GetValueByName(val->get_name());
//     bool changed = false;
//     for(Use* use_ : Val->GetUserlist())
//     {
//         if(StoreInst* inst = dynamic_cast<StoreInst*>(use_->GetUser()))
//             changed = true;
//         else if(GetElementPtrInst* inst = dynamic_cast<GetElementPtrInst*>(use_->GetUser()))
//         {
//             for(Use* use__ : inst->GetUserlist())
//                 if(dynamic_cast<StoreInst*>(use__->GetUser()))
//                     changed = true;
//         }
//     }
//     if(changed)
//             return false;
//     else
//         return true;
//     }
//     else
//         return false;
// }

void Global2Local::CreateCallNum()
{
    for(auto& func_ : module.GetFuncTion())
    {
        Function* func = func_.get();
        for(Use* user_ : func->GetUserlist())
        {
            User* user = user_->GetUser();
            if(dynamic_cast<CallInst*>(user))
            {
                Function* CallFunc = user->GetParent()->GetParent();
                if(CallFunc)
                    CallTimes[func]++;
            }
        }
    }
}