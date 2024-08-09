#pragma once
#include "../../lib/BaseCFG.hpp"
#include "../../lib/CFG.hpp"
#include "../Analysis/LoopInfo.hpp"
#include "../Analysis/SideEffect.hpp"
#include "../Analysis/dominant.hpp"
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"

class _AnalysisManager;
class CondMerge : public _PassManagerBase<CondMerge, Function>
{
  private:
    Function *func;
    _AnalysisManager &AM;
    dominance *dom;
    std::vector<BasicBlock *> DFSOrder;
    std::unordered_set<BasicBlock *> wait_del;
    bool AdjustCondition();
    bool DetectCall(Value *inst, BasicBlock *block, int depth);
    bool RetPhi(BasicBlock *block);
    bool Handle_Or(BasicBlock *cur, BasicBlock *succ, std::unordered_set<BasicBlock *> &wait_del);
    bool Handle_And(BasicBlock *cur, BasicBlock *succ, std::unordered_set<BasicBlock *> &wait_del);
    inline bool Match_Lib_Phi(BasicBlock *curr, BasicBlock *succ, BasicBlock *exit);
    inline bool DetectUserPos(Value *user, BasicBlock *blockpos, Value *val);
    void OrderBlock(BasicBlock *block);

  public:
    CondMerge(Function *func, _AnalysisManager &_AM) : func(func), AM(_AM)
    {
    }
    bool Run();
};