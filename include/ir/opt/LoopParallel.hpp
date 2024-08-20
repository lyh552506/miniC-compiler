#pragma once
#include "../../lib/CFG.hpp"
#include "../Analysis/LoopInfo.hpp"
#include "../../lib/BaseCFG.hpp"
#include "CSE.hpp"
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"
#include "../../lib/Type.hpp"
#include <unordered_set>
#include <vector>
class _AnalysisManager;
class LoopParallel : public _PassManagerBase<LoopParallel, Function> {
public:
  LoopParallel(Function *func, _AnalysisManager &_AM) : m_func(func), AM(_AM) {
    if (!Storage_int) {
      Storage_int = new Variable(Variable::GlobalVariable,
                                 IntType::NewIntTypeGet(), "Storage_int");
      Storage_int->ForParallel = true;
    }

    if (!Storage_float) {
      Storage_float =
          new Variable(Variable::GlobalVariable, FloatType::NewFloatTypeGet(),
                       "Storage_float");
      Storage_float->ForParallel = true;
    }
  }
  bool Run();
  ~LoopParallel() {
    for (auto l : DeleteLoop)
      delete l;
    delete SubstitudeTrait.cmp;
  }

private:
  bool CanBeParallel(LoopInfo *loop);
  CallInst *ExtractLoopParallelBody(LoopInfo *loop);
  bool DependencyAnalysis(LoopInfo *loop);
  Value *FindPointBase(Value *val);
  Value *GetBoundVal(BinaryInst::Operation op, LoopInfo *loop, User *cmp);
  void MakeWorkThread(Value *begin, Value *end, CallInst *loop_body);
  bool Judge(BasicBlock *bb, Value *target);
  void SimplifyPhi(LoopInfo *loop);
  bool TempChoice(LoopInfo *loop); // tmp
  void PreserveResult(LoopInfo *loop);
  Value* FindResInitial(Value* res);
  LoopTrait SubstitudeTrait;
  std::unordered_set<BasicBlock *> ExcutedLoops;
  LoopAnalysis *loop;
  Function *m_func;
  dominance *dom;
  _AnalysisManager &AM;
  LoopAnalysis *loopAnaly;
  bool ShoudPreserveRes = false;
  std::unordered_map<Value *, Variable *> Val2Arg;
  std::vector<LoopInfo *> DeleteLoop;
  static Variable *Storage_int;
  static Variable *Storage_float;
};
