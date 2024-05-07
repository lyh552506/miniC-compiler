#include "RISCVISel.hpp"
#include "RISCVMIR.hpp"

RISCVMIR* RISCVISel::Builder(RISCVMIR::RISCVISA _isa,User* inst){
    auto minst=new RISCVMIR(_isa);
    minst->SetDef(ctx.mapping(inst));
    for(int i=0;i<inst->Getuselist().size();i++)
        minst->AddOperand(ctx.mapping(inst->GetOperand(i)));
    return minst;
}
RISCVMIR* RISCVISel::Builder_withoutDef(RISCVMIR::RISCVISA _isa,User* inst){
    auto minst=new RISCVMIR(_isa);
    for(int i=0;i<inst->Getuselist().size();i++)
        minst->AddOperand(ctx.mapping(inst->GetOperand(i)));
    return minst;
}
RISCVMIR* RISCVISel::Builder_withoutDef(RISCVMIR::RISCVISA _isa,std::initializer_list<RISCVMOperand*> list) {
    auto minst=new RISCVMIR(_isa);
    for(auto it=list.begin(); it!=list.end(); ++it) {
        RISCVMOperand* i=*it;
        minst->AddOperand(i);
    }
    return minst;    
}

RISCVMIR* RISCVISel::Builder(RISCVMIR::RISCVISA _isa,std::initializer_list<RISCVMOperand*> list){
    auto minst=new RISCVMIR(_isa);
    minst->SetDef(list.begin()[0]); 
    for(auto it=list.begin()+1; it!=list.end(); ++it) {
        RISCVMOperand* i=*it;
        minst->AddOperand(i);
    }
    return minst;
}

bool RISCVISel::run(Function* m){
    if(m->GetParams().size()!=0) {
        RISCVBasicBlock* entry=RISCVBasicBlock::CreateRISCVBasicBlock();
        RISCVLoweringContext& ctx=this->ctx;
        ctx(entry);
        LowerFormalArguments(m,ctx);
        ctx.mapping(m->front())->as<RISCVBasicBlock>();
        RISCVMIR* uncondinst = new RISCVMIR(RISCVMIR::RISCVISA::_j);
        uncondinst->AddOperand(ctx.mapping(m->front())->as<RISCVBasicBlock>());
        entry->push_back(uncondinst);
    }
    for(auto i:*m){
        ctx(ctx.mapping(i)->as<RISCVBasicBlock>());
        for(auto inst:*i)
            InstLowering(inst);
    }
    return true;
}

void RISCVISel::InstLowering(AllocaInst* inst){
    ctx.mapping(inst);
}

void RISCVISel::InstLowering(StoreInst* inst){
    if(inst->GetOperand(0)->GetType()==IntType::NewIntTypeGet()) {
        if(ConstIRInt* Intconst = dynamic_cast<ConstIRInt*>(inst->GetOperand(0))) {
            auto minst=new RISCVMIR(RISCVMIR::_sw);
            minst->AddOperand(Li_Intimm(Intconst));
            minst->AddOperand(ctx.mapping(inst->GetOperand(1)));
            ctx(minst);
        }
        else {
            auto minst=new RISCVMIR(RISCVMIR::_sw);
            for(int i=0;i<inst->Getuselist().size();i++)
                minst->AddOperand(ctx.mapping(inst->GetOperand(i)));
            ctx(minst);
        }
    }
    else if(inst->GetOperand(0)->GetType()==FloatType::NewFloatTypeGet()) {
        if(ConstIRFloat* Floatconst = dynamic_cast<ConstIRFloat*>(inst->GetOperand(0))) {
            auto minst=new RISCVMIR(RISCVMIR::_fsw);
            minst->AddOperand(new Imm(Floatconst));
            minst->AddOperand(ctx.mapping(inst->GetOperand(1)));
            ctx(minst);
        }
        else {
            auto minst=new RISCVMIR(RISCVMIR::_fsw);
            for(int i=0;i<inst->Getuselist().size();i++)
                minst->AddOperand(ctx.mapping(inst->GetOperand(i)));
            ctx(minst);
        }
    }
    else assert("invalid store type");
}

void RISCVISel::InstLowering(LoadInst* inst){
    if(inst->GetOperand(0)->GetType()==PointerType::NewPointerTypeGet(IntType::NewIntTypeGet())) {
        ctx(Builder(RISCVMIR::_lw,inst));
    }
    else if(inst->GetOperand(0)->GetType()==PointerType::NewPointerTypeGet(FloatType::NewFloatTypeGet()))
        ctx(Builder(RISCVMIR::_flw,inst));
    else assert(0&&"invalid load type");
}

void RISCVISel::InstLowering(FPTSI* inst){
    ctx(Builder(RISCVMIR::_fcvt_w_s,inst));
}

void RISCVISel::InstLowering(SITFP* inst){
    ctx(Builder(RISCVMIR::_fcvt_s_w,inst));
}

void RISCVISel::InstLowering(UnCondInst* inst){
    // ctx(Builder(RISCVMIR::_j,inst));
    ctx(Builder(RISCVMIR::_j, {ctx.mapping(inst->GetOperand(0))}));
}

void RISCVISel::InstLowering(CondInst* inst){
    #define M(x) ctx.mapping(x)
    auto cond=inst->GetOperand(0)->as<BinaryInst>();
    assert(cond!=nullptr&&"Invalid Condition");
    // assert((cond->GetOperand(0)->GetType()==BoolType::NewBoolTypeGet())&&"Invalid Condition Type");
    assert((cond->GetDef()->GetType()==BoolType::NewBoolTypeGet())&&"Invalid Condition Type");
    if(cond->GetOperand(0)->GetType()==IntType::NewIntTypeGet()){
        switch (cond->getopration())
        {
            case BinaryInst::Op_L:
            {
                auto fi=Builder_withoutDef(RISCVMIR::_blt,{M(cond->GetOperand(0)),M(cond->GetOperand(1)),M(inst->GetOperand(1))});
                auto se=Builder_withoutDef(RISCVMIR::_j,{M(inst->GetOperand(2))});
                ctx(fi);
                ctx(se);
                break;
            }
            case BinaryInst::Op_LE:
            {
                auto fi=Builder_withoutDef(RISCVMIR::_bge,{M(cond->GetOperand(1)),M(cond->GetOperand(0)),M(inst->GetOperand(1))});
                auto se=Builder_withoutDef(RISCVMIR::_j,{M(inst->GetOperand(2))});
                ctx(fi);
                ctx(se);
                break;
            }
            case BinaryInst::Op_G:
            {
                auto fi=Builder_withoutDef(RISCVMIR::_blt,{M(cond->GetOperand(1)),M(cond->GetOperand(0)),M(inst->GetOperand(1))});
                auto se=Builder_withoutDef(RISCVMIR::_j,{M(inst->GetOperand(2))});
                ctx(fi);
                ctx(se);
                break;
            }
            case BinaryInst::Op_GE:
            {
                auto fi=Builder_withoutDef(RISCVMIR::_bge,{M(cond->GetOperand(0)),M(cond->GetOperand(1)),M(inst->GetOperand(1))});
                auto se=Builder_withoutDef(RISCVMIR::_j,{M(inst->GetOperand(2))});
                ctx(fi);
                ctx(se);
                break;
            }
            case BinaryInst::Op_E:
            {    
                auto fi=Builder_withoutDef(RISCVMIR::_beq,{M(cond->GetOperand(0)),M(cond->GetOperand(1)),M(inst->GetOperand(1))});
                auto se=Builder_withoutDef(RISCVMIR::_j,{M(inst->GetOperand(2))});
                ctx(fi);
                ctx(se);
                break;
            }
            case BinaryInst::Op_NE:
            {
                auto fi=Builder_withoutDef(RISCVMIR::_bne,{M(cond->GetOperand(0)),M(cond->GetOperand(1)),M(inst->GetOperand(1))});
                auto se=Builder_withoutDef(RISCVMIR::_j,{M(inst->GetOperand(2))});
                ctx(fi);
                ctx(se);
                break;
            }
            case BinaryInst::Op_Or:
            {
                assert("Or will not appear in IR");
                break;
            }
            case BinaryInst::Op_And:
            {
                assert("And will not appear in IR");
                break;
            }
            default:
                break;
        }
    }
    else if (cond->GetOperand(0)->GetType()==FloatType::NewFloatTypeGet()) {
        switch (cond->getopration())
        {
            case BinaryInst::Op_L:
            {
                auto condi=Builder(RISCVMIR::_flt_s,cond);
                auto fi=Builder_withoutDef(RISCVMIR::_beq,{M(cond->GetDef()),PhyRegister::GetPhyReg(PhyRegister::PhyReg::zero),M(inst->GetOperand(1))});
                auto se=Builder_withoutDef(RISCVMIR::_j,{M(inst->GetOperand(2))});
                ctx(condi);
                ctx(fi);
                ctx(se);
                break;
            }
            case BinaryInst::Op_LE:
            {
                auto condi=Builder(RISCVMIR::_fle_s,cond);
                auto fi=Builder_withoutDef(RISCVMIR::_beq,{M(cond->GetDef()),PhyRegister::GetPhyReg(PhyRegister::PhyReg::zero),M(inst->GetOperand(1))});
                auto se=Builder_withoutDef(RISCVMIR::_j,{M(inst->GetOperand(2))});
                ctx(condi);
                ctx(fi);
                ctx(se);
                break;
            }
            case BinaryInst::Op_G:
            {
                auto condi=Builder(RISCVMIR::_fgt_s,cond);
                auto fi=Builder_withoutDef(RISCVMIR::_beq,{M(cond->GetDef()),PhyRegister::GetPhyReg(PhyRegister::PhyReg::zero),M(inst->GetOperand(1))});
                auto se=Builder_withoutDef(RISCVMIR::_j,{M(inst->GetOperand(2))});
                ctx(condi);
                ctx(fi);
                ctx(se);
                break;
            }
            case BinaryInst::Op_GE:
            {
                auto condi=Builder(RISCVMIR::_fge_s,cond);
                auto fi=Builder_withoutDef(RISCVMIR::_beq,{M(cond->GetDef()),PhyRegister::GetPhyReg(PhyRegister::PhyReg::zero),M(inst->GetOperand(1))});
                auto se=Builder_withoutDef(RISCVMIR::_j,{M(inst->GetOperand(2))});
                ctx(condi);
                ctx(fi);
                ctx(se);
                break;
            }
            case BinaryInst::Op_E:
            {    
                auto condi=Builder(RISCVMIR::_feq_s,cond);
                auto fi=Builder_withoutDef(RISCVMIR::_beq,{M(cond->GetDef()),PhyRegister::GetPhyReg(PhyRegister::PhyReg::zero),M(inst->GetOperand(1))});
                auto se=Builder_withoutDef(RISCVMIR::_j,{M(inst->GetOperand(2))});
                ctx(condi);
                ctx(fi);
                ctx(se);
                break;
            }
            case BinaryInst::Op_NE:
            {
                auto condi=Builder(RISCVMIR::_feq_s,cond);
                auto fi=Builder_withoutDef(RISCVMIR::_beq,{M(cond->GetDef()),PhyRegister::GetPhyReg(PhyRegister::PhyReg::zero),M(inst->GetOperand(2))});
                auto se=Builder_withoutDef(RISCVMIR::_j,{M(inst->GetOperand(1))});
                ctx(condi);
                ctx(fi);
                ctx(se);
                break;
            }
            case BinaryInst::Op_Or:
            {
                assert("Or will not appear in IR");
                break;
            }
            case BinaryInst::Op_And:
            {
                assert("And will not appear in IR");
                break;
            }
            default:
                break;
        }
    } else{
        assert(0&&"Invalid cmp");
    }
    #undef M
}

void RISCVISel::InstLowering(BinaryInst* inst){
    if(inst->getopration()<BinaryInst::Op_And){
        RISCVMIR* result;
        switch (inst->getopration())
        {
        case BinaryInst::Op_Add:
        {
            if(inst->GetType()==IntType::NewIntTypeGet()) {
                if(ConstIRInt* constint = dynamic_cast<ConstIRInt*>(inst->GetOperand(1))) {
                    int inttemp = constint->GetVal();
                    if(inttemp<2048)
                        ctx(Builder(RISCVMIR::_addi,inst));
                    else if(inttemp>=2048) {
                        auto minst=new RISCVMIR(RISCVMIR::_addw);
                        minst->SetDef(ctx.mapping(inst->GetDef()));
                        minst->AddOperand(ctx.mapping(inst->GetOperand(0)));
                        minst->AddOperand(Li_Intimm(constint));
                        ctx(minst);
                    } else assert(0&&"Invalid constint in add inst"); 
                } else 
                    ctx(Builder(RISCVMIR::_addw,inst));
            } else if(inst->GetType()==FloatType::NewFloatTypeGet()) {
                ctx(Builder(RISCVMIR::_fadd_s,inst));
            }
            else assert("Illegal!");
            break;
        }
        case BinaryInst::Op_Sub:
        {
            if(inst->GetType()==IntType::NewIntTypeGet()) {
                if(ConstIRInt* constint = dynamic_cast<ConstIRInt*>(inst->GetOperand(1))) {
                    auto minst=new RISCVMIR(RISCVMIR::_subw);
                    minst->SetDef(ctx.mapping(inst->GetDef()));
                    minst->AddOperand(ctx.mapping(inst->GetOperand(0)));
                    minst->AddOperand(Li_Intimm(constint));
                    ctx(minst);
                } else ctx(Builder(RISCVMIR::_subw,inst));
            } else if(inst->GetType()==FloatType::NewFloatTypeGet())
                ctx(Builder(RISCVMIR::_fsub_s,inst));
            else assert("Illegal!");
            break;
        }
        case BinaryInst::Op_Mul:
        {
            if(inst->GetType()==IntType::NewIntTypeGet()) {
                if(ConstIRInt* constint = dynamic_cast<ConstIRInt*>(inst->GetOperand(1))) {
                    auto minst=new RISCVMIR(RISCVMIR::_mulw);
                    minst->SetDef(ctx.mapping(inst->GetDef()));
                    minst->AddOperand(ctx.mapping(inst->GetOperand(0)));
                    minst->AddOperand(Li_Intimm(constint));
                    ctx(minst);
                } else ctx(Builder(RISCVMIR::_mulw,inst));
            } else if(inst->GetType()==FloatType::NewFloatTypeGet())
                ctx(Builder(RISCVMIR::_fmul_s,inst));
            else assert("Illegal!");
            break;
        }
        case BinaryInst::Op_Div:
        {
            if(inst->GetType()==IntType::NewIntTypeGet()) {
                if(ConstIRInt* constint = dynamic_cast<ConstIRInt*>(inst->GetOperand(1))) {
                    auto minst=new RISCVMIR(RISCVMIR::_divw);
                    minst->SetDef(ctx.mapping(inst->GetDef()));
                    minst->AddOperand(ctx.mapping(inst->GetOperand(0)));
                    minst->AddOperand(Li_Intimm(constint));
                    ctx(minst);
                } else ctx(Builder(RISCVMIR::_divw,inst));            
            } else if(inst->GetType()==FloatType::NewFloatTypeGet())
                ctx(Builder(RISCVMIR::_fdiv_s,inst));
            else assert("Illegal!");
            break;
        }
        case BinaryInst::Op_Mod:
        {
            if(inst->GetType()==IntType::NewIntTypeGet()) {
                if(ConstIRInt* constint = dynamic_cast<ConstIRInt*>(inst->GetOperand(1))) {
                    auto minst=new RISCVMIR(RISCVMIR::_remw);
                    minst->SetDef(ctx.mapping(inst->GetDef()));
                    minst->AddOperand(ctx.mapping(inst->GetOperand(0)));
                    minst->AddOperand(Li_Intimm(constint));
                    ctx(minst);
                } else ctx(Builder(RISCVMIR::_remw,inst));
            } else assert(0&&"Illegal!");
            break;
        }
        default:
            break;
        }
    }
}

void RISCVISel::InstLowering(GetElementPtrInst* inst){
    #define M(x) ctx.mapping(x)
    // cast it to multiple add and mul first 
    /// @todo 循环不变量外提很重要了这里，之后会做一个循环不变量外提的优化
    int limi=inst->Getuselist().size();
    auto baseptr=M(inst->GetOperand(0));
    auto hasSubtype=dynamic_cast<HasSubType*>(inst->GetOperand(0)->GetType());
    size_t offset=0;
    for(int i=1;i<limi;i++){
        // just make sure
        assert(hasSubtype!=nullptr&&"Impossible Here");
        size_t size=hasSubtype->GetSubType()->get_size();
        auto index=inst->GetOperand(i);
        if(index->isConst()){
            if(auto constindex=dynamic_cast<ConstIRInt*>(index))
                offset+=size*(size_t)constindex->GetVal();
            else assert("?Impossible Here");
        }
        else{
            // auto mul=Builder(RISCVMIR::_mulw,{ctx.createVReg(RISCVType::riscv_ptr),M(index),M(ConstSize_t::GetNewConstant(size))});
            // ctx(mul);
            // auto temp=ctx.createVReg(riscv_ptr);
            // ctx(Builder(RISCVMIR::_addw,{temp,baseptr,mul->GetOperand(0)}));
            // baseptr=temp;
        }
        hasSubtype=dynamic_cast<HasSubType*>(hasSubtype->GetSubType());
    }
    if(offset!=0) {}
        // ctx(Builder(RISCVMIR::_addw,{baseptr,M(ConstSize_t::GetNewConstant(offset))}));
    #undef M
}

void RISCVISel::InstLowering(PhiInst* inst){
    ///@note phi elimination not here, no op
    return;
}

void RISCVISel::InstLowering(CallInst* inst){
    // 把VReg Copy到PhyReg
    // 如果溢出则按照规约store
    // 如果有返回值则copy a0 到 VReg
    #define M(x) ctx.mapping(x)
    if(!inst->Getuselist().empty()) {
        int MAXnum = 9, paramnum=inst->Getuselist().size();
        if (paramnum > MAXnum) {
        // to do 
        // spill to stack
        // 
        }
        for (int i=1; i<std::min(paramnum, MAXnum); i++) {
            int regnum=PhyRegister::PhyReg::a0-1;
            regnum+=i;
            if(ConstIRInt* constint = dynamic_cast<ConstIRInt*>(inst->GetOperand(i))) {
                auto li = new RISCVMIR(RISCVMIR::li);
                VirRegister* vreg = ctx.createVReg(RISCVTyper(inst->GetOperand(i)->GetType()));
                li->SetDef(vreg);
                Imm* imm = new Imm(constint);
                li->AddOperand(imm);
                ctx.insert_val2mop(constint, imm);
                ctx(li);
            }
            /// @todo const float
            // else if(ConstIRFloat* constfloat = dynamic_cast<ConstIRFloat*>(inst->GetOperand(i))) {
            //     auto load = new RISCVMIR(RISCVMIR::_flw);
            //     VirRegister* vreg = ctx.createVReg(RISCVTyper(inst->GetOperand(i)->GetType()));
            //     load->SetDef(vreg);
            //     Imm* imm = new Imm(constfloat);
            //     load->AddOperand(imm);
            //     ctx.insert_val2mop(constint, imm);
            //     ctx(load);
            // }
            else if(inst->GetOperand(i)->GetType()==IntType::NewIntTypeGet()\
            || inst->GetOperand(i)->GetType()==FloatType::NewFloatTypeGet())
                ctx(Builder(RISCVMIR::mv,{PhyRegister::GetPhyReg(static_cast<PhyRegister::PhyReg>(regnum)),M(inst->GetOperand(i))}));
        }
    }
    if(!inst->GetUserlist().is_empty()){
        ctx(Builder_withoutDef(RISCVMIR::call, inst));
        ctx(Builder(RISCVMIR::mv, {ctx.mapping(inst), PhyRegister::GetPhyReg(PhyRegister::PhyReg::a0)}));
    }
    else ctx(Builder_withoutDef(RISCVMIR::call, inst));
    #undef M
}

void RISCVISel::InstLowering(RetInst* inst){
    #define M(x) ctx.mapping(x)
    if(inst->Getuselist().empty()) {
        auto minst=new RISCVMIR(RISCVMIR::ret);
        ctx(minst);
    }
    else if(inst->GetOperand(0)&&inst->GetOperand(0)->GetType()==IntType::NewIntTypeGet()) {
        ctx(Builder(RISCVMIR::_lw,{PhyRegister::GetPhyReg(PhyRegister::PhyReg::a0),M(inst->GetOperand(0))}));
        ctx(Builder_withoutDef(RISCVMIR::ret,inst));
    }
    else if(inst->GetOperand(0)&&inst->GetOperand(0)->GetType()==FloatType::NewFloatTypeGet()) {
        ctx(Builder(RISCVMIR::_flw,{PhyRegister::GetPhyReg(PhyRegister::PhyReg::a0),M(inst->GetOperand(0))}));
        ctx(Builder_withoutDef(RISCVMIR::ret,inst));
    }
    else 
        assert(0&&"Invalid return type");
    #undef M
}

RISCVMOperand* RISCVISel::Li_Intimm(ConstIRInt* Intconst) {
    int inttemp = Intconst->GetVal();
    VirRegister* vreg = ctx.createVReg(RISCVType::riscv_i32);
    if(inttemp>=-2048 && inttemp<2048) {
        Imm* const_imm = new Imm(Intconst);
        ctx(Builder(RISCVMIR::li, {vreg, const_imm}));
    } else {
        int mod = inttemp%4096;
        if(mod==0) {
            //li .a int
            Imm* const_imm = new Imm(Intconst);
            ctx(Builder(RISCVMIR::li, {vreg, const_imm}));
        } else if ((mod>0&&mod<2048)||(mod>=-2048&&mod<0)) {
            //li .a int-m
            //addi .a, .a, m
            Imm* const_imm = new Imm(ConstIRInt::GetNewConstant(inttemp-mod));
            ctx(Builder(RISCVMIR::li, {vreg, const_imm}));
            Imm* mod_imm = new Imm(ConstIRInt::GetNewConstant(mod));
            ctx(Builder(RISCVMIR::_addiw, {vreg, vreg, mod_imm}));
        } else if (mod >=2048 && mod <4095) {
            //li .a int-m+4096
            //addi .a, .a, m-4096
            Imm* const_imm = new Imm(ConstIRInt::GetNewConstant(inttemp-mod+4096));
            ctx(Builder(RISCVMIR::li, {vreg, const_imm}));
            Imm* mod_imm = new Imm(ConstIRInt::GetNewConstant(mod-4096));
            ctx(Builder(RISCVMIR::_addiw, {vreg, vreg, mod_imm}));
        }   
        else if (mod>-4095&&mod<-2048) {
            //li .a int-m-4096
            //addi .a, .a, m+4096
            Imm* const_imm = new Imm(ConstIRInt::GetNewConstant(inttemp-mod-4096));
            ctx(Builder(RISCVMIR::li, {vreg, const_imm}));
            Imm* mod_imm = new Imm(ConstIRInt::GetNewConstant(mod+4096));
            ctx(Builder(RISCVMIR::_addiw, {vreg, vreg, mod_imm}));
        } else assert(0&&"error imm");
    }
    return vreg;
}

void RISCVISel::InstLowering(User* inst){
    if(auto store=dynamic_cast<StoreInst*>(inst))InstLowering(store);
    else if(auto load=dynamic_cast<LoadInst*>(inst))InstLowering(load);
    else if(auto alloca=dynamic_cast<AllocaInst*>(inst))InstLowering(alloca);
    else if(auto fptsi=dynamic_cast<FPTSI*>(inst))InstLowering(fptsi);
    else if(auto sitfp=dynamic_cast<SITFP*>(inst))InstLowering(sitfp);
    else if(auto uncond=dynamic_cast<UnCondInst*>(inst))InstLowering(uncond);
    else if(auto cond=dynamic_cast<CondInst*>(inst))InstLowering(cond);
    else if(auto binary=dynamic_cast<BinaryInst*>(inst))InstLowering(binary);
    else if(auto gep=dynamic_cast<GetElementPtrInst*>(inst))InstLowering(gep);
    else if(auto phi=dynamic_cast<PhiInst*>(inst))InstLowering(phi);
    else if(auto call=dynamic_cast<CallInst*>(inst))InstLowering(call);
    else if(auto ret=dynamic_cast<RetInst*>(inst))InstLowering(ret);
    else assert("Invalid Inst Type");
}

RISCVISel::RISCVISel(RISCVLoweringContext& _ctx):ctx(_ctx){}