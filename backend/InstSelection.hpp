#pragma once
#include "Mcode.hpp"
#include "../lib/CFG.hpp"
#include<iostream>

//将参数放进栈帧
// void MatchAllocaInst(User& inst);
//一条一条翻译
// MachineStoreInst MatchStoreInst(User& inst);
// MachineLoadInst MatchLoadInst(User& inst);
// User* MatchFPTSI(User& inst);
// User* MatchSITFP(User& inst);
// User* MatchUnCondInst(User& inst);
// User* MatchCondInst(User& inst);
// User* MatchCallInst(User& inst);
// User* MatchRetInst(User& inst);
MachineBinaryInst* MatchBinaryInst(BinaryInst* inst);

MachineInst* InstSelect(User& inst);