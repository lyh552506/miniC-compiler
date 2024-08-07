#pragma once
#include "../../lib/BaseCFG.hpp"
#include "../../lib/CFG.hpp"
#include "../Analysis/LoopInfo.hpp"
#include "../Analysis/SideEffect.hpp"
#include "../Analysis/dominant.hpp"
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"

class _AnalysisManager;

struct ValueHash
{
    size_t operator()(Value* val, Value* base) const
    {

    }
};

struct GepHash
{
    size_t operator()(GetElementPtrInst* gep) const
    {
        size_t h = 0;
        Value* Base = gep->GetOperand(0);
        if(!Base->isParam())
        {
            if(auto alloca = dynamic_cast<AllocaInst*>(Base))
                h ^= std::hash<AllocaInst *>()(alloca);
            else if(auto gep_base = dynamic_cast<GetElementPtrInst*>(Base))
                h ^= GepHash{}(gep_base);
            for(int i = 1; i < gep->Getuselist().size(); i++)
            {
                auto p = gep->Getuselist()[i]->usee;
                h ^= ValueHash{}(p, Base);
            }
        }
        else
        {
            if(dynamic_cast<HasSubType*>(Base->GetType())->GetSubType()->GetTypeEnum() == InnerDataType::IR_ARRAY)
            {
                auto array = dynamic_cast<ArrayType*>(dynamic_cast<HasSubType*>(Base->GetType())->GetSubType());
                h ^= (std::hash<Value *>()(Base) << array->GetNumEle());
            }
            else
                h ^= std::hash<Variable *>()(dynamic_cast<Variable*>(Base));
            for(int i = 1; i < gep->Getuselist().size(); i++)
            {
                auto p = gep->Getuselist()[i]->usee;
                h ^= ValueHash{}(p, Base);
            }
        }
        return h;
    }
};
class GepEvaluate : public _PassManagerBase<GepEvaluate, Function>
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
        std::unordered_map<Value *, std::unordered_map<size_t, Value *>> ValueAddr;
        std::unordered_map<Value *, std::unordered_map<size_t, Value *>> ChildValueAddr;

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
        void SetChildValueAddr(std::unordered_map<Value *, std::unordered_map<size_t, Value *>> valueaddr)
        {
            ChildValueAddr = valueaddr;
        }
        std::unordered_map<Value *, std::unordered_map<size_t, Value *>> GetChildValueAddr()
        {
            return ChildValueAddr;
        }
        std::unordered_map<Value *, std::unordered_map<size_t, Value *>> GetValueAddr()
        {
            return ValueAddr;
        }
        void SetValueAddr(std::unordered_map<Value *, std::unordered_map<size_t, Value *>> valueaddr)
        {
            ValueAddr = valueaddr;
        }
        HandleNode(dominance *dom, dominance::Node *node, std::forward_list<int>::iterator child,
                   std::forward_list<int>::iterator end,  std::unordered_map<Value *, std::unordered_map<size_t, Value *>> ValueAddr)
            : DomTree(dom), dom_node(node), Curiter(child), Enditer(end), ValueAddr(ValueAddr)
        {
            block = node->thisBlock;
        }
    };

  private:
    Function *func;
    dominance *DomTree;
    _AnalysisManager &AM;
    std::vector<User*> wait_del;
    bool ProcessNode(HandleNode *node);
  public:
    GepEvaluate(Function *_func, _AnalysisManager &_AM) : func(_func), AM(_AM)
    {
    }
    bool Run();
};