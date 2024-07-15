#include "../../include/ir/opt/DeadArgsElimination.hpp"
#include "../../lib/CFG.hpp"
#include "../../util/my_stl.hpp"
#include "../../include/ir/Analysis/SideEffect.hpp"
bool DeadArgsElimination::Run()
{
    AM.get<SideEffect>(&Singleton<Module>());
    wait_del.clear();
    bool modified = false;
    bool changed = true;
    while (changed)
    {
        changed = false;
        for (auto &func_Ptr : mod->GetFuncTion())
        {
            Handle_SameArgs(func_Ptr.get());
        }
        for (auto &func_Ptr : mod->GetFuncTion())
        {
            changed |= Detect_Dead_Args(func_Ptr.get());
        }
        modified |= changed;
    }

    return modified;
}

void DeadArgsElimination::NormalHandle(Function *func)
{
    for (auto it = func->GetParams().begin(); it != func->GetParams().end(); it++)
    {
        if ((*it)->GetUserlist().is_empty())
            wait_del.push_back(std::make_pair((*it).get(), std::distance(func->GetParams().begin(), it)));
        else
        {
            bool flag = true;
            for (Use *User_ : (*it)->GetUserlist())
            {
                if (auto store = dynamic_cast<StoreInst *>(User_->GetUser()))
                {
                    if ((*it).get() == store->GetOperand(0))
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
            if (flag)
                wait_del.push_back(std::make_pair((*it).get(), std::distance(func->GetParams().begin(), it)));
        }
        // if(std::all_of((*it)->GetUserlist().begin(), (*it)->GetUserlist().end(), [](Use* user)
        // {return user->GetUser()->GetInstId() == User::OpID::Store;}))
        //     wait_del.push_back(std::make_pair((*it).get(), std::distance(func->GetParams().begin(), it)));
    }
}

void DeadArgsElimination::Handle_SameArgs(Function *func)
{
    if (func->GetParams().size() > 0 && !func->GetUserlist().is_empty())
    {
        bool result = true;
        for (Use *call_ : func->GetUserlist())
        {

            if (auto call = dynamic_cast<CallInst *>(call_->GetUser()))
            {
                auto &uses = call->Getuselist();
                auto all_except_first_are_same = [&uses]() {
                    if (uses.size() < 3)
                        return true;
                    return std::all_of(uses.begin() + 2, uses.end(),
                                       [&uses](User::UsePtr &use) { return uses[1]->usee == use->usee; });
                };
                result &= all_except_first_are_same();
            }
            else
                result &= false;
        }
        if (result)
        {
            Value *val = func->GetParams().front().get();
            for (auto it = func->GetParams().begin(); it != func->GetParams().end(); it++)
            {
                if ((*it).get() == val)
                    continue;
                (*it)->RAUW(val);
            }
        }
    }
}
bool DeadArgsElimination::Detect_Dead_Args(Function *func)
{
    bool modified = false;
    NormalHandle(func);

    while (!wait_del.empty())
    {
        auto &pair = wait_del.back();
        wait_del.pop_back();

        _DEBUG(std::cerr << "Delete arg: " << pair.first->GetName() << "in func:" << func->GetName() << std::endl;)

        for (Use *User_ : func->GetUserlist())
        {
            if (auto call = dynamic_cast<CallInst *>(User_->GetUser()))
            {
                call->Getuselist().erase(call->Getuselist().begin() + pair.second + 1);
            }
        }
        func->GetParams().erase(func->GetParams().begin() + pair.second);
        modified = true;
    }

    return modified;
}