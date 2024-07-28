#pragma once
#include "CFG.hpp"
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"
#include "dominant.hpp"
#include "my_stl.hpp"
#include <unordered_set>
class _AnalysisManager;
namespace HashTool
{
struct InstHash
{
    size_t operator()(Value *val)
    {
        size_t HashValue;
        if (val->isGlobal())
        {
            return std::hash<std::string>{}(val->GetName());
        }
        if (auto inst = dynamic_cast<User *>(val))
        {
            if (inst->GetInstId() == User::OpID::G)
            {
                HashValue += std::hash<User::OpID>{}(User::OpID::G);
                HashValue += std::hash<Value *>{}(inst->GetOperand(0)) * 3;
                HashValue += std::hash<Value *>{}(inst->GetOperand(1)) * 5;
            }
            else if (inst->GetInstId() == User::OpID::Le)
            {
                HashValue += std::hash<User::OpID>{}(User::OpID::G);
                HashValue += std::hash<Value *>{}(inst->GetOperand(0)) * 5;
                HashValue += std::hash<Value *>{}(inst->GetOperand(1)) * 3;
            }
            else if (inst->GetInstId() == User::OpID::L)
            {
                HashValue += std::hash<User::OpID>{}(User::OpID::L);
                HashValue += std::hash<Value *>{}(inst->GetOperand(0)) * 3;
                HashValue += std::hash<Value *>{}(inst->GetOperand(1)) * 5;
            }
            else if (inst->GetInstId() == User::OpID::Ge)
            {
                HashValue += std::hash<User::OpID>{}(User::OpID::L);
                HashValue += std::hash<Value *>{}(inst->GetOperand(0)) * 5;
                HashValue += std::hash<Value *>{}(inst->GetOperand(1)) * 3;
            }
            else
            {
                HashValue = std::hash<User::OpID>{}(inst->GetInstId());
                for (auto &Use_ : inst->Getuselist())
                {
                    Value *Val = Use_->usee;
                    HashValue = HashValue * 111 + std::hash<Value *>{}(Val);
                }
            }
            return HashValue;
        }
        if (auto c = dynamic_cast<ConstantData *>(val))
            return std::hash<ConstantData *>{}(c);
        return std::hash<Value *>{}(val);
    }
};
} // namespace HashTool
class CSE : public _PassManagerBase<CSE, Function>
{
    typedef struct LoadValue
    {
        Value *before;
        unsigned int LoadGeneration;
        LoadValue() : before(nullptr), LoadGeneration(0)
        {
        }
        LoadValue(Value *val, unsigned int gen) : before(val), LoadGeneration(gen)
        {
        }
    } loadinfo;
    typedef struct CallValue
    {
        Value *before;
        unsigned int CallGeneration;
        CallValue() : before(nullptr), CallGeneration(0)
        {
        }
        CallValue(Value *val, unsigned int gen) : before(val), CallGeneration(gen)
        {
        }
    } callinfo;

    typedef struct StoreValue
    {
        StoreInst *store;
        unsigned int StoreGeneration;
        StoreValue() : store(nullptr), StoreGeneration(0)
        {
        }
        StoreValue(StoreInst *inst, unsigned int gen) : store(inst), StoreGeneration(gen)
        {
        }
    } storeinfo;
    class CSENode
    {
      private:
        BasicBlock *block;
        dominance::Node *dom_node;
        unsigned int ChildGens;
        unsigned int CurGens;
        std::forward_list<int>::iterator Curiter;
        std::forward_list<int>::iterator Enditer;
        bool Processed = false;
        dominance *DomTree;
        std::map<size_t, Value *> Values;
        std::map<Value *, std::set<loadinfo *>> Loads;
        std::map<size_t, std::set<callinfo *>> Calls;
        std::map<Value *, std::set<storeinfo *>> Stores;

      public:
        unsigned int GetCurGeneration()
        {
            return CurGens;
        }
        unsigned int GetChildGeneration()
        {
            return ChildGens;
        }
        void SetChildGeneration(unsigned int gen)
        {
            ChildGens = gen;
        }
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
        void SetValue(Value *val, User *inst)
        {
            size_t hash = HashTool::InstHash{}(inst);
            Values[hash] = val;
        }
        Value *LookUp(User *inst)
        {
            size_t hash = HashTool::InstHash{}(inst);
            if (Values.find(hash) != Values.end())
                return Values[hash];
            return nullptr;
        }
        Value *LookUpLoad(Value *val, unsigned int gen)
        {
            if (Loads.find(val) != Loads.end())
            {
                for (auto load : Loads[val])
                {
                    if (load->LoadGeneration == gen)
                        return load->before;
                }
            }
            return nullptr;
        }
        void SetLoadValue(Value *val, Value *before, unsigned int gen)
        {
            if (Loads.find(val) == Loads.end())
            {
                Loads[val] = std::set<loadinfo *>();
                Loads[val].insert(new loadinfo(before, gen));
            }
            else
            {
                Loads[val].insert(new loadinfo(before, gen));
            }
        }
        void DelLoadValue(Value *val, Value *before, unsigned int gen)
        {
            if (Loads.find(val) != Loads.end())
            {
                for (auto load : Loads[val])
                {
                    if (load->before == before && load->LoadGeneration == gen)
                    {
                        Loads[val].erase(load);
                        break;
                    }
                }
            }
        }
        Value *LookUpCall(User *inst, unsigned int gen)
        {
            size_t hash = HashTool::InstHash{}(inst);
            if (Calls.find(hash) != Calls.end())
            {
                for (auto call : Calls[hash])
                {
                    if (call->CallGeneration == gen)
                        return call->before;
                }
            }
            return nullptr;
        }
        void SetCallValue(User *inst, Value *before, unsigned int gen)
        {
            size_t hash = HashTool::InstHash{}(inst);
            if (Calls.find(hash) == Calls.end())
            {
                Calls[hash] = std::set<callinfo *>();
                Calls[hash].insert(new callinfo(before, gen));
            }
            else
            {
                Calls[hash].insert(new callinfo(before, gen));
            }
        }

        void SetStoreValue(StoreInst *inst, unsigned int gen)
        {
            if (Stores.find(inst->GetOperand(1)) == Stores.end())
            {
                Stores[inst->GetOperand(1)] = std::set<storeinfo *>();
                Stores[inst->GetOperand(1)].insert(new storeinfo(inst, gen));
            }
            else
            {
                Stores[inst->GetOperand(1)].insert(new storeinfo(inst, gen));
            }
        }

        void DelStoreValue(User *inst, unsigned int gen)
        {
            for (auto &use : inst->Getuselist())
            {
                Value *val = use->usee;
                if (Stores.find(val) != Stores.end())
                {
                    for (auto storeinfo : Stores[val])
                    {
                        if (storeinfo->StoreGeneration == gen)
                        {
                            Stores[val].erase(storeinfo);
                            break;
                        }
                    }
                }
            }
        }

        User *LookUpStore(StoreInst *inst, unsigned int gen)
        {
            if (Stores.find(inst->GetOperand(1)) != Stores.end())
            {
                for (auto storeinfo : Stores[inst->GetOperand(1)])
                {
                    if (storeinfo->StoreGeneration == gen)
                        return storeinfo->store;
                }
            }
            return nullptr;
        }
        User *StoreSame(StoreInst *inst)
        {
            if (auto load = dynamic_cast<LoadInst *>(inst->Getuselist()[0]->usee))
            {
                if (load->Getuselist()[0]->usee == inst->Getuselist()[1]->usee)
                    return load;
            }
            return nullptr;
        };
        CSENode(dominance *dom, dominance::Node *node, std::forward_list<int>::iterator child,
                std::forward_list<int>::iterator end, unsigned int gens)
            : DomTree(dom), dom_node(node), Curiter(child), Enditer(end), CurGens(gens), ChildGens(gens)
        {
            block = node->thisBlock;
        }
    };

  private:
    dominance *DomTree;
    Function *func;
    unsigned int CurGeneration;
    _AnalysisManager &AM;
    std::vector<User *> wait_del;
    bool ProcessNode(CSENode *node);
    void init();
    bool CanHandle(User *inst);

  public:
    CSE(Function *func, _AnalysisManager &AM) : func(func), AM(AM)
    {
        init();
    }
    bool Run();
};