#pragma once
#include "../../lib/CFG.hpp"
#include "ConstantProp.hpp"

Value* SimplifyBinOp(BinaryInst* inst, BinaryInst::Operation Opcode, Value* LHS, Value* RHS);
Value* SimplifyAddInst(Value* LHS, Value* RHS);
Value* SimplifySubInst(Value* LHS, Value* RHS);
Value* SimplifyMulInst(Value* LHS, Value* RHS);
Value* SimplifyDivInst(Value* LHS, Value* RHS);
Value* SimplifyModInst(Value* LHS, Value* RHS);
Value* SimplifyIcmpInst(BinaryInst* inst, BinaryInst::Operation Opcode, Value* LHS, Value* RHS);
Value* SimplifySelectInst(SelectInst* inst);
bool MatchAddModInst(BasicBlock* cur);