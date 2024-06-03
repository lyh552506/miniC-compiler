#include "dominant.hpp"
#include "CFG.hpp"
#include "my_stl.hpp"
#include <unordered_set>

static bool CanHandle(User* inst)
{
    if(inst->GetInstId() > 7 && inst->GetInstId() < 22)
        return true;
    if(dynamic_cast<CallInst*>(inst) && !inst->HasSideEffect())
        return true;
}

class CSE
{
    typedef HashScopeVal<User*, Value*> AllocatorTy;
    typedef HashScope<User*, Value*, AllocatorTy> HashScopeTy;
    HashScopeTy AvailableValues;
    struct LoadValue
    {
        User* DefInst;
        size_t Version;
        int Id;
        bool IsAtomic;
        bool Variant;
        LoadValue() : DefInst(nullptr), Version(0), Id(-1), IsAtomic(false), Variant(true) {}
        LoadValue(User* inst, size_t Version, int ID, bool isAtomic, bool Variant) :
            DefInst(inst), Version(Version), Id(ID), IsAtomic(isAtomic), Variant(Variant) {}  
    };
    typedef HashScopeVal<Value*, LoadValue> LoadAllocatorTy;
    typedef HashScope<Value*, LoadValue, LoadAllocatorTy> LoadHashScopeTy;
    LoadHashScopeTy AvailableLoads;
    typedef HashScope<Value*, std::pair<User*, size_t>, HashScopeVal<Value*, std::pair<User*, size_t>>> CallHashScopeTy;
    CallHashScopeTy AvailableCalls;
private:
    // std::unordered_map<User*, std::unordered_set<User*, InstHashTable, Same>> In;
    // std::unordered_map<User*, std::unordered_set<User*, InstHashTable, Same>> Out;
    // std::unordered_map<User*, std::unordered_set<User*, InstHashTable, Same>> Gens;
    // std::unordered_map<User*, std::unordered_set<User*, InstHashTable, Same>> Kills;
    std::set<dominance::Node*> Processed;
    size_t CurrGens;

private:
    Function* func;
    dominance* DomTree;
    void Init();
    bool RunOnNode(dominance::Node* node);
public:
    CSE(Function* m_func, dominance* dom) : func(m_func), DomTree(dom), CurrGens(0) { Init(); }
    void RunOnFunction();
};

