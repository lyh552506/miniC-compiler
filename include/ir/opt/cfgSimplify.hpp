#pragma once
#include "../../lib/BaseCFG.hpp"
#include "../../lib/CFG.hpp"
#include "../Analysis/LoopInfo.hpp"
#include "LoopSimplify.hpp"
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"
#include "../../lib/Singleton.hpp"
#include "../Analysis/dominant.hpp"
#include "../../../util/my_stl.hpp"
#include <algorithm>
#include <vector>
class _AnalysisManager;
class cfgSimplify : public _PassManagerBase<cfgSimplify, Function> {
public:
  cfgSimplify(Function *func, _AnalysisManager &_AM) : m_func(func), AM(_AM) {}
  bool Run();
  void PrintPass();
  ~cfgSimplify() = default;

private:
  bool mergeRetBlock();
  bool simplify_Block();
  bool DealBrInst();
  bool DelSamePhis();
  bool DelUndefBlock();
  //对于每个block，检查是否只有一个前驱并且前驱只有自己一个后继
  bool mergeSpecialBlock();
  void updateDTinfo(BasicBlock *bb);
  bool SimplifyUncondBr();
  bool SimplifyEmptyUncondBlock(BasicBlock *bb);
  void DeletDeadBlock(BasicBlock *bb);
  bool simplifyPhiInst();
  bool EliminateDeadLoop();
  bool DeleteUnReachable();
  Function *m_func;
  dominance *m_dom;
  _AnalysisManager &AM;
  LoopAnalysis *loopAnlaysis;
};