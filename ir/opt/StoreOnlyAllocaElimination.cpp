#include "../../include/ir/opt/StoreOnlyAllocaElimination.hpp"
#include "../../util/my_stl.hpp"

bool StoreOnlyAllocaElimination::Run()
{
    bool modified = false;
    modified |= DetectStoreOnlyAlloca();
    while(!storeOnlyAllocas.empty())
    {
        AllocaInst* alloca = storeOnlyAllocas.back();
        storeOnlyAllocas.pop_back();
        _DEBUG(std::cerr<<"del alloca :" << alloca->GetName() <<std::endl;);
        for(Use* user_ : alloca->GetUserlist())
        {
            if(auto inst = dynamic_cast<User*>(user_->GetUser()))
            {
                // inst->ClearRelation();
                // inst->EraseFromParent();
                delete inst;
            }
        }
    }

    return modified;
}

bool StoreOnlyAllocaElimination::DetectStoreOnlyAlloca()
{
    BasicBlock* block = func->front();
    for(User* inst : *block)
    {
        if(inst->GetInstId() == User::Alloca)
        {

        }
    }
}