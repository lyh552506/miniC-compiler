#pragma once
#include "../../../util/my_stl.hpp"
#include "../../lib/CFG.hpp"
#include "../Analysis/AliasAnalysis.hpp"
#include "../Analysis/LoopInfo.hpp"
#include "../Analysis/SideEffect.hpp"
#include "../Analysis/dominant.hpp"
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"

class _AnalysisManager;

class DeadStoreElimination : public _PassManagerBase<DeadStoreElimination, Function>
{
  private:
    dominance *DomTree;
    Function *func;
    _AnalysisManager &AM;
    std::set<User *> wait_del;
    std::vector<BasicBlock *> DFSOrder;
    void OrderBlock(BasicBlock *block);
    bool RunOnBlock(BasicBlock *block);
    bool Judge(StoreInst* inst, BasicBlock* block, Value* dst, BasicBlock* src_block, std::unordered_set<BasicBlock*>& visited, mylist<BasicBlock,User>::iterator pos);
    bool SelfStoreElimination();
    void Collect(std::unordered_map<Value*, std::vector<StoreInst*>>& info);
    void CheckSelfStore(std::unordered_map<Value*, std::vector<StoreInst*>>& info);
    void init();

  public:
    DeadStoreElimination(Function *f, _AnalysisManager &am) : func(f), AM(am)
    {
        init();
    }
    bool Run();
};