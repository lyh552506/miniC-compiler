#include "../../include/ir/opt/ConstantFold.hpp"
#include "../../include/ir/opt/InstructionSimplify.hpp"

Value *ConstantFolding::ConstantFoldInst(User *inst)
{
    // if (auto PHiInst = dynamic_cast<PhiInst *>(inst))
    //   return ConstantFoldPhiInst(PHiInst);
    if (auto BInaryInst = dynamic_cast<BinaryInst *>(inst))
        return ConstantFoldBinaryInst(BInaryInst);
    else if (auto _SITFP = dynamic_cast<SITFP *>(inst))
        return ConstantFoldSITFPInst(_SITFP);
    else if (auto _FPTSI = dynamic_cast<FPTSI *>(inst))
        return ConstantFoldFPTSIInst(_FPTSI);
    else if (auto ZExtInst = dynamic_cast<ZextInst *>(inst))
        return ConstantFoldZextInst(ZExtInst);
    else if (auto maxinst = dynamic_cast<MaxInst*>(inst))
        return ConstFoldMaxInst(inst->GetOperand(0), inst->GetOperand(1));
    else if(auto mininst = dynamic_cast<MinInst*>(inst))
        return ConstFoldMinInst(inst->GetOperand(0), inst->GetOperand(1));
    else if(auto select = dynamic_cast<SelectInst*>(inst))
        return ConstFoldSelectInst(select, select->GetOperand(0), select->GetOperand(1), select->GetOperand(2));
    return nullptr;
}

// Value *ConstantFolding::ConstantFoldPhiInst(PhiInst *inst) {
//   Value *CommonValue = nullptr;
//   for (Value *income : inst->GetAllPhiVal()) {
//     if (auto _UndefValue = dynamic_cast<UndefValue *>(income))
//       return nullptr;
//     if (!dynamic_cast<ConstantData *>(income))
//       return nullptr;
//     if (CommonValue && income != CommonValue)
//       return nullptr;
//     CommonValue = income;
//   }
//   if (CommonValue)
//     return CommonValue;
//   assert(0&&"Unreachable");
// }

Value *ConstantFolding::ConstantFoldBinaryInst(BinaryInst *inst)
{
    Value *LHS = inst->Getuselist()[0]->usee;
    Value *RHS = inst->Getuselist()[1]->usee;
    InnerDataType type = inst->GetTypeEnum();

    if (LHS->isConst() && RHS->isConst())
    {
        Value *Simplify = SimplifyBinOp(inst, inst->getopration(), LHS, RHS);
        if (Simplify)
        {
            if (dynamic_cast<UndefValue *>(Simplify))
                return nullptr;
            else
                return Simplify;
        }
        if (type == InnerDataType::IR_Value_INT)
        {
            if (auto val = ConstantFoldBinaryInt(inst, LHS, RHS))
                return val;
            if (auto val = ConstantFoldBinaryFloat(inst, LHS, RHS))
                return val;
            if (auto val = ConstantFoldIntAndFloat(inst, LHS, RHS))
                return val;
        }
        if (type == InnerDataType::IR_Value_Float)
            return ConstantFoldBinaryFloat(inst, LHS, RHS);
    }
    Value *Simplify = SimplifyBinOp(inst, inst->getopration(), LHS, RHS);
    if (Simplify)
        return Simplify;
    if (inst->getopration() == BinaryInst::Op_Sub)
        ReversedSubOperand(inst);
    return nullptr;
}

Value *ConstantFolding::ConstantFoldBinaryInt(BinaryInst *inst, Value *LHS, Value *RHS)
{
    if (dynamic_cast<ConstIRInt *>(LHS) && dynamic_cast<ConstIRInt *>(RHS))
    {
        int LVal = dynamic_cast<ConstIRInt *>(LHS)->GetVal();
        int RVal = dynamic_cast<ConstIRInt *>(RHS)->GetVal();
        BinaryInst::Operation Opcode = inst->getopration();
        switch (Opcode)
        {
        case BinaryInst::Op_Add:
        case BinaryInst::Op_Sub:
        case BinaryInst::Op_Mul:
        case BinaryInst::Op_Div:
        case BinaryInst::Op_Mod:
            return ConstFoldInt(Opcode, LVal, RVal);
        case BinaryInst::Op_E:
        case BinaryInst::Op_G:
        case BinaryInst::Op_GE:
        case BinaryInst::Op_L:
        case BinaryInst::Op_LE:
        case BinaryInst::Op_And:
        case BinaryInst::Op_Or:
            return ConstFoldIntCmp(Opcode, LVal, RVal);
        }
    }
    if (dynamic_cast<ConstIRBoolean *>(LHS) && dynamic_cast<ConstIRBoolean *>(RHS))
    {
        bool LVal = dynamic_cast<ConstIRBoolean *>(LHS)->GetVal();
        bool RVal = dynamic_cast<ConstIRBoolean *>(RHS)->GetVal();
        BinaryInst::Operation Opcode = inst->getopration();
        return ConstFoldCmp(Opcode, LVal, RVal);
    }
    return nullptr;
}
Value *ConstantFolding::ConstantFoldIntAndFloat(BinaryInst *inst, Value *LHS, Value *RHS)
{
    if (dynamic_cast<ConstIRInt *>(LHS) && dynamic_cast<ConstIRFloat *>(RHS))
    {
        int LVal = dynamic_cast<ConstIRInt *>(LHS)->GetVal();
        float RVal = dynamic_cast<ConstIRFloat *>(RHS)->GetVal();
        BinaryInst::Operation Opcode = inst->getopration();
        switch (Opcode)
        {
        case BinaryInst::Op_Add:
        case BinaryInst::Op_Sub:
        case BinaryInst::Op_Mul:
        case BinaryInst::Op_Div:
            return ConstFoldFloat(Opcode, LVal, RVal);
        case BinaryInst::Op_E:
        case BinaryInst::Op_G:
        case BinaryInst::Op_GE:
        case BinaryInst::Op_L:
        case BinaryInst::Op_LE:
        case BinaryInst::Op_And:
        case BinaryInst::Op_Or:
            return ConstFoldFloatCmp(Opcode, LVal, RVal);
        }
    }
    if (dynamic_cast<ConstIRInt *>(RHS) && dynamic_cast<ConstIRFloat *>(LHS))
    {
        int LVal = dynamic_cast<ConstIRInt *>(RHS)->GetVal();
        float RVal = dynamic_cast<ConstIRFloat *>(LHS)->GetVal();
        BinaryInst::Operation Opcode = inst->getopration();
        switch (Opcode)
        {
        case BinaryInst::Op_Add:
        case BinaryInst::Op_Sub:
        case BinaryInst::Op_Mul:
        case BinaryInst::Op_Div:
            return ConstFoldFloat(Opcode, LVal, RVal);
        case BinaryInst::Op_E:
        case BinaryInst::Op_G:
        case BinaryInst::Op_GE:
        case BinaryInst::Op_L:
        case BinaryInst::Op_LE:
        case BinaryInst::Op_And:
        case BinaryInst::Op_Or:
            return ConstFoldFloatCmp(Opcode, LVal, RVal);
        }
    }
    return nullptr;
}
Value *ConstantFolding::ConstantFoldBinaryFloat(BinaryInst *inst, Value *LHS, Value *RHS)
{
    if (dynamic_cast<ConstIRFloat *>(LHS) && dynamic_cast<ConstIRFloat *>(RHS))
    {
        float LVal = dynamic_cast<ConstIRFloat *>(LHS)->GetVal();
        float RVal = dynamic_cast<ConstIRFloat *>(RHS)->GetVal();
        BinaryInst::Operation Opcode = inst->getopration();
        switch (Opcode)
        {
        case BinaryInst::Op_Add:
        case BinaryInst::Op_Sub:
        case BinaryInst::Op_Mul:
        case BinaryInst::Op_Div:
            return ConstFoldFloat(Opcode, LVal, RVal);
        case BinaryInst::Op_E:
        case BinaryInst::Op_G:
        case BinaryInst::Op_GE:
        case BinaryInst::Op_L:
        case BinaryInst::Op_LE:
        case BinaryInst::Op_And:
        case BinaryInst::Op_Or:
            return ConstFoldFloatCmp(Opcode, LVal, RVal);
        }
    }
    if (dynamic_cast<ConstIRBoolean *>(LHS) && dynamic_cast<ConstIRBoolean *>(RHS))
    {
        bool LVal = dynamic_cast<ConstIRBoolean *>(LHS)->GetVal();
        bool RVal = dynamic_cast<ConstIRBoolean *>(RHS)->GetVal();
        BinaryInst::Operation Opcode = inst->getopration();
        return ConstFoldCmp(Opcode, LVal, RVal);
    }
    return nullptr;
}

Value *ConstantFolding::ConstantFoldSITFPInst(SITFP *inst)
{
    Value *Operand = inst->Getuselist()[0]->GetValue();
    Type *type;
    if (auto UNdefValue = dynamic_cast<UndefValue *>(Operand))
        return UndefValue::get(type->NewTypeByEnum(InnerDataType::IR_Value_Float));
    else if (auto iNt = dynamic_cast<ConstIRInt *>(Operand))
        return ConstIRFloat::GetNewConstant((float)(iNt->GetVal()));
    else
        return nullptr;
}

Value *ConstantFolding::ConstantFoldFPTSIInst(FPTSI *inst)
{
    Value *Operand = inst->Getuselist()[0]->GetValue();
    Type *type;
    if (auto UNdefValue = dynamic_cast<UndefValue *>(Operand))
        return UndefValue::get(type->NewTypeByEnum(InnerDataType::IR_Value_INT));
    else if (auto fLoat = dynamic_cast<ConstIRFloat *>(Operand))
        return ConstIRInt::GetNewConstant((int)(fLoat->GetVal()));
    else
        return nullptr;
}

Value *ConstantFolding::ConstantFoldZextInst(ZextInst *inst)
{
    Value *Val = inst->Getuselist()[0]->GetValue();
    if (auto UNdefValue = dynamic_cast<UndefValue *>(Val))
        return UndefValue::get(UNdefValue->GetType());
    else if (auto BOol = dynamic_cast<ConstIRBoolean *>(Val))
    {
        if (BOol->GetVal())
            return ConstIRInt::GetNewConstant(1);
        else
            return ConstIRInt::GetNewConstant(0);
    }
    return nullptr;
}

Value *ConstantFolding::ConstFoldInt(BinaryInst::Operation Opcode, int LVal, int RVal)
{
    int Result;
    switch (Opcode)
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
    case BinaryInst::Op_Mod:
        Result = (LVal % RVal);
        break;
    }
    return ConstIRInt::GetNewConstant(Result);
}

Value *ConstantFolding::ConstFoldFloat(BinaryInst::Operation Opcode, float LVal, float RVal)
{
    float Result;
    switch (Opcode)
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
    }
    return ConstIRFloat::GetNewConstant(Result);
}
Value *ConstantFolding::ConstFoldIntCmp(BinaryInst::Operation Opcode, int LVal, int RVal)
{
    bool Result;
    switch (Opcode)
    {
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
    return ConstIRBoolean::GetNewConstant(Result);
}
Value *ConstantFolding::ConstFoldFloatCmp(BinaryInst::Operation Opcode, float LVal, float RVal)
{
    bool Result;
    switch (Opcode)
    {
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
    return ConstIRBoolean::GetNewConstant(Result);
}

Value *ConstantFolding::ConstFoldCmp(BinaryInst::Operation Opcode, bool LVal, bool RVal)
{
    bool Result;
    switch (Opcode)
    {
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
    return ConstIRBoolean::GetNewConstant(Result);
}

ConstantData *ConstantFolding::ConstFoldBinary(BinaryInst* inst, BinaryInst::Operation Opcode, ConstantData *LHS, ConstantData *RHS)
{
    Value *Simplify = SimplifyBinOp(inst, Opcode, LHS, RHS);
    ConstantData *Simplify_ = static_cast<ConstantData *>(Simplify);
    if (Simplify_)
    {
        return Simplify_;
    }
    ConstantData *retval = nullptr;
    if (dynamic_cast<ConstIRBoolean *>(LHS) && dynamic_cast<ConstIRBoolean *>(RHS))
    {
        bool LVal = dynamic_cast<ConstIRBoolean *>(LHS)->GetVal();
        bool RVal = dynamic_cast<ConstIRBoolean *>(RHS)->GetVal();
        bool Result;
        switch (Opcode)
        {
        case BinaryInst::Op_E:
            Result = (LVal == RVal);
            retval = ConstIRBoolean::GetNewConstant(Result);
            break;
        case BinaryInst::Op_NE:
            Result = (LVal != RVal);
            retval = ConstIRBoolean::GetNewConstant(Result);
            break;
        case BinaryInst::Op_GE:
            Result = (LVal >= RVal);
            retval = ConstIRBoolean::GetNewConstant(Result);
            break;
        case BinaryInst::Op_L:
            Result = (LVal < RVal);
            retval = ConstIRBoolean::GetNewConstant(Result);
            break;
        case BinaryInst::Op_LE:
            Result = (LVal <= RVal);
            retval = ConstIRBoolean::GetNewConstant(Result);
            break;
        case BinaryInst::Op_G:
            Result = (LVal > RVal);
            retval = ConstIRBoolean::GetNewConstant(Result);
            break;
        }
    }
    if (retval)
        return retval;
    if (LHS->GetType()->GetTypeEnum() == InnerDataType::IR_Value_INT)
    {
        int LVal = dynamic_cast<ConstIRInt *>(LHS)->GetVal();
        int RVal = dynamic_cast<ConstIRInt *>(RHS)->GetVal();
        int Result;
        bool Result_;
        switch (Opcode)
        {
        case BinaryInst::Op_Add:
            Result = LVal + RVal;
            retval = ConstIRInt::GetNewConstant(Result);
            break;
        case BinaryInst::Op_Sub:
            Result = LVal - RVal;
            retval = ConstIRInt::GetNewConstant(Result);
            break;
        case BinaryInst::Op_Mul:
            Result = LVal * RVal;
            retval = ConstIRInt::GetNewConstant(Result);
            break;
        case BinaryInst::Op_Div:
            Result = LVal / RVal;
            retval = ConstIRInt::GetNewConstant(Result);
            break;
        case BinaryInst::Op_Mod:
            Result = (LVal % RVal);
            retval = ConstIRInt::GetNewConstant(Result);
            break;
        case BinaryInst::Op_E:
            Result_ = (LVal == RVal);
            retval = ConstIRBoolean::GetNewConstant(Result_);
            break;
        case BinaryInst::Op_NE:
            Result_ = (LVal != RVal);
            retval = ConstIRBoolean::GetNewConstant(Result_);
            break;
        case BinaryInst::Op_GE:
            Result_ = (LVal >= RVal);
            retval = ConstIRBoolean::GetNewConstant(Result_);
            break;
        case BinaryInst::Op_L:
            Result_ = (LVal < RVal);
            retval = ConstIRBoolean::GetNewConstant(Result_);
            break;
        case BinaryInst::Op_LE:
            Result_ = (LVal <= RVal);
            retval = ConstIRBoolean::GetNewConstant(Result_);
            break;
        case BinaryInst::Op_G:
            Result_ = (LVal > RVal);
            retval = ConstIRBoolean::GetNewConstant(Result_);
            break;
        }
    }
    if (retval)
        return retval;
    if (LHS->GetType()->GetTypeEnum() == InnerDataType::IR_Value_Float)
    {
        float LVal = dynamic_cast<ConstIRFloat *>(LHS)->GetVal();
        float RVal = dynamic_cast<ConstIRFloat *>(RHS)->GetVal();
        float Result;
        bool Result_;
        switch (Opcode)
        {
        case BinaryInst::Op_Add:
            Result = LVal + RVal;
            retval = ConstIRFloat::GetNewConstant(Result);
            break;
        case BinaryInst::Op_Sub:
            Result = LVal - RVal;
            retval = ConstIRFloat::GetNewConstant(Result);
            break;
        case BinaryInst::Op_Mul:
            Result = LVal * RVal;
            retval = ConstIRFloat::GetNewConstant(Result);
            break;
        case BinaryInst::Op_Div:
            Result = LVal / RVal;
            retval = ConstIRFloat::GetNewConstant(Result);
            break;
        case BinaryInst::Op_E:
            Result_ = (LVal == RVal);
            retval = ConstIRBoolean::GetNewConstant(Result_);
            break;
        case BinaryInst::Op_NE:
            Result_ = (LVal != RVal);
            retval = ConstIRBoolean::GetNewConstant(Result_);
            break;
        case BinaryInst::Op_GE:
            Result_ = (LVal >= RVal);
            retval = ConstIRBoolean::GetNewConstant(Result_);
            break;
        case BinaryInst::Op_L:
            Result_ = (LVal < RVal);
            retval = ConstIRBoolean::GetNewConstant(Result_);
            break;
        case BinaryInst::Op_LE:
            Result_ = (LVal <= RVal);
            retval = ConstIRBoolean::GetNewConstant(Result_);
            break;
        case BinaryInst::Op_G:
            Result_ = (LVal > RVal);
            retval = ConstIRBoolean::GetNewConstant(Result_);
            break;
        }
    }
    if (retval)
        return retval;
    return nullptr;
}

bool ConstantFolding::ReversedSubOperand(BinaryInst *inst)
{
    assert(inst->getopration() == BinaryInst::Op_Sub && "Not a Sub Operation");
    Value *RHS = inst->Getuselist()[1]->usee;
    if (dynamic_cast<ConstantData *>(RHS))
    {
        inst->setoperation(BinaryInst::Op_Add);
        if(auto INT = dynamic_cast<ConstIRInt*>(RHS))
        {
            inst->RSUW(inst->Getuselist()[1].get() ,ConstIRInt::GetNewConstant(-INT->GetVal()));
            return true;
        }
        else if(auto FLOAT = dynamic_cast<ConstIRFloat*>(RHS))
        {
            inst->RSUW(inst->Getuselist()[1].get() ,ConstIRFloat::GetNewConstant(-FLOAT->GetVal()));
            return true;
        }
    }
    else
    {
        RHS->Negative_tag = true;
        return true;
    }
    return false;
}

Value* ConstantFolding::ConstFoldMaxInst(Value* LHS, Value* RHS)
{
    if(!dynamic_cast<ConstantData*>(LHS) || !dynamic_cast<ConstantData*>(RHS))
        return nullptr;
    if(dynamic_cast<ConstIRInt*>(LHS) && dynamic_cast<ConstIRInt*>(RHS))
    {
        int LVal = dynamic_cast<ConstIRInt*>(LHS)->GetVal();
        int RVal = dynamic_cast<ConstIRInt*>(RHS)->GetVal();
        return ConstIRInt::GetNewConstant(std::max(LVal, RVal));
    }
    else if(dynamic_cast<ConstIRFloat*>(LHS) && dynamic_cast<ConstIRFloat*>(RHS))
    {
        float LVal = dynamic_cast<ConstIRFloat*>(LHS)->GetVal();
        float RVal = dynamic_cast<ConstIRFloat*>(RHS)->GetVal();
        return ConstIRFloat::GetNewConstant(std::max(LVal, RVal));
    }
    return nullptr;
}

Value* ConstantFolding::ConstFoldMinInst(Value* LHS, Value* RHS)
{
    if(!dynamic_cast<ConstantData*>(LHS) || !dynamic_cast<ConstantData*>(RHS))
        return nullptr;
    if(dynamic_cast<ConstIRInt*>(LHS) && dynamic_cast<ConstIRInt*>(RHS))
    {
        int LVal = dynamic_cast<ConstIRInt*>(LHS)->GetVal();
        int RVal = dynamic_cast<ConstIRInt*>(RHS)->GetVal();
        return ConstIRInt::GetNewConstant(std::min(LVal, RVal));
    }
    else if(dynamic_cast<ConstIRFloat*>(LHS) && dynamic_cast<ConstIRFloat*>(RHS))
    {
        float LVal = dynamic_cast<ConstIRFloat*>(LHS)->GetVal();
        float RVal = dynamic_cast<ConstIRFloat*>(RHS)->GetVal();
        return ConstIRFloat::GetNewConstant(std::min(LVal, RVal));
    }
    return nullptr;
}

Value* ConstantFolding::ConstFoldSelectInst(SelectInst* inst, Value* cond, Value* TrueVal, Value* FalseVal)
{
    if(auto val = SimplifySelectInst(inst))
        return val;
    auto Cond = dynamic_cast<ConstIRBoolean*>(cond);
    if(!Cond)
        return nullptr;
    if(Cond->GetVal())
        return TrueVal;
    else
        return FalseVal;
}