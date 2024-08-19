#pragma once
#include "../../include/ir/Analysis/dominant.hpp"
#include "../../include/ir/opt/New_passManager.hpp"
#include "../../include/ir/opt/PassManagerBase.hpp"
#include "../../include/lib/BaseCFG.hpp"
#include "../../include/lib/CFG.hpp"
class _AnalysisManager;
class ArithOpt : public _PassManagerBase<ArithOpt, Function> {
public:
  ArithOpt(Function *func, _AnalysisManager &_AM) : m_func(func), AM(_AM) {}
  bool Run();
  void PostOrderCFG(BasicBlock *root, dominance *m_dom);
  bool ReduceDiv();
private:
  Function *m_func;
  _AnalysisManager &AM;
  std::vector<BasicBlock *> RPO;
};