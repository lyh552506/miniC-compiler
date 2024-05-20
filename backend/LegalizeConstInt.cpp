#pragma once
#include "LegalizeConstInt.hpp"

LegalizeConstInt::LegalizeConstInt(RISCVLoweringContext& _ctx)
    :ctx(_ctx) {}
void LegalizeConstInt::LegConstInt(RISCVMIR* inst, Imm* constdata,mylist<RISCVBasicBlock,RISCVMIR>::iterator it) {
    if(inst->GetOpcode()==RISCVMIR::RISCVISA::ret) return;
    else if(inst->GetOpcode()==RISCVMIR::RISCVISA::call) return;
    
    int inttemp = dynamic_cast<ConstIRInt*>(constdata->Getdata())->GetVal();
    if(inttemp>=-2048 && inttemp<2048) {
        if(inst->GetOpcode()==RISCVMIR::RISCVISA::mv) inst->SetMopcode(RISCVMIR::RISCVISA::li); 
        return;
    }
    else {
        int mod = inttemp % 4096;
        if(mod==0) {
            if(inst->GetOpcode() == RISCVMIR::RISCVISA::li) {
                return;
            }
            else if(inst->GetOpcode() == RISCVMIR::RISCVISA::_addi ||\
                    inst->GetOpcode() == RISCVMIR::RISCVISA::_addiw) {
                RISCVMIR* li = new RISCVMIR(RISCVMIR::RISCVISA::li);
                VirRegister* vreg = new VirRegister(RISCVType::riscv_i32);
                li->SetDef(vreg);
                li->AddOperand(constdata);
                it.insert_before(li);
                for(int i=0; i<inst->GetOperandSize(); i++) {
                    if(Imm* imm = dynamic_cast<Imm*>(inst->GetOperand(i))) {
                        if(imm->Getdata()==constdata->Getdata()) {
                            inst->SetOperand(i,vreg);
                            break;
                        }
                    } 
                }
                LegalizeMOpcode(inst);
            }
            else {
                inst->SetMopcode(RISCVMIR::RISCVISA::li);
            }
            return;
        } else if((mod>0&&mod<2048)||(mod>=-2048&&mod<0)) {
            VirRegister* vreg = ctx.createVReg(RISCVType::riscv_i32);
            Imm* const_imm = new Imm(ConstIRInt::GetNewConstant(inttemp-mod));
            RISCVMIR* li = new RISCVMIR(RISCVMIR::RISCVISA::li);
            li->SetDef(vreg);
            li->AddOperand(const_imm);
            it.insert_before(li);
            Imm* mod_imm = new Imm(ConstIRInt::GetNewConstant(mod));
            RISCVMIR* addi = new RISCVMIR(RISCVMIR::RISCVISA::_addiw);
            addi->SetDef(vreg);
            addi->AddOperand(vreg);
            addi->AddOperand(mod_imm);
            it.insert_before(addi);
            LegalizeMOpcode(inst);
            for(int i=0; i<inst->GetOperandSize(); i++) {
                while(inst->GetOperand(i)==constdata) {
                    inst->SetOperand(i,vreg);
                    return;
                }
            }
        } else if (mod >=2048 && mod <4095) {
            VirRegister* vreg = ctx.createVReg(RISCVType::riscv_i32);
            Imm* const_imm = new Imm(ConstIRInt::GetNewConstant(inttemp-mod-4096));
            RISCVMIR* li = new RISCVMIR(RISCVMIR::RISCVISA::li);
            li->SetDef(vreg);
            li->AddOperand(const_imm);
            it.insert_before(li);
            Imm* mod_imm = new Imm(ConstIRInt::GetNewConstant(mod-4096));
            RISCVMIR* addi = new RISCVMIR(RISCVMIR::RISCVISA::_addiw);
            addi->SetDef(vreg);
            addi->AddOperand(vreg);
            addi->AddOperand(mod_imm);
            it.insert_before(addi);
            LegalizeMOpcode(inst);
            for(int i=0; i<inst->GetOperandSize(); i++) {
                while(inst->GetOperand(i)==constdata) {
                    inst->SetOperand(i,vreg);
                    return;
                }
            }
        } else if (mod>-4095&&mod<-2048) {
            VirRegister* vreg = ctx.createVReg(RISCVType::riscv_i32);
            Imm* const_imm = new Imm(ConstIRInt::GetNewConstant(inttemp-mod-4096));
            RISCVMIR* li = new RISCVMIR(RISCVMIR::RISCVISA::li);
            li->SetDef(vreg);
            li->AddOperand(const_imm);
            it.insert_before(li);
            Imm* mod_imm = new Imm(ConstIRInt::GetNewConstant(mod+4096));
            RISCVMIR* addi = new RISCVMIR(RISCVMIR::RISCVISA::_addiw);
            addi->SetDef(vreg);
            addi->AddOperand(mod_imm);
            it.insert_before(addi);
            LegalizeMOpcode(inst);
            for(int i=0; i<inst->GetOperandSize(); i++) {
                while(inst->GetOperand(i)==constdata) {
                    inst->SetOperand(i,vreg);
                    return;
                }
            }
        } else assert(0&&"error imm");
    }
}

bool LegalizeConstInt::run() {
    for(auto& func : ctx.GetFunctions()) {
        for(auto block : *func) {
            for(mylist<RISCVBasicBlock,RISCVMIR>::iterator it=block->begin();it!=block->end();++it) {
                RISCVMIR* inst = *it;
                for(int i=0; i<inst->GetOperandSize(); i++) {
                    if(Imm* constdata = dynamic_cast<Imm*>(inst->GetOperand(i))) {
                        if(ConstIRInt* constint = dynamic_cast<ConstIRInt*>(constdata->Getdata())) {
                            LegConstInt(inst, constdata, it);
                        }
                    }
                }
            }
        }
    }
    return false;
}

void LegalizeConstInt::LegalizeMOpcode(RISCVMIR* inst) {
    using ISA = RISCVMIR::RISCVISA;
    ISA& opcode = inst->GetOpcode();
    if(opcode == ISA::_slli) inst->SetMopcode(ISA::_sll);
    else if(opcode == ISA::_srli) inst->SetMopcode(ISA::_srl);
    else if(opcode == ISA::_srai) inst->SetMopcode(ISA::_sra);
    else if(opcode == ISA::_addi) inst->SetMopcode(ISA::_add);
    else if(opcode == ISA::_addiw) inst->SetMopcode(ISA::_addw);
    else if(opcode == ISA::_xori) inst->SetMopcode(ISA::_xor);
    else if(opcode == ISA::_ori) inst->SetMopcode(ISA::_or);
    else if(opcode == ISA::_andi) inst->SetMopcode(ISA::_and);
    else if(opcode == ISA::_slti) inst->SetMopcode(ISA::_slt);
    else if(opcode == ISA::_sltiu) inst->SetMopcode(ISA::_sltu);
    else assert(0&&"Invalid MOpcode type");
}
