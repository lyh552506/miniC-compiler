#include "dominant.hpp"
#include "CFG.hpp"
#include "my_stl.hpp"
#include <unordered_set>

namespace HashTool
{
    struct InstHash
    {
        size_t operator()(Value* val)
        {
            size_t HashValue;
            if(User* inst = dynamic_cast<User*>(val))
            {
                HashValue = std::hash<User::OpID>{}(inst->GetInstId());
                for(auto& Use_ : inst->Getuselist())
                {
                    Value* Val = Use_->usee;
                    HashValue = HashValue * 111 + std::hash<Value*>{}(Val);
                }
                return HashValue;
            }
            return std::hash<Value*>{}(val);
        }
    };
    
    struct BinaryInstHash
    {
        size_t operator()(User* inst)
        {
            size_t HashValue;
            HashValue = std::hash<User::OpID>{}(inst->GetInstId());
            for(auto& Use_ : inst->Getuselist())
            {
                Value* Val = Use_->usee;
                HashValue = HashValue * 111 + std::hash<Value*>{}(Val);
            }
            return HashValue;
        }
    };
    struct CmpSame
    {
        bool operator()(Value* LHS_, User* RHS) const
        {
            if(User* LHS = dynamic_cast<User*>(LHS_))
            {
                if(LHS->GetInstId() == User::OpID::Ge && RHS->GetInstId() == User::OpID::L)
                {
                    Value* LHS_LHS = LHS->GetOperand(0);
                    Value* LHS_RHS = LHS->GetOperand(1);
                    Value* RHS_LHS = RHS->GetOperand(0);
                    Value* RHS_RHS = RHS->GetOperand(1);
                    if((LHS_LHS == RHS_LHS && LHS_RHS == RHS_RHS) || (LHS_LHS == RHS_RHS && LHS_RHS == RHS_LHS))
                        return true;
                }
                else if(LHS->GetInstId() == User::OpID::Le && RHS->GetInstId() == User::OpID::G)
                {
                    Value* LHS_LHS = LHS->GetOperand(0);
                    Value* LHS_RHS = LHS->GetOperand(1);
                    Value* RHS_LHS = RHS->GetOperand(0);
                    Value* RHS_RHS = RHS->GetOperand(1);
                    if((LHS_LHS == RHS_LHS && LHS_RHS == RHS_RHS) || (LHS_LHS == RHS_RHS && LHS_RHS == RHS_LHS))
                        return true;
                }
                else if(LHS->GetInstId() == User::OpID::L && RHS->GetInstId() == User::OpID::Ge)
                {
                    Value* LHS_LHS = LHS->GetOperand(0);
                    Value* LHS_RHS = LHS->GetOperand(1);
                    Value* RHS_LHS = RHS->GetOperand(0);
                    Value* RHS_RHS = RHS->GetOperand(1);
                    if((LHS_LHS == RHS_LHS && LHS_RHS == RHS_RHS) || (LHS_LHS == RHS_RHS && LHS_RHS == RHS_LHS))
                        return true;
                }
                else if(LHS->GetInstId() == User::OpID::G && RHS->GetInstId() == User::OpID::Le)
                {
                    Value* LHS_LHS = LHS->GetOperand(0);
                    Value* LHS_RHS = LHS->GetOperand(1);
                    Value* RHS_LHS = RHS->GetOperand(0);
                    Value* RHS_RHS = RHS->GetOperand(1);
                    if((LHS_LHS == RHS_LHS && LHS_RHS == RHS_RHS) || (LHS_LHS == RHS_RHS && LHS_RHS == RHS_LHS))
                        return true;
                }
                else
                    return false;
            }
        }
    };
}

struct info
{
    std::map<std::pair<size_t, User::OpID>, Value*> AEB_Binary;
    std::map<size_t, Value*> Loads;
    std::map<size_t, Value*> Geps;
    std::set<Function*> Funcs;
    bool operator==(const info& rhs) const
    {
        if(AEB_Binary == rhs.AEB_Binary && Loads == rhs.Loads && Geps == rhs.Geps && Funcs == rhs.Funcs)
            return true;
        return false;
    }
};

class CSE
{
    std::map<BasicBlock*, info> BlockLiveIn;
    std::map<BasicBlock*, info> BlockLiveOut;
private:
    void GetBlockLiveOut(BasicBlock* block);
    void GetBlockLiveIn(BasicBlock* block);
    void iterate(Function* func);
    std::map<BasicBlock*, bool> Unchanged;
    bool IsChanged = false;
    bool Changed = false;
    Function* m_func;
    Function* Find_Change(Value* val, info Info);
    void RunOnFunc(Function* func);
    bool RunPass(BasicBlock* block);
    dominance* DomTree;
public:
    bool RunOnFunction();
    CSE(Function* func, dominance* m_dom) : m_func(func) , DomTree(m_dom) {}
};

// class CSE
// {
//     class ProcessNode
//     {
//     public:
//         dominance::Node* node;
//         std::forward_list<int>::iterator end;
//         std::forward_list<int>::iterator iter;
//     public:
//         int nextChild()
//         {
//             int next = *iter;
//             iter++;
//             return next;
//         }
//         ProcessNode(dominance::Node* n) : node(n), iter(n->idom_child.begin()), end(n->idom_child.end()) {}
//     };
//     typedef struct CSE_Info
//     {
//         std::map<std::pair<size_t, User::OpID>, Value*> AEB_Binary;
//         std::map<size_t, Value*> Loads;
//         std::map<size_t, Value*> Geps;
//         std::set<Function*> Funcs;
//     }info;
//     std::set<ProcessNode*> Processed;
//     std::map<BasicBlock*, info*> BlockOut;
//     std::map<BasicBlock*, info*> BlockIn;
//     std::vector<User*> wait_del;
//     Function* func;
//     dominance* DomTree;
//     size_t num;
// private:
//     void Process_Multiple_In(info& block_in, std::vector<info*> args);
//     bool Is_Gep_Changed(User* inst, BasicBlock* Curr_Block);
//     void Init();
//     bool RunOnNode(ProcessNode* node_, info& block_in, info& block_out);
//     Function* Find_Change(Value* val, info* Info);
// public:
//     CSE(Function* m_func, dominance* dom) : func(m_func), DomTree(dom) { Init(); }
//     bool RunOnFunc();
// };

