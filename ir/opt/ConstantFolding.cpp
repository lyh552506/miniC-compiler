#include "ConstantFold.hpp"

Value ConstantFolding::*ConstantFoldInstruction(User* inst, BasicBlock* block)
{
    // Handle PHI nodes quickly here...
    if(auto _PhiNode = dynamic_cast<PhiInst*>(inst))
    {
        Constant *CommonValue = nullptr;
        for(Value* income : _PhiNode->PhiRecord[block])
    }
}

Value ConstantFolding::*ConstantFoldInstOperands(User* inst, std::vector<Value*> _Operands);

Value ConstantFolding::*ConstantFoldCompareInstOperands(User* Pred, Value* LHS, Value* RHS);

Value ConstantFolding::*ConstantFoldLoadFromConstPtr(Value* _Const, Type* type);

bool canConstantFoldCallto(User* inst);

Value ConstantFolding::*ConstantFoldCall(Function* func, std::vector<Value*> Operands);