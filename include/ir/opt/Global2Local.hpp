#pragma once
#include "../../lib/CFG.hpp"
#include "../Analysis/LoopInfo.hpp"
#include "../Analysis/dominant.hpp"
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"
#include <vector>
class _AnalysisManager;
class Global2Local : public _PassManagerBase<Global2Local, Module> {
protected:
  dominance *dom_info;
  LoopAnalysis *loopAnalysis;
  int MaxNum = 5;
  size_t CurrSize = 0;
  size_t MaxSize = 3064320;
  std::map<Function *, std::set<Function *>> SuccFuncs;
  std::set<Function *> RecursiveFunctions;
  std::map<Variable *, std::set<Function *>>
      Global2Funcs; // 哪些func 用了这个 globalvalue
  std::vector<User *> insert_insts;
  std::map<Function *, int> CallTimes;
  Module *module;
  _AnalysisManager &AM;

private:
  void init(Module *module);
  void createSuccFuncs(Module *module);
  void DetectRecursive(Module *module);
  void CalGlobal2Funcs(Module *module);
  void visit(Function *func, std::set<Function *> &visited);
  void RunPass(Module *module);
  void LocalGlobalVariable(Variable *val, Function *func);
  void LocalArray(Variable *arr, AllocaInst *alloca, BasicBlock *block);
  bool CanLocal(Variable *val, Function *func);
  bool CanLocal(Variable *val);
  bool hasChanged(int index, Function *func);
  void CreateCallNum(Module *module);
  std::vector<LoopInfo *> DeleteLoop;

public:
  bool Run();
  Global2Local(Module *m, _AnalysisManager &AM) : module(m), AM(AM) {}
  ~Global2Local() {
    for (auto l : DeleteLoop)
      delete l;
  }
};
