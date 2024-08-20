#pragma once
#include "../../lib/CFG.hpp"
#include "CSE.hpp"
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"
class _AnalysisManager;
class DeadArgsElimination
    : public _PassManagerBase<DeadArgsElimination, Module> {
private:
  std::vector<std::pair<Value *, int>> wait_del;
  Module *mod;
  _AnalysisManager &AM;
  bool Detect_Dead_Args(Function *func);
  void NormalHandle(Function* func);
  void Handle_SameArgs(Function* func);
public:
  bool Run();
  DeadArgsElimination(Module *m, _AnalysisManager &AM) : mod(m), AM(AM) {}
};