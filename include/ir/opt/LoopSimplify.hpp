#pragma once
#include "../../lib/CFG.hpp"
#include "../Analysis/LoopInfo.hpp"
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"
#include <vector>
class _AnalysisManager;

class LoopSimplify : public _PassManagerBase<LoopSimplify, Function> {
public:
  LoopSimplify(Function *func, _AnalysisManager &_AM) : m_func(func), AM(_AM) {}
  bool Run();
  void PrintPass();
  static void CaculateLoopInfo(LoopInfo *loop, LoopAnalysis *Anlay);
  ~LoopSimplify() {
    for (auto l : DeleteLoop)
      delete l;
  }

private:
  bool SimplifyLoopsImpl(LoopInfo *loop);
  void SimplifyPhi();
  void InsertPreHeader(LoopInfo *loop);
  void FormatLatch(LoopInfo *loop, BasicBlock *PreHeader,
                   std::vector<BasicBlock *> &latch);
  void FormatExit(LoopInfo *loop, BasicBlock *exit);
  void UpdatePhiNode(PhiInst *phi, std::set<BasicBlock *> &worklist,
                     BasicBlock *target);
  LoopInfo *SplitNewLoop(LoopInfo *L);
  void UpdateInfo(std::vector<BasicBlock *> &bbs, BasicBlock *insert,
                  BasicBlock *head, LoopInfo *loop);
  void UpdateLoopInfo(BasicBlock *Old, BasicBlock *New,
                      const std::vector<BasicBlock *> &pred);
  LoopAnalysis *loopAnlay;
  _AnalysisManager &AM;
  std::vector<LoopInfo *> DeleteLoop;
  Function *m_func;
  dominance *m_dom;
};