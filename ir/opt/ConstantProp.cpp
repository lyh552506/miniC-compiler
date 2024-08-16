#include "../../include/ir/opt/ConstantProp.hpp"
#include <cmath>
#include <set>

bool ConstantProp::Run()
{
    bool modified = false;
    for (BasicBlock *block : *_func)
        modified |= RunOnBlock(block);
    return modified;
}

bool ConstantProp::RunOnBlock(BasicBlock *block)
{
    bool modified = false;
    std::vector<User *> wait_del;
    for (User *inst : *block)
    {
        Value *C = ConstFold->ConstantFoldInst(inst);
        if (C && !dynamic_cast<UndefValue *>(C))
        {
            inst->RAUW(C);
            if (!dynamic_cast<CallInst *>(inst))
                wait_del.push_back(inst);
        }
        else if (dynamic_cast<UndefValue *>(C))
        {
            if (!inst->GetUserlist().is_empty())
            {
                inst->RAUW(C);
                wait_del.push_back(inst);
            }
        }
        ChangeCmpOp(inst);
    }
    for (auto inst : wait_del)
    {
        inst->ClearRelation();
        inst->EraseFromParent();
        modified |= true;
    }
    modified |= MatchAddModInst(block);
    return modified;
}

bool ConstantProp::ChangeCmpOp(User *inst)
{
    auto GetFirstConstAndPosition = [](BinaryInst *bina) -> std::pair<int, Operand> {
        for (int i = 0; i < 2; i++)
        {
            auto op = bina->GetOperand(i);
            if (op->isConst())
            {
                return {i, op};
            }
        }
        return {-1, nullptr};
    };

    bool modified = false;

    if (auto bina = inst->as<BinaryInst>())
    {
        auto opcode = bina->getopration();
        if (inst->GetOperand(0)->GetType() == IntType::NewIntTypeGet())
        {
            if (opcode == BinaryInst::Op_LE || opcode == BinaryInst::Op_GE)
            {
                auto [pos, val] = GetFirstConstAndPosition(bina);
                if (pos != -1)
                {
                    auto constval = val->as<ConstIRInt>()->GetVal();
                    if (constval != INT32_MAX && constval != INT32_MIN)
                    {
                        if (opcode == BinaryInst::Op_LE)
                        {
                            if (pos == 0)
                                bina->RSUW(0, ConstIRInt::GetNewConstant(constval - 1));
                            else
                                bina->RSUW(1, ConstIRInt::GetNewConstant(constval + 1));
                            bina->setoperation(BinaryInst::Op_L);
                        }
                        else
                        {
                            if (pos == 0)
                                bina->RSUW(0, ConstIRInt::GetNewConstant(constval + 1));
                            else
                                bina->RSUW(1, ConstIRInt::GetNewConstant(constval - 1));
                            bina->setoperation(BinaryInst::Op_G);
                        }
                        modified = true;
                    }
                }
            }
        }
    }
    return modified;
}