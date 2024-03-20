#include "DCE.hpp"

void DCE::PrintPass()
{
    std::cout << "--------DCE--------" << std::endl;
    Singleton<Module>().Test();
}

void DCE::RunOnFunction()
{
    std::vector<User*> WorkList;
    for(BasicBlock* block : *func)
    {
        for(auto inst = block->rbegin();inst != block->rend(); --inst)
        {
            if(std::find(WorkList.begin(), WorkList.end(), *inst) == WorkList.end())
                DCEInst(*inst, WorkList);
        }
    }
    while(!WorkList.empty())
    {
        User* inst = WorkList.back();
        WorkList.pop_back();
        DCEInst(inst, WorkList);
    }
    return;
}

void DCE::DCEInst(User* inst, std::vector<User*> Worklist)
{
    if(isDeadInst(inst))
    {
        for(auto& use_ : inst->Getuselist())
        {
            Value* op = use_->usee;
            if(User* inst_ = dynamic_cast<User*>(op))
            {
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
    if(auto CAll = dynamic_cast<CallInst*>(inst))
    {
        if(!CAll->HasSideEffect())
        {
            if(CAll->GetTypeEnum() == IR_Value_VOID)
                return true;
            Value* RetVal = RVACC(dynamic_cast<Function*>(CAll->Getuselist()[0]->usee));
            if(dynamic_cast<UndefValue*>(RetVal))
            {
                CAll->RAUW(RetVal);
                return true;
            }
        }
    }
    if(inst->IsTerminateInst())
        return false;
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
    return nullptr;
}