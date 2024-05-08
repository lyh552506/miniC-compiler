#include "SCCP.hpp"

void SCCP::RunOnFunction()
{
    val_map.clear();
    marked.clear();
    cfg_worklist.clear();
    SSA_worklist.clear();

    cfg_worklist.emplace_back(nullptr, func->front());
    for(BasicBlock* block : *func)
    {
        for(User* inst : *block)
            val_map.set(inst, {ValueStatus::TOP});
    }
    int i, j = 0;
    while(i < cfg_worklist.size() || j < SSA_worklist.size())
    {
        while(i < cfg_worklist.size())
        {
            BasicBlock* pred = cfg_worklist[i].first;
            BasicBlock* succ = cfg_worklist[i].second;
            i++;
            if(marked.find({pred, succ}) != marked.end())
                continue;
            marked.insert(std::make_pair(pred, succ));
            for(User* inst : *succ)
                visitor->visit(inst);
        }
        while(j < SSA_worklist.size())
        {
            User* inst = SSA_worklist[j];
            j++;
            BasicBlock* block_ = inst->GetParent();
            for(int k : dom->GetNode(block_->num).rev)
            {
                BasicBlock* pred = dom->GetNode(k).thisBlock;
                if(marked.count({pred, block_}) != 0)
                {
                    visitor->visit(inst);
                    break;
                }
            }
        }
    }
    ReplaceConst();
}

void SCCP::ReplaceConst()
{
    std::vector<User*> Del_Insts;

    for(BasicBlock* block : *func)
    {
        for(User* inst : *block)
        {
            if(Value* value = getval_status(inst).val)
            {
                inst->RAUW(value);
                Del_Insts.push_back(inst);
            }
        }
    }
    for(User* inst : Del_Insts)
    {
        inst->ClearRelation();
        inst->EraseFromParent();
    }
}

ConstantData* SCCP::ConstFold(User* inst)
{
    if(BinaryInst* Binary = dynamic_cast<BinaryInst*>(inst))
    {
        ConstantData* val1 = dynamic_cast<ConstantData*>(getval_status(inst->GetOperand(0)).val);
        ConstantData* val2 = dynamic_cast<ConstantData*>(getval_status(inst->GetOperand(1)).val);
        if(val1 && val2)
            return ConstFolding->ConstFoldBinary(Binary->getopration(), val1, val2);
    }
    else if(SITFP* SITFP_ = dynamic_cast<SITFP*>(inst))
    {
        ConstantData* val = dynamic_cast<ConstantData*>(getval_status(inst->GetOperand(0)).val);
        if(UndefValue* UNdefValue = dynamic_cast<UndefValue*>(val))
            return UndefValue::get(FloatType::NewFloatTypeGet());
        else if(ConstIRInt* iNt = dynamic_cast<ConstIRInt*>(val))
            return ConstIRFloat::GetNewConstant((float)(iNt->GetVal()));
        else
            return nullptr;
    }
    else if(FPTSI* FPTSI_ = dynamic_cast<FPTSI*>(inst))
    {
        ConstantData* val = dynamic_cast<ConstantData*>(getval_status(inst->GetOperand(0)).val);
        if (UndefValue* UNdefValue = dynamic_cast<UndefValue *>(val))
            return UndefValue::get(IntType::NewIntTypeGet());
        else if (ConstIRFloat* fLoat = dynamic_cast<ConstIRFloat*>(val))
            return ConstIRInt::GetNewConstant((int)(fLoat->GetVal()));
        else
            return nullptr;
    }
    else if(ZextInst* Zext = dynamic_cast<ZextInst*>(inst))
    {
        ConstantData* val = dynamic_cast<ConstantData*>(getval_status(inst->GetOperand(0)).val);
        if(UndefValue* UNdefValue = dynamic_cast<UndefValue *>(val))
            return UndefValue::get(UNdefValue->GetType());
        else if(ConstIRBoolean* BOol = dynamic_cast<ConstIRBoolean *>(val)) 
        {
        if (BOol->GetVal())
            return ConstIRInt::GetNewConstant(1);
        else
            return ConstIRInt::GetNewConstant(0);
        }
        return nullptr;
    }
    return nullptr;
}

void InstVisitor::visit(User* inst)
{
    BasicBlock* block_ = inst->GetParent();
    prev_statu = value_map.get(inst);
    cur_statu = prev_statu;

    if(PhiInst* Phi = dynamic_cast<PhiInst*>(inst))
        visit_Phi(Phi);
    else if(CondInst* Cond = dynamic_cast<CondInst*>(inst))
        visit_Branch(Cond);
    else if(UnCondInst* UnCond = dynamic_cast<UnCondInst*>(inst))
        visit_Branch(UnCond);
    else if(dynamic_cast<BinaryInst*>(inst) || dynamic_cast<FPTSI*>(inst) 
    || dynamic_cast<SITFP*>(inst) || dynamic_cast<ZextInst*>(inst))
        visit_canfold(inst);
    else
        cur_statu = {ValueStatus::BOT};
    if(cur_statu != prev_statu)
    {
        value_map.set(inst, cur_statu);
        for(Use* Use_ : inst->GetUserlist())
        {
            User* user = Use_->GetUser();
            if(std::find(SSA_worklist.begin(), SSA_worklist.end(), user) == SSA_worklist.end())
                SSA_worklist.push_back(user);
        }
    }
}

void InstVisitor::visit_Phi(PhiInst* inst)
{
    for(int i = 0; i < inst->Blocks.size(); i++)
    {
        if(sccp.getmarked().count({inst->Blocks[i], block}))
        {
            Value* val = inst->ReturnValIn(inst->Blocks[i]);
            ValueStatus statu = value_map.get(val);
            cur_statu ^= statu;
        }
    }
}

void InstVisitor::visit_Branch(UnCondInst* inst)
{
    BasicBlock* block_ = dynamic_cast<BasicBlock*>(inst->Getuselist()[0]->usee);
    cfg_worklist.emplace_back(block, block_);
}

void InstVisitor::visit_Branch(CondInst* inst)
{
    BasicBlock* block_1 = dynamic_cast<BasicBlock*>(inst->Getuselist()[1]->usee);
    BasicBlock* block_2 = dynamic_cast<BasicBlock*>(inst->Getuselist()[2]->usee);
    bool cond = dynamic_cast<ConstIRBoolean*>(inst->Getuselist()[0]->usee)->GetVal();
    if(cond)
        cfg_worklist.emplace_back(block, block_1);
    else
        cfg_worklist.emplace_back(block, block_2);
}

void InstVisitor::visit_canfold(User* inst)
{
    ConstantData* val = sccp.ConstFold(inst);
    if(val)
    {
        cur_statu = {ValueStatus::CONST, val};
        return;
    }
    cur_statu = {ValueStatus::TOP};
    for(auto& Use_ : inst->Getuselist())
    {
        Value* val = Use_->usee;
        if(value_map.get(val).is_bot())
        {
            cur_statu = {ValueStatus::BOT};
            return;
        }
    }
}