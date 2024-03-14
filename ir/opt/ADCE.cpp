#include "ADCE.hpp"


void ADCE::Pass()
{
        AgressiveDCE(_func);
}

void ADCE::AgressiveDCE(Function* func)
{
    for(BasicBlock* block : *func)
    {
        for(auto inst_ = block->rbegin();inst_ != block->rend(); --inst_)
        {
            User* inst = *inst_;
            if(inst->Alive)
            {
                SetInstAliveRelation(inst);
                continue;
            }
            if(inst->IsTerminateInst() || inst->HasSideEffect())
            {
                inst->Alive = true;
                SetInstAliveRelation(inst);
            }
        }
    }

    for(BasicBlock* block : *func)
    {
        for(auto inst_ = block->rbegin();inst_ != block->rend(); --inst_)
        {
            User* inst = *inst_;
            if(!inst->Alive)
            {
                inst->ClearRelation();
                inst->EraseFromParent();
            }
        }
    }
}

void ADCE::SetInstAliveRelation(User* inst)
{
    for(auto& uses : inst->Getuselist())
    {
        Value* use = uses->usee;
        if(auto user = dynamic_cast<User*>(use))
        {
            if(!user->Alive)
            {
                user->Alive = true;
                SetInstAliveRelation(user);
            }
        }
    }
}