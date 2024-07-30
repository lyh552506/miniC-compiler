#pragma once
#include "CFG.hpp"
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"
#include "dominant.hpp"
#include "my_stl.hpp"
class _AnalysisManager;

class GepCombine : public _PassManagerBase<GepCombine, Function>
{
    class HandleNode
    {
      private:
        BasicBlock *block;
        dominance::Node *dom_node;
        std::forward_list<int>::iterator Curiter;
        std::forward_list<int>::iterator Enditer;
        bool Processed = false;
        dominance *DomTree;

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
        HandleNode(dominance *dom, dominance::Node *node, std::forward_list<int>::iterator child,
                   std::forward_list<int>::iterator end)
            : DomTree(dom), dom_node(node), Curiter(child), Enditer(end)
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
    bool CanHandle(User *inst);

  public:
    GepCombine(Function *func, _AnalysisManager &AM_) : func(func), AM(AM_)
    {
    }
    bool Run();
};