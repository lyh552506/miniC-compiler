#include "../../include/ir/opt/CodeMove.hpp"

void CodeMove::init()
{
    Loop = AM.get<LoopAnalysis>(func, std::ref(DeleteLoops));
    DomTree = AM.get<dominance>(func);
    AM.get<SideEffect>(&Singleton<Module>());
    Loops = Loop->GetLoops();
    Collect();
}

bool CodeMove::Run()
{
    bool Changed = false;

    return Changed;
}

void CodeMove::Collect()
{
    for(BasicBlock* block : *func)
    {
        if(block == func->front())
            continue;
        
        // canhandle

        for(User* inst : *block)
        {
            if(!CanHandle(inst))
                continue;

            bool flag = true;
            for(auto& use : inst->Getuselist())
            {
                if(auto user = dynamic_cast<User*>(use->usee))
                {
                    if(user->GetParent() == block)
                    {
                        if(!MoveOutSet.count(user))
                        {
                            flag = false;
                            break;
                        }
                    }
                }
            }
            if(flag)
            {
                MoveOut.push_back(inst);
                MoveOutSet.insert(inst);
            }
        }
        std::vector<std::pair<User*, BasicBlock*>> MoveTo;
        std::unordered_map<User*, BasicBlock*> SetTarget;
    }
}

bool CodeMove::CanHandle(User* inst)
{
    if(inst->HasSideEffect())
        return false;
    User::OpID id = inst->id;
    switch(id)
    {
        case User::OpID::Alloca:
        case User::OpID::Phi:
        case User::OpID::Load:
            return false;
        case User::OpID::Div:
        case User::OpID::Mod:
            if(inst->GetOperand(1)->isConstZero())
                return false;
        case User::OpID::Gep:
        {
            if(inst->GetOperand(0)->isGlobal())
                return false;
        }
        default:
            return true;
    }    
}