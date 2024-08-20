#pragma once
#include "PassManagerBase.hpp"
#include "../../lib/BaseCFG.hpp"
#include "../../lib/CFG.hpp"
#include "../Analysis/SideEffect.hpp"
#include "../Analysis/dominant.hpp"
#include <vector>

class CacheLookUp : public _PassManagerBase<CacheLookUp, Function> {
public:
  CacheLookUp(Function *func, _AnalysisManager &_AM) : m_func(func), AM(_AM) {}
  bool Run();
  bool InsertCache();
  ~CacheLookUp() {
    for (auto l : DeleteLoop)
      delete l;
  }

private:
  bool checkRecursive(Function *target);
  Function *m_func;
  _AnalysisManager &AM;
  static Function *_CacheLookUp;
  static bool AlreadyInsert;
  const int RetNone = INT16_MIN;
  std::vector<LoopInfo *> DeleteLoop;
};
