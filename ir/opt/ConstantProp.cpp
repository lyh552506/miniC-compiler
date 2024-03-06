#include "ConstantProp.hpp"
#include <set>
#include <queue>

void ConstantProp::CalDomBlocks(BasicBlock* block)
{
    if(visited.insert(block).second)
    {
        auto& node = _dom->GetNode(block->num);
        for(int child : node.des)
            CalDomBlocks(_dom->GetNode(child).thisBlock);
        DomBlocks.push_back(block);
    }
}

void ConstantProp::Pass()
{
    CalDomBlocks(*_func->begin());
    for(BasicBlock* block : DomBlocks)
        RunOnBlock(block);
}

void ConstantProp::RunOnBlock(BasicBlock* block)
{
    For_inst_In(block)
    {
        Value* C = ConstFold->ConstantFoldInst(inst);
        if(C)
        {
        inst->RAUW(C);
        inst->ClearRelation();
        inst->EraseFromParent();
        }
    }
}