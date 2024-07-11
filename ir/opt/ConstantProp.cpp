#include "../../include/ir/opt/ConstantProp.hpp"
#include <set>

void ConstantProp::RunOnFunction()
{
    for(BasicBlock* block : *_func)
        RunOnBlock(block);
}
void ConstantProp::PrintPass()
{
    std::cout << "--------constprop--------" << std::endl;
    Singleton<Module>().Test();
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
    }
}