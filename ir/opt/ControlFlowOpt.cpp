#include "../../include/ir/opt/ControlFlowOpt.hpp"

#define MaxInstNum 4
#define MaxLoadNum 1

void ControlFlowOpt::init()
{
    AM.get<SideEffect>(&Singleton<Module>());
}

bool ControlFlowOpt::Run()
{
    bool modified = false;
    for (BasicBlock *block : *func)
        modified |= RunOnBlock(block);
    return modified;
}

bool ControlFlowOpt::RunOnBlock(BasicBlock *block)
{
    bool modified = false;
    if (block->Size() > MaxInstNum)
        return false;
    if (dynamic_cast<RetInst *>(block->back()) || dynamic_cast<CondInst*>(block->back()))
        return false;
    User *br = block->back();
    if (dynamic_cast<UnCondInst *>(br))
    {
        if (br->GetOperand(0) == block)
            return false;
    }
    int conut = 0;
    for (User *inst : *block)
    {
        switch (inst->GetInstId())
        {
        case User::Phi:
        case User::Store:
        case User::Call:
        case User::Div:
        case User::Mod:
            return false;
        case User::Load: {
            Value *val = inst->GetOperand(0);
            if (val->isGlobal())
            {
                if (++conut > MaxLoadNum)
                    return false;
            }
            else
                return false;
        }
        break;
        default:
            break;
        }
    }
    if (block->GetUserlist().GetSize() != 1)
        return false;
    BasicBlock *pred = block->GetUserlist().Front()->GetUser()->GetParent();
    if (!dynamic_cast<CondInst *>(pred->back()))
        return false;
    User *PredBr = pred->back();
    User *CurrBr = block->back();
    BasicBlock *TrueBlock = PredBr->GetOperand(1)->as<BasicBlock>();
    BasicBlock *FalseBlock = PredBr->GetOperand(2)->as<BasicBlock>();
    BasicBlock *CurrSucc = nullptr;
    if (dynamic_cast<CondInst *>(CurrBr))
        CurrSucc = CurrBr->GetOperand(1)->as<BasicBlock>();
    else if (dynamic_cast<UnCondInst *>(CurrBr))
        CurrSucc = CurrBr->GetOperand(0)->as<BasicBlock>();
    if (!((TrueBlock == block && FalseBlock == CurrSucc) || (TrueBlock == CurrSucc && FalseBlock == block)))
        return false;
    if (TrueBlock == CurrSucc)
        TrueBlock = pred;
    else
        FalseBlock = pred;
    if (!dynamic_cast<PhiInst *>(CurrSucc->front()))
        return false;
    for (auto iter = CurrSucc->begin(); iter != CurrSucc->end();)
    {
        if (auto phi = dynamic_cast<PhiInst *>(*iter))
        {
            SelectInst *new_select =
                new SelectInst(PredBr->GetOperand(0), phi->ReturnValIn(TrueBlock), phi->ReturnValIn(FalseBlock));
            BasicBlock::mylist<BasicBlock, User>::iterator Pos(CurrBr);
            Pos.insert_before(new_select);
            phi->EraseRecordByBlock(TrueBlock);
            phi->EraseRecordByBlock(FalseBlock);
            phi->updateIncoming(new_select, block);
        }
        else
            break;
        ++iter;
    }
    pred->back()->ClearRelation();
    pred->back()->EraseFromParent();
    UnCondInst* Uncond = new UnCondInst(block);
    pred->push_back(Uncond);
    modified = true;
    return modified;
}