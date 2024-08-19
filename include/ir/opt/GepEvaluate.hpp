#pragma once
#include "../../lib/BaseCFG.hpp"
#include "../../lib/CFG.hpp"
#include "../Analysis/LoopInfo.hpp"
#include "../Analysis/SideEffect.hpp"
#include "../Analysis/dominant.hpp"
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"

class _AnalysisManager;
typedef std::unordered_map<Value *, std::unordered_map<size_t, Value *>> ValueAddr_Struct;

struct InitHash
{
    size_t operator()(AllocaInst *alloca, std::vector<int> index)
    {
        std::reverse(index.begin(), index.end());
        size_t hash = 0;
        hash ^= std::hash<AllocaInst *>()(alloca);
        int j = 0;
        for (auto i : index)
        {
            hash += (((std::hash<int>()(i + 3) * 10107 ^ std::hash<int>()(i + 5) * 137) * 157) * ((j + 4) * 107));
            j++;
        }
        return hash;
    }
};

struct ValueHash
{
    size_t operator()(Value *val) const
    {
        if (auto val_int = dynamic_cast<ConstIRInt *>(val))
            return ((std::hash<int>()(val_int->GetVal() + 3) * 10107 ^ std::hash<int>()(val_int->GetVal() + 5) * 137) *
                    157);
        else
            return std::hash<Value *>{}(val) ^ (std::hash<Value *>{}(val) << 3);
    }
};

struct GepHash
{
    size_t operator()(GetElementPtrInst *gep, ValueAddr_Struct *addr) const
    {
        size_t h = 0;
        Value *Base = gep->GetOperand(0);
        if (!Base->isParam())
        {
            if (auto alloca = dynamic_cast<AllocaInst *>(Base))
            {
                h ^= std::hash<AllocaInst *>()(alloca);
                int j = 0;
                for (int i = 2; i < gep->Getuselist().size(); i++)
                {
                    auto p = gep->Getuselist()[i]->usee;
                    if (auto load = dynamic_cast<LoadInst *>(p))
                    {
                        if (auto load_gep = dynamic_cast<GetElementPtrInst *>(load->Getuselist()[0]->usee))
                        {
                            size_t load_gep_hash = GepHash{}(load_gep, addr);
                            if (addr->find(load_gep->Getuselist()[0]->usee) != addr->end())
                            {
                                if (addr->find(load_gep->Getuselist()[0]->usee)->second.find(load_gep_hash) !=
                                    addr->find(load_gep->Getuselist()[0]->usee)->second.end())
                                {
                                    h += ValueHash{}(
                                             addr->find(load_gep->Getuselist()[0]->usee)->second[load_gep_hash]) *
                                         ((j + 4) * 107);
                                }
                                else
                                {
                                    h += (std::hash<int>{}(load_gep_hash) << (j + 3) * 101);
                                }
                            }
                            else
                            {
                                h += (std::hash<int>{}(load_gep_hash) << (j + 3) * 333);
                            }
                        }
                        else
                        {
                            h += ValueHash{}(p) * ((j + 111) * 123) * (j + 1);
                        }
                    }
                    else
                        h += ValueHash{}(p) * ((j + 4) * 107);
                    j++;
                }
            }
            else if (auto gep_base = dynamic_cast<GetElementPtrInst *>(Base))
            {
                auto alloca = dynamic_cast<AllocaInst *>(gep_base->GetOperand(0));
                int j = 0;
                for (int i = 1; i < gep->Getuselist().size(); i++)
                {
                    auto p = gep->Getuselist()[i]->usee;
                    if (auto load = dynamic_cast<LoadInst *>(p))
                    {
                        if (auto load_gep = dynamic_cast<GetElementPtrInst *>(load->Getuselist()[0]->usee))
                        {
                            size_t load_gep_hash = GepHash{}(load_gep, addr);
                            if (addr->find(load_gep->Getuselist()[0]->usee) != addr->end())
                            {
                                if (addr->find(load_gep->Getuselist()[0]->usee)->second.find(load_gep_hash) !=
                                    addr->find(load_gep->Getuselist()[0]->usee)->second.end())
                                {
                                    h += ValueHash{}(
                                             addr->find(load_gep->Getuselist()[0]->usee)->second[load_gep_hash]) *
                                         ((j + 4) * 107);
                                }
                                else
                                {
                                    h += (std::hash<int>{}(load_gep_hash) << (j + 3) * 101);
                                }
                            }
                            else
                            {
                                h += (std::hash<int>{}(load_gep_hash) << (j + 3) * 333);
                            }
                        }
                    }
                    else
                        h += ValueHash{}(p) * ((j + 4) * 107);
                    j++;
                }
            }
        }
        else
        {
            if (dynamic_cast<HasSubType *>(Base->GetType())->GetSubType()->GetTypeEnum() == InnerDataType::IR_ARRAY)
            {
                auto array = dynamic_cast<ArrayType *>(dynamic_cast<HasSubType *>(Base->GetType())->GetSubType());
                h ^= (std::hash<Value *>()(Base) << array->GetNumEle());
            }
            else
                h ^= std::hash<Variable *>()(dynamic_cast<Variable *>(Base));
            int j = 0;
            for (int i = 1; i < gep->Getuselist().size(); i++)
            {
                auto p = gep->Getuselist()[i]->usee;
                h ^= ValueHash{}(p) * ((j + 4) * 107);
                j++;
            }
        }
        return h;
    }
};

// struct ValueHash
// {
//     size_t operator()(Value *val, ValueAddr_Struct *addr) const
//     {
//         if (auto val_int = dynamic_cast<ConstIRInt *>(val))
//             return ((std::hash<int>()(val_int->GetVal() + 3) * 10107 ^ std::hash<int>()(val_int->GetVal() + 5) * 137)
//             *
//                     157);
//         else if (auto load = dynamic_cast<LoadInst *>(val))
//         {
//             if (auto gep = dynamic_cast<GetElementPtrInst *>(load->Getuselist()[0]->usee))
//             {
//                 if (addr->find(gep->Getuselist()[0]->usee) != addr->end())
//                 {
//                     size_t hash = GepHash{}(gep, addr);
//                     if (addr->find(gep) != addr->end())
//                     {
//                         if (addr->find(gep)->second.find(hash) != addr->find(gep)->second.end())
//                         {
//                             return ValueHash{}(addr->find(gep)->second[hash], addr);
//                         }
//                     }
//                 }
//             }
//         }
//         else
//             return std::hash<Value *>()(val);
//     }
// };

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

      public:
        ValueAddr_Struct ValueAddr;

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
                   std::forward_list<int>::iterator end,
                   std::unordered_map<Value *, std::unordered_map<size_t, Value *>> ValueAddr)
            : DomTree(dom), dom_node(node), Curiter(child), Enditer(end), ValueAddr(ValueAddr)
        {
            block = node->thisBlock;
        }
    };

  private:
    Function *func;
    dominance *DomTree;
    _AnalysisManager &AM;
    std::vector<User *> wait_del;
    std::unordered_map<BasicBlock *, HandleNode *> Mapping;
    std::unordered_map<AllocaInst *, Initializer *> AllocaInitMap;
    std::unordered_set<AllocaInst *> allocas;
    bool ProcessNode(HandleNode *node);
    void HandleMemcpy(AllocaInst *inst, Initializer *init, HandleNode *node, std::vector<int> index);
    void HandleZeroInitializer(AllocaInst *inst, HandleNode *node, std::vector<int> index);
    void HandleBlockIn(ValueAddr_Struct &addr, HandleNode *node);

  public:
    GepEvaluate(Function *_func, _AnalysisManager &_AM) : func(_func), AM(_AM)
    {
    }
    bool Run();
};