#include "RISCVISel.hpp"
#include "RISCVMIR.hpp"

RISCVMIR* RISCVISel::Builder(RISCVMIR::RISCVISA _isa,User* inst){
    auto minst=new RISCVMIR(_isa);
    for(int i=0;i<inst->Getuselist().size();i++)
        minst->AddOperand(ctx.mapping(inst->GetOperand(i)));
    return minst;
}

RISCVMIR* RISCVISel::Builder(RISCVMIR::RISCVISA _isa,std::initializer_list<RISCVMOperand*> list){
    auto minst=new RISCVMIR(_isa);
    for(auto i:list)
        minst->AddOperand(i);
    return minst;
}

bool RISCVISel::run(Function* m){
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
    if(inst->GetOperand(0)->GetType()==IntType::NewIntTypeGet())
        ctx(Builder(RISCVMIR::_sw,inst));
    else if(inst->GetOperand(0)->GetType()==FloatType::NewFloatTypeGet())
        ctx(Builder(RISCVMIR::_fsw,inst));
    else assert("invalid store type");
}

void RISCVISel::InstLowering(LoadInst* inst){
    if(inst->GetOperand(0)->GetType()==IntType::NewIntTypeGet())
        ctx(Builder(RISCVMIR::_lw,inst));
    else if(inst->GetOperand(0)->GetType()==FloatType::NewFloatTypeGet())
        ctx(Builder(RISCVMIR::_flw,inst));
    else assert("invalid load type");
}

void RISCVISel::InstLowering(FPTSI* inst){
    ctx(Builder(RISCVMIR::_fcvt_w_s,inst));
}

void RISCVISel::InstLowering(SITFP* inst){
    ctx(Builder(RISCVMIR::_fcvt_s_w,inst));
}

void RISCVISel::InstLowering(UnCondInst* inst){
    ctx(Builder(RISCVMIR::_j,inst));
}

void RISCVISel::InstLowering(CondInst* inst){
    #define M(x) ctx.mapping(x)
    auto cond=inst->GetOperand(0)->as<BinaryInst>();
    assert(cond!=nullptr&&"Invalid Condition");
    assert((cond->GetOperand(0)->GetType()==IntType::NewIntTypeGet()||cond->GetOperand(0)->GetType()==FloatType::NewFloatTypeGet())&&"Invalid Condition Type");
    if(cond->GetOperand(0)->GetType()==IntType::NewIntTypeGet()){
        switch (cond->getopration())
        {
            case BinaryInst::Op_L:
            {
                auto fi=Builder(RISCVMIR::_blt,{M(cond->GetOperand(0)),M(cond->GetOperand(1)),M(inst->GetOperand(1))});
                auto se=Builder(RISCVMIR::_j,{M(inst->GetOperand(2))});
                ctx(fi);
                ctx(se);
                break;
            }
            case BinaryInst::Op_LE:
            {
                auto fi=Builder(RISCVMIR::_bge,{M(cond->GetOperand(1)),M(cond->GetOperand(0)),M(inst->GetOperand(1))});
                auto se=Builder(RISCVMIR::_j,{M(inst->GetOperand(2))});
                break;
            }
            case BinaryInst::Op_G:
            {
                auto fi=Builder(RISCVMIR::_blt,{M(cond->GetOperand(1)),M(cond->GetOperand(0)),M(inst->GetOperand(1))});
                auto se=Builder(RISCVMIR::_j,{M(inst->GetOperand(2))});
                ctx(fi);
                ctx(se);
                break;
            }
            case BinaryInst::Op_GE:
            {
                auto fi=Builder(RISCVMIR::_bge,{M(cond->GetOperand(0)),M(cond->GetOperand(1)),M(inst->GetOperand(1))});
                auto se=Builder(RISCVMIR::_j,{M(inst->GetOperand(2))});
                ctx(fi);
                ctx(se);
                break;
            }
            case BinaryInst::Op_E:
            {    
                auto fi=Builder(RISCVMIR::_beq,{M(cond->GetOperand(0)),M(cond->GetOperand(1)),M(inst->GetOperand(1))});
                auto se=Builder(RISCVMIR::_j,{M(inst->GetOperand(2))});
                ctx(fi);
                ctx(se);
                break;
            }
            case BinaryInst::Op_NE:
            {
                auto fi=Builder(RISCVMIR::_bne,{M(cond->GetOperand(0)),M(cond->GetOperand(1)),M(inst->GetOperand(1))});
                auto se=Builder(RISCVMIR::_j,{M(inst->GetOperand(2))});
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
    else{
        assert("Not IMPL");
    }
    #undef M
}

void RISCVISel::InstLowering(BinaryInst* inst){
    if(inst->getopration()<BinaryInst::Op_And){
        // if(inst->ConstCalc())return;
        RISCVMIR* result;
        switch (inst->getopration())
        {
        case BinaryInst::Op_Add:
        {
            if(inst->GetType()==IntType::NewIntTypeGet())
                ctx(Builder(RISCVMIR::_add,inst));
            else if(inst->GetType()==FloatType::NewFloatTypeGet())
                ctx(Builder(RISCVMIR::_fadd_s,inst));
            else assert("Illegal!");
            break;
        }
        case BinaryInst::Op_Sub:
        {
            if(inst->GetType()==IntType::NewIntTypeGet())
                ctx(Builder(RISCVMIR::_sub,inst));
            else if(inst->GetType()==FloatType::NewFloatTypeGet())
                ctx(Builder(RISCVMIR::_fsub_s,inst));
            else assert("Illegal!");
            break;
        }
        case BinaryInst::Op_Mul:
        {
            if(inst->GetType()==IntType::NewIntTypeGet())
                ctx(Builder(RISCVMIR::_mul,inst));
            else if(inst->GetType()==FloatType::NewFloatTypeGet())
                ctx(Builder(RISCVMIR::_fmul_s,inst));
            else assert("Illegal!");
            break;
        }
        case BinaryInst::Op_Div:
        {
            if(inst->GetType()==IntType::NewIntTypeGet())
                ctx(Builder(RISCVMIR::_div,inst));
            else if(inst->GetType()==FloatType::NewFloatTypeGet())
                ctx(Builder(RISCVMIR::_fdiv_s,inst));
            else assert("Illegal!");
            break;
        }
        case BinaryInst::Op_Mod:
        {
            if(inst->GetType()==IntType::NewIntTypeGet())ctx(Builder(RISCVMIR::_rem,inst));
            else assert("Illegal!");
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
            auto mul=Builder(RISCVMIR::_mulw,{ctx.createVReg(RISCVType::riscv_ptr),M(index),M(ConstSize_t::GetNewConstant(size))});
            ctx(mul);
            auto temp=ctx.createVReg(riscv_ptr);
            ctx(Builder(RISCVMIR::_addw,{temp,baseptr,mul->GetOperand(0)}));
            baseptr=temp;
        }
        hasSubtype=dynamic_cast<HasSubType*>(hasSubtype->GetSubType());
    }
    if(offset!=0)
        ctx(Builder(RISCVMIR::_addw,{baseptr,M(ConstSize_t::GetNewConstant(offset))}));
    #undef M
}

void RISCVISel::InstLowering(PhiInst* inst){
    ///@note phi elimination here,
    ///
    assert(0&&"NOT IMPL");
}

void RISCVISel::InstLowering(CallInst* inst){
    // 把VReg Copy到PhyReg
    // 如果溢出则按照规约store
    // 如果有返回值则copy a0 到 VReg

    if(!inst->GetUserlist().is_empty()&&inst->GetType()!=VoidType::NewVoidTypeGet()){

    }
}

void RISCVISel::InstLowering(RetInst* inst){

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