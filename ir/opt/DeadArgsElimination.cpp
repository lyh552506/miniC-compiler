#include "DeadArgsElimination.hpp"
#include "CFG.hpp"

bool DeadArgsElimination::RunOnModule()
{
    for(auto& func_Ptr : module.GetFuncTion())
    {
        Detect_Dead_Args(func_Ptr.get());
    }
}

void DeadArgsElimination::Detect_Dead_Args(Function* func)
{
    for(auto it = func->GetParams().begin(); it != func->GetParams().end(); it++)
    {
        if((*it)->GetUserlist().is_empty())
            wait_del.push_back(std::make_pair((*it).get(), std::distance(func->GetParams().begin(), it)));

        if(std::all_of((*it)->GetUserlist().begin(), (*it)->GetUserlist().end(), [](Use* user)
        {return user->GetUser()->GetInstId() == User::OpID::Store;}))
            wait_del.push_back(std::make_pair((*it).get(), std::distance(func->GetParams().begin(), it)));
    }

    while (!wait_del.empty())
    {
        auto& pair = wait_del.back();
        wait_del.pop_back();
        for(Use* User_ : func->GetUserlist())
        {
            if(auto call = dynamic_cast<CallInst*>(User_->GetUser()))
            {
                call->Getuselist().erase(call->Getuselist().begin() + pair.second);
            }
        }
        func->GetParams().erase(func->GetParams().begin() + pair.second);
    }
}