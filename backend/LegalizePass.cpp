#include "LegalizePass.hpp"
Legalize::Legalize(RISCVLoweringContext& _ctx) :ctx(_ctx) {}

void Legalize::run() {
    using PhyReg = PhyRegister::PhyReg;
    using ISA = RISCVMIR::RISCVISA;
    for(auto& func: ctx.GetFunctions()) {
        for(auto block : *func) {
            for(mylist<RISCVBasicBlock, RISCVMIR>::iterator it=block->begin(); it!=block->end(); ++it) {
                RISCVMIR* inst = *it;
                ISA opcode = inst->GetOpcode();
                if(opcode==ISA::mv) mvLegalize(it);
                else if(opcode==ISA::call||opcode==ISA::ret) break;

                for(int i=0; i<inst->GetOperandSize(); i++){
                    RISCVMOperand* oprand = inst->GetOperand(i);
                    if(dynamic_cast<RISCVFrameObject*>(oprand)) 
                        freamobjLegalize(i, it);
                    else if(dynamic_cast<StackRegister*>(oprand)) 
                        stackOffsetLegalize(i, it);
                }
            }
        }
    } 
    LegalizeConstInt lcint(ctx);
    lcint.run();
}
void Legalize::mvLegalize(mylist<RISCVBasicBlock, RISCVMIR>::iterator& it) {
    using PhyReg = PhyRegister::PhyReg;
    using ISA = RISCVMIR::RISCVISA;
    RISCVMIR* inst = *it;
    RISCVMIR* ld = nullptr;
    VirRegister* vreg = nullptr;
    if(StackRegister* reg = dynamic_cast<StackRegister*>(inst->GetOperand(0))) {
        // mv .1 off(s0) =>
        // ld .2 off(s0)
        // mv .1 .2
        ld = new RISCVMIR(ISA::_ld);
        if(reg->GetParent()!=nullptr) {
            switch(reg->GetParent()->GetContextType()){
                case RISCVType::riscv_i32:
                    vreg = ctx.createVReg(riscv_i32);
                    break;
                case RISCVType::riscv_float32:
                    vreg = ctx.createVReg(riscv_float32);
                    break;
                case RISCVType::riscv_ptr:
                    vreg = ctx.createVReg(riscv_ptr);
                    break;
                default:
                    assert(false);
            }
        } 
        else vreg = ctx.createVReg(riscv_ptr);

        ld->SetDef(vreg);
        ld->AddOperand(inst->GetOperand(0));
        it.insert_before(ld);
        inst->SetOperand(0, ld->GetDef());
    }
    else if(RISCVFrameObject* obj = dynamic_cast<RISCVFrameObject*>(inst->GetOperand(0))) {
        ld = new RISCVMIR(ISA::_ld);
        switch(obj->GetType()){
            case RISCVType::riscv_i32:
                vreg = ctx.createVReg(riscv_i32);
                break;
            case RISCVType::riscv_float32:
                vreg = ctx.createVReg(riscv_float32);
                break;
            case RISCVType::riscv_ptr:
                vreg = ctx.createVReg(riscv_ptr);
                break;
            default:
                assert(false);
        }
        ld->SetDef(vreg);
        ld->AddOperand(inst->GetOperand(0));
        it.insert_before(ld);
        inst->SetOperand(0, ld->GetDef());
    }
    else if (LARegister* reg = dynamic_cast<LARegister*>(inst->GetOperand(0))) {
        ld = new RISCVMIR(ISA::_ld);
        vreg = ctx.createVReg(riscv_ptr);
        ld->SetDef(vreg);
        ld->AddOperand(inst->GetOperand(0));
        it.insert_before(ld);
        inst->SetOperand(0, ld->GetDef());
    }
    
}
void Legalize::freamobjLegalize(int i, mylist<RISCVBasicBlock, RISCVMIR>::iterator& it) {
    RISCVMIR* inst = *it;
    StackRegister* sreg = dynamic_cast<RISCVFrameObject*>(inst->GetOperand(i))->GetStackReg();
    int offset = sreg->GetOffset();
    if(offset>=-2048&&offset<=2047) {
        return;
    }
    else {
        int mod = offset%2047;
        offset = offset - mod;
        RISCVMIR* addiw = new RISCVMIR(RISCVMIR::_addiw);
        VirRegister* vreg = ctx.createVReg(riscv_ptr);
        Imm* imm = new Imm(ConstIRInt::GetNewConstant(offset));
        addiw->SetDef(vreg);
        addiw->AddOperand(sreg->GetReg());
        addiw->AddOperand(imm);
        it.insert_before(addiw);
        sreg->SetOffset(mod);
        sreg->SetReg(dynamic_cast<Register*>(addiw->GetDef()));
        inst->SetOperand(i, sreg);
    } 
}
void Legalize::stackOffsetLegalize(int i, mylist<RISCVBasicBlock, RISCVMIR>::iterator& it) {
    RISCVMIR* inst = *it;
    StackRegister* sreg = dynamic_cast<StackRegister*>(inst->GetOperand(i));
    int offset = sreg->GetOffset();
    if(offset>=-2048&&offset<=2047) {
        return;
    }
    else {
        int mod = offset%2047;
        offset = offset - mod;
        RISCVMIR* addiw = new RISCVMIR(RISCVMIR::_addiw);
        VirRegister* vreg = ctx.createVReg(riscv_ptr);
        Imm* imm = new Imm(ConstIRInt::GetNewConstant(offset));
        addiw->SetDef(vreg);
        addiw->AddOperand(sreg->GetReg());
        addiw->AddOperand(imm);
        it.insert_before(addiw);
        sreg->SetOffset(mod);
        sreg->SetReg(dynamic_cast<Register*>(addiw->GetDef()));
    } 
}

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
        } else if (mod >=2048 && mod <4096) {
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
        } else if (mod>=-4095&&mod<-2048) {
            VirRegister* vreg = ctx.createVReg(RISCVType::riscv_i32);
            Imm* const_imm = new Imm(ConstIRInt::GetNewConstant(inttemp-mod-4096));
            RISCVMIR* li = new RISCVMIR(RISCVMIR::RISCVISA::li);
            li->SetDef(vreg);
            li->AddOperand(const_imm);
            it.insert_before(li);
            Imm* mod_imm = new Imm(ConstIRInt::GetNewConstant(mod+4096));
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
        } else assert(0&&"error imm");
    }
}

bool LegalizeConstInt::run() {
    using PhyReg = PhyRegister::PhyReg;
    using ISA = RISCVMIR::RISCVISA;
    for(auto& func : ctx.GetFunctions()) {
        for(auto block : *func) {
            for(mylist<RISCVBasicBlock,RISCVMIR>::iterator it=block->begin();it!=block->end();++it) {
                RISCVMIR* inst = *it;
                for(int i=0; i<inst->GetOperandSize(); i++) {
                    if(Imm* constdata = dynamic_cast<Imm*>(inst->GetOperand(i))) {
                        if(ConstIRInt* constint = dynamic_cast<ConstIRInt*>(constdata->Getdata())) {
                            if(constint->GetVal() == 0 && inst->GetOpcode()!=ISA::li && inst->GetOpcode()!=ISA::mv) {
                                PhyRegister* zero = PhyRegister::GetPhyReg(PhyReg::zero);
                                inst->SetOperand(i,zero);
                                break;
                            }
                            if(inst->GetOpcode()>ISA::BeginBranch && inst->GetOpcode()<ISA::EndBranch) {
                                RISCVMIR* li = new RISCVMIR(ISA::li);
                                VirRegister* vreg = ctx.createVReg(RISCVType::riscv_i32);
                                li->SetDef(vreg);
                                li->AddOperand(constdata);
                                it.insert_before(li);
                                inst->SetOperand(i, li->GetDef());
                                break;
                            }
                            // real legalize
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
    else if(opcode == ISA::li) inst->SetMopcode(ISA::mv);
    else if(opcode == ISA::_sw||opcode == ISA::_sd||opcode == ISA::_sh||opcode == ISA::_sb) {}
    else assert(0&&"Invalid MOpcode type");
}

