#include "CSE_Tmp.hpp"

void CSE::RunOnFunction()
{
    init();
    for(BasicBlock* block : *func)
        RunOnBlock(block);
}

void CSE::init()
{
    InstSet.clear();
    PhiList.clear();
    ToBeDeleted.clear();
}

void CSE::RunOnBlock(BasicBlock* block)
{
    for(User* inst : *block)
    {
        if(inst->GetInstId() == User::OpID::Phi)
        {
            PhiInst* LHS = inst->as<PhiInst>();
            bool UnChanged = true;
            for(PhiInst* RHS : PhiList)
            {
                if(LHS->IsSame(RHS))
                {
                    LHS->RAUW(RHS);
                    ToBeDeleted.push_back(LHS);
                    UnChanged = false;
                }

                if(UnChanged)
                    PhiList.push_back(LHS);
            }
        }
        else
        {
            if(!CanBeOptimized(inst))
                continue;

            if(auto [iter, eq] = InstSet.insert(inst); !eq)
            {
                inst->RAUW(*iter);
                ToBeDeleted.push_back(inst);
            }
        }
    }
}

bool CSE::CanBeOptimized(User* inst)
{
    if(inst->HasSideEffect())
        return false;
    switch (inst->GetInstId())
    {
    case User::OpID::Alloca:
    case User::OpID::Load:
    case User::OpID::Store:
        return false;
    case User::OpID::Div:
    case User::OpID::Mod:
        return dynamic_cast<ConstantData*>(inst->Getuselist()[1]->usee)->isConstZero();
    default:
        return true;
    }
}
