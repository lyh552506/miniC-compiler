#include "ConstantFold.hpp"
#include <queue>


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
    Value* LHS = inst->Getuselist()[0]->GetValue();
    Value* RHS = inst->Getuselist()[1]->GetValue();
    assert(LHS->isConst() && RHS->isConst());
    if(auto iNt = dynamic_cast<ConstIRInt*>(LHS))
        ConstantFoldBinaryInt(inst, LHS, RHS);
    if(auto fLoat = dynamic_cast<ConstIRFloat*>(RHS))
        ConstantFoldBinaryFloat(inst, LHS, RHS);
    
} 
Value* ConstantFolding::ConstantFoldBinaryInt(BinaryInst* inst, Value* LHS, Value* RHS)
{
    int LVal = dynamic_cast<ConstIRInt*>(LHS)->GetVal();
    int RVal = dynamic_cast<ConstIRInt*>(RHS)->GetVal();
    BinaryInst::Operation Opcode = inst->GetOpcode(inst);
    int Result;
    switch(Opcode)
    {
        case BinaryInst::Op_Add:
            Result = LVal + RVal;
        case BinaryInst::Op_Sub:
            Result = LVal - RVal;
        case BinaryInst::Op_Mul:
            Result = LVal * RVal;
        case BinaryInst::Op_Div:
            Result = LVal / RVal;
        case BinaryInst::Op_And:
            Result = (LVal && RVal);
        case BinaryInst::Op_Or:
            Result = (LVal || RVal);
        case BinaryInst::Op_Mod:
            Result = (LVal % RVal);
        case BinaryInst::Op_E:
            Result = (LVal == RVal);
        case BinaryInst::Op_NE:
            Result = (LVal != RVal);
        case BinaryInst::Op_GE:
            Result = (LVal >= RVal);
        case BinaryInst::Op_L:
            Result = (LVal < RVal);
        case BinaryInst::Op_LE:
            Result = (LVal <= RVal);
        case BinaryInst::Op_G:
            Result = (LVal > RVal);
        default:
            assert(0);
    }
    return dynamic_cast<Value*>(ConstIRInt::GetNewConstant(Result));
}

Value* ConstantFolding::ConstantFoldBinaryFloat(BinaryInst* inst, Value* LHS, Value* RHS)
{
    float LVal = dynamic_cast<ConstIRInt*>(LHS)->GetVal();
    float RVal = dynamic_cast<ConstIRInt*>(RHS)->GetVal();
    BinaryInst::Operation Opcode = inst->GetOpcode(inst);
    float Result;
    switch(Opcode)
    {
        case BinaryInst::Op_Add:
            Result = LVal + RVal;
        case BinaryInst::Op_Sub:
            Result = LVal - RVal;
        case BinaryInst::Op_Mul:
            Result = LVal * RVal;
        case BinaryInst::Op_Div:
            Result = LVal / RVal;
        case BinaryInst::Op_And:
            Result = (LVal && RVal);
        case BinaryInst::Op_Or:
            Result = (LVal || RVal);
        case BinaryInst::Op_E:
            Result = (LVal == RVal);
        case BinaryInst::Op_NE:
            Result = (LVal != RVal);
        case BinaryInst::Op_GE:
            Result = (LVal >= RVal);
        case BinaryInst::Op_L:
            Result = (LVal < RVal);
        case BinaryInst::Op_LE:
            Result = (LVal <= RVal);
        case BinaryInst::Op_G:
            Result = (LVal > RVal);
        default:
            assert(0);
    }
    return dynamic_cast<Value*>(ConstIRFloat::GetNewConstant(Result));
}

