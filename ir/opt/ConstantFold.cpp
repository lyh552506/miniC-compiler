#include "ConstantFold.hpp"
#include "InstructionSimplify.hpp"

Value* ConstantFolding::ConstantFoldInst(User* inst)
{
    if(auto PHiInst = dynamic_cast<PhiInst*>(inst))
        return ConstantFoldPhiInst(PHiInst);
    if(auto BInaryInst = dynamic_cast<BinaryInst*>(inst))
        return ConstantFoldBinaryInst(BInaryInst);
    if(auto _SITFP = dynamic_cast<SITFP*>(inst))
        return ConstantFoldSITFPInst(_SITFP);
    if(auto _FPTSI = dynamic_cast<FPTSI*>(inst))
        return ConstantFoldFPTSIInst(_FPTSI);
    if(auto LOadInst = dynamic_cast<LoadInst*>(inst))
        return ConstantFoldLoadInst(LOadInst);
    if(auto STore = dynamic_cast<StoreInst*>(inst))
        return ConstantFoldStoreInst(STore);
    if(auto _CallInst = dynamic_cast<CallInst*>(inst))
        ConstantFoldCallInst(_CallInst);
    // if(auto GEtElementPtrInst = dynamic_cast<GetElementPtrInst*>(inst))
    //     return ConstantFoldGetElementPtrInst(GEtElementPtrInst);
    if(auto ZExtInst = dynamic_cast<ZextInst*>(inst))
        return ConstantFoldZextInst(ZExtInst);
    return nullptr;
}

Value* ConstantFolding::ConstantFoldPhiInst(PhiInst* inst)
{
    Value* CommonValue = nullptr;
    for(Value* income : inst->GetAllPhiVal())
    {
        if(auto _UndefValue = dynamic_cast<UndefValue*>(income))
            continue;
        if(!dynamic_cast<ConstantData*>(income))
            return nullptr;
        if(CommonValue && income != CommonValue)
            return nullptr;
        CommonValue = income;
    }
    return CommonValue ? CommonValue : UndefValue::get(inst->GetType());
}

Value* ConstantFolding::ConstantFoldBinaryInst(BinaryInst* inst)
{
    Value* LHS = inst->Getuselist()[0]->usee;
    Value* RHS = inst->Getuselist()[1]->usee;
    InnerDataType type = inst->GetTypeEnum();
    
    if(LHS->isConst() && RHS->isConst())
    {
        Value* Simplify = SimplifyBinOp(inst->getopration(), LHS, RHS);
        if(Simplify)
            return Simplify;
        if(type == InnerDataType::IR_Value_INT)
            return ConstantFoldBinaryInt(inst, LHS, RHS);
        if(type == InnerDataType::IR_Value_Float)
            return ConstantFoldBinaryFloat(inst, LHS, RHS);
    }
    Value* Simplify = SimplifyBinOp(inst->getopration(), LHS, RHS);
    if(Simplify)
        return Simplify;
    return nullptr;
} 

Value* ConstantFolding::ConstantFoldBinaryInt(BinaryInst* inst, Value* LHS, Value* RHS)
{
    int LVal = dynamic_cast<ConstIRInt*>(LHS)->GetVal();
    int RVal = dynamic_cast<ConstIRInt*>(RHS)->GetVal();
    BinaryInst::Operation Opcode = inst->getopration();
    int Result;
    switch(Opcode)
    {
        case BinaryInst::Op_Add:
            Result = LVal + RVal;
            break;
        case BinaryInst::Op_Sub:
            Result = LVal - RVal;
            break;
        case BinaryInst::Op_Mul:
            Result = LVal * RVal;
            break;
        case BinaryInst::Op_Div:
            Result = LVal / RVal;
            break;
        case BinaryInst::Op_And:
            Result = (LVal && RVal);
            break;
        case BinaryInst::Op_Or:
            Result = (LVal || RVal);
            break;
        case BinaryInst::Op_Mod:
            Result = (LVal % RVal);
            break;
        case BinaryInst::Op_E:
            Result = (LVal == RVal);
            break;
        case BinaryInst::Op_NE:
            Result = (LVal != RVal);
            break;
        case BinaryInst::Op_GE:
            Result = (LVal >= RVal);
            break;
        case BinaryInst::Op_L:
            Result = (LVal < RVal);
            break;
        case BinaryInst::Op_LE:
            Result = (LVal <= RVal);
            break;
        case BinaryInst::Op_G:
            Result = (LVal > RVal);
            break;
    }
    return ConstIRInt::GetNewConstant(Result);
}

Value* ConstantFolding::ConstantFoldBinaryFloat(BinaryInst* inst, Value* LHS, Value* RHS)
{
    float LVal = dynamic_cast<ConstIRFloat*>(LHS)->GetVal();
    float RVal = dynamic_cast<ConstIRFloat*>(RHS)->GetVal();
    BinaryInst::Operation Opcode = inst->getopration();
    float Result;
    switch(Opcode)
    {
        case BinaryInst::Op_Add:
            Result = LVal + RVal;
            break;
        case BinaryInst::Op_Sub:
            Result = LVal - RVal;
            break;
        case BinaryInst::Op_Mul:
            Result = LVal * RVal;
            break;
        case BinaryInst::Op_Div:
            Result = LVal / RVal;
            break;
        case BinaryInst::Op_And:
            Result = (LVal && RVal);
            break;
        case BinaryInst::Op_Or:
            Result = (LVal || RVal);
            break;
        case BinaryInst::Op_E:
            Result = (LVal == RVal);
            break;
        case BinaryInst::Op_NE:
            Result = (LVal != RVal);
            break;
        case BinaryInst::Op_GE:
            Result = (LVal >= RVal);
            break;
        case BinaryInst::Op_L:
            Result = (LVal < RVal);
            break;
        case BinaryInst::Op_LE:
            Result = (LVal <= RVal);
            break;
        case BinaryInst::Op_G:
            Result = (LVal > RVal);
            break;
    }
    return ConstIRFloat::GetNewConstant(Result);
}

Value* ConstantFolding::ConstantFoldSITFPInst(SITFP* inst)
{
    Value* Operand = inst->Getuselist()[0]->GetValue();
    if(auto UNdefValue = dynamic_cast<UndefValue*>(Operand))
        return UndefValue::get(Operand->GetType());
    else if(auto iNt = dynamic_cast<ConstIRInt*>(Operand))
        return ConstIRFloat::GetNewConstant((float)(iNt->GetVal()));
    else
        return nullptr;
}

Value* ConstantFolding::ConstantFoldFPTSIInst(FPTSI* inst)
{
    Value* Operand = inst->Getuselist()[0]->GetValue();
    if(auto UNdefValue = dynamic_cast<UndefValue*>(Operand))
        return UndefValue::get(Operand->GetType());
    else if(auto fLoat = dynamic_cast<ConstIRFloat*>(Operand))
        return ConstIRInt::GetNewConstant((int)(fLoat->GetVal()));
    else
        return nullptr;
}

Value* ConstantFolding::ConstantFoldLoadInst(LoadInst* inst)
{
    Value* Operand = inst->Getuselist()[0]->usee;
    if(auto UNdefValue = dynamic_cast<UndefValue*>(Operand))
        return UndefValue::get(Operand->GetType());
    else if(auto iNt = dynamic_cast<ConstIRInt*>(Operand))
        return ConstIRInt::GetNewConstant(iNt->GetVal());
    else if(auto fLoat = dynamic_cast<ConstIRFloat*>(Operand))
        return ConstIRFloat::GetNewConstant(fLoat->GetVal());
    else if(auto BOol = dynamic_cast<ConstIRBoolean*>(Operand))
        return ConstIRBoolean::GetNewConstant(BOol->GetVal());
    else
        return nullptr;
}

Value* ConstantFolding::ConstantFoldStoreInst(StoreInst* inst)
{
    Value* Operand = inst->Getuselist()[0]->usee;
    if(auto UNdefValue = dynamic_cast<UndefValue*>(Operand))
        return UndefValue::get(Operand->GetType());
    else if(auto iNt = dynamic_cast<ConstIRInt*>(Operand))
        return ConstIRInt::GetNewConstant(iNt->GetVal());
    else if(auto fLoat = dynamic_cast<ConstIRFloat*>(Operand))
        return ConstIRFloat::GetNewConstant(fLoat->GetVal());
    else if(auto BOol = dynamic_cast<ConstIRBoolean*>(Operand))
        return ConstIRBoolean::GetNewConstant(BOol->GetVal());
    else
        return nullptr;
}
// Value* ConstantFolding::ConstantFoldGetElementPtrInst(GetElementPtrInst* inst)
// {
//     Value* Val = inst->GetPtrVal();
//     if(auto UNdefValue = dynamic_cast<UndefValue*>(Val))
//         return UndefValue::get(UNdefValue->GetType());
//     else if(auto iNt = dynamic_cast<ConstIRInt*>(Val))
//         return ConstIRInt::GetNewConstant(iNt->GetVal());
//     else if(auto fLoat = dynamic_cast<ConstIRFloat*>(Val))
//         return ConstIRFloat::GetNewConstant(fLoat->GetVal());
//     else if(auto BOol = dynamic_cast<ConstIRBoolean*>(Val))
//         return ConstIRBoolean::GetNewConstant(BOol->GetVal());
//     return nullptr;
// }

bool ConstantFolding::CallHasSideEffects(Function* func)
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
            auto &vac = inst->Getuselist();
            for(auto &_val : vac)
            {
                if(_val->GetValue()->isGlobVal())
                    return true;
            }
        }
    }
    return false;
}

Value* ConstantFolding::ConstantFoldCallInst(CallInst* inst)
{
    Function* func = dynamic_cast<Function*>(inst->Getuselist()[0]->usee);
    auto test = func->GetParams()[0].get();
    if(CallHasSideEffects(func))
        return nullptr;
    if(inst->GetUserlist().is_empty())
    {
        inst->ClearRelation();
        inst->EraseFromParent();
    }
    Value* Val = RVACC(func);
    if(Val)
        return Val;
    return nullptr;
}
Value* ConstantFolding::RVACC(Function* func)
{

    for(BasicBlock* block : *func)
        for(User* inst : *block)
        {
            Value* C = ConstantFoldInst(inst);
            if(C)
            inst->RAUW(C);
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
}

Value* ConstantFolding::ConstantFoldZextInst(ZextInst* inst)
{
    Value* Val = inst->Getuselist()[0]->GetValue();
    if(auto UNdefValue = dynamic_cast<UndefValue*>(Val))
        return UndefValue::get(UNdefValue->GetType());
    else if(auto iNt = dynamic_cast<ConstIRInt*>(Val))
        return ConstIRInt::GetNewConstant(iNt->GetVal());
    return nullptr;
}