#include "../../include/ir/opt/DSE.hpp"

void DSE::init()
{
    Store_Map.clear();
    Array_Store_Map.clear();
    wait_del.clear();
    DomTree = AM.get<dominance>(func);
}

bool DSE::Run()
{
    bool modified = false;
    std::vector<BasicBlock *> WorkList;
    WorkList.push_back(func->front());
    while(!WorkList.empty())
    {
        BasicBlock* block = WorkList.back();
        WorkList.pop_back();
        if(HasHandleBlock.count(block))
            continue;
        HasHandleBlock.insert(block);
        modified |= RunOnBlock(block);
    }
}

bool DSE::RunOnBlock(BasicBlock* block)
{
    return false;
}