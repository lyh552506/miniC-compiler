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
  void SimplifyLoosImpl(LoopInfo* loop);
  void PrintPass() override{};
  void SimplifyPreHeader(LoopInfo* loop);
  void SimplifyLatch();
  void SimplifyExit();

 private:
  LoopAnalysis* loopAnlay;
  Function* m_func;
  dominance* m_dom;
};