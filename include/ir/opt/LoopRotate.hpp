#pragma once
#include "BaseCFG.hpp"
#include "CFG.hpp"
#include "LoopInfo.hpp"
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"
#include "dominant.hpp"
#include "lcssa.hpp"
#include <unordered_map>

class LoopRotate : public _PassManagerBase<LoopRotate, Function> {
public:
  LoopRotate(Function *func, _AnalysisManager &_AM) : m_func(func), AM(_AM) {}
  bool Run();
  void PrintPass();

private:
  bool RotateLoop(LoopInfo *loop);
  bool CanBeMove(User *I);
  void SimplifyBlocks(BasicBlock *Header, LoopInfo *loop);
  void PreservePhi(BasicBlock *header, LoopInfo *loop, BasicBlock *preheader,
                   BasicBlock *new_header,
                   std::unordered_map<Value *, Value *> &PreHeaderValue);
  void PreserveLcssa(BasicBlock *new_exit, BasicBlock *old_exit,
                     BasicBlock *pred);
  void UpdateLoopInfo(BasicBlock *Old, BasicBlock *New,
                      const std::vector<BasicBlock *> &pred);
  LoopAnalysis *loopAnlasis;
  Function *m_func;
  dominance *m_dom;
  _AnalysisManager &AM;
  const int Heuristic = 8;
};