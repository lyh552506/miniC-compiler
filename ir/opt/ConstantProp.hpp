#include "ConstantFold.hpp"

class ConstantProp
{  
    void CalDomBlocks(BasicBlock* block);
    void RunOnFunc(Function* func);
    void RunOnBlock(BasicBlock* block);
    std::vector<BasicBlock*> BFSTraversal(int rootIndex, dominance* dom);
private:
    std::vector<BasicBlock*> bfsOrder;
    ConstantFolding* ConstFold;
    bool changed = false;
    Function* _func;
    std::vector<BasicBlock*> DomBlocks;
    std::unordered_set<BasicBlock *> visited;
    dominance* _dom;

public:
    void Pass();
    void Test(BasicBlock* block);

    ConstantProp(dominance *dom, Function* func) : _dom(dom), _func(func) {}
};
