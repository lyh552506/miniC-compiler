#pragma once
#include "AliasAnalysis.hpp"
#include "BaseCFG.hpp"
#include "CFG.hpp"
#include "SideEffect.hpp"
#include "LoopInfo.hpp"
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"
#include "dominant.hpp"
#include <vector>
class AliasAnalysis;
class LICMPass :public _PassManagerBase<LICMPass, Function> {
public:
  LICMPass(Function *func, _AnalysisManager &_AM) : AM(_AM), m_func(func) {}
  bool Run();
  bool RunOnLoop(LoopInfo *l);
  void PrintPass(){};
  bool change = false;

private:
  bool licmSink(const std::set<BasicBlock *> &contain, LoopInfo *l,
                BasicBlock *bb);
  bool licmHoist(const std::set<BasicBlock *> &contain, LoopInfo *l,
                 BasicBlock *bb);
  bool UserOutSideLoop(const std::set<BasicBlock *> &contain, User *I,
                       LoopInfo *curloop);
  bool CanBeMove(LoopInfo *curloop,User *I);
  bool IsDomExit(User *I, std::vector<BasicBlock *> &exit);
  dominance *m_dom;
  Function *m_func;
  AliasAnalysis *alias;
  _AnalysisManager &AM;
  LoopAnalysis *loop;
};