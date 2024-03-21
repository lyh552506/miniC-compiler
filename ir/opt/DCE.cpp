#include "DCE.hpp"

void DCE::PrintPass()
{
    std::cout << "--------DCE--------" << std::endl;
    Singleton<Module>().Test();
}

void DCE::RunOnFunction()
{
    bool flag = FuncHasSideEffect(func);
    if(dynamic_cast<UndefValue*>(RVACC(func)) && !flag)
    {
        for(auto iter = func->rbegin(); iter != func->rend(); --iter)
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
        return;
    }
    std::vector<User*> WorkList;
    for(BasicBlock* block : *func)
    {
        for(auto inst = block->rbegin();inst != block->rend(); --inst)
        {
            if(std::find(WorkList.begin(), WorkList.end(), (*inst)) == WorkList.end())
                DCEInst((*inst), WorkList);
        }
    }
    while(!WorkList.empty())
    {
        User* inst = WorkList.back();
        WorkList.pop_back();
        DCEInst(inst, WorkList);
    }
}

void DCE::DCEInst(User* inst, std::vector<User*> &Worklist)
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
    }
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
    for(BasicBlock* block : *func)
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
                else
                    return nullptr;
            }
            if(auto REtInst = dynamic_cast<RetInst*>(inst))
            {
                if(inst->GetTypeEnum() == IR_Value_VOID)
                    return nullptr;
                else
                {
                    Value* REtVal = inst->Getuselist()[0]->usee;
                    if(REtVal->isConst())
                    {
                        if(auto INt = dynamic_cast<ConstIRInt*>(REtVal))
                            return ConstIRInt::GetNewConstant(INt->GetVal());
                        if(auto FLoat = dynamic_cast<ConstIRFloat*>(REtVal))
                            return ConstIRFloat::GetNewConstant(FLoat->GetVal());
                        if(auto BOol = dynamic_cast<ConstIRBoolean*>(REtVal))
                            return ConstIRBoolean::GetNewConstant(BOol->GetVal());
                    }
                    else if(dynamic_cast<UndefValue*>(REtVal))
                        return UndefValue::get(REtVal->GetType());
                    else
                        return nullptr;
                }
            }
        }
    return nullptr;
}

bool DCE::FuncHasSideEffect(Function* func)
{
    auto &Params = func->GetParams();
    for(auto &_param : Params)
    {
        if(_param->GetTypeEnum() == InnerDataType::IR_PTR)
            return true;
    }
    for(BasicBlock* block : *func)
    {
        for(User* inst : *block)
        {
            if(dynamic_cast<CallInst*>(inst))
                return true;
            if(!dynamic_cast<UnCondInst*>(inst) && !dynamic_cast<CondInst*>(inst))
            {
                auto &vac = inst->Getuselist();
                for(auto &_val : vac)
                {
                    if(_val->GetValue()->isGlobVal())
                        return true;
                }
            }
        }
    }
    return false;
}