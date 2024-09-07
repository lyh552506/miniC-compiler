#pragma once
#include "../opt/New_passManager.hpp"
#include "../opt/PassManagerBase.hpp"
#include "../../lib/CFG.hpp"
#include <cstddef>
#include <unordered_map>
enum InstTy {
  Load = 131,
  Gep = 231,
};

class AliasAnalysis : public _AnalysisManagerBase<AliasAnalysis, Function> {
public:
  explicit AliasAnalysis(Function *func) : m_func(func) {}
  void *GetResult(Function *func);
  static size_t GetHash(Value *val);
  std::set<Value *> FindHashVal(size_t hs);

private:
  void run();
  Function *m_func;
  std::unordered_map<size_t, std::set<Value *>> AliasTable;
};