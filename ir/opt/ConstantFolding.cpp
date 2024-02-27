#include "ConstantFold.hpp"
#include <queue>

void ConstantFolding::RunOnBlock(BasicBlock* block)
{
    for(User* inst:*block)
    {
        if(isConstantAssignment(inst))
            propConstToRef(inst);
        else if(isBranchAndConstPredicate(inst))
            changeCondBranchToAbsBranchAndMark(inst);
        else if(isPhi(inst))
            if(isOneBlockUnreachable(inst) || IsSameValPre(inst))
                propPhiToRef(inst);
    }
}

Value* ConstantFolding::ConstantFoldInstruction(User* inst, BasicBlock* block)
{
    // Handle PHI nodes quickly here...
    if(PhiInst* _PhiNode = dynamic_cast<PhiInst*>(inst))
        return ConstantFoldPhiInst(_PhiNode);
    if(LoadInst* _LoadInst = dynamic_cast<LoadInst*>(inst))
        return ConstantFoldLoadInst(_LoadInst);
    if(BinaryInst* _BinaryInst = dynamic_cast<BinaryInst*>(inst))
        return ConstantFoldBinaryInst(_BinaryInst);
    std::vector<ConstantData*> Operands;
    for(auto &_Operand : inst->Getuselist())
    {
        if(!dynamic_cast<ConstantData*>((_Operand.get()->GetValue()))->isConst())
            return nullptr; //warning:todo

        auto *__Operand = dynamic_cast<ConstantData*>(_Operand->GetValue());
        if(auto *NewConstantExpr = dynamic_cast<ConstantExpr*>(__Operand))
            __Operand = ConstantFoldConstantExpression(NewConstantExpr);
        Operands.push_back(__Operand);
    }
    return ConstantFoldInstOperands(inst, Operands);
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


ConstantData ConstantFolding::*ConstantFoldInstOperands(User* inst, std::vector<Value*> _Operands);

ConstantData ConstantFolding::*ConstantFoldLoadFromConstPtr(Value* _Const, Type* type);

bool canConstantFoldCallto(User* inst);

ConstantData ConstantFolding::*ConstantFoldCall(Function* func, std::vector<Value*> Operands);

void ConstantFolding::Pass(Function* func, dominance& dom)
{
    bfsTraversal(func, dom);
}
void ConstantFolding::bfsTraversal(Function* func, dominance& dom)
{
    std::queue<int> q;
    std::vector<bool> visited(sizeof(dominance::Node), false);

    //从根节点开始
    int rootIndex = 1;
    q.push(rootIndex);
    visited[rootIndex] = true;

    while(!q.empty())
    {
        int current = q.front();
        q.pop();
        dominance::Node* currentNode = &dom.node[current];

        //TODO
        RunOnBlock(currentNode->thisBlock);

        for(int childIndex : currentNode->idom_child)
        {
            if(!visited[childIndex])
            {
                q.push(childIndex);
                visited[childIndex] = true;
            }
        }
    }
}

bool isConstantAssignment(User* inst)
{

}
/*
    沿CFG对应的 dominant tree 从entry开始按BFS顺序遍历BasicBlock
    foreach block in blocks do:
        遍历每个inst
        foreach instr in block do:
            如果是常量赋值或者常量计算的结果
            if isConstantAssignment(instr):
                用常量值替换该变量的所有引用
                propConstToRef(instr)
            如果是常量值的分支条件
            elif isBranchAndConstPredicate(instr):
                替换为强制跳转，并标记另一个分支不可达
                changeCondBranchToAbsBranchAndMark(instr)
            如果是phi
            elif isPhi(instr):
                如果有一个基本块不可达，或者两个基本块的值相同
                if isOneBlockUnreachable(instr) || IsSameValPre(instr):
                    将可达块的值传播到对该指令的引用
                    propPhiToRef(instr)
    */

