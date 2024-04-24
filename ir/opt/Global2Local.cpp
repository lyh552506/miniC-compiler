#include "Global2Local.hpp"

void Global2Local::init()
{
    createSuccFuncs();
    DetectRecursive();
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

void Global2Local::RunOnModule()
{
    init();
    RunPass();
}

void Global2Local::RunPass()
{
    std::map<Value*, std::set<Function*>> Global2Funcs;  // 哪些func 用了这个 globalvalue
    for(auto & global_ptr : module.GetGlobalVariable())
    {
        Value* val = module.GetValueByName(global_ptr->get_name());
        for(Use* user_ : val->GetUserlist())
        {
            if(User* inst = dynamic_cast<User*>(user_->GetValue()))
                Global2Funcs[val].insert(inst->GetParent()->GetParent());
        }
    }

    
}