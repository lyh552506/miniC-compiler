#pragma once
#include "../../lib/BaseCFG.hpp"
#include "../../lib/CFG.hpp"
#include "../Analysis/LoopInfo.hpp"
#include "../Analysis/dominant.hpp"
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"
#include <set>
#include <unordered_map>
#include <vector>
class _AnalysisManager;
class LcSSA : public _PassManagerBase<LcSSA, Function> {
public:
  LcSSA(Function *func, _AnalysisManager &_AM) : m_func(func), AM(_AM) {}
  bool Run();
  void PrintPass() {}
  ~LcSSA() {
    for (auto l : DeleteLoop)
      delete l;
  }

private:
  bool DFSLoops(LoopInfo *l);
  bool FormalLcSSA(std::vector<User *> &FormingInsts);
  void InsertPhis(Use *u, std::set<BasicBlock *> &exit);
  void FindBBRecursive(std::set<BasicBlock *> &exit,
                       std::set<BasicBlock *> &target,
                       std::set<BasicBlock *> &visited, BasicBlock *bb);
  void FindBBRoot(BasicBlock *src, BasicBlock *dst,
                  std::set<BasicBlock *> &visited,
                  std::stack<BasicBlock *> &assist);
  Function *m_func;
  LoopAnalysis *loops;
  dominance *m_dom;
  _AnalysisManager &AM;
  std::vector<LoopInfo *> DeleteLoop;
  //记录lcssa后的phi对应的原值，方便后续替换
  std::unordered_map<PhiInst *, Value *> LcssaRecord;
  std::unordered_map<User *, std::vector<Use *>> UseRerite;
  std::set<PhiInst *> InsertedPhis;
};