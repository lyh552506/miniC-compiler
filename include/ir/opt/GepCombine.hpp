#pragma once
#include "../../lib/CFG.hpp"
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"
#include "../Analysis/dominant.hpp"
#include "../../../util/my_stl.hpp"
class _AnalysisManager;

class GepCombine : public _PassManagerBase<GepCombine, Function>
{
    typedef struct GepInfo
    {
        Value *base;
        Value *offset;
        std::vector<Value *> index;
        std::vector<ConstantData *> const_index;
        bool ConstIndex = false;
        GepInfo()
            : base(nullptr), offset(nullptr), index(std::vector<Value *>()), const_index(std::vector<ConstantData *>()),
              ConstIndex(false)
        {
        }
        GepInfo(Value *base_, Value *offset_, std::vector<Value *> index_, std::vector<ConstantData *> const_index_,
                bool flag)
            : base(base_), offset(offset_), index(index_), const_index(const_index_), ConstIndex(flag)
        {
        }
    } gepinfo;

    typedef struct BinaryInfo
    {
        User* inst;
        Value* op1;
        Value* op2;
        User::OpID op;
        bool LHS_Const = false;
        bool RHS_Const = false;
        ConstantData* LHS_ConstVal;
        ConstantData* RHS_ConstVal;
        BinaryInfo(User* inst) : inst(inst), op1(inst->GetOperand(0)), op2(inst->GetOperand(1)), op(inst->GetInstId())
        {
            assert(dynamic_cast<BinaryInst*>(inst) && "Not a binary operator");
            if (dynamic_cast<ConstantData*>(op1))
            {
                LHS_Const = true;
                LHS_ConstVal = dynamic_cast<ConstantData*>(op1);
            }
            if (dynamic_cast<ConstantData*>(op2))
            {
                RHS_Const = true;
                RHS_ConstVal = dynamic_cast<ConstantData*>(op2);
            }
        }
    } binaryinfo;
    class HandleNode
    {
      private:
        BasicBlock *block;
        dominance *DomTree;
        dominance::Node *dom_node;
        bool Processed = false;
        std::forward_list<int>::iterator Curiter;
        std::forward_list<int>::iterator Enditer;
        std::unordered_map<Value*, std::unordered_set<gepinfo*>> Geps;
        std::unordered_set<binaryinfo*> Binarys;
      public:
        std::forward_list<int>::iterator Child()
        {
            return Curiter;
        }
        std::forward_list<int>::iterator NextChild()
        {
            std::forward_list<int>::iterator iter = Curiter;
            Curiter++;
            return iter;
        }
        std::forward_list<int>::iterator EndIter()
        {
            return Enditer;
        }
        bool isProcessed()
        {
            return Processed;
        }
        void Process()
        {
            Processed = true;
        }
        BasicBlock *GetBlock()
        {
            return block;
        }
        std::unordered_map<Value*, std::unordered_set<gepinfo*>> GetGeps()
        {
            return Geps;
        }
        std::unordered_set<binaryinfo*> GetBinarys()
        {
            return Binarys;
        }
        HandleNode(dominance *dom, dominance::Node *node, std::forward_list<int>::iterator child,
                   std::forward_list<int>::iterator end, std::unordered_map<Value*, std::unordered_set<gepinfo*>> geps, std::unordered_set<binaryinfo*> binarys)
            : DomTree(dom), dom_node(node), Curiter(child), Enditer(end), Geps(geps), Binarys(binarys)
        {
            block = node->thisBlock;
        }
    };

  private:
    dominance *DomTree;
    Function *func;
    _AnalysisManager &AM;
    bool ProcessNode(HandleNode *node);
    void init();
    bool CanHandle(GetElementPtrInst* src, GetElementPtrInst* base);
    Value* SimplifyGepInst(GetElementPtrInst* inst);
    GetElementPtrInst* HandleGepPhi(GetElementPtrInst* inst);
    GetElementPtrInst* Normal_Handle_With_GepBase(GetElementPtrInst* inst);
  public:
    GepCombine(Function *func, _AnalysisManager &AM_) : func(func), AM(AM_)
    {
    }
    bool Run();
};