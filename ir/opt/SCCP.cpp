#include "SCCP.hpp"

void SCCP::RunOnFunction()
{
    val_map.clear();
    marked.clear();
    cfg_worklist.clear();
    SSA_worklist.clear();

    cfg_worklist.emplace_back(nullptr, func->front());
    for(BasicBlock* block : *func)
    {
        for(User* inst : *block)
            val_map.set(inst, {ValueStatus::TOP});
    }
    int i, j = 0;
    while(i < cfg_worklist.size() || j < SSA_worklist.size())
    {
        while(i < cfg_worklist.size())
        {
            BasicBlock* pred = cfg_worklist[i].first;
            BasicBlock* succ = cfg_worklist[i].second;
            i++;
            if(marked.find({pred, succ}) != marked.end())
                continue;
            marked.insert(std::make_pair(pred, succ));
            for(User* inst : *succ)
                visitor->visit(inst);
        }
        while(j < SSA_worklist.size())
        {
            User* inst = SSA_worklist[j];
            j++;
            BasicBlock* block_ = inst->GetParent();
            // for(BasicBlock* Block : block_->getpred())
            // {
            //     if(marked.count({Block, block_}) != 0)
            //     {
            //         visitor->visit(inst);
            //         break;
            //     }
            // }
        }
    }
    // replaceConst(f);
}

void SCCP::ReplaceConst()
{
    std::vector<User*> Del_Insts;

    for(BasicBlock* block : *func)
    {
        for(User* inst : *block)
        {
            if(Value* value = getval_status(inst).val)
            {
                inst->RAUW(value);
                Del_Insts.push_back(inst);
            }
        }
    }
    for(User* inst : Del_Insts)
    {
        inst->ClearRelation();
        inst->EraseFromParent();
    }

    // cond_br with const cond
    for(BasicBlock* block : *func)
    {
        User* inst = block->back();
        if(!dynamic_cast<CondInst*>(inst))
            continue;
        if(Value* cond = inst->Getuselist()[0]->usee)
        {
            if(dynamic_cast<ConstIRBoolean*>(cond)->GetVal())
            {
                auto uncond = new UnCondInst(dynamic_cast<BasicBlock*>(inst->Getuselist()[1]->usee));
                inst->ClearRelation();
                inst->EraseFromParent();
                block->push_back(uncond);
            }
            else
            {
                auto uncond = new UnCondInst(dynamic_cast<BasicBlock*>(inst->Getuselist()[2]->usee));
                inst->ClearRelation();
                inst->EraseFromParent();
                block->push_back(uncond);
            }
        }

        // if(CondInst* br = dynamic_cast<CondInst*>(block->back()))
        // {
        //     if(Value* value = getval_status(br->getcond()).val)
        //     {
        //         br->RAUW(value);
        //         br->ClearRelation();
        //         br->EraseFromParent();
        //     }
        // }
    }
}