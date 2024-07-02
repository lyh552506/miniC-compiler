#pragma once
#include "BaseCFG.hpp"
#include "CFG.hpp"
#include "LoopInfo.hpp"
#include "PassManagerBase.hpp"
#include "dominant.hpp"
#include <vector>

class LICMPass : PassManagerBase {
public:
  LICMPass(dominance *dom, Function *func) : m_dom(dom), m_func(func) {
    loop = new LoopAnalysis(func, dom);
  }
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
  //bool IsLoopInvariant(const std::set<BasicBlock *> &contain,User* I,LoopInfo * curloop);                       
  bool CanBeMove(User *I);
  bool IsDomExit(User*I,std::vector<BasicBlock*>&exit);
  dominance *m_dom;
  Function *m_func;
  LoopAnalysis *loop;
};