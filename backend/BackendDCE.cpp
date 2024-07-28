#include "../include/backend/BackendDCE.hpp"
using DCE = BackendDCE;

bool DCE::RunImpl()
{
    return run(func);
}
bool DCE::run(RISCVFunction *func)
{
    bool modified = false;
    RunOnFunction();
    for (RISCVBasicBlock *block : *func)
        modified |= RunOnBlock(block);
    return modified;
}

bool DCE::RunOnBlock(RISCVBasicBlock *block)
{
    std::set<MOperand> live = BlockLiveout[block];
    bool modified = false;
    for (auto it = block->rbegin(); it != block->rend();)
    {
        RISCVMIR *inst = *it;
        --it;
        if (CanHandle(inst) && TryDeleteInst(inst, live))
        {
            modified = true;
            UpdateLive(inst, live, false);
            delete inst;
            continue;
        }
        else
            UpdateLive(inst, live, true);
    }
    return modified;
}

void DCE::UpdateLive(RISCVMIR *inst, std::set<MOperand> &live, bool flag)
{
    if (inst->GetOpcode() == RISCVMIR::RISCVISA::ret)
    {
        if (inst->GetOperandSize() > 0)
            live.insert(static_cast<Register *>(inst->GetOperand(0)));
        else
        {
            PhyRegister *Phy = PhyRegister::GetPhyReg(PhyRegister::PhyReg::a0);
            live.insert(Phy);
        }
        return;
    }
    if (flag)
    {
        if (auto def = inst->GetDef()->ignoreLA())
            live.erase(def);
    }
    for (int i = 0; i < inst->GetOperandSize(); i++)
    {
        if (auto op = inst->GetOperand(i)->ignoreLA())
            live.insert(op);
    }
}

bool DCE::TryDeleteInst(RISCVMIR *inst, std::set<MOperand> &live)
{
    if (inst->GetDef()->ignoreLA() && !live.count(inst->GetDef()->ignoreLA()))
        return true;
    return false;
}

bool DCE::CanHandle(RISCVMIR* inst)
{
    RISCVMIR::RISCVISA op = inst->GetOpcode();
    switch(op)
    {
        case RISCVMIR::RISCVISA::_j:
        case RISCVMIR::RISCVISA::_beq:
        case RISCVMIR::RISCVISA::_bne:
        case RISCVMIR::RISCVISA::_blt:
        case RISCVMIR::RISCVISA::_bge:
        case RISCVMIR::RISCVISA::_bltu:
        case RISCVMIR::RISCVISA::_bgeu:
        case RISCVMIR::RISCVISA::_bgt:
        case RISCVMIR::RISCVISA::_ble:
        case RISCVMIR::RISCVISA::_jal:
        case RISCVMIR::RISCVISA::_jalr:
        case RISCVMIR::RISCVISA::ret:
        case RISCVMIR::RISCVISA::call:
            return false;
        default:
            return true;
    }    
}