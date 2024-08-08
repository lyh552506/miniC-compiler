#pragma once
#include "../../../util/my_stl.hpp"
#include "../../include/lib/BaseCFG.hpp"
#include "../../include/lib/CFG.hpp"
#include "../../include/lib/Singleton.hpp"
#include "../Analysis/LoopInfo.hpp"
#include "../Analysis/dominant.hpp"
#include "LoopSimplify.hpp"
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"
#include <algorithm>
#include <vector>
class _AnalysisManager;
class BlockMerge : public _PassManagerBase<BlockMerge, Function> {
public:
  BlockMerge(Function *func, _AnalysisManager &_AM) : m_func(func), AM(_AM) {}
  bool Run();
  ~BlockMerge() = default;

private:
  bool mergeRetBlock();
  bool simplify_Block();
  bool DealBrInst();
  bool DelUndefBlock();
  //对于每个block，检查是否只有一个前驱并且前驱只有自己一个后继
  bool mergeSpecialBlock();
  void updateDTinfo(BasicBlock *bb);
  bool SimplifyUncondBr();
  bool SimplifyEmptyUncondBlock(BasicBlock *bb);
  void DeletDeadBlock(BasicBlock *bb);
  bool EliminateDeadLoop();
  bool DeleteUnReachable();
  Function *m_func;
  dominance *m_dom;
  _AnalysisManager &AM;
  LoopAnalysis *loopAnlaysis;
};