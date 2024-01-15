#include "ConstantFold.hpp"

Value ConstantFolding::*ConstantFoldInstruction(User* inst);

Value ConstantFolding::*ConstantFoldInstOperands(User* inst, std::vector<Value*> _Operands);

Value ConstantFolding::*ConstantFoldCompareInstOperands(User* Pred, Value* LHS, Value* RHS);

Value ConstantFolding::*ConstantFoldLoadFromConstPtr(Value* _Const, Type* type);

bool canConstantFoldCallto(User* inst);

Value ConstantFolding::*ConstantFoldCall(Function* func, std::vector<Value*> Operands);