#include "ConstantFold.hpp"
ConstantData* ConstantFolding::ConstantFoldConstantExpression(ConstantExpr* _ConstantExpr){};
ConstantData* ConstantFolding::ConstantFoldInstruction(User* inst, BasicBlock* block)
{
    // Handle PHI nodes quickly here...
    if(auto _PhiNode = dynamic_cast<PhiInst*>(inst))
    {
        ConstantData *CommonValue = nullptr;
        for(Value* income : _PhiNode->GetAllPhiVal())
        {
            if(auto _UndefValue = dynamic_cast<UndefValue*>(income))
                continue;
            auto *_Constant = dynamic_cast<ConstantData*>(income);
            if(!_Constant)
                return nullptr;
            if(auto *NewConstant = dynamic_cast<ConstantExpr*>(_Constant))
                _Constant = ConstantFoldConstantExpression(NewConstant);
            if(CommonValue && _Constant != CommonValue)
                return nullptr;
            CommonValue = _Constant;
        }
        return CommonValue ? CommonValue : UndefValue::get(_PhiNode->GetType());
    }
    bool all_Constant = true;
    for(auto &_Operand : inst->Getuselist())
    {
        auto __Operand = _Operand.get();
        if(!dynamic_cast<ConstantData*>(__Operand->GetValue()))
        {
            all_Constant = false;
            break;
        }
    }
    if(all_Constant)
    {
        //ConstantFoldInstOperandsImpl;
    }
    return nullptr;
    
    std::vector<ConstantData*> Operands;
    for(auto &_Operand : inst->Getuselist())
    {
        auto *__Operand = dynamic_cast<ConstantData*>(_Operand->GetValue());
        if(auto *NewConstantExpr = dynamic_cast<ConstantExpr*>(__Operand))
            __Operand = ConstantFoldConstantExpression(NewConstantExpr);
        Operands.push_back(__Operand);
    }
    if(const auto *_LoadInst = dynamic_cast<LoadInst*>(inst))
        return ConstantFoldLoadInst(_LoadInst);
    return ConstantFoldInstOperands(inst, Operands);
}

ConstantData ConstantFolding::*SymbolicallyEvaluateBinop(unsigned Opcode, Value* Op0, Value* Op1)
{
    if(Opcode == BinaryInst::Op_And)
    {
        
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