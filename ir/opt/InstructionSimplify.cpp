#include "InstructionSimplify.hpp"

Value* SimplifyBinOp(BinaryInst::Operation Opcode, Value* LHS, Value* RHS)
{
    switch(Opcode)
    {
        case BinaryInst::Op_Add:
            return SimplifyAddInst(LHS, RHS);
        case BinaryInst::Op_Sub:
            return SimplifySubInst(LHS, RHS);
        case BinaryInst::Op_Mul:
            return SimplifyMulInst(LHS, RHS);
        case BinaryInst::Op_Div:
            return SimplifyDivInst(LHS, RHS);
        case BinaryInst::Op_Mod:
            return SimplifyModInst(LHS, RHS);
        case BinaryInst::Op_E:
        case BinaryInst::Op_NE:
        case BinaryInst::Op_G:
        case BinaryInst::Op_GE:
        case BinaryInst::Op_L:
        case BinaryInst::Op_LE:
            return SimplifyIcmpInst(Opcode, LHS, RHS);
    }
}


Value* SimplifyAddInst(Value* LHS, Value* RHS)
{
    // X + undef -> undef
    if(LHS->isUndefVal() || RHS->isUndefVal())
        return UndefValue::get(LHS->GetType());
    // X + 0 -> X
    if(LHS->isConstZero() && !RHS->isConstZero())
        return RHS;
    if(RHS->isConstZero() && !LHS->isConstZero())
        return LHS;
}

Value* SimplifySubInst(Value* LHS, Value* RHS)
{
    // X - undef -> undef
    // undef - X -> undef
    if(LHS->isUndefVal() || RHS->isUndefVal())
        return UndefValue::get(LHS->GetType());  
    // X - 0 -> X
    if(RHS->isConstZero() && !LHS->isConstZero())
        return LHS;
    // X - X -> 0
    if(LHS == RHS)
        return ConstIRInt::GetNewConstant(0);
}

Value* SimplifyMulInst(Value* LHS, Value* RHS)
{
    // X * undef -> 0
    if(LHS->isUndefVal() || RHS->isUndefVal())
        return ConstIRInt::GetNewConstant(0);
    
    // X * 0 -> 0
    if(LHS->isConstZero() || RHS->isConstZero())
        return ConstIRInt::GetNewConstant(0);
    
    // X * 1 -> X
    if(LHS->isConstOne())
        return RHS;
    if(RHS->isConstOne())
        return LHS;
}

Value* SimplifyDivInst(Value* LHS, Value* RHS)
{
    // X / undef -> undef
    if(RHS->isUndefVal() && !LHS->isUndefVal())
        return UndefValue::get(RHS->GetType());
    // undef / 0 -> undef
    if(LHS->isUndefVal() && RHS->isConstZero())
        return UndefValue::get(RHS->GetType());
    // undef / undef -> undef
    if(LHS->isUndefVal() && RHS->isUndefVal())
        return UndefValue::get(RHS->GetType());
    // X / 0 -> undef ,we don't need to preserve faults!
    if(!LHS->isConstZero() && RHS->isConstZero())
        return UndefValue::get(RHS->GetType());
    // undef / X -> 0
    if(LHS->isUndefVal() && !RHS->isUndefVal())
        return ConstIRInt::GetNewConstant(0);
    // 0 / X -> 0
    if(LHS->isConstOne() && !RHS->isConstOne())
        return ConstIRInt::GetNewConstant(0);
    // X / 1 -> X
    if(RHS->isConstOne())
        return LHS;
    // X / X -> 1
    if(LHS == RHS)
        return ConstIRInt::GetNewConstant(1);
}

Value* SimplifyModInst(Value* LHS, Value* RHS)
{
    // X % undef -> undef
    if(!LHS->isUndefVal() && RHS->isUndefVal())
        return UndefValue::get(RHS->GetType());
    // undef % X -> 0
    if(LHS->isUndefVal() && !RHS->isUndefVal())
        return ConstIRInt::GetNewConstant(0);
    // 0 % X -> 0
    if(LHS->isConstZero())
        return ConstIRInt::GetNewConstant(0);
    // X % 0 -> undef
    if(RHS->isConstZero())
        return UndefValue::get(RHS->GetType());
    // X % 1 -> 0
    if(RHS->isConstOne())
        return ConstIRInt::GetNewConstant(0);
    // X % X -> 0
    if(RHS == LHS)
        return ConstIRInt::GetNewConstant(0);
}

Value* SimplifyIcmpInst(BinaryInst::Operation Opcode, Value* LHS, Value* RHS)
{
    if(LHS == RHS && Opcode == BinaryInst::Op_E)
        return ConstIRBoolean::GetNewConstant(true);
    if(LHS == RHS && (Opcode ==BinaryInst::Op_L || Opcode == BinaryInst::Op_LE \
    || Opcode == BinaryInst::Op_G || Opcode == BinaryInst::Op_GE || BinaryInst::Op_NE))
        return ConstIRBoolean::GetNewConstant(false);
    if(dynamic_cast<UndefValue*>(LHS) || dynamic_cast<UndefValue*>(RHS))
        return ConstIRBoolean::GetNewConstant(false);
    if(Opcode == BinaryInst::Op_E)
    {
        if((dynamic_cast<ConstIRBoolean*>(LHS))->GetVal())
            return RHS;
        if((dynamic_cast<ConstIRBoolean*>(RHS))->GetVal())
            return LHS;
    }
    if(Opcode == BinaryInst::Op_NE)
    {
        if(!(dynamic_cast<ConstIRBoolean*>(LHS))->GetVal())
            return RHS;
        if(!(dynamic_cast<ConstIRBoolean*>(RHS))->GetVal())
            return LHS;
    }
    if(Opcode == BinaryInst::Op_G)
    {
        if(!(dynamic_cast<ConstIRBoolean*>(LHS))->GetVal())
            return RHS;
        if(!(dynamic_cast<ConstIRBoolean*>(RHS))->GetVal())
            return LHS;
    }
    if(Opcode == BinaryInst::Op_GE)
    {
        if((dynamic_cast<ConstIRBoolean*>(LHS))->GetVal())
            return RHS;
        if((dynamic_cast<ConstIRBoolean*>(RHS))->GetVal())
            return LHS;
    }
}