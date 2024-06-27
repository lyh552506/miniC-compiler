#include "BaseCFG.hpp"
#include "CFG.hpp"
#include "LoopInfo.hpp"
#include "PassManagerBase.hpp"
#include "dominant.hpp"

class LICMPass : PassManagerBase {
public:
  LICMPass(dominance *dom, Function *func)
      : m_dom(dom), m_func(func) {}
  void RunOnFunction();
  void RunOnLoop(LoopInfo *l);
  void PrintPass(){};
  bool change = false;

private:
  bool licmSink(const std::set<BasicBlock *> &contain, LoopInfo *l,
                BasicBlock *bb);
  bool licmHoist(const std::set<BasicBlock *> &contain, LoopInfo *l,
                 BasicBlock *bb);
  bool UserOutSideLoop(const std::set<BasicBlock *> &contain, User *I,
                       LoopInfo *curloop);
  bool CanBeMove(User *I);
  dominance *m_dom;
  Function *m_func;
  LoopAnalysis *loop;
};