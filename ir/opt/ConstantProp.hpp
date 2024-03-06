#include "ConstantFold.hpp"

class ConstantProp
{  
    void CalDomBlocks(BasicBlock* block);
    void RunOnFunc(Function* func);
    void RunOnBlock(BasicBlock* block);
private:
    ConstantFolding* ConstFold;
    bool changed = false;
    Function* _func;
    std::vector<BasicBlock*> DomBlocks;
    std::unordered_set<BasicBlock *> visited;
    dominance* _dom;

public:
    void Pass();

    ConstantProp(dominance *dom, Function* func) : _dom(dom), _func(func) {}
};
