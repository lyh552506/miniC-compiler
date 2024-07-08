#include <vector>

#include "CFG.hpp"
#include "LoopInfo.hpp"
#include "PassManagerBase.hpp"
#include "dominant.hpp"
class LoopSimplify : public PassManagerBase {
public:
  LoopSimplify(Function *func, dominance *dom) : m_func(func), m_dom(dom) {
    loopAnlay = new LoopAnalysis(func, dom);
  }
  void RunOnFunction() override;
  void PrintPass() override{};

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
                  BasicBlock *head,LoopInfo* loop);
  void CaculateLoopInfo(LoopInfo *loop);
  void UpdateLoopInfo(BasicBlock *Old, BasicBlock *New,
                      const std::vector<BasicBlock *> &pred);
  LoopAnalysis *loopAnlay;
  Function *m_func;
  dominance *m_dom;
};