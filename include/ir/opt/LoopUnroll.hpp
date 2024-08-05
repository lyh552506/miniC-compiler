#pragma once
#include "../../lib/CFG.hpp"
#include "../Analysis/LoopInfo.hpp"
#include "../Analysis/dominant.hpp"
#include "CSE.hpp"
#include "New_passManager.hpp"

class LoopUnroll : public _PassManagerBase<LoopUnroll, Function> {
public:
  LoopUnroll(Function *func, _AnalysisManager &_AM) : m_func(func), AM(_AM) {}
  bool Run();

private:
  CallInst *ExtractLoopBody(LoopInfo *loop);
  BasicBlock *Unroll(LoopInfo *loop, CallInst *UnrollBody);
  bool CanBeUnroll(LoopInfo *loop);
  void CleanUp(LoopInfo *loop, BasicBlock *clean);
  bool simplify_Block();
  void DeletDeadBlock(BasicBlock *bb);
  Function *m_func;
  dominance *dom;
  LoopAnalysis *loopAnaly;
  _AnalysisManager &AM;
  std::unordered_map<Value *, Variable *> Val2Arg;
  Value *OriginChange = nullptr;
  BasicBlock *prehead = nullptr;
  int cost = 0; // gep: 4 ; load: 4 ;binary: 1; phi: 2
  const int MaxInstCost = 800;
  const int MaxBlock = 128;
  const int MaxIteration = 500;
};