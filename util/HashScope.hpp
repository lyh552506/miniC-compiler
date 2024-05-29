#pragma once
#include <cassert>
#include <vector>
#include "CFG.hpp"

struct HashValue
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
template <typename Key, typename Val, typename AllocatorTy>
class HashScope;
template <typename Key, typename Val>
class HashScopeVal
{
    HashScopeVal* next_for_scope;
    HashScopeVal* next_for_key;
    
    Key key;
    Val val;

    HashScopeVal(const Key &key, const Val &val) : key(key), val(val) {}

public:
    const Key& GetKey() const { return key; }
    const Val& GetVal() const { return val; }
    Val& GetVal() { return val; }
    HashScopeVal* GetNextForScope() { return next_for_scope; }
    const HashScopeVal* GetNextForKey() const { return next_for_key; }
    HashScopeVal* GetNextForKey() { return next_for_key; }
template <typename AllocatorTy>
    static HashScopeVal* Create(HashScopeVal* nextforscope, HashScopeVal* nextforkey,
    const Key& key, const Val& val, AllocatorTy &Allocator)
    {
        HashScopeVal* New = Allocator.template Allocate<HashScopeVal>();
        new (New) HashScopeVal(key, val);
        New->next_for_scope = nextforscope;
        New->next_for_key = nextforkey;
        return New;
    }
template <typename AllocatorTy>
    void Delete(AllocatorTy &Allocator)
    {
        this->~ScopedHashTableVal();
        Allocator.Deallocate(this);
    }

};

template <typename Key, typename Val, typename AllocatorTy>
class HashScope_Scope
{
friend class HashScope<Key, Val, AllocatorTy>;
    HashScope<Key, Val, AllocatorTy>& HashTable;

    HashScope_Scope* PrevScope;
    // 作用域最后插入的值，如果尚未插入，则为空。
    HashScopeVal<Key, Val>* LastVal;

    void operator=(HashScope_Scope&) = delete;
    HashScope_Scope(HashScope_Scope&) = delete;

public:
    HashScope_Scope(HashScope<Key, Val, AllocatorTy>& HashTable)
        : HashTable(HashTable), PrevScope(HashTable.CurScope), LastVal(nullptr)
    {
        HashTable.CurScope = this;
    }
    
    HashScope_Scope *GetPrevScope() { return PrevScope; }
    const HashScope_Scope *GetPrevScope() const { return PrevScope; }

    HashScopeVal<Key, Val>* GetLastVal() { return LastVal; }
    
    void SetLastVal(HashScopeVal(Key, Val)* Val) { LastVal = Val; }
};

template <typename Key, typename Val>
class HashScopeIterator
{
    HashScopeVal<Key, Val>* Ptr;
public:
    HashScopeIterator(HashScopeVal<Key, Val>* ptr) : Ptr(ptr) {}

    Val& operator->() const { return &Ptr->GetVal(); }
    Val& operator*() const { return Ptr->GetVal(); }
    HashScopeIterator operator++() { Ptr = Ptr->GetNextForKey(); return *this; }
    bool operator==(const HashScopeIterator& RHS) const { return Ptr == RHS.Ptr; }
    bool operator!=(const HashScopeIterator& RHS) const { return Ptr != RHS.Ptr; }
};

template <typename Key, typename Val, typename AllocatorTy>
class HashScope
{
    typedef HashScope_Scope<Key, Val, AllocatorTy> Scope;
    typedef unsigned size_t;
    typedef HashScopeVal<Key, Val> Val_Ptr;
    // TODO: Restruct a unordered_map
    std::unordered_map<Key, Val_Ptr*> Mapping;
    Scope* CurScope;

    AllocatorTy Allocator;

    
};