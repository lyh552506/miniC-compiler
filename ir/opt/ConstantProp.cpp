#include "ConstantProp.hpp"
#include <set>

void ConstantProp::Pass()
{
    for(BasicBlock* block : *_func)
        RunOnBlock(block);
    int num = _func->GetBasicBlock().size();
}
void ConstantProp::RunOnBlock(BasicBlock* block)
{
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
            inst->RAUW(C);
    }
    for(auto inst : wait_del)
    {
        inst->ClearRelation();
        inst->EraseFromParent();
    }
}