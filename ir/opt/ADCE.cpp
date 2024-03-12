#include "ADCE.hpp"
#include <unordered_set>

void ADCE::Pass()
{
    AgressiveDCE(_func);
}

void ADCE::AgressiveDCE(Function* func)
{
    std::unordered_set<User*> Alive;
    std::vector<User*> worklist;
    
    for(BasicBlock* block : *func)
    {
        for(User* inst : *block)
        {
            if(inst->IsTerminateInst() || inst->HasSideEffect())
            {
                if(IsInstHandleConst(inst))
                    continue;
                Alive.insert(inst);
                worklist.push_back(inst);
            }
        }
    }
    
    while(!worklist.empty())
    {
        User* inst = worklist.back();
        worklist.pop_back();
        for(auto& use_ : inst->Getuselist())
        {
            Value* use = use_->usee;
            if(auto inst = dynamic_cast<User*>(use))
            {
                if(Alive.find(inst) == Alive.end())
                {
                    Alive.insert(inst);
                    worklist.push_back(inst);
                }
            }
        }
    }

    for(BasicBlock* block : *func)
    {
        for(User* inst : *block)
        {
            if(Alive.find(inst) != Alive.end())
                continue;
            worklist.push_back(inst);
            inst->ClearRelation();
        }
    }
    for(User* inst : worklist)
        inst->EraseFromParent();
}

bool ADCE::IsInstHandleConst(User* inst)
{
    if(dynamic_cast<CallInst*>(inst))
    {
        bool flag = true;
        for(auto& use_ : inst->Getuselist())
        {
            Value* use = use_->usee;
            if(!use->isConst())
            {
                flag = false;
                break;
            }
        }
        if(!flag)
            return false;
    }
    if(inst->HasSideEffect())
        return false;
}