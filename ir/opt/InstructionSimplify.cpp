#include "../../include/ir/opt/InstructionSimplify.hpp"
#include "../../include/lib/CFG.hpp"
#include <vector>

Value *SimplifyBinOp(BinaryInst *inst, BinaryInst::Operation Opcode, Value *LHS, Value *RHS)
{
    switch (Opcode)
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
    case BinaryInst::Op_And:
    case BinaryInst::Op_Or:
    case BinaryInst::Op_E:
    case BinaryInst::Op_NE:
    case BinaryInst::Op_G:
    case BinaryInst::Op_GE:
    case BinaryInst::Op_L:
    case BinaryInst::Op_LE:
        return SimplifyIcmpInst(inst, Opcode, LHS, RHS);
    default:
        return nullptr;
    }
}

Value *SimplifyAddInst(Value *LHS, Value *RHS)
{
    // X + undef -> undef
    if (LHS->isUndefVal() || RHS->isUndefVal())
        return UndefValue::get(LHS->GetType());
    // X + 0 -> X
    if (LHS->isConstZero() && !RHS->isConstZero())
        return RHS;
    if (RHS->isConstZero() && !LHS->isConstZero())
        return LHS;
    return nullptr;
}

Value *SimplifySubInst(Value *LHS, Value *RHS)
{
    // X - undef -> undef
    // undef - X -> undef
    if (LHS->isUndefVal() || RHS->isUndefVal())
        return UndefValue::get(LHS->GetType());
    // X - 0 -> X
    if (RHS->isConstZero() && !LHS->isConstZero())
        return LHS;
    // X - X -> 0
    if (LHS == RHS)
    {
        if (LHS->GetType()->GetTypeEnum() == InnerDataType::IR_Value_INT)
            return ConstIRInt::GetNewConstant(0);
        else if (LHS->GetType()->GetTypeEnum() == InnerDataType::IR_Value_Float)
            return ConstIRFloat::GetNewConstant(0);
    }

    return nullptr;
}

Value *SimplifyMulInst(Value *LHS, Value *RHS)
{
    // X * undef -> 0
    if (LHS->isUndefVal() || RHS->isUndefVal())
    {
        if (dynamic_cast<ConstIRFloat *>(LHS))
            return ConstIRFloat::GetNewConstant(0);
        else if (dynamic_cast<ConstIRInt *>(LHS))
            return ConstIRInt::GetNewConstant(0);
    }

    // X * 0 -> 0
    if (LHS->isConstZero() || RHS->isConstZero())
    {
        if (dynamic_cast<ConstIRFloat *>(LHS))
            return ConstIRFloat::GetNewConstant(0);
        else if (dynamic_cast<ConstIRInt *>(LHS))
            return ConstIRInt::GetNewConstant(0);
    }

    // X * 1 -> X
    if (LHS->isConstOne())
        return RHS;
    if (RHS->isConstOne())
        return LHS;

    // a / b * b -> a
    if (auto Div = dynamic_cast<BinaryInst *>(LHS))
    {
        if (Div->getopration() == BinaryInst::Op_Div && Div->GetOperand(1) == RHS)
            return Div->GetOperand(0);
    }
    if (auto DIV = dynamic_cast<BinaryInst *>(RHS))
    {
        if (DIV->getopration() == BinaryInst::Op_Div && DIV->GetOperand(1) == LHS)
            return DIV->GetOperand(0);
    }
    return nullptr;
}

Value *SimplifyDivInst(Value *LHS, Value *RHS)
{
    // X / undef -> undef
    if (RHS->isUndefVal() && !LHS->isUndefVal())
        return UndefValue::get(RHS->GetType());
    // undef / 0 -> undef
    if (LHS->isUndefVal() && RHS->isConstZero())
        return UndefValue::get(RHS->GetType());
    // undef / undef -> undef
    if (LHS->isUndefVal() && RHS->isUndefVal())
        return UndefValue::get(RHS->GetType());
    // X / 0 -> undef ,we don't need to preserve faults!
    if (!LHS->isConstZero() && RHS->isConstZero())
        return UndefValue::get(RHS->GetType());
    // undef / X -> 0
    if (LHS->isUndefVal() && !RHS->isUndefVal())
    {
        if (dynamic_cast<ConstIRFloat *>(LHS))
            return ConstIRFloat::GetNewConstant(0);
        else if (dynamic_cast<ConstIRInt *>(LHS))
            return ConstIRInt::GetNewConstant(0);
    }
    // 0 / X -> 0
    if (LHS->isConstZero() && !RHS->isConstZero())
    {
        if (dynamic_cast<ConstIRFloat *>(LHS))
            return ConstIRFloat::GetNewConstant(0);
        else if (dynamic_cast<ConstIRInt *>(LHS))
            return ConstIRInt::GetNewConstant(0);
    }
    // X / 1 -> X
    if (RHS->isConstOne())
        return LHS;
    // X / X -> 1
    if (LHS == RHS)
    {
        if (dynamic_cast<ConstIRInt *>(LHS) && dynamic_cast<ConstIRInt *>(RHS))
            return ConstIRInt::GetNewConstant(1);
        else if (dynamic_cast<ConstIRFloat *>(LHS) && dynamic_cast<ConstIRFloat *>(RHS))
            return ConstIRFloat::GetNewConstant(1);
    }

    // a * b / b -> a
    if (auto Mul = dynamic_cast<BinaryInst *>(LHS))
    {
        if (Mul->getopration() == BinaryInst::Op_Mul && Mul->GetOperand(1) == RHS)
            return Mul->GetOperand(0);
        else if (Mul->getopration() == BinaryInst::Op_Mul && Mul->GetOperand(0) == RHS)
            return Mul->GetOperand(1);
    }
    return nullptr;
}

Value *SimplifyModInst(Value *LHS, Value *RHS)
{
    // X % undef -> undef
    if (!LHS->isUndefVal() && RHS->isUndefVal())
        return UndefValue::get(RHS->GetType());
    // undef % X -> 0
    if (LHS->isUndefVal() && !RHS->isUndefVal())
        return ConstIRInt::GetNewConstant(0);
    // 0 % X -> 0
    if (LHS->isConstZero())
    {
        if (dynamic_cast<ConstIRFloat *>(LHS))
            return ConstIRFloat::GetNewConstant(0);
        else if (dynamic_cast<ConstIRInt *>(LHS))
            return ConstIRInt::GetNewConstant(0);
    }
    // X % 0 -> undef
    if (RHS->isConstZero())
        return UndefValue::get(RHS->GetType());
    // X % 1 -> 0
    if (RHS->isConstOne())
    {
        if (dynamic_cast<ConstIRFloat *>(LHS))
            return ConstIRFloat::GetNewConstant(0);
        else if (dynamic_cast<ConstIRInt *>(LHS))
            return ConstIRInt::GetNewConstant(0);
    }
    // X % X -> 0
    if (RHS == LHS)
    {
        if (dynamic_cast<ConstIRFloat *>(LHS))
            return ConstIRFloat::GetNewConstant(0);
        else if (dynamic_cast<ConstIRInt *>(LHS))
            return ConstIRInt::GetNewConstant(0);
    }
    return nullptr;
}

Value *SimplifyIcmpInst(BinaryInst *inst, BinaryInst::Operation Opcode, Value *LHS, Value *RHS)
{
    // false and  X -> false
    if (Opcode == BinaryInst::Op_And)
    {
        auto LHSBool = dynamic_cast<ConstIRBoolean *>(LHS);
        auto RHSBool = dynamic_cast<ConstIRBoolean *>(RHS);
        if (LHSBool && RHSBool)
        {
            if (LHSBool->GetVal() == false || RHSBool->GetVal() == false)
                return ConstIRBoolean::GetNewConstant(false);
            else
                return ConstIRBoolean::GetNewConstant(true);
        }
        else if (LHSBool && !RHSBool)
        {
            if (LHSBool->GetVal() == false)
                return ConstIRBoolean::GetNewConstant(false);
        }
        else if (RHSBool && !LHSBool)
        {
            if (RHSBool->GetVal() == false)
                return ConstIRBoolean::GetNewConstant(false);
        }
    }

    // m and !m
    if (Opcode == BinaryInst::Op_And)
    {
        auto LHS_Cmp = dynamic_cast<BinaryInst *>(LHS);
        auto RHS_Cmp = dynamic_cast<BinaryInst *>(RHS);
        if (LHS_Cmp && RHS_Cmp)
        {
            BinaryInst::Operation LHS_Op = LHS_Cmp->getopration();
            BinaryInst::Operation RHS_Op = RHS_Cmp->getopration();
            auto match_Op = [&](int i, int j) {
                return LHS_Cmp->GetOperand(0) == RHS_Cmp->GetOperand(i) &&
                       LHS_Cmp->GetOperand(1) == RHS_Cmp->GetOperand(j);
            };
            if (LHS_Cmp->GetInvertedOperation(LHS_Op) == RHS_Op && match_Op(0, 1))
                return ConstIRBoolean::GetNewConstant(false);
        }
    }

    // m or !m
    if (Opcode == BinaryInst::Op_Or)
    {
        auto LHS_Cmp = dynamic_cast<BinaryInst *>(LHS);
        auto RHS_Cmp = dynamic_cast<BinaryInst *>(RHS);
        if (LHS_Cmp && RHS_Cmp)
        {
            BinaryInst::Operation LHS_Op = LHS_Cmp->getopration();
            BinaryInst::Operation RHS_Op = RHS_Cmp->getopration();
            auto match_Op = [&](int i, int j) {
                return LHS_Cmp->GetOperand(0) == RHS_Cmp->GetOperand(i) &&
                       LHS_Cmp->GetOperand(1) == RHS_Cmp->GetOperand(j);
            };
            if (LHS_Cmp->GetInvertedOperation(LHS_Op) == RHS_Op && match_Op(0, 1))
                return ConstIRBoolean::GetNewConstant(true);
        }
    }

    // true or X -> true
    if (Opcode == BinaryInst::Op_Or)
    {
        auto LHSBool = dynamic_cast<ConstIRBoolean *>(LHS);
        auto RHSBool = dynamic_cast<ConstIRBoolean *>(RHS);
        if (LHSBool && RHSBool)
        {
            if (LHSBool->GetVal() == false && RHSBool->GetVal() == false)
                return ConstIRBoolean::GetNewConstant(false);
            else
                return ConstIRBoolean::GetNewConstant(true);
        }
        else if (LHSBool && !RHSBool)
        {
            if (LHSBool->GetVal() == true)
                return ConstIRBoolean::GetNewConstant(true);
        }
        else if (RHSBool && !LHSBool)
        {
            if (RHSBool->GetVal() == true)
                return ConstIRBoolean::GetNewConstant(true);
        }
    }

    // ( X == a ) && ( Y == b ) ->  ( X ^ a ) || ( Y ^ b ) == 0 实测慢了
    // if(Opcode == BinaryInst::Op_And)
    // {
    //   if(dynamic_cast<BinaryInst*>(LHS) && dynamic_cast<BinaryInst*>(RHS))
    //   {
    //     BinaryInst* lhs = dynamic_cast<BinaryInst*>(LHS);
    //     BinaryInst* rhs = dynamic_cast<BinaryInst*>(RHS);
    //     if(lhs->getopration() == BinaryInst::Operation::Op_E && rhs->getopration() == BinaryInst::Operation::Op_E)
    //     {
    //       BinaryInst* LHS_Xor = new BinaryInst(lhs->GetOperand(0), BinaryInst::Operation::Op_Xor,
    //       lhs->GetOperand(1)); BinaryInst* RHS_Xor = new BinaryInst(rhs->GetOperand(0),
    //       BinaryInst::Operation::Op_Xor, rhs->GetOperand(1)); lhs->RAUW(LHS_Xor); rhs->RAUW(RHS_Xor); delete lhs;
    //       delete rhs;
    //       BinaryInst* New_Or = new BinaryInst(LHS_Xor, BinaryInst::Operation::Op_Or, RHS_Xor);
    //       BinaryInst* New_Cmp = nullptr;
    //       if(New_Or->GetType()->GetTypeEnum() == InnerDataType::IR_Value_INT)
    //         New_Cmp = new BinaryInst(New_Or, BinaryInst::Operation::Op_E, ConstIRInt::GetNewConstant(0));
    //       else if(New_Or->GetType()->GetTypeEnum() == InnerDataType::IR_Value_Float)
    //         New_Cmp = new BinaryInst(New_Or, BinaryInst::Operation::Op_E, ConstIRFloat::GetNewConstant(0.0));
    //       else
    //         New_Cmp = new BinaryInst(New_Or, BinaryInst::Operation::Op_E, ConstIRBoolean::GetNewConstant(false));
    //       BasicBlock::mylist<BasicBlock, User>::iterator Pos(inst);
    //       Pos.insert_before(LHS_Xor);
    //       Pos.insert_before(RHS_Xor);
    //       Pos.insert_before(New_Or);
    //       Pos.insert_before(New_Cmp);
    //       return New_Cmp;
    //     }
    //   }
    // }

    // X == X -> true
    if (LHS == RHS && Opcode == BinaryInst::Op_E)
        return ConstIRBoolean::GetNewConstant(true);
    // X <= X -> true
    // X >= X -> true
    // X < X -> false
    // X > X -> false
    // X != X -> false
    if (LHS == RHS && Opcode == BinaryInst::Op_L)
        return ConstIRBoolean::GetNewConstant(false);
    if (LHS == RHS && Opcode == BinaryInst::Op_LE)
        return ConstIRBoolean::GetNewConstant(true);
    if (LHS == RHS && Opcode == BinaryInst::Op_G)
        return ConstIRBoolean::GetNewConstant(false);
    if (LHS == RHS && Opcode == BinaryInst::Op_GE)
        return ConstIRBoolean::GetNewConstant(true);
    if (LHS == RHS && Opcode == BinaryInst::Op_NE)
        return ConstIRBoolean::GetNewConstant(false);
    // X != Y -> true
    if (LHS->isConst() && RHS->isConst() && Opcode == BinaryInst::Op_NE && LHS != RHS)
        return ConstIRBoolean::GetNewConstant(true);
    // UndefValue op UndefValue -> false
    if (dynamic_cast<UndefValue *>(LHS) || dynamic_cast<UndefValue *>(RHS))
        return ConstIRBoolean::GetNewConstant(false);

    return nullptr;
}

bool MatchAddModInst(BasicBlock *cur)
{
    for (auto iter = cur->begin(); iter != cur->end();)
    {
        auto bin = dynamic_cast<BinaryInst *>(*iter);
        std::vector<BinaryInst *> AddInst;
        std::vector<BinaryInst *> ModInst;
        ++iter;
        bool match = true;
        int ModNum = 0;
        BinaryInst *Base = nullptr;
        while (match)
        {
            match = false;
            if (bin && bin->getopration() == BinaryInst::Op_Add && bin->GetUserListSize() == 1 &&
                bin->GetOperand(1)->isConst())
            {
                if (!Base)
                    Base = bin;
                AddInst.push_back(bin);
                auto user = bin->GetUserlist().Front()->GetUser();
                auto mod = dynamic_cast<BinaryInst *>(user);
                if (mod && mod->getopration() == BinaryInst::Op_Mod && mod->GetParent() == bin->GetParent() &&
                    mod->GetUserListSize() == 1 && mod->GetOperand(1)->isConst())
                {
                    if (ModNum == 0)
                        ModNum = dynamic_cast<ConstIRInt *>(mod->GetOperand(1))->GetVal();
                    else
                    {
                        if (ModNum != dynamic_cast<ConstIRInt *>(mod->GetOperand(1))->GetVal())
                            break;
                    }

                    ModInst.push_back(mod);
                    bin = dynamic_cast<BinaryInst *>(mod->GetUserlist().Front()->GetUser());
                    match = true;
                }
                else
                {
                    // reach the end of Insts
                    if (AddInst.size() <= 1 || ModInst.size() <= 1)
                        return false;
                    BasicBlock::mylist<BasicBlock, User>::iterator insert_pos(mod);
                    _DEBUG(std::cerr << "Match Add Mod Insts!" << std::endl;)
                    auto Relp = mod;
                    auto op = Base->GetOperand(0);
                    int Sum = 0;
                    for (auto add : AddInst)
                        Sum += dynamic_cast<ConstIRInt *>(add->GetOperand(1))->GetVal();
                    Sum = Sum % ModNum;
                    auto New_Add = new BinaryInst(op, BinaryInst::Op_Add, ConstIRInt::GetNewConstant(Sum));
                    auto New_Mod = new BinaryInst(New_Add, BinaryInst::Op_Mod, ConstIRInt::GetNewConstant(ModNum));
                    insert_pos = insert_pos.insert_after(New_Add);
                    insert_pos.insert_after(New_Mod);
                    mod->RAUW(New_Mod);
                    delete mod;
                    return true;
                }
            }
        }
    }
    return false;
}

Value *SimplifySelectInst(SelectInst *inst)
{
    Value *Cond = inst->GetOperand(0);
    Value *TrueVal = inst->GetOperand(1);
    Value *FalseVal = inst->GetOperand(2);
    if (Cond->isConst())
    {
        if (dynamic_cast<ConstIRBoolean *>(Cond)->GetVal())
            return TrueVal;
        else
            return FalseVal;
    }
    else if (auto binary = dynamic_cast<BinaryInst *>(Cond))
    {
        if (binary->getopration() == BinaryInst::Op_L || binary->getopration() == BinaryInst::Op_LE)
        {
            if (binary->GetOperand(0) == TrueVal && binary->GetOperand(1) == FalseVal)
            {
                auto min = new MinInst(TrueVal, FalseVal);
                BasicBlock::mylist<BasicBlock, User>::iterator Pos(inst);
                Pos.insert_before(min);
                return min;
            }
            else if (binary->GetOperand(0) == FalseVal && binary->GetOperand(0) == TrueVal)
            {
                auto max = new MaxInst(TrueVal, FalseVal);
                BasicBlock::mylist<BasicBlock, User>::iterator Pos(inst);
                Pos.insert_before(max);
                return max;
            }
        }
        else if (binary->getopration() == BinaryInst::Op_G || binary->getopration() == BinaryInst::Op_GE)
        {
            if (binary->GetOperand(0) == TrueVal && binary->GetOperand(1) == FalseVal)
            {
                auto max = new MaxInst(TrueVal, FalseVal);
                BasicBlock::mylist<BasicBlock, User>::iterator Pos(inst);
                Pos.insert_before(max);
                return max;
            }
            else if (binary->GetOperand(0) == FalseVal && binary->GetOperand(0) == TrueVal)
            {
                auto min = new MinInst(TrueVal, FalseVal);
                BasicBlock::mylist<BasicBlock, User>::iterator Pos(inst);
                Pos.insert_before(min);
                return min;
            }
        }
    }
    return nullptr;
}