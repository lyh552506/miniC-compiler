#pragma once
#include "Mcode.hpp"
#include "../lib/CFG.hpp"
#include <variant>
#include <iostream>

bool is_int(Operand op);
bool is_float(Operand op);

//void MatchAllocaInst(User& inst);
//一条一条翻译
MachineInst* MatchStoreInst(MachineBasicBlock* parent, StoreInst* inst);
MachineInst* MatchLoadInst(MachineBasicBlock* parent, LoadInst* inst);
MachineInst* MatchFPTSI(MachineBasicBlock* parent, FPTSI* inst);
MachineInst* MatchSITFP(MachineBasicBlock* parent, SITFP* inst);
MachineInst* MatchUnCondInst(MachineBasicBlock* parent, UnCondInst* inst);
MachineInst* MatchCondInst(MachineBasicBlock* parent, CondInst* inst);
MachineInst* MatchCallInst(MachineBasicBlock* parent, CallInst* inst);
MachineInst* MatchRetInst(MachineBasicBlock* parent, RetInst* inst);
MachineInst* MatchBinaryInst(MachineBasicBlock* parent, BinaryInst* inst);

MachineInst* InstSelect(MachineBasicBlock* parent, User& inst);