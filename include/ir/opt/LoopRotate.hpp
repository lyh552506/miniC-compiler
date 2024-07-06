#pragma once
#include "CFG.hpp"
#include "LoopInfo.hpp"
#include "PassManagerBase.hpp"
#include "dominant.hpp"
#include "lcssa.hpp"

class LoopRotate : public PassManagerBase {
public:
  LoopRotate(Function *func, dominance *dom) : m_func(func), m_dom(dom) {}
  void RunOnFunction() override;
  void PrintPass() override{};

private:
  bool RotateLoop(LoopInfo *loop);
  bool CanBeMove(User *I);
  void SimplifyBlocks(BasicBlock *Header, LoopInfo *loop);
  void PreservePhi(BasicBlock *header, LoopInfo *loop, BasicBlock *preheader,
                   BasicBlock *new_header);
  LoopAnalysis *loopAnlasis;
  Function *m_func;
  dominance *m_dom;
  PhiInst *x = nullptr;
  const int Heuristic = 8;
};