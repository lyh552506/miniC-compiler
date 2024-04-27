#include <vector>
#include "CFG.hpp"
#include "LoopInfo.hpp"
#include "PassManagerBase.hpp"
#include "dominant.hpp"
class LoopSimplify : public PassManagerBase {
 public:
  LoopSimplify(Function* func, dominance* dom) : m_func(func), m_dom(dom) {
    loopAnlay = new LoopAnalysis(func, dom);
  }
  void RunOnFunction() override;
  void PrintPass() override{};
 private:
  void SimplifyLoosImpl(LoopInfo* loop);
  void InsertPreHeader(LoopInfo* loop);
  void InsertLatch();
  void InsertExit();
  void UpdatePhiNode(PhiInst* phi,std::set<BasicBlock*>& outside);
  LoopAnalysis* loopAnlay;
  Function* m_func;
  dominance* m_dom;
};