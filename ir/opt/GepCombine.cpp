#include "../../include/ir/opt/GepCombine.hpp"
#include "../../include/ir/Analysis/SideEffect.hpp"
#include "../../include/ir/opt/ConstantFold.hpp"
#include "../../include/ir/opt/InstructionSimplify.hpp"
#include <algorithm>
#include <deque>

bool GepCombine::Run()
{
    DomTree = AM.get<dominance>(func);
    AM.get<SideEffect>(&Singleton<Module>());
    bool modified = false;
    std::deque<HandleNode *> WorkList;
    WorkList.push_back(new HandleNode(
        DomTree, &(DomTree->GetNode(0)), DomTree->GetNode(0).idom_child.begin(), DomTree->GetNode(0).idom_child.end(),
        std::unordered_map<Value *, std::unordered_set<gepinfo *>>(), std::unordered_set<binaryinfo *>()));
    while (!WorkList.empty())
    {
        GepCombine::HandleNode *cur = WorkList.back();
        if (!cur->isProcessed())
        {
            modified |= ProcessNode(cur);
            cur->Process();
        }
        else if (cur->Child() != cur->EndIter())
        {
            auto node = cur->NextChild();
            WorkList.push_back(
                new HandleNode(DomTree, &(DomTree->GetNode(*node)), DomTree->GetNode(*node).idom_child.begin(),
                               DomTree->GetNode(*node).idom_child.end(), cur->GetGeps(), cur->GetBinarys()));
        }
        else
        {
            delete cur;
            WorkList.pop_back();
        }
    }
    return modified;
}

bool GepCombine::ProcessNode(HandleNode *node)
{
    bool modified = false;
    BasicBlock *block = node->GetBlock();
    _DEBUG(std::cerr << "Processing Node: " << block->GetName() << std::endl;)

    for (User *inst : *block)
    {
        if (auto gep = dynamic_cast<GetElementPtrInst *>(inst))
        {
            if (auto val = SimplifyGepInst(gep))
            {
                gep->RAUW(val);
                modified |= true;
                continue;
            }

            if (GetElementPtrInst *new_gep = HandleGepPhi(gep))
            {
                gep = new_gep;
                modified |= true;
            }

            if (GetElementPtrInst *new_gep = Normal_Handle_With_GepBase(gep))
            {
                gep = new_gep;
                modified |= true;
            }
        }
    }
    return modified;
}

Value *GepCombine::SimplifyGepInst(GetElementPtrInst *inst)
{
    Value *Base = inst->Getuselist()[0]->usee;

    // In this case, there is only < gep base > -> base
    if (inst->Getuselist().size() == 1)
        return Base;

    if (dynamic_cast<UndefValue *>(Base))
        return UndefValue::get(inst->GetType());

    if (inst->Getuselist().size() == 2)
    {
        Value *Op1 = inst->Getuselist()[1]->usee;
        if (auto val = dynamic_cast<ConstantData *>(Op1))
        {
            if (val->isConstZero())
                return Base;
        }
        // Now there is the case of < gep base, offset >
        {
            if (auto tp = dynamic_cast<HasSubType *>(Base->GetType()))
            {
                if (tp->get_size() == 0)
                    return Base;
            }

            if (auto binary = dynamic_cast<BinaryInst *>(Op1))
            {
                if (binary->getopration() == BinaryInst::Operation::Op_Sub)
                {
                    if (binary->Getuselist()[1]->usee == Base)
                    {
                        inst->RSUW(inst->Getuselist()[0].get(), binary->Getuselist()[0]->usee);
                        inst->RSUW(inst->Getuselist()[1].get(), ConstIRInt::GetNewConstant(0));
                        return inst;
                    }
                }
            }
        }
    }

    // Now handle the case of < gep base, 0, 0, 0  ... >
    auto all_offset_zero = [&inst]() {
        return std::all_of(inst->Getuselist().begin() + 1, inst->Getuselist().end(), [](User::UsePtr &use) {
            if (auto val = dynamic_cast<ConstantData *>(use->usee))
            {
                return val->isConstZero();
            }
            return false;
        });
    };
    // if(all_offset_zero())
    // return Base;
    return nullptr;
}

GetElementPtrInst *GepCombine::HandleGepPhi(GetElementPtrInst *inst)
{
    Value *Base = inst->Getuselist()[0]->usee;
    if (auto Phi = dynamic_cast<PhiInst *>(Base))
    {
        auto val = dynamic_cast<GetElementPtrInst *>(Phi->GetVal(0));
        if (!val)
            return nullptr;
        if (val == inst)
            return nullptr;

        int Not_Same_Pos = -1;
        for (int i = 1; i < Phi->Getuselist().size(); i++)
        {
            auto val_ = dynamic_cast<GetElementPtrInst *>(Phi->GetVal(i));
            if (!val_ || val_->Getuselist().size() != val->Getuselist().size())
                return nullptr;
            if (val_ == inst)
                return nullptr;

            Type *CurTp = nullptr;

            for (int j = 0; j < val->Getuselist().size(); j++)
            {
                if (val->GetOperand(j)->GetType() != val_->GetOperand(j)->GetType())
                    return nullptr;
                Value *Val_j = val->GetOperand(j);
                Value *Val_j_ = val_->GetOperand(j);
                auto const_Val_j = dynamic_cast<ConstantData *>(Val_j);
                auto const_Val_j_ = dynamic_cast<ConstantData *>(Val_j_);
                if (const_Val_j && const_Val_j_)
                {
                    if (auto const_Val_j_int = dynamic_cast<ConstIRInt *>(const_Val_j))
                    {
                        if (auto const_val_j_int_ = dynamic_cast<ConstIRInt *>(const_Val_j_))
                        {
                            if (const_Val_j_int->GetVal() != const_val_j_int_->GetVal())
                                return nullptr;
                        }
                        else if (auto const_val_j_float_ = dynamic_cast<ConstIRFloat *>(const_Val_j_))
                        {
                            if (const_Val_j_int->GetVal() != const_val_j_float_->GetVal())
                                return nullptr;
                        }
                    }
                    else if (auto const_Val_j_float = dynamic_cast<ConstIRFloat *>(const_Val_j))
                    {
                        if (auto const_val_j_int_ = dynamic_cast<ConstIRInt *>(const_Val_j_))
                        {
                            if (const_Val_j_float->GetVal() != const_val_j_int_->GetVal())
                                return nullptr;
                        }
                        else if (auto const_val_j_float_ = dynamic_cast<ConstIRFloat *>(const_Val_j_))
                        {
                            if (const_Val_j_float->GetVal() != const_val_j_float_->GetVal())
                                return nullptr;
                        }
                    }
                }
                else if (Val_j != Val_j_)
                {
                    if (Not_Same_Pos == -1)
                        Not_Same_Pos = j;
                    else
                        return nullptr;
                }
                // More than one different operand
            }
        }
        if (Phi->GetUserlist().GetSize() != 1)
            return nullptr;
        std::vector<Operand> Ops;
        for (int i = 1; i < val->Getuselist().size(); i++)
            Ops.push_back(val->GetOperand(i));
        GetElementPtrInst *New_Gep = new GetElementPtrInst(val->Getuselist()[0]->usee, Ops);
        if (Not_Same_Pos == -1)
        {
            // insert before
            BasicBlock::mylist<BasicBlock, User>::iterator Inst_Pos(inst);
            Inst_Pos.insert_before(New_Gep);
        }
        else
        {
            // Down the Phi to Current Block
            PhiInst *NewPhi = new PhiInst(Phi, Phi->GetType());
            for (auto &[key, val] : Phi->PhiRecord)
                NewPhi->updateIncoming(val.first, val.second);
            New_Gep->RSUW(Not_Same_Pos, NewPhi);
            // insert before
            BasicBlock::mylist<BasicBlock, User>::iterator Inst_Pos(inst);
            Inst_Pos.insert_before(New_Gep);
            New_Gep->RSUW(Not_Same_Pos, NewPhi);
        }
        inst->RSUW(0, New_Gep);
        Base = New_Gep;
        return inst;
    }
    return nullptr;
}

GetElementPtrInst *GepCombine::Normal_Handle_With_GepBase(GetElementPtrInst *inst)
{
    Value *Base = inst->Getuselist()[0]->usee;
    if (auto base = dynamic_cast<GetElementPtrInst *>(Base))
    {
        if (!CanHandle(inst, base))
            return nullptr;

        // Handle the case
        /*
            %a = gep %1, ...
            %b = gep %a, ...
            %c = gep %b, ...
            %d = gep %c, ...
            ...
        */
        // Pay attention to the base_gep is has been folded
        if (auto base_base = dynamic_cast<GetElementPtrInst *>(base->Getuselist()[0]->usee))
            if (base_base->Getuselist().size() == 2 && CanHandle(base, base_base))
                return nullptr;

        std::vector<Value *> Offsets;

        // Handle the case
        /*
            %1 = gep %base, A
            %a = gep %1, B
            ---->
            C = A + B
            %a = gep %base, C
        */
        {
            Value *Dst = nullptr;
            Value *Src_Op = base->GetOperand(base->Getuselist().size() - 1);
            Value *Cur_Op = inst->GetOperand(1);
            if (dynamic_cast<ConstantData *>(Src_Op) && dynamic_cast<ConstantData *>(Src_Op)->isZero())
                Dst = Cur_Op;
            else if (dynamic_cast<ConstantData *>(Cur_Op) && dynamic_cast<ConstantData *>(Cur_Op)->isZero())
                Dst = Src_Op;
            else
            {
                if (!dynamic_cast<ConstantData *>(Src_Op) && !dynamic_cast<ConstantData *>(Cur_Op))
                    return nullptr;
                else
                    Dst = new BinaryInst(Src_Op, BinaryInst::Operation::Op_Add, Cur_Op);
            }

            if (base->Getuselist().size() == 2)
            {
                inst->RSUW(0, base->Getuselist()[0]->usee);
                inst->RSUW(1, Dst);
                return inst;
            }
            // Offsets.insert(Offsets.end(), base->Getuselist().begin() + 1, base->Getuselist().end() - 1);
            // Offsets.push_back(Dst);
            // Offsets.insert(Offsets.end(), inst->Getuselist().begin() + 2, inst->Getuselist().end());
        }
    }
    return nullptr;
}

bool GepCombine::CanHandle(GetElementPtrInst *src, GetElementPtrInst *base)
{
    // Judge if it can be simplified
    auto inst_all_offset_zero = [&src]() {
        return std::all_of(src->Getuselist().begin() + 1, src->Getuselist().end(), [](User::UsePtr &use) {
            if (auto val = dynamic_cast<ConstantData *>(use->usee))
            {
                return val->isConstZero();
            }
            return false;
        });
    };
    auto base_all_offset_zero = [&base]() {
        return std::all_of(base->Getuselist().begin() + 1, base->Getuselist().end(), [](User::UsePtr &use) {
            if (auto val = dynamic_cast<ConstantData *>(use->usee))
            {
                return val->isConstZero();
            }
            return false;
        });
    };
    if (inst_all_offset_zero() && !base_all_offset_zero() && base->GetUserlist().GetSize() != 1)
        return false;
    return true;
}