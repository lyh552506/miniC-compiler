#include "DCE.hpp"
#include "my_stl.hpp"
#include <algorithm>

bool DCE::Run()
{
    Value* C = RVACC(func);
    if(dynamic_cast<UndefValue*>(C) && !func->HasSideEffect)
    {
        for(auto iter = func->rbegin(); 
        iter != func->rend(); --iter)
        {
            bool NDelBlock = false;
            for(auto iter1 = (*iter)->rbegin(); iter1 != (*iter)->rend(); --iter1)
            {
                if(!dynamic_cast<RetInst*>(*iter1))
                {
                    (*iter1)->ClearRelation();
                    (*iter1)->EraseFromParent();
                }
                else
                    NDelBlock = true;
            }
            if(!NDelBlock)
                (*iter)->EraseFromParent();
        }
        return true;
    }
    if(C && !func->HasSideEffect)
    {
        for(auto user : func->GetUserlist())
        {
            User* inst = user->GetUser();
            if(dynamic_cast<CallInst*>(inst))
            {
                inst->RAUW(C);
                _DEBUG(std::cerr<< "Delete Inst:" << inst->GetName() << "In Func:" << inst->GetParent()->GetParent()->GetName() <<std::endl;)
                delete inst;
            }
        }
        if(func->GetUserlist().is_empty())
        {
            // for(auto iter = func->rbegin(); iter != func->rend(); --iter)
            // {
            //     auto block = (*iter);
            //     delete block;
            // }
            func->clear();
            func->init_bbs();
            auto Block = new BasicBlock;
            auto ret = new RetInst(C);
            Block->push_back(ret);
            func->add_block(Block);
            func->GetBasicBlock().push_back(Block);
        }
        return true;
    }
    bool modified = false;
    std::vector<User*> WorkList;
    for(BasicBlock* block : *func)
    {
        for(auto inst = block->rbegin();inst != block->rend(); --inst)
        {
            if(std::find(WorkList.begin(), WorkList.end(), (*inst)) == WorkList.end())
                modified |= DCEInst((*inst), WorkList);
        }
    }
    while(!WorkList.empty())
    {
        User* inst = WorkList.back();
        WorkList.pop_back();
        modified |= DCEInst(inst, WorkList);
    }
    return modified;
}

bool DCE::DCEInst(User* inst, std::vector<User*> &Worklist)
{
    if(isDeadInst(inst))
    {
        for(auto& use_ : inst->Getuselist())
        {
            Value* op = use_->usee;
            if(User* inst_ = dynamic_cast<User*>(op))
            {
                if(isDeadInst(inst_))
                    Worklist.push_back(inst_);
            }
        }
        inst->ClearRelation();
        inst->EraseFromParent();
        return true;
    }
    return false;
}

bool DCE::isDeadInst(User* inst)
{
    if(!inst->GetUserlist().is_empty() || inst->IsTerminateInst())
        return false;
    if(!inst->HasSideEffect())
        return true;
    return false;
}

Value* DCE::RVACC(Function* func)
{
    Value* RetVal = nullptr;
    for(BasicBlock* block : *func)
    {
        for(User* inst : *block)
        {
            if(auto PHiInst = dynamic_cast<PhiInst*>(inst))
            {
                Value* CommonValue = nullptr;
                for(Value* income : PHiInst->GetAllPhiVal())
                {
                    if(auto _UndefValue = dynamic_cast<UndefValue*>(income))
                        return nullptr;
                    if(CommonValue && income != CommonValue)
                        return nullptr;
                    CommonValue = income;
                }
                if(CommonValue)
                    inst->RAUW(CommonValue);
            }
        
            if(auto REtInst = dynamic_cast<RetInst*>(inst))
            {
                if(inst->Getuselist().size() == 0)
                    RetVal = nullptr;
                else
                {
                    Value* Val = inst->Getuselist()[0]->usee;
                    if(RetVal && RetVal != Val)
                        return nullptr;
                    RetVal = Val;
                }
            }

        }
    }
    if(RetVal && dynamic_cast<ConstantData*>(RetVal))
        return RetVal;
    return nullptr;
}
