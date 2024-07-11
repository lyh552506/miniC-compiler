#include "ConstantProp.hpp"
#include <set>

bool ConstantProp::Run()
{
    bool modified = false;
    for(BasicBlock* block : *_func)
        modified |= RunOnBlock(block);
    return modified;
}

bool ConstantProp::RunOnBlock(BasicBlock* block)
{
    bool modified = false;
    std::vector<User*> wait_del;
    for(User* inst : *block)
    {
        Value* C = ConstFold->ConstantFoldInst(inst);
        if(C && !dynamic_cast<UndefValue*>(C))
        {
            inst->RAUW(C);
            if(!dynamic_cast<CallInst*>(inst))
                wait_del.push_back(inst);
        }
        else if(dynamic_cast<UndefValue*>(C))
        {
            if(!inst->GetUserlist().is_empty())
            {
                inst->RAUW(C);
                wait_del.push_back(inst);
            }
        }
    }
    for(auto inst : wait_del)
    {
        inst->ClearRelation();
        inst->EraseFromParent();
        modified |= true;
    }
    return modified;
}