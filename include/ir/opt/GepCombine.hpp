#pragma once
#include "../../lib/CFG.hpp"
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"
#include "../Analysis/dominant.hpp"
#include "../../../util/my_stl.hpp"
class _AnalysisManager;

class GepCombine : public _PassManagerBase<GepCombine, Function>
{
    class HandleNode
    {
      private:
        BasicBlock *block;
        dominance *DomTree;
        dominance::Node *dom_node;
        bool Processed = false;
        std::forward_list<int>::iterator Curiter;
        std::forward_list<int>::iterator Enditer;
        std::unordered_set<GetElementPtrInst*> Geps;
        std::unordered_set<GetElementPtrInst*> ChildGeps;
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
        void SetChildGeps(std::unordered_set<GetElementPtrInst*> geps)
        {
            ChildGeps = geps;
        }
        std::unordered_set<GetElementPtrInst*> GetChildGeps()
        {
            return ChildGeps;
        }
        std::unordered_set<GetElementPtrInst*> GetGeps()
        {
            return Geps;
        }
        void SetGeps(std::unordered_set<GetElementPtrInst*> geps)
        {
            Geps = geps;
        }
        HandleNode(dominance *dom, dominance::Node *node, std::forward_list<int>::iterator child,
                   std::forward_list<int>::iterator end, std::unordered_set<GetElementPtrInst*> geps)
            : DomTree(dom), dom_node(node), Curiter(child), Enditer(end), Geps(geps)
        {
            block = node->thisBlock;
        }
    };

  private:
    dominance *DomTree;
    Function *func;
    _AnalysisManager &AM;
    std::vector<User*> wait_del;
    bool ProcessNode(HandleNode *node);
    bool CanHandle(GetElementPtrInst* src, GetElementPtrInst* base);
    Value* SimplifyGepInst(GetElementPtrInst* inst, std::unordered_set<GetElementPtrInst*>& geps);
    GetElementPtrInst* HandleGepPhi(GetElementPtrInst* inst, std::unordered_set<GetElementPtrInst*>& geps);
    GetElementPtrInst* Normal_Handle_With_GepBase(GetElementPtrInst* inst, std::unordered_set<GetElementPtrInst*>& geps);
  public:
    GepCombine(Function *func, _AnalysisManager &AM_) : func(func), AM(AM_)
    {
    }
    bool Run();
};