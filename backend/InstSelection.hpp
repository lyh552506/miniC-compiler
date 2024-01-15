#pragma once
#include "Mcode.hpp"
#include "../lib/CFG.hpp"
#include <variant>
#include <iostream>

bool is_int(Operand op);
bool is_float(Operand op);

//void MatchAllocaInst(User& inst);
//一条一条翻译
// MachineStoreInst MatchStoreInst(User& inst);
// MachineLoadInst MatchLoadInst(User& inst);
// User* MatchFPTSI(User& inst);
// User* MatchSITFP(User& inst);
// User* MatchUnCondInst(User& inst);
// User* MatchCondInst(User& inst);
// User* MatchCallInst(User& inst);
// User* MatchRetInst(User& inst);
// MachineInst* ConvertToMachineInst (std::variant<MachineBinaryInst*, MachineCmpInst*>& variant);
MachineInst* MatchBinaryInst(BinaryInst* inst);
MachineInst* InstSelect(User& inst);