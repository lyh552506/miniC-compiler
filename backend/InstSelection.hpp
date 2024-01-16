#pragma once

//将参数放进栈帧
User* MatchAllocaInst(User& inst);
//一条一条翻译
User* MatchStoreInst(User& inst);
User* MatchLoadInst(User& inst);
User* MatchFPTSI(User& inst);
User* MatchSITFP(User& inst);
User* MatchUnCondInst(User& inst);
User* MatchCondInst(User& inst);
User* MatchCallInst(User& inst);
User* MatchRetInst(User& inst);
User* MatchBinaryInst(User& inst);

User* InstSelect(User& inst);