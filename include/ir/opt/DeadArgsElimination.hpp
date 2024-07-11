#pragma once
#include "CFG.hpp"
#include "CSE.hpp"
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"
class _AnalysisManager;
class DeadArgsElimination
    : public _PassManagerBase<DeadArgsElimination, Module> {
private:
  std::vector<std::pair<Value *, int>> wait_del;
  Module &mod;
  _AnalysisManager &AM;

public:
  bool Run();
  bool Detect_Dead_Args(Function *func);
  DeadArgsElimination(Module &m, _AnalysisManager &AM) : mod(m), AM(AM) {}
};