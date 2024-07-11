#include "DeadArgsElimination.hpp"
#include "CFG.hpp"
#include "my_stl.hpp"
bool DeadArgsElimination::Run()
{
    wait_del.clear();
    bool modified = false;
    bool changed = true;
    while(changed)
    {
        changed = false;
        for(auto& func_Ptr : mod->GetFuncTion())
        {
            changed |= Detect_Dead_Args(func_Ptr.get());
        }
        modified |= changed;
    }
    
    return modified;
}

bool DeadArgsElimination::Detect_Dead_Args(Function* func)
{
    bool modified = false;
    for(auto it = func->GetParams().begin(); it != func->GetParams().end(); it++)
    {
        if((*it)->GetUserlist().is_empty())
            wait_del.push_back(std::make_pair((*it).get(), std::distance(func->GetParams().begin(), it)));
        else
        {
            bool flag = true;
            for(Use* User_ : (*it)->GetUserlist())
            {
                if(auto store = dynamic_cast<StoreInst*>(User_->GetUser()))
                {
                    if((*it).get() == store->GetOperand(0))
                    {
                        flag = false;
                        break;                     
                    }
                }
                else
                {
                    flag = false;
                    break;     
                }
            }
            if(flag)
                wait_del.push_back(std::make_pair((*it).get(), std::distance(func->GetParams().begin(), it)));
        }
        // if(std::all_of((*it)->GetUserlist().begin(), (*it)->GetUserlist().end(), [](Use* user)
        // {return user->GetUser()->GetInstId() == User::OpID::Store;}))
        //     wait_del.push_back(std::make_pair((*it).get(), std::distance(func->GetParams().begin(), it)));
    }

    while (!wait_del.empty())
    {
        auto& pair = wait_del.back();
        wait_del.pop_back();

        _DEBUG(std::cerr << "Delete arg: " << pair.first->GetName() << "in func:" << func->GetName() << std::endl;)

        for(Use* User_ : func->GetUserlist())
        {
            if(auto call = dynamic_cast<CallInst*>(User_->GetUser()))
            {
                call->Getuselist().erase(call->Getuselist().begin() + pair.second + 1);
            }
        }
        func->GetParams().erase(func->GetParams().begin() + pair.second);
        modified = true;
    }

    return modified;
}