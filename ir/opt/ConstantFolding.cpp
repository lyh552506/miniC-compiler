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
        return ConstantFoldBinaryInst(_BinaryInst, block);
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
        auto *_Constant = dynamic_cast<ConstantData*>(income);
        if(!_Constant)
            return nullptr;
        if(CommonValue && _Constant != CommonValue)
            return nullptr;
        CommonValue = _Constant;
    }
    return CommonValue ? CommonValue : UndefValue::get(inst->GetType());
}

// void ConstantFolding::ConstantFoldBinaryInst(User* inst, BasicBlock* block)
// {
//     if(auto binaryInst = dynamic_cast<BinaryInst*>(inst))
//     {
//         Value* lhs = binaryInst->GetOperand(0);
//         Value* rhs = binaryInst->GetOperand(1);
//         ConstantData* foldedResult = ConstantFoldBinaryOpOperands(binaryInst->GetOpcode(), lhs, rhs);
//         if(foldedResult)
//         {
//             // Replace the binary instruction with the folded result
//             block->ReplaceInstruction(inst, foldedResult);
//         }
//     }
// }
// ConstantData* ConstantFolding::ConstantFoldBinaryOpOperands(BinaryInst::Operation Opcode, Value* LHS, Value* RHS)
// {
//     if(auto *lhsConst = dynamic_cast<ConstantData*>(LHS))
//     {
//         if(auto *rhsConst = dynamic_cast<ConstantData*>(RHS))
//         {
//             return ConstantFoldBinaryOpOperands(Opcode, lhsConst, rhsConst);
//         }
//     }
//     return nullptr;
// }

// ConstantData* ConstantFolding::ConstantFoldConstantExpression(ConstantExpr* _ConstantExpr)
// {
//     // 获取常量表达式的操作符和操作数
//     Value* Opcode = _ConstantExpr->getOpcode();
//     unsigned Opcode = _ConstantExpr->getOpcode();
//     Constant* LHS = _ConstantExpr->getOperand(0);
//     Constant* RHS = _ConstantExpr->getOperand(1);

//     // 根据操作符执行相应的折叠操作
//     switch (Opcode)
//     {
//         case Instruction::Add:
//         {
//             // 执行加法操作
//             Constant* Result = ConstantExpr::getAdd(LHS, RHS);
//             return new ConstantData(Result);
//         }
//         case Instruction::Sub:
//         {
//             // 执行减法操作
//             Constant* Result = ConstantExpr::getSub(LHS, RHS);
//             return new ConstantData(Result);
//         }
//         // 其他操作符的处理...

//         default:
//             // 无法折叠的操作符，返回空指针
//             return nullptr;
//     }
// }
// Constant *llvm::ConstantFoldConstantExpression(const ConstantExpr *CE,
//                                                const DataLayout &DL,
//                                                const TargetLibraryInfo *TLI) {
//   SmallPtrSet<ConstantExpr *, 4> FoldedOps;
//   return ConstantFoldConstantExpressionImpl(CE, DL, TLI, FoldedOps);
// }

Value* ConstantFolding::*SymbolicallyEvaluateBinop(BinaryInst::Operation Opcode, Value* Op0, Value* Op1)
{
    int Int_Val0 = dynamic_cast<ConstIRInt*>(Op0)->GetVal();
    int Int_Val1 = dynamic_cast<ConstIRInt*>(Op1)->GetVal();
    float float_Val0 = dynamic_cast<ConstIRFloat*>(Op0)->GetVal();
    float float_Val1 = dynamic_cast<ConstIRFloat*>(Op1)->GetVal();
    switch(Opcode)
    {
        case BinaryInst::Op_Add:
        {
            return ConstIRInt::GetNewConstant(Int_Val0 + Int_Val1);
        }
        case BinaryInst::Op_Sub:
        {}
        case BinaryInst::Op_Mul:
        {}
        case BinaryInst::Op_Div:
        {}
        case BinaryInst::Op_And:
        {}
        case BinaryInst::Op_Or:
        {}
        case BinaryInst::Op_Mod:
        {}
        case BinaryInst::Op_E:
        {}
        case BinaryInst::Op_NE:
        {}
        case BinaryInst::Op_GE:
        {}
        case BinaryInst::Op_L:
        {}
        case BinaryInst::Op_LE:
        {}
        case BinaryInst::Op_G:
        {}

    }
    if(Opcode == BinaryInst::Op_And)
    {
        if(Op0->isConst() && Op1->isConst())
            return new ConstantData(Op0 + Op1);
    }
    if(Opcode == BinaryInst::Op_Sub)
    {

    }
    

    return nullptr;
}

ConstantData ConstantFolding::*ConstantFoldBinaryOpOperands(unsigned Opcode, Value* LHS, Value* RHS)
{
    
}

ConstantData ConstantFolding::*ConstantFoldInstOperands(User* inst, std::vector<Value*> _Operands);

ConstantData ConstantFolding::*ConstantFoldCompareInstOperands(User* Pred, Value* LHS, Value* RHS);

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

