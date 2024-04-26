#include "Global2Local.hpp"

void Global2Local::init()
{
    createSuccFuncs();
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
            if(auto inst = dynamic_cast<CallInst*>(user->GetValue()))
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
            if(User* inst = dynamic_cast<User*>(user_->GetValue()))
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
    // if(globalvals.size() > MaxNum)
        // return;
    for(auto iter = globalvals.begin(); iter != globalvals.end(); iter++)
    {
        Variable* global = iter->get();
        if(Global2Funcs[global].size() == 0)
        {
            globalvals.erase(iter);
            continue;
        }
        else if(Global2Funcs[global].size() == 1)
        {
            Function* func = *Global2Funcs[global].begin();
            if(RecursiveFunctions.find(func) == RecursiveFunctions.end())
            {
                LocalGlobalVariable(global, func);
                globalvals.erase(iter);
                continue;
            }
        }
        else if(global->GetType()->GetTypeEnum() == InnerDataType::IR_PTR)
        {
            for(Function* func : Global2Funcs[global])
            {
                if(RecursiveFunctions.find(func) == RecursiveFunctions.end())
                    LocalGep(global, func);
            }
        }
    }
}


void Global2Local::LocalGlobalVariable(Variable* val, Function* func)
{
    AllocaInst* alloca = new AllocaInst(val->GetType());
    BasicBlock* begin = func->front();
    alloca->SetParent(begin);
    insert_insts.push_back(alloca);
    if(val->GetType()->GetTypeEnum() == InnerDataType::IR_ARRAY)
    {
        // bool ret = GetArrayinit(val, alloca);
        // if(!ret)
        // {
        //     StoreInst* store = new StoreInst(ConstIRInt::GetNewConstant(0), alloca);
        //     store->SetParent(begin);
        //     insert_insts.push_back(store);
        // }
        //插入insts
        module.GetValueByName(val->get_name())->RAUW(alloca);
    }
    else
    {
        Operand load = begin->GenerateLoadInst(alloca);
        module.GetValueByName(val->get_name())->RAUW(load);
    }
}

void Global2Local::LocalGep(Variable* val, Function* func)
{
    BasicBlock* begin = func->front();
    Value* Val = module.GetValueByName(val->get_name());
    GetElementPtrInst* gep = new GetElementPtrInst(Val);
    begin->GenerateGEPInst(gep);
    for(Use* use_ : Val->GetUserlist())
    {
        if(User* inst = dynamic_cast<User*>(use_->GetValue()))
        {
            if(inst->GetParent()->GetParent() == func)
                inst->RSUW(inst->GetUseIndex(use_), gep);   //可能有问题
        }
    }
}
