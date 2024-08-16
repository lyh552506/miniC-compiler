#pragma once
#include "../../../util/my_stl.hpp"
#include "../../lib/CFG.hpp"
#include "../Analysis/dominant.hpp"
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"
#include <unordered_set>

class _AnalysisManager;

class ConstantHoist : public _PassManagerBase<ConstantHoist, Function>
{
    struct HoistNode
    {
        User *LHS_Inst;
        Value *LHS;
        User *RHS_Inst;
        Value *RHS;
        int index;
        HoistNode(User *LHS_Inst_, Value *LHS_, User *RHS_Inst_, Value *RHS_, int index_)
            : LHS_Inst(LHS_Inst_), LHS(LHS_), RHS_Inst(RHS_Inst_), RHS(RHS_), index(index_)
        {
        }
    };

  private:
    Function *func;
    dominance *DomTree;
    _AnalysisManager &AM;
    std::vector<HoistNode *> HoistList;
    std::unordered_map<BasicBlock *, std::unordered_map<User *, int>> InstIndex;

    bool RunOnBlock(BasicBlock *bb);
    bool HoistInstInBlock(BasicBlock *TrueBlock, BasicBlock *FalseBlock);

  public:
    ConstantHoist(Function *func_, _AnalysisManager &AM_) : func(func_), AM(AM_)
    {
    }
    ~ConstantHoist()
    {
        HoistList.clear();
    }
    bool Run();
};