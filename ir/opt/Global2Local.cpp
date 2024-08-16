#include "../../include/ir/opt/Global2Local.hpp"
#include "../../include/lib/Trival.hpp"
void Global2Local::init(Module* module)
{
    createSuccFuncs(module);
    CreateCallNum(module);
    DetectRecursive(module);
    CalGlobal2Funcs(module);
}  

void Global2Local::createSuccFuncs(Module* module)
{
    for(auto& func_ : module->GetFuncTion())
    {
        Function* func = func_.get();
        for(Use* user : func->GetUserlist())
        {
            if(auto inst = dynamic_cast<CallInst*>(user->GetUser()))
                SuccFuncs[func].insert(inst->GetParent()->GetParent());
        }
    }
}

void Global2Local::DetectRecursive(Module* module)
{
    Function* entry = module->GetMainFunction();
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

void Global2Local::CalGlobal2Funcs(Module* module)
{
    for(auto & global_ptr : module->GetGlobalVariable())
    {
        Variable* global = global_ptr.get();
        for(Use* user_ : global->GetUserlist())
        {
            if(User* inst = dynamic_cast<User*>(user_->GetUser()))
                Global2Funcs[global].insert(inst->GetParent()->GetParent());
        }
    }
}
bool Global2Local::Run()
{
    init(module);
    RunPass(module);
    return false;
}

void Global2Local::RunPass(Module* module)
{
    Function* main = module->GetMainFunction();
    auto& globalvals = module->GetGlobalVariable();
    bool Repeat = false;
    for(auto iter = globalvals.begin(); iter != globalvals.end(); )
    {
        Variable* global = iter->get();
        if(!Repeat && global)
        {
            auto Tp = dynamic_cast<HasSubType*>(global->GetType());
            if(Tp->GetSubType()->GetTypeEnum() == InnerDataType::IR_ARRAY)
            {
                ++iter;
            }
            else
            {
                if(Global2Funcs[global].size() == 0)
                {
                    if(globalvals.size() == 1)
                    {
                        globalvals.erase(iter);
                        return;
                    }
                    else
                        iter = globalvals.erase(iter);
                }
                else if(global->usage == Variable::Constant || global->ForParallel)
                    iter++;
                else if(Global2Funcs[global].size() == 1)
                {
                    Function* func = *Global2Funcs[global].begin();
                    if(CanLocal(global, func))
                    {
                        _DEBUG(std::cerr << "LocalGlobalVariable: " << global->GetName() << std::endl;)
                        LocalGlobalVariable(global, func);
                        if(globalvals.size() == 1)
                        {
                            globalvals.erase(iter);
                            return;
                        }
                        else
                            iter = globalvals.erase(iter);
                    }
                    else
                        iter++;
                }
                else
                    iter++;
            }
            if(iter == globalvals.end())
            {
                Repeat = true;
                iter = globalvals.begin();
            }
        }
        else if(iter == globalvals.end())
            return;
        else if(Repeat && global)
        {
            if(global->usage == Variable::Constant || global->ForParallel)
                iter++;
            else if(Global2Funcs[global].size() == 1)
            {
                Function* func = *Global2Funcs[global].begin();
                if(CanLocal(global, func))
                {
                    _DEBUG(std::cerr << "LocalGlobalVariable: " << global->GetName() << std::endl;)
                    LocalGlobalVariable(global, func);

                    if(iter->get()->usage == Variable::Constant)
                        ++iter;
                    else
                    {
                        if(globalvals.size() == 1)
                        {
                            globalvals.erase(iter);
                        }
                        else
                            iter = globalvals.erase(iter);
                    }
                }
                else
                    ++iter;
            }
            else
                iter++;
        }
    }
    //     // FIXME : 适配多个func使用Global Array
    //     // else if(global->GetType()->GetTypeEnum() == InnerDataType::IR_ARRAY)
    //     // {
    //     //     for(Function* func : Global2Funcs[global])
    //     //     {
    //     //         if(RecursiveFunctions.find(func) == RecursiveFunctions.end())
    //     //             LocalGep(global, func); //todo 需要完善
    //     //     }
    //     //     ++iter;
    //     // }
    // }
}

void Global2Local::LocalGlobalVariable(Variable* val, Function* func)
{
    auto tp = dynamic_cast<HasSubType*>(val->GetType());
    AllocaInst* alloca = new AllocaInst(val->GetName(),tp->GetSubType());
    BasicBlock* begin = func->front();
    alloca->SetParent(begin);
    begin->push_front(alloca);
    if(!val->GetInitializer())
    {
        if(tp->GetSubType()->GetTypeEnum() != InnerDataType::IR_ARRAY)
        {
            auto iter = begin->begin();
            for (; iter != begin->end(); ++iter) 
            {
                if (!dynamic_cast<AllocaInst*>(*iter))
                    break;
            }
            StoreInst* store = new StoreInst(ConstIRInt::GetNewConstant(0), alloca);
            iter.insert_before(store);
            val->RAUW(alloca);
        }
        else
        {
            val->RAUW(alloca);
            LocalArray(val, alloca, begin);
        }
    }
    else
    {
        if(tp->GetSubType()->GetTypeEnum() == InnerDataType::IR_ARRAY)
        {
            val->RAUW(alloca);
            LocalArray(val, alloca, begin);
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
            StoreInst* store = new StoreInst(init, alloca);
            iter.insert_before(store);
            val->RAUW(alloca);
        }
    }
}

// void Global2Local::LocalGep(Variable* val, Function* func)
// {
//     BasicBlock* begin = func->front();
//     Value* Val = module->GetValueByName(val->get_name());
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
    Type* tp = arr->GetType();
    std::vector<Operand> args;
    arr->usage = Variable::Constant;
    args.push_back(alloca);
    args.push_back(arr);
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
    auto Sub_Tp = dynamic_cast<HasSubType*>(val->GetType());
    if(Sub_Tp->GetSubType()->GetTypeEnum() == InnerDataType::IR_ARRAY)
    {
        size_t size = Sub_Tp->GetSubType()->get_size();
        CurrSize += size;
        if(CurrSize > MaxSize)
            return false;
        /*
        return false;
        */
       /*
       if(!val->GetInitializer())
            return false;
       */
    }
    if(RecursiveFunctions.find(func) != RecursiveFunctions.end())
        return false;
    if(Sub_Tp->GetSubType()->GetTypeEnum() != InnerDataType::IR_ARRAY)
    {
        bool changed = false;
        for(Use* use_ : val->GetUserlist())
        {
            if(StoreInst* inst = dynamic_cast<StoreInst*>(use_->GetUser()))
            {
                changed = true;
                break;
            }
            else if(GetElementPtrInst* inst = dynamic_cast<GetElementPtrInst*>(use_->GetUser()))
            {
                for(Use* use__ : inst->GetUserlist())
                    if(dynamic_cast<StoreInst*>(use__->GetUser()))
                    {
                        changed = true;
                        break;
                    }
                if(changed)
                    break;
            }
        }
        if(changed)
        {
            if(CallTimes[func] > 1)
                return false;
            else
            {
                for(Use* use_ : func->GetUserlist())
                {
                    if(auto call = dynamic_cast<CallInst*>(use_->GetUser()))
                    {
                        BasicBlock* block = call->GetParent();
                        Function* func_ = block->GetParent();
                        // dom_info = AM_.get<dominance>*(func);
                        // loopAnalysis = AM_.get<LoopAnalysis>(func);
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
        if(!val->GetInitializer())
        {
            if(auto gep = val->GetUserlist().back())
            {
                if(auto inst = dynamic_cast<GetElementPtrInst*>(gep->GetUser()))
                {
                    if(auto call = dynamic_cast<CallInst*>(inst->GetUserlist().back()->GetUser()))
                    {
                        if(!(call->Getuselist()[0]->usee->GetName() == "getfarray" || call->Getuselist()[0]->usee->GetName() == "getarray"))
                            return false;
                    }
                    else if(!dynamic_cast<StoreInst*>(inst->GetUserlist().back()->GetUser()))
                        return false;
                }
            }
        }
        for(Use* use_ : val->GetUserlist())
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
                    else if(StoreInst* store = dynamic_cast<StoreInst*>(use__->GetUser()))
                    {
                        for(Use* use_ : func->GetUserlist())
                        {
                            if(auto call = dynamic_cast<CallInst*>(use_->GetUser()))
                            {
                                BasicBlock* block = call->GetParent();
                                Function* func_ = block->GetParent();
                                // dom_info = AM.get<dominance>(func)
                                // loopAnalysis = AM_.get<LoopAnalysis>(func);
                                if(block->LoopDepth != 0)
                                    return false;
                            }
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
    return false;
    assert(0&&"!!!RETURN VALUE!!!, Unreachable");
}

// bool Global2Local::CanLocal(Variable* val)
// {
//     if((val->GetType()->GetTypeEnum() != InnerDataType::IR_ARRAY) && (val->GetType()->GetTypeEnum() != InnerDataType::IR_PTR) \
//     && val->GetInitializer())
//     {
//     Value* Val = module->GetValueByName(val->get_name());
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

void Global2Local::CreateCallNum(Module* module)
{
    for(auto& func_ : module->GetFuncTion())
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
                CallFunc->bb_num = 0;
                CallFunc->GetBasicBlock().clear();
                for (auto bb : *CallFunc) {
                  bb->num = CallFunc->bb_num++;
                  CallFunc->GetBasicBlock().push_back(bb);
                }
                dom_info = AM.get<dominance>(CallFunc);
                loopAnalysis = AM.get<LoopAnalysis>(CallFunc, dom_info,std::ref(DeleteLoop));
                if(auto loop = loopAnalysis->LookUp(user->GetParent()))
                {
                    CallTimes[func] += 3;
                    break;
                }
            }
        }
    }
    //TODO: 修复CallInst 在循环中的问题
}