#include "CFG.hpp"
#include <unordered_set>

struct InstHashTable
{
    size_t HashValue;
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
    
    bool operator()(User* LHS, User* RHS) const
    {
        if(LHS->GetInstId() != RHS->GetInstId())
            return false;
        if(LHS->GetType() != RHS->GetType())
            return false;
        auto LHSUseList = LHS->Getuselist();
        auto RHSUseList = RHS->Getuselist();
        if(LHSUseList.size() != RHSUseList.size())
            return false;
        return std::equal(LHSUseList.begin(), LHSUseList.end(), RHSUseList.begin(), []
        (Use* lhs, Use* rhs){ return lhs->usee = rhs->usee; });
    }
};

class CSE
{
    std::unordered_set<User*, InstHashTable> InstSet;
    std::queue<PhiInst*> PhiList;
    
};





