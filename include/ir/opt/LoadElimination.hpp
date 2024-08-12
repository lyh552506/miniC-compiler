#pragma once
#include "../../lib/BaseCFG.hpp"
#include "../../lib/CFG.hpp"
#include "../Analysis/LoopInfo.hpp"
#include "../Analysis/SideEffect.hpp"
#include "../Analysis/dominant.hpp"
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"

class _AnalysisManager;

class LoadElimination : public _PassManagerBase<LoadElimination, Function>
{
  private:
    dominance *DomTree;
    Function *func;
    _AnalysisManager &AM;
    std::set<User *> wait_del;
    std::vector<BasicBlock *> DFSOrder;
    void OrderBlock(BasicBlock *block);
    bool RunOnBlock(BasicBlock *block);
    void init();
    std::pair<Value*, BasicBlock*> Judge(User *inst, User* origin, BasicBlock *block, Value *src, BasicBlock *pred_block,
               std::unordered_set<BasicBlock *> &visited, mylist<BasicBlock, User>::iterator pos, size_t depth);

  public:
    LoadElimination(Function *f, _AnalysisManager &am) : func(f), AM(am)
    {
        init();
    }
    bool Run();
};