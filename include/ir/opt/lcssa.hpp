#pragma once
#include "BaseCFG.hpp"
#include "CFG.hpp"
#include "LoopInfo.hpp"
#include "PassManagerBase.hpp"
#include "dominant.hpp"
#include <set>
#include <unordered_map>
#include <vector>

class LcSSA : public PassManagerBase {
public:
  LcSSA(Function *func, dominance *dom) : m_func(func), m_dom(dom) {}
  void RunOnFunction();
  void PrintPass() {}
  void DFSLoops(LoopInfo *l);
  void FormalLcSSA(LoopInfo *l, std::set<BasicBlock *> &ContainBB,
                   std::vector<User *> &FormingInsts);
  void InsertPhis(Use *u);
  void FindBBRecursive(std::set<BasicBlock *> &target, BasicBlock *bb);

private:
  Function *m_func;
  LoopAnalysis *loops;
  dominance *m_dom;
  //记录lcssa后的phi对应的原值，方便后续替换
  std::unordered_map<PhiInst *, Value *> LcssaRecord;
  std::unordered_map<User *, std::vector<Use *>> UseRerite;
};