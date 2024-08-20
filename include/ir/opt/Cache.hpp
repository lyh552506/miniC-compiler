#pragma once
#include "PassManagerBase.hpp"
#include "../../lib/BaseCFG.hpp"
#include "../../lib/CFG.hpp"
#include "../Analysis/SideEffect.hpp"
#include "../Analysis/dominant.hpp"
#include <cstdint>
#include <vector>

class CacheLookUp : public _PassManagerBase<CacheLookUp, Function> {
public:
  CacheLookUp(Function *func, _AnalysisManager &_AM) : m_func(func), AM(_AM) {}
  bool Run();
  bool InsertCache_2arg();
  bool InsertCache_4arg(CallInst* call,std::vector<Value *>& args);
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
  const int RetNone = INT16_MAX;
  std::vector<LoopInfo *> DeleteLoop;
};
