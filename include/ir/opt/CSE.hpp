#include "dominant.hpp"
#include "CFG.hpp"
#include "my_stl.hpp"
#include <unordered_set>

struct ValueTable
{
    User* inst;
    ValueTable(User* inst) : inst(inst) 
    {
        assert(CanHandle(inst) && "Inst can't be handled!");
    }

    static bool CanHandle(User* inst)
    {
        if(inst->GetInstId() > 7 && inst->GetInstId() < 22)
            return true;
        if(dynamic_cast<CallInst*>(inst) && !inst->HasSideEffect())
            return true;
    }
};

struct LoadValue
{
    User* DefInst;
    size_t Version;
    int Id;
    bool IsAtomic;
    bool Variant;
};

class CSE
{
private:
    std::unordered_map<User*, std::unordered_set<User*, InstHashTable, Same>> In;
    std::unordered_map<User*, std::unordered_set<User*, InstHashTable, Same>> Out;
    std::unordered_map<User*, std::unordered_set<User*, InstHashTable, Same>> Gens;
    std::unordered_map<User*, std::unordered_set<User*, InstHashTable, Same>> Kills;
    std::set<dominance::Node> Processed;
private:
    Function* func;
    dominance* DomTree;
    void Init();
    bool RunOnNode(dominance::Node node);
public:
    CSE(Function* m_func, dominance* dom) : func(m_func), DomTree(dom) { Init(); }
    void RunOnFunction();
};

