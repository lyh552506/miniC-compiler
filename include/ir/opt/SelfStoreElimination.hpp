#pragma once
#include "../../../util/my_stl.hpp"
#include "../../lib/CFG.hpp"
#include "../Analysis/AliasAnalysis.hpp"
#include "../Analysis/LoopInfo.hpp"
#include "../Analysis/SideEffect.hpp"
#include "../Analysis/dominant.hpp"
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"

class SelfStoreElimination : public _PassManagerBase<SelfStoreElimination, Function>
{
  private:
    dominance *DomTree;
    Function *func;
    _AnalysisManager &AM;
    std::set<User *> wait_del;
    std::vector<BasicBlock *> DFSOrder;
    void OrderBlock(BasicBlock *block);
    void Collect(std::unordered_map<Value *, std::vector<User *>> &info);
    void CheckSelfStore(std::unordered_map<Value *, std::vector<User *>> &info);
    void init();

  public:
    SelfStoreElimination(Function *f, _AnalysisManager &am) : func(f), AM(am)
    {
        init();
    }
    bool Run();
};