#include "../include/backend/LegalizePass.hpp"
#include "../include/backend/RISCVAsmPrinter.hpp"
#include <cstring>
Legalize::Legalize(RISCVLoweringContext& _ctx) :ctx(_ctx) {}

void Legalize::run() {
    // fold 2 stackreg
    {
        auto func=ctx.GetCurFunction();
        for(auto block:*func){
            for(auto inst:*block){
                auto opcode=inst->GetOpcode();
                if(RISCVMIR::BeginLoadMem<opcode&&opcode<RISCVMIR::EndLoadMem
                ||RISCVMIR::BeginFloatLoadMem<opcode&&opcode<RISCVMIR::EndFloatLoadMem){
                    if(auto preg=inst->GetOperand(0)->as<PhyRegister>()){
                        // turn it into stackreg
                        auto sreg=new StackRegister(preg->Getregenum(),0);
                        inst->SetOperand(0,sreg);
                    }
                }
                else if(RISCVMIR::BeginStoreMem<opcode&&opcode<RISCVMIR::EndStoreMem
                ||RISCVMIR::BeginFloatStoreMem<opcode&&opcode<RISCVMIR::EndFloatStoreMem){
                    if(auto preg=inst->GetOperand(1)->as<PhyRegister>()){
                        // turn it into stackreg
                        auto sreg=new StackRegister(preg->Getregenum(),0);
                        inst->SetOperand(1,sreg);
                    }
                }
            }
        }
    }

    // 伪指令变成非伪指令
    {
        auto func=ctx.GetCurFunction();
        for(auto block:*func){
            for(auto it=block->begin();it!=block->end();){
                auto inst=*it;
                auto opcode=inst->GetOpcode();
                switch (opcode)
                {
                case RISCVMIR::LoadGlobalAddr:
                {
                    // reg = LoadGlobalAddr globalvar
                    // lui reg, %hi(globalvar)
                    // addi reg, reg, %lo(globalvar)
                    
                    auto getTagName=[&](){
                        if(auto glob=inst->GetOperand(0)->as<globlvar>()){
                            return glob->GetName();
                        }
                        else if(auto tag=inst->GetOperand(0)->as<OuterTag>()){
                            return tag->GetName();
                        }
                        else assert(0&&"GG in get global address");
                    };
                    // assert(glob!=nullptr);
                    auto name=getTagName();
                    auto hi=new LARegister(riscv_ptr,name,LARegister::hi);
                    auto lo=new LARegister(riscv_ptr,name,LARegister::lo);
                    auto reg=inst->GetDef()->as<Register>();
                    assert(reg!=nullptr);
                    RISCVMIR* lui=new RISCVMIR(RISCVMIR::_lui);
                    lui->SetDef(reg);
                    lui->AddOperand(hi);
                    RISCVMIR* addi=new RISCVMIR(RISCVMIR::_addi);
                    addi->SetDef(reg);
                    addi->AddOperand(reg);
                    addi->AddOperand(lo);
                    it.insert_before(lui);
                    it.insert_before(addi);
                    it=mylist<RISCVBasicBlock,RISCVMIR>::iterator(addi);
                    delete inst;
                    break;
                }
                case RISCVMIR::LoadLocalAddr:
                {
                    // reg = LoadLocalAddr frameobj
                    // addi reg, s0, offset
                    auto frameobj=inst->GetOperand(0)->as<RISCVFrameObject>();
                    auto stackreg=frameobj->GetStackReg();
                    auto reg=inst->GetDef()->as<Register>();
                    assert(reg!=nullptr);
                    RISCVMIR* addi=new RISCVMIR(RISCVMIR::_addi);
                    addi->SetDef(reg);
                    addi->AddOperand(stackreg->GetReg());
                    addi->AddOperand(Imm::GetImm(ConstIRInt::GetNewConstant(stackreg->GetOffset())));
                    it.insert_before(addi);
                    it=mylist<RISCVBasicBlock,RISCVMIR>::iterator(addi);
                    delete inst;
                    break;
                }
                case RISCVMIR::LoadImmReg:
                {
                    auto imm=inst->GetOperand(0)->as<Imm>();
                    auto isfloatconst=imm->GetType()==RISCVType::riscv_float32;
                    if(isfloatconst){
                        auto fval=imm->Getdata()->as<ConstIRFloat>()->GetVal();
                        int initval;
                        std::memcpy(&initval,&fval,sizeof(float));

                        auto liinst=new RISCVMIR(RISCVMIR::li);
                        liinst->SetDef(PhyRegister::GetPhyReg(PhyRegister::t0));
                        liinst->AddOperand(Imm::GetImm(ConstIRInt::GetNewConstant(initval)));

                        auto fmvwx=new RISCVMIR(RISCVMIR::_fmv_w_x);
                        // auto defreg=ctx.createVReg(riscv_float32);
                        fmvwx->SetDef(inst->GetDef());
                        fmvwx->AddOperand(PhyRegister::GetPhyReg(PhyRegister::t0));

                        it=mylist<RISCVBasicBlock,RISCVMIR>::iterator(inst);
                        it.insert_before(liinst);
                        it.insert_before(fmvwx);
                        delete inst;
                        it=mylist<RISCVBasicBlock,RISCVMIR>::iterator(fmvwx);
                        break;
                    }
                    else{
                        inst->SetMopcode(RISCVMIR::li);
                    }
                }
                default:
                    break;
                }
                ++it;
            }
        }
    }

    // Legalize StackReg and StackReg in FrameObj outof memory inst
    // Offset Legalize of StackReg and StackReg in FrameObj

    // Legalize const int => zero Legalize
    //                    => branch Legalize
    //                    => const int Legalize
    int legalizetime=2, time = 0;
    while(time < legalizetime) {
        RISCVFunction* func = ctx.GetCurFunction();
        for(auto block : *(func)) {
            for(mylist<RISCVBasicBlock, RISCVMIR>::iterator it=block->begin(); it!=block->end(); ++it) {
                LegalizePass(it);
            } 
        }
        for(mylist<RISCVBasicBlock, RISCVMIR>::iterator it=func->GetExit()->begin(); it!=func->GetExit()->end(); ++it) {
            LegalizePass(it);
        }
        time++;
    }
}
void Legalize::run_beforeRA() {
    int legalizetime=2, time = 0;
    while(time < legalizetime) {
        RISCVFunction* func = ctx.GetCurFunction();
        for(auto block : *(func)) {
            for(mylist<RISCVBasicBlock, RISCVMIR>::iterator it=block->begin(); it!=block->end(); ++it) {
                LegalizePass_before(it);
            } 
        }
        for(mylist<RISCVBasicBlock, RISCVMIR>::iterator it=func->GetExit()->begin(); it!=func->GetExit()->end(); ++it) {
            LegalizePass_before(it);
        }
        time++;
    }
}
void Legalize::run_afterRA() {
    int legalizetime=2, time = 0;
    while(time < legalizetime) {
        RISCVFunction* func = ctx.GetCurFunction();
        for(auto block : *(func)) {
            for(mylist<RISCVBasicBlock, RISCVMIR>::iterator it=block->begin(); it!=block->end(); ++it) {
                LegalizePass_after(it);
            } 
        }
        for(mylist<RISCVBasicBlock, RISCVMIR>::iterator it=func->GetExit()->begin(); it!=func->GetExit()->end(); ++it) {
            LegalizePass_after(it);
        }
        time++;
    }
}
void Legalize::LegalizePass(mylist<RISCVBasicBlock, RISCVMIR>::iterator it) {
    using PhyReg = PhyRegister::PhyReg;
    using ISA = RISCVMIR::RISCVISA;
    RISCVMIR* inst = *it;
    ISA opcode = inst->GetOpcode();
    if(opcode==ISA::call||opcode==ISA::ret) {return;}
    for(int i=0; i<inst->GetOperandSize(); i++){
        RISCVMOperand* oprand = inst->GetOperand(i);
        // StackReg and Frameobj out memory inst
        RISCVFrameObject* framobj = dynamic_cast<RISCVFrameObject*>(oprand);
        StackRegister* sreg = dynamic_cast<StackRegister*>(oprand);
        if(framobj||sreg) {
            // load .1 offset(s0)
            //             ^
            if(i==0&&((opcode>ISA::BeginLoadMem&&opcode<ISA::EndLoadMem)\
            ||(opcode>ISA::BeginFloatLoadMem&&opcode<ISA::EndFloatLoadMem))) {
                OffsetLegalize(i, it);
            }
            // store .1 offset(s0)
            //             ^
            else if(i==1&&((opcode>ISA::BeginStoreMem&&opcode<ISA::EndStoreMem)\
            ||(opcode>ISA::BeginFloatStoreMem&&opcode<ISA::EndFloatStoreMem))) {
                OffsetLegalize(i, it);
            }
            else StackAndFrameLegalize(i, it);
        } 
        // Imm
        if(Imm* constdata = dynamic_cast<Imm*>(inst->GetOperand(i))) {
            // const int 
            if(ConstIRInt* constint = dynamic_cast<ConstIRInt*>(constdata->Getdata())) {
                // const int 0
                if(constdata->Getdata()->isZero() && !isImminst(opcode)) { 
                    zeroLegalize(i, it);
                    continue;
                }
                // branch inst with const int
                if(opcode>ISA::BeginBranch && opcode<ISA::EndBranch) {
                    branchLegalize(i, it);
                    continue;
                }
                if(!isImminst(opcode)) {
                    noImminstLegalize(i, it);
                    continue;
                }
                if(opcode!=RISCVMIR::li)
                    constintLegalize(i, it);
            }
        }
    } // End Operand For Loop
}
void Legalize::LegalizePass_before(mylist<RISCVBasicBlock, RISCVMIR>::iterator it) {
    using PhyReg = PhyRegister::PhyReg;
    using ISA = RISCVMIR::RISCVISA;
    RISCVMIR* inst = *it;
    ISA opcode = inst->GetOpcode();
    if(opcode==ISA::call||opcode==ISA::ret) {return;}
    for(int i=0; i<inst->GetOperandSize(); i++){
        RISCVMOperand* oprand = inst->GetOperand(i);
        // StackReg and Frameobj out memory inst
        RISCVFrameObject* framobj = dynamic_cast<RISCVFrameObject*>(oprand);
        StackRegister* sreg = dynamic_cast<StackRegister*>(oprand);
        if(framobj||sreg) {
            StackAndFrameLegalize(i, it);
        } 
    }
}

void Legalize::LegalizePass_after(mylist<RISCVBasicBlock, RISCVMIR>::iterator it) {
    using PhyReg = PhyRegister::PhyReg;
    using ISA = RISCVMIR::RISCVISA;
    RISCVMIR* inst = *it;
    ISA opcode = inst->GetOpcode();
    if(opcode==ISA::call||opcode==ISA::ret) {return;}
    for(int i=0; i<inst->GetOperandSize(); i++){
        RISCVMOperand* oprand = inst->GetOperand(i);
        // StackReg and Frameobj out memory inst
        RISCVFrameObject* framobj = dynamic_cast<RISCVFrameObject*>(oprand);
        StackRegister* sreg = dynamic_cast<StackRegister*>(oprand);
        if(framobj||sreg) {
            // load .1 offset(s0)
            //             ^
            if(i==0&&((opcode>ISA::BeginLoadMem&&opcode<ISA::EndLoadMem)\
            ||(opcode>ISA::BeginFloatLoadMem&&opcode<ISA::EndFloatLoadMem))) {
                OffsetLegalize(i, it);
            }
            // store .1 offset(s0)
            //             ^
            else if(i==1&&((opcode>ISA::BeginStoreMem&&opcode<ISA::EndStoreMem)\
            ||(opcode>ISA::BeginFloatStoreMem&&opcode<ISA::EndFloatStoreMem))) {
                OffsetLegalize(i, it);
            }
        } 

        // Imm
        if(Imm* constdata = dynamic_cast<Imm*>(inst->GetOperand(i))) {
            // const int 
            if(ConstIRInt* constint = dynamic_cast<ConstIRInt*>(constdata->Getdata())) {
                // const int 0
                if(constdata->Getdata()->isZero() && !isImminst(opcode)) { 
                    zeroLegalize(i, it);
                    continue;
                }
                // branch inst with const int
                if(opcode>ISA::BeginBranch && opcode<ISA::EndBranch) {
                    branchLegalize(i, it);
                    continue;
                }
                if(!isImminst(opcode)) {
                    noImminstLegalize(i, it);
                    continue;
                }
                constintLegalize(i, it);
            }
        }
    } // End Operand For Loop
}
void Legalize::StackAndFrameLegalize(int i,mylist<RISCVBasicBlock, RISCVMIR>::iterator& it) {
    RISCVMIR* inst = *it;
    StackRegister* sreg = nullptr;
    if(sreg = dynamic_cast<StackRegister*>(inst->GetOperand(i))) {}
    else if(RISCVFrameObject* obj = dynamic_cast<RISCVFrameObject*>(inst->GetOperand(i))) {
        sreg = dynamic_cast<RISCVFrameObject*>(obj)->GetStackReg();
    }
    RISCVMIR* addi = new RISCVMIR(RISCVMIR::_addi);
    PhyRegister* t0 = PhyRegister::GetPhyReg(PhyRegister::t0);
    // VirRegister* vreg = ctx.createVReg(riscv_ptr);
    // addi->SetDef(vreg);
    addi->SetDef(t0);
    addi->AddOperand(sreg->GetReg());
    Imm* imm = new Imm(ConstIRInt::GetNewConstant(sreg->GetOffset()));
    addi->AddOperand(imm);
    it.insert_before(addi);
    inst->SetOperand(i, addi->GetDef());
}

void Legalize::OffsetLegalize(int i, mylist<RISCVBasicBlock, RISCVMIR>::iterator& it) {
    RISCVMIR* inst = *it;
    StackRegister* sreg = nullptr;
    if(sreg = dynamic_cast<StackRegister*>(inst->GetOperand(i))) {}
    else if(RISCVFrameObject* obj = dynamic_cast<RISCVFrameObject*>(inst->GetOperand(i))) {
        sreg = obj->GetStackReg();
    }
    int offset = sreg->GetOffset();
    if(offset>=-2048&&offset<=2047) {
        return;
    }
    else {
        RISCVMIR* li = new RISCVMIR(RISCVMIR::li);
        li->AddOperand(Imm::GetImm(ConstIRInt::GetNewConstant(offset)));
        li->SetDef(PhyRegister::GetPhyReg(PhyRegister::t0));

        RISCVMIR* add = new RISCVMIR(RISCVMIR::_add);
        add->AddOperand(li->GetDef());
        add->AddOperand(sreg->GetReg());
        add->SetDef(PhyRegister::GetPhyReg(PhyRegister::t0));

        it.insert_before(li);
        it.insert_before(add);

        StackRegister* newStackReg = new StackRegister(PhyRegister::t0,0);
        inst->SetOperand(i, newStackReg);
    } 
}

void Legalize::zeroLegalize(int i, mylist<RISCVBasicBlock, RISCVMIR>::iterator& it) {
    RISCVMIR* inst = *it;
    PhyRegister* zero = PhyRegister::GetPhyReg(PhyRegister::zero);
    inst->SetOperand(i,zero);
}

void Legalize::branchLegalize(int i, mylist<RISCVBasicBlock, RISCVMIR>::iterator& it) {
    RISCVMIR* inst = *it;
    RISCVMIR* li = new RISCVMIR(RISCVMIR::li);
    // VirRegister* vreg = ctx.createVReg(RISCVType::riscv_i32);
    PhyRegister* t0 = PhyRegister::GetPhyReg(PhyRegister::t0);
    Imm* imm = dynamic_cast<Imm*>(inst->GetOperand(i));
    li->SetDef(t0);
    li->AddOperand(imm);
    it.insert_before(li);
    inst->SetOperand(i, li->GetDef());
}

void Legalize::noImminstLegalize(int i, mylist<RISCVBasicBlock, RISCVMIR>::iterator& it) {
    RISCVMIR* inst = *it;
    Imm* constdata = dynamic_cast<Imm*>(inst->GetOperand(i));
    int val = dynamic_cast<ConstIRInt*>(constdata->Getdata())->GetVal();
    if(val>=-2048 && val<2048) {
        if(inst->GetOpcode() == RISCVMIR::mv) {
            inst->SetMopcode(RISCVMIR::RISCVISA::li); 
            return;
        }
    }
    RISCVMIR* li = new RISCVMIR(RISCVMIR::li);
    // VirRegister* vreg = ctx.createVReg(riscv_i32);
    // t1 here
    PhyRegister* t0 = PhyRegister::GetPhyReg(PhyRegister::t1);
    li->SetDef(t0);
    li->AddOperand(constdata);
    it.insert_before(li);
    inst->SetOperand(i, li->GetDef());
}

void Legalize::constintLegalize(int i, mylist<RISCVBasicBlock, RISCVMIR>::iterator& it) {
    RISCVMIR* inst = *it;
    Imm* constdata = dynamic_cast<Imm*>(inst->GetOperand(i));
    // actually t1 here
    PhyRegister* t0 = PhyRegister::GetPhyReg(PhyRegister::t1);
    int inttemp = dynamic_cast<ConstIRInt*>(constdata->Getdata())->GetVal();
    if(inttemp>=-2048 && inttemp<2048) {
        // if(inst->GetOpcode()==RISCVMIR::RISCVISA::mv) 
        // inst->SetMopcode(RISCVMIR::RISCVISA::li); 
        return;
    }
    else {
        auto mir= new RISCVMIR(RISCVMIR::li);
        mir->SetDef(PhyRegister::GetPhyReg(PhyRegister::t0));
        mir->AddOperand(constdata);
        it.insert_before(mir);
        inst->SetOperand(i, PhyRegister::GetPhyReg(PhyRegister::t0));
        MOpcodeLegalize(inst);
        // int mod = inttemp % 4096;
        // if(mod==0) {
        //     if(inst->GetOpcode() == RISCVMIR::RISCVISA::li) {
        //         return;
        //     }
        //     else if(inst->GetOpcode() == RISCVMIR::RISCVISA::_addi ||\
        //             inst->GetOpcode() == RISCVMIR::RISCVISA::_addiw) {
        //         RISCVMIR* li = new RISCVMIR(RISCVMIR::RISCVISA::li);
        //         // VirRegister* vreg = new VirRegister(RISCVType::riscv_i32);
        //         li->SetDef(t0);
        //         li->AddOperand(constdata);
        //         it.insert_before(li);
        //         for(int i=0; i<inst->GetOperandSize(); i++) {
        //             if(Imm* imm = dynamic_cast<Imm*>(inst->GetOperand(i))) {
        //                 if(imm->Getdata()==constdata->Getdata()) {
        //                     inst->SetOperand(i,t0);
        //                     break;
        //                 }
        //             } 
        //         }
        //         MOpcodeLegalize(inst);
        //     }
        //     else {
        //         inst->SetMopcode(RISCVMIR::RISCVISA::li);
        //     }
        //     return;

        // } else if((mod>0&&mod<2048)||(mod>=-2048&&mod<0)) {
        //     // VirRegister* vreg = ctx.createVReg(RISCVType::riscv_i32);
        //     Imm* const_imm = new Imm(ConstIRInt::GetNewConstant(inttemp-mod));
        //     RISCVMIR* li = new RISCVMIR(RISCVMIR::RISCVISA::li);
        //     li->SetDef(t0);
        //     li->AddOperand(const_imm);
        //     it.insert_before(li);
        //     Imm* mod_imm = new Imm(ConstIRInt::GetNewConstant(mod));
        //     RISCVMIR* addi = new RISCVMIR(RISCVMIR::RISCVISA::_addi);
        //     addi->SetDef(t0);
        //     addi->AddOperand(t0);
        //     addi->AddOperand(mod_imm);
        //     it.insert_before(addi);
        //     MOpcodeLegalize(inst);
        //     for(int i=0; i<inst->GetOperandSize(); i++) {
        //         while(inst->GetOperand(i)==constdata) {
        //             inst->SetOperand(i,t0);
        //             return;
        //         }
        //     }
        // } else if (mod >=2048 && mod <4096) {
        //     // VirRegister* vreg = ctx.createVReg(RISCVType::riscv_i32);
        //     Imm* const_imm = new Imm(ConstIRInt::GetNewConstant(inttemp-mod+4096));
        //     RISCVMIR* li = new RISCVMIR(RISCVMIR::RISCVISA::li);
        //     li->SetDef(t0);
        //     li->AddOperand(const_imm);
        //     it.insert_before(li);
        //     Imm* mod_imm = new Imm(ConstIRInt::GetNewConstant(mod-4096));
        //     RISCVMIR* addi = new RISCVMIR(RISCVMIR::RISCVISA::_addi);
        //     addi->SetDef(t0);
        //     addi->AddOperand(t0);
        //     addi->AddOperand(mod_imm);
        //     it.insert_before(addi);
        //     MOpcodeLegalize(inst);
        //     for(int i=0; i<inst->GetOperandSize(); i++) {
        //         while(inst->GetOperand(i)==constdata) {
        //             inst->SetOperand(i,t0);
        //             return;
        //         }
        //     }
        // } else if (mod>=-4095&&mod<-2048) {
        //     // VirRegister* vreg = ctx.createVReg(RISCVType::riscv_i32);
        //     Imm* const_imm = new Imm(ConstIRInt::GetNewConstant(inttemp-mod-4096));
        //     RISCVMIR* li = new RISCVMIR(RISCVMIR::RISCVISA::li);
        //     li->SetDef(t0);
        //     li->AddOperand(const_imm);
        //     it.insert_before(li);
        //     Imm* mod_imm = new Imm(ConstIRInt::GetNewConstant(mod+4096));
        //     RISCVMIR* addi = new RISCVMIR(RISCVMIR::RISCVISA::_addi);
        //     addi->SetDef(t0);
        //     addi->AddOperand(t0);
        //     addi->AddOperand(mod_imm);
        //     it.insert_before(addi);
        //     MOpcodeLegalize(inst);
        //     for(int i=0; i<inst->GetOperandSize(); i++) {
        //         while(inst->GetOperand(i)==constdata) {
        //             inst->SetOperand(i,t0);
        //             return;
        //         }
        //     }
        // } else assert(0&&"error imm");
    }
}

void Legalize::MOpcodeLegalize(RISCVMIR* inst) {
    using ISA = RISCVMIR::RISCVISA;
    ISA& opcode = inst->GetOpcode();
    if(opcode == ISA::_slli) inst->SetMopcode(ISA::_sll);
    else if(opcode == ISA::_slliw) inst->SetMopcode(ISA::_sllw);
    else if(opcode == ISA::_srli) inst->SetMopcode(ISA::_srl);
    else if(opcode == ISA::_srliw) inst->SetMopcode(ISA::_srlw);
    else if(opcode == ISA::_srai) inst->SetMopcode(ISA::_sra);
    else if(opcode == ISA::_sraiw) inst->SetMopcode(ISA::_sraw);
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

bool Legalize::isImminst(RISCVMIR::RISCVISA opcode)
{
    if(opcode == RISCVMIR::_slli ||
       opcode == RISCVMIR::_slliw ||
       opcode == RISCVMIR::_srli ||
       opcode == RISCVMIR::_srliw ||
       opcode == RISCVMIR::_srai ||
       opcode == RISCVMIR::_sraiw ||
       opcode == RISCVMIR::_addi ||
       opcode == RISCVMIR::_addiw ||
       opcode == RISCVMIR::_xori ||
       opcode == RISCVMIR::_ori ||
       opcode == RISCVMIR::_andi ||
       opcode == RISCVMIR::_slti ||
       opcode == RISCVMIR::_sltiu ||
       opcode == RISCVMIR::li) 
    return true;
    else return false;
}