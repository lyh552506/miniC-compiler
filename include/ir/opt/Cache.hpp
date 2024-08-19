#pragma once
#include "../../include/ir/opt/PassManagerBase.hpp"
#include "BaseCFG.hpp"
#include "CFG.hpp"
#include "../../include/ir/Analysis/SideEffect.hpp"
#include "../../include/ir/Analysis/dominant.hpp"
#include <vector>

class CacheLookUp : public _PassManagerBase<CacheLookUp, Function> {
public:
  CacheLookUp(Function *func, _AnalysisManager &_AM) : m_func(func), AM(_AM) {}
  bool Run();
  bool InsertCache();

private:
  bool checkRecursive(Function *target);
  Function *m_func;
  _AnalysisManager &AM;
  static Function *_CacheLookUp;
  static bool AlreadyInsert;
  const int RetNone = INT16_MIN;
};
