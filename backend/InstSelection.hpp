#pragma once
#include "Mcode.hpp"
#include "../lib/CFG.hpp"
#include <variant>
#include <iostream>

bool is_int(Operand op);
bool is_float(Operand op);
bool need_load(User* inst);
void add_inst(MachineInst* inst, MachineBasicBlock* parent, mylist<BasicBlock, User>::iterator& it);


//指令选择 宏扩展
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

