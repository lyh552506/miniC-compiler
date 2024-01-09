#pragma once

//将参数放进栈帧
MachineInst* MatchAllocaInst(User* inst);
//一条一条翻译
MachineInst* MatchStoreInst(User* inst);
MachineInst* MatchLoadInst(User* inst);
MachineInst* MatchFPTSI(User* inst);
MachineInst* MatchSITFP(User* inst);
MachineInst* MatchUnCondInst(User* inst);
MachineInst* MatchCondInst(User* inst);
MachineInst* MatchCallInst(User* inst);
MachineInst* MatchRetInst(User* inst);
MachineInst* MatchBinaryInst(User* inst);

MachineInst* InstSelect(User* inst);