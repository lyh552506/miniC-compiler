#pragma once
#include <cassert>
#include <vector>
#include "CFG.hpp"
namespace InstHashTool{
    struct InstHash
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

    struct InstSame
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
template <typename Key, typename Val, typename AllocatorTy>
class HashScope;
template <typename Key, typename Val>
class HashScopeIterator;
template <typename Key, typename Val>
class HashScopeVal
{
    HashScopeVal* next_for_scope;
    HashScopeVal* next_for_key;
    
    Key key;
    Val val;
public:
    HashScopeVal(const Key &key, const Val &val) : key(key), val(val) {}
    HashScopeVal() { next_for_key = nullptr; next_for_scope = nullptr; key = Key(); val = Val(); }
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
    HashScope_Scope(HashScope<Key, Val, AllocatorTy>& HashTable) : HashTable(HashTable)
    {
        PrevScope = HashTable.CurScope;
        HashTable.CurScope = this;
        LastVal = nullptr;
    }
    ~HashScope_Scope()
    {
        assert(HashTable.CurScope == this && "Scope is not the current scope!");
        HashTable.CurScope = PrevScope;
        while(HashScopeVal<Key, Val>* thisval = LastVal)
        {
            if(!thisval->GetNextForScope())
            {
                assert(HashTable.Mapping[thisval->GetKey()] == thisval && "imbalance!");
                HashTable.Mapping.erase(thisval->GetKey());
            }
            else
            {
                HashScopeVal<Key, Val>*& thiskey = HashTable.Mapping[thisval->GetKey()];
                assert(thiskey == thisval && "imbalance!");
                thiskey = thisval->GetNextForKey();
            }

            LastVal = thisval->GetNextForScope();
            thisval->Delete(HashTable.Allocator);
        }
    }
    void SetLastVal(HashScopeVal<Key, Val>* newVal) { LastVal = newVal; }
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

    HashScope(const HashScope& );
    void operator=(const HashScope& );
    friend class HashScope_Scope<Key, Val, AllocatorTy>;
public:
    HashScope() { CurScope = nullptr; }
    HashScope(AllocatorTy Allocator_) : CurScope(0), Allocator(Allocator_) {}
    ~HashScope() { assert(!CurScope && Mapping.empty() && "Scope is not empty!"); } 

    size_t count(const Key& key) const { return Mapping.count(key); }
    Val lookup(const Key& key) { if(Mapping.find(key) != Mapping.end()) return Mapping[key]->GetVal(); return Val(); }

    void Insert(const Key& key, const Val& val) { InsertIntoScope(CurScope, key, val); }
    void InsertIntoScope(Scope* scope, const Key& key, const Val& val)
    {
        assert(scope && "No scope!");
        HashScopeVal<Key, Val>*& entry = Mapping[key];
        entry = Val_Ptr::Create(entry, scope->LastVal, key, val, Allocator);
        scope->SetLastVal(entry);
    }

    HashScopeIterator<Key, Val> end() { return HashScopeIterator<Key, Val>(nullptr); }
    HashScopeIterator<Key, Val> begin(const Key& key)
    {
        if(Mapping.find(key) != Mapping.end())
            return HashScopeIterator<Key, Val>(Mapping[key]);
        return end();
    }

    Scope* GetCurScope() { return CurScope; }
    const Scope* GetCurScope() const { return CurScope; }
};