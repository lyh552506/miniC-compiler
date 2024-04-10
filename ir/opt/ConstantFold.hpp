#pragma once
#include "CFG.hpp"
#include "dominant.hpp"
#include <unordered_map>
using DNode=dominance::Node*;
class ConstantFolding
{
public:
Value* ConstantFoldInst(User* inst);

private:
// Handle PhiInst
Value* ConstantFoldPhiInst(PhiInst* inst);
// Handle BinaryInst
Value* ConstantFoldBinaryInst(BinaryInst* inst);
// For ConsantFoldBinaryInst 
Value* ConstantFoldBinaryInt(BinaryInst* inst, Value* LHS, Value* RHS);
// For ConsantFoldBinaryInst 
Value* ConstantFoldBinaryFloat(BinaryInst* inst, Value* LHS, Value* RHS);
Value* ConstFoldInt(BinaryInst::Operation Opcode, int LVal, int RVal);
Value* ConstFoldFloat(BinaryInst::Operation Opcode, float LVal, float RVal);
Value* ConstFoldIntCmp(BinaryInst::Operation Opcode, int LVal, int RVal);
Value* ConstFoldFloatCmp(BinaryInst::Operation Opcode, float LVal, float RVal);
Value* ConstFoldCmp(BinaryInst::Operation Opcode, bool LVal, bool RVal);
// Handle SITFP
Value* ConstantFoldSITFPInst(SITFP* inst);
// Handle FPTSI
Value* ConstantFoldFPTSIInst(FPTSI* inst);
// Handle ZextInst
Value* ConstantFoldZextInst(ZextInst* inst);

};
