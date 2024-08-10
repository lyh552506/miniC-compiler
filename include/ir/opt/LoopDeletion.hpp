#pragma once
#include "../../../util/my_stl.hpp"
#include "../../lib/CFG.hpp"
#include "../Analysis/LoopInfo.hpp"
#include "../Analysis/dominant.hpp"
#include "CSE.hpp"
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"
#include <vector>
class _AnalysisManager;

class LoopDeletion : public _PassManagerBase<LoopDeletion, Function> {
public:
  LoopDeletion(Function *m_func, _AnalysisManager &_AM)
      : func(m_func), AM(_AM) {}
  bool Run();
  ~LoopDeletion() {
    for (auto l : DeleteLoop)
      delete l;
  }

private:
  bool DetectDeadLoop(LoopInfo *loop);
  bool TryDeleteLoop(LoopInfo *loop);
  bool CanBeDelete(LoopInfo *loop);
  bool IsSafeToMove(User *inst);
  bool makeLoopInvariant(User *inst, LoopInfo *loop, User *Termination);
  bool makeLoopInvariant_val(Value *val, LoopInfo *loop, User *Termination);
  bool DeleteUnReachable();
  bool isLoopInvariant(std::set<BasicBlock *> &blocks, User *inst);
  void DeletDeadBlock(BasicBlock *bb);
  void updateDTinfo(BasicBlock *bb);

private:
  LoopAnalysis *loop;
  Function *func;
  dominance *dom;
  _AnalysisManager &AM;
  std::vector<LoopInfo *> DeleteLoop;
};
