#include "dominant.hpp"
#include "CFG.hpp"
#include "my_stl.hpp"
#include <unordered_set>

namespace HashTool
{
    struct InstHash
    {
        size_t operator()(User* inst)
        {
            size_t HashValue;
            HashValue += std::hash<User::OpID>{}(inst->GetInstId());
            for(auto& Use_ : inst->Getuselist())
            {
                Value* Val = Use_->usee;
                HashValue = HashValue * 111 + std::hash<Value*>{}(Val);
            }
            return HashValue;
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

static bool CanHandle(User* inst)
{
    if(inst->GetInstId() > 7 && inst->GetInstId() < 22)
        return true;
    if(dynamic_cast<CallInst*>(inst) && !inst->HasSideEffect())
        return true;
}

class CSE
{
private:
    std::map<User*,std::unordered_set<User*,HashTool::InstHash, HashTool::Same>> Gens;
    std::map<User*,std::unordered_set<User*,HashTool::InstHash, HashTool::Same>> Kills;
    // std::unordered_map<User*, std::unordered_set<User*, InstHashTable, Same>> In;
    // std::unordered_map<User*, std::unordered_set<User*, InstHashTable, Same>> Out;
    // std::unordered_map<User*, std::unordered_set<User*, InstHashTable, Same>> Gens;
    // std::unordered_map<User*, std::unordered_set<User*, InstHashTable, Same>> Kills;
    std::set<dominance::Node*> Processed;
    size_t CurrGens;

private:
    Function* func;
    dominance* DomTree;
    // void Init();
    bool RunOnNode(dominance::Node* node);
public:
    CSE(Function* m_func, dominance* dom) : func(m_func), DomTree(dom), CurrGens(0) { }
    void RunOnFunction();
};

