#include "dominant.hpp"
#include "CFG.hpp"
#include "my_stl.hpp"
#include <unordered_set>
struct InstHashTable
{
    size_t operator()(User* inst) const
    {
        size_t HashValue;
        HashValue += std::hash<User::OpID>{}(inst->GetInstId());
        for(auto& Use_ : inst->Getuselist())
        {
            Value* val = Use_->usee;
            HashValue = HashValue * 111 + std::hash<Value*>{}(val);
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
        return std::equal(LHSUseList.begin(), LHSUseList.end(), RHSUseList.begin(), []
        (std::unique_ptr<Use>& lhs, std::unique_ptr<Use>& rhs){ return lhs->usee == rhs->usee; });
    }
};

class CSE
{
private:
    std::unordered_map<User*, std::unordered_set<User*, InstHashTable, Same>> In;
    std::unordered_map<User*, std::unordered_set<User*, InstHashTable, Same>> Out;
    std::unordered_map<User*, std::unordered_set<User*, InstHashTable, Same>> Gens;
    std::unordered_map<User*, std::unordered_set<User*, InstHashTable, Same>> Kills;
    std::set<BasicBlock*> Processed;
private:
    Function* func;
    dominance* DomTree;
    void Init();
    bool RunOnBlock(BasicBlock* block);
public:
    CSE(Function* m_func, dominance* dom) : func(m_func), DomTree(dom) { Init(); }
    void RunOnFunction();
};

