#pragma once
#include "../../lib/BaseCFG.hpp"
#include "../../lib/CFG.hpp"
#include "../Analysis/LoopInfo.hpp"
#include "../Analysis/dominant.hpp"
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"
#include "lcssa.hpp"
#include <unordered_map>
#include <vector>
class _AnalysisManager;
class LoopRotate : public _PassManagerBase<LoopRotate, Function> {
public:
  LoopRotate(Function *func, _AnalysisManager &_AM) : m_func(func), AM(_AM) {}
  bool Run();
  void PrintPass();
  ~LoopRotate() {
    for (auto l : DeleteLoop)
      delete l;
  }

private:
  bool RotateLoop(LoopInfo *loop, bool Succ);
  bool TryRotate(LoopInfo *loop);
  bool CanBeMove(User *I);
  void SimplifyBlocks(BasicBlock *Header, LoopInfo *loop);
  void PreservePhi(BasicBlock *header, BasicBlock *Latch, LoopInfo *loop,
                   BasicBlock *preheader, BasicBlock *new_header,
                   std::unordered_map<Value *, Value *> &PreHeaderValue,
                   LoopAnalysis *loopAnlasis);
  void PreserveLcssa(BasicBlock *new_exit, BasicBlock *old_exit,
                     BasicBlock *pred);
  LoopAnalysis *loopAnlasis;
  Function *m_func;
  dominance *m_dom;
  _AnalysisManager &AM;
  std::unordered_map<Value *, Value *> CloneMap;
  std::vector<LoopInfo *> DeleteLoop;
  const int Heuristic = 8;
};