#include "ConstantFold.hpp"

class ConstantProp
{  
    void CalDomBlocks(BasicBlock* block);
    void RunOnFunc(Function* func);
    void RunOnBlock(BasicBlock* block);
    ConstantData* SetDefVal(ConstantData* v1, Value* v2);
    ConstantData* GetDefVal(Value* val);

private:
    struct BlockInfo
    {
        std::map<User*, int> IndexInfo;
        int GetinstIndex(User* inst);
        void DelIndex(User* inst);
        std::string CalGepKey(GetElementPtrInst* inst);
        BlockInfo() = default;
    };
    // std::map<std::pair<int, std::string>, std::pair<StoreInst*, Value*>> valMap;
    std::map<int, std::pair<std::string, Value*>> ValMap;
    ConstantData* GetConstVal(Value* val);
    std::map<Value*, ConstantData*> Global_Def;
    std::map<Value*, std::map<std::string, ConstantData*>> ArrayDefVal;
    std::vector<BasicBlock*> bfsOrder;
    ConstantFolding* ConstFold;
    bool changed = false;
    Function* _func;
    std::vector<BasicBlock*> DomBlocks;
    std::unordered_set<BasicBlock *> visited;
    dominance* _dom;

public:
    void HandleMemInst(BlockInfo& BlockInfo, AllocaInst* AI);
    void Pass();
    void Test(BasicBlock* block);

    ConstantProp(dominance *dom, Function* func) : _dom(dom), _func(func) {}
};
