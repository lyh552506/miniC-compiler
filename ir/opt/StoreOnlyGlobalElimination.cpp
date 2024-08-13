#include "../../include/ir/opt/StoreOnlyGlobalElimination.hpp"
#include "../../util/my_stl.hpp"
bool StoreOnlyGlobalElimination::Run()
{
    auto &globals = module->GetGlobalVariable();
    DetectStoreOnlyGlobal();
    while (!storeOnlyGlobals.empty())
    {
        Variable *global = storeOnlyGlobals.back();
        storeOnlyGlobals.pop_back();
        for (Use *user_ : global->GetUserlist())
        {
            if (auto inst = dynamic_cast<User *>(user_->GetUser()))
            {
                // inst->ClearRelation();
                // inst->EraseFromParent();
                delete inst;
            }
        }
        _DEBUG(std::cerr << "del global： " << global->GetName() << std::endl;);

        globals.erase(std::remove_if(globals.begin(), globals.end(),
                                     [global](std::unique_ptr<Variable> &ptr) { return ptr.get() == global; }),
                      globals.end());
    }
    return false;
}

void StoreOnlyGlobalElimination::DetectStoreOnlyGlobal()
{
    for (auto &ptr : module->GetGlobalVariable())
    {
        if (ptr->usage == Variable::UsageTag::Param || ptr->ForParallel)
            continue;
        else if (ptr->usage == Variable::UsageTag::Constant)
        {
            User *callinst = nullptr;
            for (Use *user_ : ptr->GetUserlist())
            {
                if (auto call = dynamic_cast<CallInst *>(user_->GetUser()))
                    if (call->Getuselist()[0]->usee->GetName() == "llvm.memcpy.p0.p0.i32")
                    {
                        callinst = call;
                        break;
                    }
            }
            if (callinst)
            {
                bool isStoreOnly = true;
                if (auto alloca = dynamic_cast<AllocaInst *>(callinst->Getuselist()[1]->usee))
                {
                    for (Use *user_ : alloca->GetUserlist())
                    {
                        if (dynamic_cast<StoreInst *>(user_->GetUser()))
                            continue;
                        if (auto call = dynamic_cast<CallInst *>(user_->GetUser()))
                        {
                            if (call->Getuselist()[0]->usee->GetName() == "llvm.memcpy.p0.p0.i32")
                                continue;
                            else
                            {
                                isStoreOnly = false;
                                break;
                            }
                        }
                        else
                        {
                            isStoreOnly = false;
                            break;
                        }
                    }
                }
                if (isStoreOnly)
                    storeOnlyGlobals.push_back(ptr.get());
            }
        }
        else
        {
            bool isStoreOnly = true;
            if (ptr->GetUserlist().is_empty())
            {
                storeOnlyGlobals.push_back(ptr.get());
                continue;
            }
            if (dynamic_cast<HasSubType *>(ptr->GetType()) &&
                dynamic_cast<HasSubType *>(ptr->GetType())->GetSubType()->GetTypeEnum() == InnerDataType::IR_ARRAY)
            {
                for(Use* user : ptr->GetUserlist())
                {
                    if(auto gep = dynamic_cast<GetElementPtrInst*>(user->GetUser()))
                    {
                        for(Use* user_ : gep->GetUserlist())
                        {
                            if(auto store = dynamic_cast<StoreInst*>(user_->GetUser()))
                                continue;
                            else
                            {
                                isStoreOnly = false;
                                break;
                            }
                        }
                    }
                    else
                    {
                        isStoreOnly = false;
                        break;
                    }
                }
            }
            else
            {
                for (Use *user_ : ptr->GetUserlist())
                {
                    if (dynamic_cast<StoreInst *>(user_->GetUser()))
                        continue;
                    if (auto call = dynamic_cast<CallInst *>(user_->GetUser()))
                    {
                        if (call->Getuselist()[0]->usee->GetName() == "llvm.memcpy.p0.p0.i32")
                            continue;
                        else
                        {
                            isStoreOnly = false;
                            break;
                        }
                    }
                    else
                    {
                        isStoreOnly = false;
                        break;
                    }
                }
            }
            if (isStoreOnly)
                storeOnlyGlobals.push_back(ptr.get());
        }
    }
}