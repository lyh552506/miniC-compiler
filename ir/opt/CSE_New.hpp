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

    struct Same
    {
        bool operator()(User* LHS, User* RHS) const
        {
            if(LHS->GetInstId() != RHS->GetInstId())
                return false;
            if(LHS->GetType() != RHS->GetType())
                return false;
            auto& LHSUseList = LHS->Getuselist();
            auto& RHSUseList = RHS->Getuselist();
            if(LHSUseList.size() != RHSUseList.size())
                return false;
            if((LHS->GetInstId() > 7 && LHS->GetInstId() < 11) ||  (LHS->GetInstId() > 12 && LHS->GetInstId() < 17))
                return std::is_permutation(LHSUseList.begin(), LHSUseList.end(), RHSUseList.begin(), []
                    (std::unique_ptr<Use>& lhs, std::unique_ptr<Use>& rhs){ return lhs->usee == rhs->usee; });
            return std::equal(LHSUseList.begin(), LHSUseList.end(), RHSUseList.begin(), []
            (std::unique_ptr<Use>& lhs, std::unique_ptr<Use>& rhs){ return lhs->usee == rhs->usee; });
        }
    };
}


class CSE
{
    class ProcessNode
    {
    public:
        dominance::Node* node;
        std::forward_list<int>::iterator end;
        std::forward_list<int>::iterator iter;
    public:
        int nextChild()
        {
            int next = *iter;
            iter++;
            return next;
        }
        ProcessNode(dominance::Node* n) : node(n), iter(n->idom_child.begin()), end(n->idom_child.end()) {}
    };
    typedef struct CSE_Info
    {
        std::map<std::tuple<Value*, Value*, User::OpID>, Value*> AEB_Binary;
    
        // std::map<Value*, Value*> Loads;
        std::map<size_t, Value*> Loads;
        // std::map<std::pair<Value*, size_t>, Value*> Geps;
        std::map<size_t, Value*> Geps;
        std::set<Function*> Funcs;
    }info;

    std::set<ProcessNode*> Processed;
    std::set<BasicBlock*> Processed_Blocks;
    std::map<BasicBlock*, info*> BlockOut;
    std::map<BasicBlock*, info*> BlockIn;
    std::vector<User*> wait_del;
    Function* func;
    dominance* DomTree;
private:
    void Process_Multiple_In(info& block_in, std::vector<info*> args);
    bool Is_Gep_Changed(User* inst, BasicBlock* Curr_Block);
    void Init();
    bool RunOnNode(ProcessNode* node_, info& block_in, info& block_out);
    bool RunOnBlock(BasicBlock* block, info& block_in, info&block_out);
    Function* Find_Change(Value* val, info* Info);
public:
    CSE(Function* m_func, dominance* dom) : func(m_func), DomTree(dom) { Init(); }
    bool RunOnFunc();
};

