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
    WorkList.push_back(new HandleNode(DomTree, &(DomTree->GetNode(0)), DomTree->GetNode(0).idom_child.begin(),
                                      DomTree->GetNode(0).idom_child.end(), std::unordered_set<GetElementPtrInst *>()));
    while (!WorkList.empty())
    {
        GepCombine::HandleNode *cur = WorkList.back();
        if (!cur->isProcessed())
        {
            modified |= ProcessNode(cur);
            cur->Process();
            cur->SetChildGeps(cur->GetGeps());
        }
        else if (cur->Child() != cur->EndIter())
        {
            auto node = cur->NextChild();
            WorkList.push_back(new HandleNode(DomTree, &(DomTree->GetNode(*node)),
                                              DomTree->GetNode(*node).idom_child.begin(),
                                              DomTree->GetNode(*node).idom_child.end(), cur->GetChildGeps()));
        }
        else
        {
            delete cur;
            WorkList.pop_back();
        }
    }
    while(!wait_del.empty())
    {
        auto inst = wait_del.back();
        wait_del.pop_back();
        delete inst;
    }
    return modified;
}

bool GepCombine::ProcessNode(HandleNode *node)
{
    bool modified = false;
    BasicBlock *block = node->GetBlock();
    _DEBUG(std::cerr << "Processing Node: " << block->GetName() << std::endl;)
    std::unordered_set<GetElementPtrInst *> geps = node->GetGeps();
    for (User *inst : *block)
    {
        if (auto gep = dynamic_cast<GetElementPtrInst *>(inst))
        {
            geps.insert(gep);
            if (auto val = SimplifyGepInst(gep, geps))
            {
                _DEBUG(std::cerr << "SimplifyGepInst modified" << std::endl;)
                modified |= true;
                continue;
            }

            if (GetElementPtrInst *new_gep = HandleGepPhi(gep, geps))
            {
                gep = new_gep;
                _DEBUG(std::cerr << "HandleGepPhi modified" << std::endl;)
                modified |= true;
            }

            if (GetElementPtrInst *new_gep = Normal_Handle_With_GepBase(gep, geps))
            {
                // gep->RAUW(new_gep);
                _DEBUG(std::cerr << "Normal_Handle_With_GepBase modified " << std::endl;)
                modified |= true;
            }
        }
    }
    node->SetGeps(geps);
    return modified;
}

Value *GepCombine::SimplifyGepInst(GetElementPtrInst *inst, std::unordered_set<GetElementPtrInst *> &geps)
{
    Value *Base = inst->Getuselist()[0]->usee;

    // In this case, there is only < gep base > -> base
    if (inst->Getuselist().size() == 1)
    {
        _DEBUG(std::cerr << "Handle Case Only have base." << std::endl;)
        inst->RAUW(Base);
        geps.erase(inst);
        return Base;
    }

    if (dynamic_cast<UndefValue *>(Base))
    {
        _DEBUG(std::cerr << "Handle Case : base is undef." << std::endl;)
        inst->RAUW(UndefValue::get(inst->GetType()));
        geps.erase(inst);
        return UndefValue::get(inst->GetType());
    }

    if (auto base_gep = dynamic_cast<GetElementPtrInst *>(Base))
    {
        // Now handle the case of < gep base, 0, 0, 0  ... >
        // auto all_offset_zero = [&base_gep]() {
        //     return std::all_of(base_gep->Getuselist().begin() + 1, base_gep->Getuselist().end(), [](User::UsePtr
        //     &use) {
        //         if (auto val = dynamic_cast<ConstantData *>(use->usee))
        //         {
        //             return val->isConstZero();
        //         }
        //         return false;
        //     });
        // };
        auto offset = dynamic_cast<ConstIRInt *>(base_gep->Getuselist().back()->usee);
        if (offset && offset->GetVal() == 0)
        {
            std::vector<Operand> Ops;
            for (int i = 1; i < base_gep->Getuselist().size() - 1; i++)
                Ops.push_back(base_gep->Getuselist()[i]->GetValue());
            for (int i = 1; i < inst->Getuselist().size(); i++)
                Ops.push_back(inst->Getuselist()[i]->usee);
            GetElementPtrInst *New_Gep = new GetElementPtrInst(base_gep->Getuselist()[0]->usee, Ops);
            // insert before
            BasicBlock::mylist<BasicBlock, User>::iterator Inst_Pos(inst);
            Inst_Pos.insert_before(New_Gep);
            inst->RAUW(New_Gep);
            geps.erase(inst);
            geps.insert(New_Gep);
            wait_del.push_back(inst);
            return New_Gep;
        }
    }

    if (inst->Getuselist().size() == 2)
    {
        Value *Op1 = inst->Getuselist()[1]->usee;
        if (auto val = dynamic_cast<ConstantData *>(Op1))
        {
            if (val->isConstZero())
            {
                _DEBUG(std::cerr << "Handle Case : offset is zero." << std::endl;)
                inst->RAUW(Base);
                geps.erase(inst);
                return Base;
            }
        }
        // Now there is the case of < gep base, offset >
        {
            if (auto tp = dynamic_cast<HasSubType *>(Base->GetType()))
            {
                if (tp->get_size() == 0)
                {
                    inst->RAUW(Base);
                    geps.erase(inst);
                    return Base;
                }
            }
        }
    }

    return nullptr;
}

GetElementPtrInst *GepCombine::HandleGepPhi(GetElementPtrInst *inst, std::unordered_set<GetElementPtrInst *> &geps)
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

GetElementPtrInst *GepCombine::Normal_Handle_With_GepBase(GetElementPtrInst *inst,
                                                          std::unordered_set<GetElementPtrInst *> &geps)
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
    }
    // Handle the case
    /*
        %a = gep %base, 0, %1
        %2 = %1 + const
        %b = gep %base, 0, %2
        ---->
        %a = gep %base, 0, %1
        %b = gep %a, const
    */
    {
        if (inst->Getuselist().size() == 3)
        {
            if (dynamic_cast<ConstantData *>(inst->Getuselist()[1]->usee) &&
                dynamic_cast<ConstantData *>(inst->Getuselist()[1]->usee)->isConstZero())
            {
                Value *val = inst->Getuselist()[2]->usee;
                if (auto binary = dynamic_cast<BinaryInst *>(val))
                {
                    if (binary->getopration() == BinaryInst::Operation::Op_Add)
                    {
                        if (auto constdata = dynamic_cast<ConstantData *>(binary->Getuselist()[1]->usee))
                        {
                            if (auto gep = dynamic_cast<GetElementPtrInst *>(binary->Getuselist()[0]->usee))
                            {
                                if (gep->Getuselist()[0]->usee == Base && geps.count(gep))
                                {
                                    inst->RSUW(inst->Getuselist()[0].get(), gep);
                                    inst->RSUW(inst->Getuselist()[1].get(), constdata);
                                    _DEBUG(std::cerr
                                               << "Handle Case : gep %base, binary(add), while there are three uses"
                                               << std::endl;)
                                }
                            }
                        }
                        else if (auto constdata = dynamic_cast<ConstantData *>(binary->Getuselist()[0]->usee))
                        {
                            if (auto gep = dynamic_cast<GetElementPtrInst *>(binary->Getuselist()[1]->usee))
                            {
                                if (gep->Getuselist()[0]->usee == Base && geps.count(gep))
                                {
                                    inst->RSUW(inst->Getuselist()[0].get(), gep);
                                    inst->RSUW(inst->Getuselist()[1].get(), constdata);
                                    _DEBUG(std::cerr
                                               << "Handle Case : gep %base, binary(add), while there are three uses"
                                               << std::endl;)
                                }
                            }
                        }
                    }
                }
            }
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