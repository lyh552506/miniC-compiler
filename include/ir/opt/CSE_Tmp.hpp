#include "CFG.hpp"
#include <unordered_set>
#include <queue>
#include <algorithm>
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

struct SameInst
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
public:
    CSE(Function* Func) : func(Func) {}
private:
    Function* func;
    std::unordered_set<User*, InstHashTable, SameInst> InstSet;
    std::vector<PhiInst*> PhiList;
    std::vector<User*> ToBeDeleted;
    void RunOnBlock(BasicBlock* block);
    bool CanBeOptimized(User* inst);
    void init();
public:
    void RunOnFunction();
};





