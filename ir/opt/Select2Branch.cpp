#include "../../include/ir/opt/Select2Branch.hpp"

void Select2Branch::Collect()
{
    for(BasicBlock* block : *func)
    {
        for(User* inst : *block)
        {
            if(auto select = dynamic_cast<SelectInst*>(inst))
                Selects.push_back(select);
        }
    }
}

bool Select2Branch::Run()
{
    bool modified = false;
    Collect();
    while(!Selects.empty())
    {
        modified = true;
        SelectInst* inst = Selects.back();
        Selects.pop_back();
        HandleSelect(inst);
    }
    return modified;
}

void Select2Branch::HandleSelect(SelectInst* inst)
{
    Value* cond = inst->GetOperand(0);
    Value* lhs = inst->GetOperand(1);
    Value* rhs = inst->GetOperand(2);
    BasicBlock* block = inst->GetParent();
    BasicBlock::mylist<Function, BasicBlock>::iterator Block_Pos(block);
    BasicBlock* FalseBlock = block->SplitAt(inst);
    Block_Pos.insert_after(FalseBlock);
    BasicBlock* TrueBlock = new BasicBlock();
    UnCondInst* True_br = new UnCondInst(FalseBlock);
    CondInst* Cur_Br = new CondInst(cond, TrueBlock, FalseBlock);
    block->push_back(Cur_Br);
    TrueBlock->push_back(True_br);
    Block_Pos.insert_after(TrueBlock);
    PhiInst* next_block_phi = new PhiInst(inst->GetType());
    inst->RAUW(next_block_phi);
    next_block_phi->updateIncoming(lhs, TrueBlock);
    next_block_phi->updateIncoming(rhs, block);
    FalseBlock->push_front(next_block_phi);
    delete inst;
}