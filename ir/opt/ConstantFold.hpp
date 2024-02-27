#include "CFG.hpp"
#include "dominant.hpp"
class ConstantFolding
{
using DNode=dominance::Node*;


public:
// Handle PhiInst
Value* ConstantFoldPhiInst(PhiInst* inst);
// Handle BinaryInst
Value* ConstantFoldBinaryInst(BinaryInst* inst);

private:
// For ConsantFoldBinaryInst
Value* ConstantFoldBinaryInt(BinaryInst* inst, Value* LHS, Value* RHS);
// For ConsantFoldBinaryInst
Value* ConstantFoldBinaryFloat(BinaryInst* inst, Value* LHS, Value* RHS);
};
