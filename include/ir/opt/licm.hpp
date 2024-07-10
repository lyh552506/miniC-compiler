#pragma once
#include "BaseCFG.hpp"
#include "CFG.hpp"
#include "LoopInfo.hpp"
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"
#include "dominant.hpp"
#include <vector>

class LICMPass : _PassManagerBase<LICMPass, Function> {
public:
  LICMPass(Function *func, _AnalysisManager &_AM) : AM(_AM), m_func(func) {
    m_dom = AM.get<dominance>(func);
  }
  void Run();
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
  bool IsDomExit(User *I, std::vector<BasicBlock *> &exit);
  dominance *m_dom;
  Function *m_func;
  _AnalysisManager &AM;
  LoopAnalysis *loop;
};