#include "../../include/ir/opt/ConstantHoist.hpp"

bool ConstantHoist::Run()
{
    bool modified = false;
    for (BasicBlock *block : *func)
        modified |= RunOnBlock(block);
    return modified;
}

bool ConstantHoist::RunOnBlock(BasicBlock *block)
{
    bool modified = false;
    User *Terminal = block->back();
    if (!dynamic_cast<CondInst *>(Terminal))
        return false;
    CondInst *Br = dynamic_cast<CondInst *>(Terminal);
    BasicBlock *TrueBlock = dynamic_cast<BasicBlock *>(Br->GetOperand(1));
    BasicBlock *FalseBlock = dynamic_cast<BasicBlock *>(Br->GetOperand(2));

    if (TrueBlock == FalseBlock || TrueBlock == block || FalseBlock == block)
        return false;
    if (TrueBlock->GetUserlist().GetSize() != 1 || FalseBlock->GetUserlist().GetSize() != 1)
        return false;
    if (TrueBlock->Size() != FalseBlock->Size())
        return false;
    if (!HoistInstInBlock(TrueBlock, FalseBlock))
        return false;
    User *cmp = Br->GetOperand(0)->as<User>();
    while (!HoistList.empty())
    {
        modified = true;
        HoistNode *node = HoistList.back();
        HoistList.pop_back();
        User *LHS_Inst = node->LHS_Inst;
        Value *LHS = node->LHS;
        User *RHS_Inst = node->RHS_Inst;
        Value *RHS = node->RHS;
        int index = node->index;
        SelectInst *new_select = new SelectInst(cmp, LHS, RHS);
        BasicBlock::mylist<BasicBlock, User>::iterator Pos(cmp);
        Pos.insert_after(new_select);
        LHS_Inst->RSUW(index, new_select);
        RHS_Inst->RSUW(index, new_select);
        modified = true;
    }
    BasicBlock::mylist<BasicBlock, User>::iterator Pos(Br);
    for (auto inst = TrueBlock->begin(); inst != TrueBlock->end();)
    {
        User *handle = *inst;
        ++inst;
        handle->EraseFromParent();
        Pos.insert_before(handle);
    }
    delete Br;
    return modified;
}

bool ConstantHoist::HoistInstInBlock(BasicBlock *TrueBlock, BasicBlock *FalseBlock)
{
    bool modified = false;
    int index = 0;
    for (auto True_iter = TrueBlock->begin(), False_iter = FalseBlock->begin();
         True_iter != TrueBlock->end(), False_iter != FalseBlock->end(); ++True_iter, ++False_iter)
    {
        User *True_Inst = *True_iter;
        User *False_Inst = *False_iter;
        if (True_Inst->GetInstId() != False_Inst->GetInstId())
            return false;
        if (True_Inst->GetType() != False_Inst->GetType())
            return false;
        if (True_Inst->Getuselist().size() != False_Inst->Getuselist().size())
            return false;
        InstIndex[TrueBlock][True_Inst] = index;
        InstIndex[FalseBlock][False_Inst] = index;
        index++;
    }
    for (auto True_iter = TrueBlock->begin(), False_iter = FalseBlock->begin();
         True_iter != TrueBlock->end(), False_iter != FalseBlock->end(); ++True_iter, ++False_iter)
    {
        User *True_Inst = *True_iter;
        User *False_Inst = *False_iter;
        if (dynamic_cast<PhiInst *>(True_Inst))
            continue;
        for (int i = 0; i < True_Inst->Getuselist().size(); i++)
        {
            Value *True_Op = True_Inst->GetOperand(i);
            Value *False_Op = False_Inst->GetOperand(i);
            User *True_User = dynamic_cast<User *>(True_Op);
            User *False_User = dynamic_cast<User *>(False_Op);
            if (True_Op->GetType() != False_Op->GetType())
                return false;
            if (dynamic_cast<ConstantData *>(True_Op) && dynamic_cast<ConstantData *>(False_Op))
            {
                if (dynamic_cast<ConstantData *>(True_Op) != dynamic_cast<ConstantData *>(False_Op))
                {
                    modified = true;
                    HoistList.push_back(new HoistNode(True_Inst, True_Op, False_Inst, False_Op, i));
                }
            }
            else if (dynamic_cast<Variable *>(True_Op) && dynamic_cast<Variable *>(False_Op))
            {
                if (dynamic_cast<Variable *>(True_Op) != dynamic_cast<Variable *>(False_Op))
                {
                    modified = true;
                    HoistList.push_back(new HoistNode(True_Inst, True_Op, False_Inst, False_Op, i));
                }
            }
            else if (dynamic_cast<StoreInst *>(True_Inst) && i == 0 && True_User && False_User &&
                     True_User->GetParent() != TrueBlock && False_User->GetParent() != FalseBlock)
            {
                if (True_Op != False_Op)
                {
                    modified = true;
                    HoistList.push_back(new HoistNode(True_Inst, True_Op, False_Inst, False_Op, i));
                }
            }
            else if (True_User && False_User && True_User->GetParent() == TrueBlock &&
                     False_User->GetParent() == FalseBlock)
            {
                if (InstIndex[TrueBlock][True_User] != InstIndex[FalseBlock][False_User])
                    return false;
            }
            else if (True_User && False_User &&
                     (True_User->GetParent() == TrueBlock || False_User->GetParent() == FalseBlock))
                return false;
        }
    }
    User *True_Br = TrueBlock->back();
    if (dynamic_cast<CondInst *>(True_Br))
    {
        BasicBlock *Block_t = True_Br->GetOperand(1)->as<BasicBlock>();
        BasicBlock *Block_f = True_Br->GetOperand(2)->as<BasicBlock>();
        for (User *inst : *Block_t)
        {
            if (auto phi = dynamic_cast<PhiInst *>(inst))
            {
                Value *True_Value = phi->ReturnValIn(TrueBlock);
                Value *False_Value = phi->ReturnValIn(FalseBlock);
                if (True_Value != False_Value)
                {
                    HoistList.clear();
                    return false;
                }
            }
            else
                break;
        }
        for (User *inst : *Block_f)
        {
            if (auto phi = dynamic_cast<PhiInst *>(inst))
            {
                Value *True_Value = phi->ReturnValIn(TrueBlock);
                Value *False_Value = phi->ReturnValIn(FalseBlock);
                if (True_Value != False_Value)
                {
                    HoistList.clear();
                    return false;
                }
            }
            else
                break;
        }
    }
    else if (dynamic_cast<UnCondInst *>(True_Br))
    {
        BasicBlock *Block_t = True_Br->GetOperand(0)->as<BasicBlock>();
        for (User *inst : *Block_t)
        {
            if (auto phi = dynamic_cast<PhiInst *>(inst))
            {
                Value *True_Value = phi->ReturnValIn(TrueBlock);
                Value *False_Value = phi->ReturnValIn(FalseBlock);
                if (True_Value != False_Value)
                {
                    HoistList.clear();
                    return false;
                }
            }
            else
                break;
        }
    }
    return modified;
}