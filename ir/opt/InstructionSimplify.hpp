#pragma once
#include "CFG.hpp"
#include "ConstantProp.hpp"

Value* SimplifyBinOp(BinaryInst::Operation Opcode, Value* LHS, Value* RHS);
Value* SimplifyAddInst(Value* LHS, Value* RHS);
Value* SimplifySubInst(Value* LHS, Value* RHS);
Value* SimplifyMulInst(Value* LHS, Value* RHS);
Value* SimplifyDivInst(Value* LHS, Value* RHS);
Value* SimplifyModInst(Value* LHS, Value* RHS);
Value* SimplifyIcmpInst(BinaryInst::Operation Opcode, Value* LHS, Value* RHS);