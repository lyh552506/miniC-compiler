#include <vector>

#include "CFG.hpp"
#include "LoopInfo.hpp"
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"
#include "dominant.hpp"
class LoopSimplify : public _PassManagerBase<LoopSimplify, Function> {
public:
  LoopSimplify(Function *func, _AnalysisManager &_AM) : m_func(func), AM(_AM) {}
  void Run();
  void PrintPass();

private:
  void SimplifyLoopsImpl(LoopInfo *loop);
  void InsertPreHeader(LoopInfo *loop);
  void FormatLatch(LoopInfo *loop, BasicBlock *PreHeader,
                   std::vector<BasicBlock *> &latch);
  void FormatExit(LoopInfo *loop, BasicBlock *exit);
  void UpdatePhiNode(PhiInst *phi, std::set<BasicBlock *> &worklist,
                     BasicBlock *target);
  LoopInfo *SplitNewLoop(LoopInfo *L);
  void UpdateInfo(std::vector<BasicBlock *> &bbs, BasicBlock *insert,
                  BasicBlock *head, LoopInfo *loop);
  void CaculateLoopInfo(LoopInfo *loop);
  void UpdateLoopInfo(BasicBlock *Old, BasicBlock *New,
                      const std::vector<BasicBlock *> &pred);
  LoopAnalysis *loopAnlay;
  _AnalysisManager &AM;
  Function *m_func;
  dominance *m_dom;
};