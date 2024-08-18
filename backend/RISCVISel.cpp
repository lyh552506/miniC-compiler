#include "../include/backend/RISCVISel.hpp"
#include "../include/backend/RISCVMIR.hpp"
#include "../include/backend/RISCVTrival.hpp"
#include "../include/backend/RISCVFrameContext.hpp"
#include "../include/ir/opt/New_passManager.hpp"
#include "../include/ir/Analysis/CondProbAnalysis.hpp"
#include "../include/ir/Analysis/LoopInfo.hpp"
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
    auto AM=_AnalysisManager();
    FunctionChange(m)
    auto mdom=AM.get<dominance>(m);
    for(auto i:mdom->DFS_Dom()){
        auto bb=i->thisBlock;
        ctx(ctx.mapping(bb)->as<RISCVBasicBlock>());
        for(auto inst:*bb)
            InstLowering(inst);
    }

    /// @note get branch prob to fix terminator
    
    auto loopinfo=AM.get<LoopAnalysis>(m,mdom,std::ref(DeleteLoop));
    auto condprob=AM.get<ProbAnalysis>(m,loopinfo,mdom);
    auto probedge=condprob->GetProb();

    for(auto& edge:probedge){
        auto pred=ctx.mapping(edge.Out)->as<RISCVBasicBlock>();
        auto succ=ctx.mapping(edge.In)->as<RISCVBasicBlock>();
        auto prob=edge.Prob;
        auto terminator=pred->getTerminator();
        assert(terminator.trueblock==succ||terminator.falseblock==succ);
        if(terminator.falseblock==succ)prob=1-prob;
        terminator.SetProb(prob);
    }

    return true;
}

void RISCVISel::InstLowering(AllocaInst* inst){
    // RISCVMIR* minst = new RISCVMIR(RISCVMIR::StackAlloc);
    // minst->SetDef(ctx.mapping(inst));
    // ctx(minst);
    ctx.mapping(inst);
}

void RISCVISel::InstLowering(StoreInst* inst){
    Operand op0 = inst->GetOperand(0);
    Operand op1 = inst->GetOperand(1);
    if(op0->GetType()==IntType::NewIntTypeGet()) {
        if(ConstIRInt* Intconst = dynamic_cast<ConstIRInt*>(op0)) {
            auto minst=new RISCVMIR(RISCVMIR::_sw);
            minst->AddOperand(ctx.GetCurFunction()->GetUsedGlobalMapping(Imm::GetImm(Intconst)));
            minst->AddOperand(ctx.mapping(op1));
            ctx(minst);
        }
        else {
            ctx(Builder_withoutDef(RISCVMIR::_sw, inst));
            // auto minst=new RISCVMIR(RISCVMIR::_sw);
            // for(int i=0;i<inst->Getuselist().size();i++)
            //     minst->AddOperand(ctx.mapping(inst->GetOperand(i)));
            // ctx(minst);
        }
    }
    else if(op0->GetType()==FloatType::NewFloatTypeGet()) {
        ctx(Builder_withoutDef(RISCVMIR::_fsw,inst));
    }
    else if(PointerType* ptrtype = dynamic_cast<PointerType*>(op0->GetType())) {
        ctx(Builder_withoutDef(RISCVMIR::_sd, inst));
    }
    else assert(0&&"invalid store type");
}

void RISCVISel::InstLowering(LoadInst* inst){
    if (inst->GetType()==IntType::NewIntTypeGet()) {
        ctx(Builder(RISCVMIR::_lw,inst));
    }
    else if  (inst->GetType()==FloatType::NewFloatTypeGet()) {
        ctx(Builder(RISCVMIR::_flw,inst));
    }
    else if(PointerType* ptrtype = dynamic_cast<PointerType*>(inst->GetType())) {
        ctx(Builder(RISCVMIR::_ld,inst));
    }
    // else if(ArrayType* arraytype = dynamic_cast<ArrayType*>(inst->GetType())) {
    //     ctx(Builder(RISCVMIR::_lw,inst));
    // }
    else assert(0&&"invalid load type");
}

void RISCVISel::InstLowering(FPTSI* inst){
    ctx(Builder(RISCVMIR::_fcvt_w_s,inst));
}

void RISCVISel::InstLowering(SITFP* inst){
    ctx(Builder(RISCVMIR::_fcvt_s_w,inst));
}

void RISCVISel::InstLowering(UnCondInst* inst){
    ctx(Builder_withoutDef(RISCVMIR::_j, {ctx.mapping(inst->GetOperand(0))}));
}

void RISCVISel::InstLowering(CondInst* inst){
    #define M(x) ctx.mapping(x)
    if (auto cond=inst->GetOperand(0)->as<ConstIRBoolean>()) {
        bool condition = cond->GetVal();
        if(condition) {
            ctx(Builder_withoutDef(RISCVMIR::_j, {ctx.mapping(inst->GetOperand(1))}));
        }
        else ctx(Builder_withoutDef(RISCVMIR::_j, {ctx.mapping(inst->GetOperand(2))}));
        return;
    }
    else if(auto cond=inst->GetOperand(0)->as<BinaryInst>()) {
        assert((cond->GetDef()->GetType()==BoolType::NewBoolTypeGet())&&"Invalid Condition Type");
        
        bool onlyusr=cond->GetUserListSize()==1;
        // CondInst is the only user of condition, and the condition is not float
        if(onlyusr&&cond->GetOperand(0)->GetType()!=FloatType::NewFloatTypeGet()){
            auto opcode=cond->getopration();
            auto integer_cond_builder=[&](RISCVMIR::RISCVISA opcode){
                ctx(Builder_withoutDef(opcode,{ctx.mapping(cond->GetOperand(0)),ctx.mapping(cond->GetOperand(1)),ctx.mapping(inst->GetOperand(1))}));
                ctx(Builder_withoutDef(RISCVMIR::_j,{ctx.mapping(inst->GetOperand(2))}));
            };
            switch (opcode)
            {
            case BinaryInst::Op_L:
            {
                // blt
                integer_cond_builder(RISCVMIR::_blt);
                break;
            }
            case BinaryInst::Op_LE:
            {
                // ble
                integer_cond_builder(RISCVMIR::_ble);
                break;
            }
            case BinaryInst::Op_G:
            {
                // bgt
                integer_cond_builder(RISCVMIR::_bgt);
                break;
            }
            case BinaryInst::Op_GE:
            {
                // bge
                integer_cond_builder(RISCVMIR::_bge);
                break;
            }
            case BinaryInst::Op_E:
            {
                // beq
                integer_cond_builder(RISCVMIR::_beq);
                break;
            }
            case BinaryInst::Op_NE:
            {
                // bne
                integer_cond_builder(RISCVMIR::_bne);
                break;
            }
            case BinaryInst::Op_And:
            case BinaryInst::Op_Or:
            case BinaryInst::Op_Xor:
            {
                // bne
                ctx(Builder_withoutDef(RISCVMIR::_bne,{ctx.mapping(cond->GetDef()),PhyRegister::GetPhyReg(PhyRegister::zero),ctx.mapping(inst->GetOperand(1))}));
                ctx(Builder_withoutDef(RISCVMIR::_j,{ctx.mapping(inst->GetOperand(2))}));
                break;
            }
            default:
                // assert(0&&"Impossible");
                break;
            }
            return;
        }
    }
    // else assert(0&&"Error in CondInst Lowering");
    ctx(Builder_withoutDef(RISCVMIR::_bne, {ctx.mapping(inst->GetOperand(0)), PhyRegister::GetPhyReg(PhyRegister::PhyReg::zero), ctx.mapping(inst->GetOperand(1))}));
    ctx(Builder_withoutDef(RISCVMIR::_j,{ctx.mapping(inst->GetOperand(2))}));
    #undef M
}

void RISCVISel::InstLowering(SelectInst* inst){
    auto trueblock=RISCVBasicBlock::CreateRISCVBasicBlock();
    auto falseblock=RISCVBasicBlock::CreateRISCVBasicBlock();
    auto nextblock=RISCVBasicBlock::CreateRISCVBasicBlock();
    auto dstVreg=ctx.createVReg(RISCVTyper(inst->GetType()));

    ctx(Builder_withoutDef(RISCVMIR::_bne, {ctx.mapping(inst->GetOperand(0)), PhyRegister::GetPhyReg(PhyRegister::PhyReg::zero), trueblock}));
    ctx(Builder_withoutDef(RISCVMIR::_j,{falseblock}));

    {
        ctx(trueblock);
        ctx(RISCVTrival::CopyFrom(dstVreg,ctx.mapping(inst->GetOperand(1))));
        ctx(Builder_withoutDef(RISCVMIR::_j,{nextblock}));
    }

    {
        ctx(falseblock);
        ctx(RISCVTrival::CopyFrom(dstVreg,ctx.mapping(inst->GetOperand(2))));
        ctx(Builder_withoutDef(RISCVMIR::_j,{nextblock}));
    }

    ctx(nextblock);
}

void RISCVISel::InstLowering(BinaryInst* inst){
    assert(!(inst->GetOperand(0)->isConst()&&inst->GetOperand(1)->isConst()));
    Operand temp = inst->GetOperand(0);
        RISCVMIR* result;
        switch (inst->getopration())
        {
        case BinaryInst::Op_Add:
        {
            if(inst->IsAtomic()){
                assert(inst->GetUserlist().GetSize()==0);
                if(inst->GetOperand(1)->GetType()==FloatType::NewFloatTypeGet()){
                    auto mv=new RISCVMIR(RISCVMIR::mv);
                    mv->SetDef(PhyRegister::GetPhyReg(PhyRegister::a0));
                    mv->AddOperand(ctx.mapping(inst->GetOperand(0)));
                    ctx(mv);

                    auto mvf=new RISCVMIR(RISCVMIR::_fmv_s);
                    mvf->SetDef(PhyRegister::GetPhyReg(PhyRegister::fa0));
                    mvf->AddOperand(ctx.mapping(inst->GetOperand(1)));
                    ctx(mvf);
                    
                    // call buildin_AtomicF32add
                    auto callmir=new RISCVMIR(RISCVMIR::call);
                    callmir->AddOperand(ctx.mapping(BuildInFunction::GetBuildInFunction("buildin_AtomicF32add")));
                    callmir->AddOperand(PhyRegister::GetPhyReg(PhyRegister::a0));
                    callmir->AddOperand(PhyRegister::GetPhyReg(PhyRegister::fa0));
                    ctx(callmir);
                    break;
                }
                auto amoadd=new RISCVMIR(RISCVMIR::_amoadd_w_aqrl);
                amoadd->SetDef(PhyRegister::GetPhyReg(PhyRegister::zero));
                if(inst->GetOperand(1)->isConst()){
                    auto constint=inst->GetOperand(1)->as<ConstIRInt>();
                    amoadd->AddOperand(ctx.GetCurFunction()->GetUsedGlobalMapping(Imm::GetImm(constint)));
                }
                else{
                    amoadd->AddOperand(ctx.mapping(inst->GetOperand(1)));
                }
                amoadd->AddOperand(ctx.mapping(inst->GetOperand(0)));
                ctx(amoadd);
                break;
            }
            
            if(inst->GetType()==IntType::NewIntTypeGet()) {
                if(ConstIRInt* constint = dynamic_cast<ConstIRInt*>(inst->GetOperand(1))) {
                    // int inttemp = constint->GetVal();
                        ctx(Builder(RISCVMIR::_addiw,inst));
                    // if(inttemp<2048)
                    //     ctx(Builder(RISCVMIR::_addiw,inst));
                    // else if(inttemp>=2048) {
                    //     auto minst=new RISCVMIR(RISCVMIR::_add);
                    //     minst->SetDef(ctx.mapping(inst->GetDef()));
                    //     minst->AddOperand(ctx.mapping(inst->GetOperand(0)));
                    //     minst->AddOperand(Li_Intimm(constint));
                    //     ctx(minst);
                    // } else assert(0&&"Invalid constint in add inst"); 
                } else 
                    ctx(Builder(RISCVMIR::_addw,inst));
            } else if(inst->GetType()==Int64Type::NewInt64TypeGet()) {
                if(ConstIRInt* constint = dynamic_cast<ConstIRInt*>(inst->GetOperand(1))) {
                    ctx(Builder(RISCVMIR::_addi,inst));
                }
                ctx(Builder(RISCVMIR::_add,inst));
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
                    minst->AddOperand(ctx.GetCurFunction()->GetUsedGlobalMapping(Imm::GetImm(constint)));
                    ctx(minst);
                } else ctx(Builder(RISCVMIR::_subw,inst));
            } else if(inst->GetType()==Int64Type::NewInt64TypeGet()) {
                if(ConstIRInt* constint = dynamic_cast<ConstIRInt*>(inst->GetOperand(1))) {
                    auto minst=new RISCVMIR(RISCVMIR::_sub);
                    minst->SetDef(ctx.mapping(inst->GetDef()));
                    minst->AddOperand(ctx.mapping(inst->GetOperand(0)));
                    minst->AddOperand(ctx.GetCurFunction()->GetUsedGlobalMapping(Imm::GetImm(constint)));
                    ctx(minst);
                } else ctx(Builder(RISCVMIR::_sub,inst));
            } else if(inst->GetType()==FloatType::NewFloatTypeGet())
                ctx(Builder(RISCVMIR::_fsub_s,inst));
            else assert("Illegal!");
            break;
        }
        case BinaryInst::Op_Mul:
        {
            if(inst->GetType()==IntType::NewIntTypeGet() || inst->GetType()==Int64Type::NewInt64TypeGet()) {
                if(ConstIRInt* constint = dynamic_cast<ConstIRInt*>(inst->GetOperand(1))) {
                    auto i32val=constint->GetVal();
                    if(i32val==0){
                        ctx.insert_val2mop(inst,PhyRegister::GetPhyReg(PhyRegister::zero));
                        return;
                    }
                    else if(i32val==1){
                        ctx.insert_val2mop(inst,ctx.mapping(inst->GetOperand(0)));
                        return;
                    }
                    else{
                        for(int i=0;;i++){
                            int val=1<<i;
                            if(val==i32val){
                                auto minst=new RISCVMIR(RISCVMIR::_slliw);
                                minst->SetDef(ctx.mapping(inst->GetDef()));
                                minst->AddOperand(ctx.mapping(inst->GetOperand(0)));
                                minst->AddOperand(Imm::GetImm(ConstIRInt::GetNewConstant(i)));
                                ctx(minst);
                                return;
                            }
                            if(val==1073741824)break;
                        }
                    }
                    RISCVMIR* minst = nullptr;
                    if(inst->GetType()==IntType::NewIntTypeGet())
                        minst=new RISCVMIR(RISCVMIR::_mulw);
                    else if(inst->GetType()==Int64Type::NewInt64TypeGet()) 
                        minst=new RISCVMIR(RISCVMIR::_mul);
                    minst->SetDef(ctx.mapping(inst->GetDef()));
                    minst->AddOperand(ctx.mapping(inst->GetOperand(0)));
                    minst->AddOperand(ctx.GetCurFunction()->GetUsedGlobalMapping(Imm::GetImm(constint)));
                    ctx(minst);
                } else {
                    if(inst->GetType()==IntType::NewIntTypeGet())
                        ctx(Builder(RISCVMIR::_mulw,inst));
                    else if(inst->GetType()==Int64Type::NewInt64TypeGet())   
                        ctx(Builder(RISCVMIR::_mul,inst));
                    else assert(0&&"Error Type!");
                }
            } else if(inst->GetType()==FloatType::NewFloatTypeGet())
                ctx(Builder(RISCVMIR::_fmul_s,inst));
            else assert("Illegal!");
            break;
        }
        case BinaryInst::Op_Div:
        {
            if(inst->GetType()==IntType::NewIntTypeGet()) {
                if(ConstIRInt* constint = dynamic_cast<ConstIRInt*>(inst->GetOperand(1))) {
                    auto i32val=constint->GetVal();
                    if(i32val==0){
                        assert(0&&"Int Div Zero, WTF");
                        return;
                    }
                    else if(i32val==1){
                        ctx.insert_val2mop(inst,ctx.mapping(inst->GetOperand(0)));
                        return;
                    }
                    else{
                        for(int i=0;i<=30;i++){
                            int val=1<<i;
                            if(val==i32val){
                                // sraiw	vreg1,op0,31
                                auto vreg1=ctx.createVReg(riscv_i32);
                                auto minst_sraiw = new RISCVMIR(RISCVMIR::_sraiw);
                                minst_sraiw->SetDef(vreg1);
                                minst_sraiw->AddOperand(ctx.mapping(inst->GetOperand(0)));
                                minst_sraiw->AddOperand(Imm::GetImm(ConstIRInt::GetNewConstant(31)));
                                ctx(minst_sraiw);

                                // srliw vreg1,vreg1,32-i
                                auto minst_srliw =  new RISCVMIR(RISCVMIR::_srliw);
                                minst_srliw->SetDef(vreg1);
                                minst_srliw->AddOperand(vreg1);
                                minst_srliw->AddOperand(Imm::GetImm(ConstIRInt::GetNewConstant(32-i)));
                                ctx(minst_srliw);

                                // addw vreg1,vreg1,op0
                                auto minst_addw = new RISCVMIR(RISCVMIR::_addw);
                                minst_addw->SetDef(vreg1);
                                minst_addw->AddOperand(vreg1);
                                minst_addw->AddOperand(ctx.mapping(inst->GetOperand(0)));
                                ctx(minst_addw);

                                auto minst=new RISCVMIR(RISCVMIR::_sraiw);
                                minst->SetDef(vreg1);
                                minst->AddOperand(vreg1);
                                minst->AddOperand(Imm::GetImm(ConstIRInt::GetNewConstant(i)));
                                ctx(minst);
                                ctx.insert_val2mop(inst,vreg1);
                                return;
                            }
                            // if(val==1073741824)break;
                        }
                    }
                    auto minst=new RISCVMIR(RISCVMIR::_divw);
                    minst->SetDef(ctx.mapping(inst->GetDef()));
                    minst->AddOperand(ctx.mapping(inst->GetOperand(0)));
                    minst->AddOperand(ctx.GetCurFunction()->GetUsedGlobalMapping(Imm::GetImm(constint)));
                    ctx(minst);
                } else ctx(Builder(RISCVMIR::_divw,inst));            
            } else if(inst->GetType()==FloatType::NewFloatTypeGet())
                ctx(Builder(RISCVMIR::_fdiv_s,inst));
            else assert("Illegal!");
            break;
        }
        case BinaryInst::Op_Mod:
        {
            if(inst->GetType()==IntType::NewIntTypeGet() || inst->GetType()==Int64Type::NewInt64TypeGet()) {
                if(ConstIRInt* constint = dynamic_cast<ConstIRInt*>(inst->GetOperand(1))) {
                    auto i32val=constint->GetVal();
                    for(int i=0;i<=30;i++){
                        int val=1<<i;
                        if(val==i32val){
                            auto andi=new RISCVMIR(RISCVMIR::_andi);
                            auto def=ctx.createVReg(riscv_i32);
                            andi->SetDef(def);
                            andi->AddOperand(ctx.mapping(inst->GetOperand(0)));
                            andi->AddOperand(Imm::GetImm(ConstIRInt::GetNewConstant(i32val-1)));
                            ctx.insert_val2mop(inst,def);
                            ctx(andi);
                            return;
                        }
                    }
                    RISCVMIR* minst = nullptr;
                    if(inst->GetType()==IntType::NewIntTypeGet())
                        minst=new RISCVMIR(RISCVMIR::_remw);
                    else if(inst->GetType()==Int64Type::NewInt64TypeGet()) 
                        minst=new RISCVMIR(RISCVMIR::_rem);
                    minst->SetDef(ctx.mapping(inst->GetDef()));
                    minst->AddOperand(ctx.mapping(inst->GetOperand(0)));
                    minst->AddOperand(ctx.GetCurFunction()->GetUsedGlobalMapping(Imm::GetImm(constint)));
                    ctx(minst);
                } else {
                    if(inst->GetType()==IntType::NewIntTypeGet())
                        ctx(Builder(RISCVMIR::_remw,inst));
                    else if(inst->GetType()==Int64Type::NewInt64TypeGet()) 
                        ctx(Builder(RISCVMIR::_rem,inst));
                    else assert(0&&"Error Type!");
                }
            } else assert(0&&"Illegal!");
            break;
        }
        case BinaryInst::Op_L:
        case BinaryInst::Op_G:
        case BinaryInst::Op_LE:
        case BinaryInst::Op_GE:
        case BinaryInst::Op_E:
        case BinaryInst::Op_NE:
        {
            // unlikely
            if(inst->GetUserlist().is_empty())
                break;
            // if the only user is 
            bool onlyusr=inst->GetUserListSize()==1;
            bool condinst=false;
            for(auto us:inst->GetUserlist()){
                auto usr=us->GetUser();
                if(usr->as<CondInst>()==nullptr)
                    break;
                else condinst=true;
            }
            if(!(onlyusr==true&&condinst==true&&inst->GetOperand(0)->GetType()!=FloatType::NewFloatTypeGet()))
                condition_helper(inst);
            break;
        }
        case BinaryInst::Op_And:
        {
            if(inst->GetType()!=FloatType::NewFloatTypeGet()) {
                if(ConstIRInt* constint = dynamic_cast<ConstIRInt*>(inst->GetOperand(1)))
                    ctx(Builder(RISCVMIR::_andi,inst));
                else 
                    ctx(Builder(RISCVMIR::_and,inst));
            }
            else assert(0&&"Illegal!");
            break;
        }
        case BinaryInst::Op_Or:
        {
            if(inst->GetType()!=FloatType::NewFloatTypeGet()) {
                if(ConstIRInt* constint = dynamic_cast<ConstIRInt*>(inst->GetOperand(1)))
                    ctx(Builder(RISCVMIR::_ori,inst));
                else 
                    ctx(Builder(RISCVMIR::_or,inst));
            }
            else assert(0&&"Illegal!");
            break;
        }
        case BinaryInst::Op_Xor:
        {
            if(inst->GetType()!=FloatType::NewFloatTypeGet()) {
                if(ConstIRInt* constint = dynamic_cast<ConstIRInt*>(inst->GetOperand(1)))
                    ctx(Builder(RISCVMIR::_xori,inst));
                else 
                    ctx(Builder(RISCVMIR::_xor,inst));
            }
            else assert(0&&"Illegal!");
            break;
        }
        default:
            assert(0&&"Invalid Opcode");
        }
}

void RISCVISel::InstLowering(GetElementPtrInst* inst){
    #define M(x) ctx.mapping(x)
    int limi=inst->Getuselist().size();
    auto hasSubtype=dynamic_cast<HasSubType*>(inst->GetOperand(0)->GetType());
    size_t offset=0;

    VirRegister* vreg=nullptr;

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
            RISCVMIR* minst=nullptr;
            for(auto i=0;;i++){
                auto val=1<<i;
                if(val==size){
                    minst=Builder(RISCVMIR::_slli,{ctx.createVReg(RISCVType::riscv_ptr),M(index),Imm::GetImm(ConstIRInt::GetNewConstant(i))});
                    ctx(minst);
                }
                if(val==1073741824)break;
            }

            if(minst==nullptr){
                minst=Builder(RISCVMIR::_mul,{ctx.createVReg(RISCVType::riscv_ptr),M(index), ctx.GetCurFunction()->GetUsedGlobalMapping(Imm::GetImm(ConstIRInt::GetNewConstant(size)))});
                ctx(minst);
            }

            if(vreg!=nullptr){
                auto newreg=ctx.createVReg(RISCVType::riscv_ptr);
                ctx(Builder(RISCVMIR::_add,{newreg,vreg,minst->GetDef()}));
                vreg=newreg;
            }
            else vreg=minst->GetDef()->as<VirRegister>();
        }
        hasSubtype=dynamic_cast<HasSubType*>(hasSubtype->GetSubType());
    }
    #undef M
    if(auto normal=ctx.mapping(inst->GetOperand(0))->as<VirRegister>()){
        if(vreg==nullptr){
            // addi newreg, normal, offset
            if(offset!=0){
                auto newreg=ctx.createVReg(RISCVType::riscv_ptr);
                ctx(Builder(RISCVMIR::_addi,{newreg,normal,Imm::GetImm(ConstIRInt::GetNewConstant(offset))})); 
                ctx.insert_val2mop(inst,newreg);
            }
            else ctx.insert_val2mop(inst,normal);
        }
        else{
            // add newreg, normal, vreg
            // addi vreg offset
            auto newreg=ctx.createVReg(RISCVType::riscv_ptr);
            ctx(Builder(RISCVMIR::_add,{newreg,normal,vreg}));
            if(offset!=0)
                ctx(Builder(RISCVMIR::_addi,{newreg,newreg,Imm::GetImm(ConstIRInt::GetNewConstant(offset))}));
            ctx.insert_val2mop(inst,newreg);
        }
    }
    else assert(0);
}

void RISCVISel::InstLowering(PhiInst* inst){
    ///@note phi elimination not here, no op
    return;
}

void RISCVISel::LowerCallInstParallel(CallInst* inst){
    #define M(x) ctx.mapping(x)
    auto func_called=inst->GetOperand(0)->as<Function>();
    assert(func_called!=nullptr);

    auto createMir=[&](PhyRegister* preg,RISCVMIR::RISCVISA _opcode,Operand op0)-> VirRegister* {
        auto mir=new RISCVMIR(_opcode);
        auto def=ctx.createVReg(riscv_i32);
        mir->SetDef(preg);
        mir->AddOperand(ctx.mapping(op0));
        ctx(mir);
        return def;
    };

    auto loadTagAddress=[&](VirRegister* reg,std::string tag){
        auto addressinst=new RISCVMIR(RISCVMIR::LoadGlobalAddr);
        addressinst->SetDef(reg);
        auto args_storage=OuterTag::GetOuterTag(tag);
        addressinst->AddOperand(args_storage);
        ctx(addressinst);
    };

    // store funcptr 2 where it should be
    auto funcptr=ctx.createVReg(riscv_ptr);
    loadTagAddress(funcptr,func_called->GetName());

    auto funcptrstorage=ctx.createVReg(riscv_ptr);
    loadTagAddress(funcptrstorage,"buildin_funcptr");

    auto sd2funcptr=new RISCVMIR(RISCVMIR::_sd);
    sd2funcptr->AddOperand(funcptr);
    sd2funcptr->AddOperand(funcptrstorage);
    ctx(sd2funcptr);

    
    auto addressreg=ctx.createVReg(riscv_ptr);
    loadTagAddress(addressreg,"buildin_parallel_arg_storage");

    auto mvaddress=[&](int offset){
        auto addi=new RISCVMIR(RISCVMIR::_addi);
        addi->SetDef(addressreg);
        addi->AddOperand(addressreg);
        addi->AddOperand(Imm::GetImm(ConstIRInt::GetNewConstant(offset)));
        ctx(addi);
    };

    int offset=0;

    for(int i=1,limi=inst->Getuselist().size();i<limi;i++){
        if(i<=2){
            assert(inst->GetOperand(i)->GetType()==IntType::NewIntTypeGet());
            offset+=4;
            auto phyreg=(i==1)?
            PhyRegister::GetPhyReg(PhyRegister::a0):
            PhyRegister::GetPhyReg(PhyRegister::a1);
            if(inst->GetOperand(i)->isConst()){
                createMir(phyreg,RISCVMIR::li,inst->GetOperand(i));
            }
            else{
                createMir(phyreg,RISCVMIR::mv,inst->GetOperand(i));
            }
        }
        else{
            auto store2place=[&](RISCVMIR::RISCVISA _opcode,RISCVMOperand* mop){
                mvaddress(offset);
                auto mir=new RISCVMIR(_opcode);
                mir->AddOperand(mop);
                mir->AddOperand(addressreg);
                ctx(mir);
                offset=0;
            };
            auto op=ctx.mapping(inst->GetOperand(i));
            auto tp=inst->GetOperand(i)->GetType();
            if(dynamic_cast<PointerType*>(tp)){
                assert(tp->get_size()==8);
                store2place(RISCVMIR::_sd,op);
                offset+=tp->get_size();
            }
            else if(tp==FloatType::NewFloatTypeGet()){
                assert(tp->get_size()==4);
                store2place(RISCVMIR::_fsw,op);
                offset+=tp->get_size();
            }
            else{
                assert(tp->get_size()==4);
                store2place(RISCVMIR::_sw,op);
                offset+=tp->get_size();
            }
        }
    }

    auto getNotifyWorker=[&](){
        if(func_called->CmpEqual)
            return BuildInFunction::GetBuildInFunction("buildin_NotifyWorkerLE");
        else
            return BuildInFunction::GetBuildInFunction("buildin_NotifyWorkerLT");
    };
    
    auto NotifyWorker=getNotifyWorker();
    auto call=new RISCVMIR(RISCVMIR::call);
    call->AddOperand(M(NotifyWorker));
    call->AddOperand(PhyRegister::GetPhyReg(PhyRegister::a0));
    call->AddOperand(PhyRegister::GetPhyReg(PhyRegister::a1));
    ctx(call);
    #undef M
}
void RISCVISel::LowerCallInstCacheLookUp(CallInst* inst){
    #define M(x) ctx.mapping(x)
    this->asmprinter->set_use_cachelookup(true);
    RISCVMIR* call = new RISCVMIR(RISCVMIR::call);
    // the call inst is: call CacheLookUp(int/float, int/float)
    // the size of uselist is 3, and the first use is called function
    BuildInFunction* buildinfunc = BuildInFunction::GetBuildInFunction(inst->GetOperand(0)->GetName());
    call->AddOperand(M(buildinfunc));  // "CacheLookUp"
    int regint=PhyRegister::PhyReg::a0;
    for(int index=1; index<3; index++) {
        Operand op = inst->GetOperand(index);
        if(ConstIRInt* constint = dynamic_cast<ConstIRInt*>(op)) {
            auto li = new RISCVMIR(RISCVMIR::li);
            PhyRegister* preg = PhyRegister::GetPhyReg(static_cast<PhyRegister::PhyReg>(regint));
            call->AddOperand(preg);
            li->SetDef(preg);
            Imm* imm = Imm::GetImm(constint);
            li->AddOperand(imm);
            ctx.insert_val2mop(constint, imm);
            ctx(li);
            regint++;
        }
        else if(RISCVTyper(op->GetType())==riscv_i32 || RISCVTyper(op->GetType())==riscv_ptr) {
            PhyRegister* preg = PhyRegister::GetPhyReg(static_cast<PhyRegister::PhyReg>(regint));
            ctx(Builder(RISCVMIR::mv,{preg,M(op)}));
            call->AddOperand(preg);
            regint++;
        }
        else if(RISCVTyper(op->GetType())==riscv_float32) {
            PhyRegister* reg = PhyRegister::GetPhyReg(static_cast<PhyRegister::PhyReg>(regint));
            ctx(Builder(RISCVMIR::_fmv_x_w,{reg,M(op)}));
            call->AddOperand(reg);
            regint++;
        }
        else assert(0 && "CallInst selection illegal type");
    }
    ctx(call);
    call->SetDef(PhyRegister::GetPhyReg(PhyRegister::PhyReg::fa0));
    ctx(Builder(RISCVMIR::mv, {ctx.mapping(inst), PhyRegister::GetPhyReg(PhyRegister::PhyReg::a0)}));
    #undef M
}

void RISCVISel::InstLowering(CallInst* inst){
    // 把VReg Copy到PhyReg
    // 如果溢出则按照规约store
    // 如果有返回值则copy a0 到 VReg
    if(inst->GetOperand(0)->as<Function>()&&inst->GetOperand(0)->as<Function>()->tag==Function::ParallelBody){
        Singleton<Enable_Parallel>().flag=true;
        LowerCallInstParallel(inst);
        return;
    }
    if(inst->GetOperand(0)->GetName()=="CacheLookUp"){
        LowerCallInstCacheLookUp(inst);
        return;
    }
    #define M(x) ctx.mapping(x)
    int IntMaxNum=8, FloatMaxNum=8;
    std::unique_ptr<RISCVFrame>& frame = ctx.GetCurFunction()->GetFrame();
    Function* called_midfunc;
    RISCVFunction* called_func;
    BuildInFunction* buildin_func;
    std::vector<int> spillnodes;
    RISCVMIR* call = new RISCVMIR(RISCVMIR::call);
    call->AddOperand(M(inst->GetOperand(0)));

    if(called_midfunc = dynamic_cast<Function*>(inst->GetOperand(0))) {
        called_func = dynamic_cast<RISCVFunction*>(M(called_midfunc));
        spillnodes = called_func->GetParamNeedSpill();
    }
    else {
        buildin_func = dynamic_cast<BuildInFunction*>(inst->GetOperand(0));
        called_func = dynamic_cast<RISCVFunction*>(M(buildin_func));
        spillnodes = called_func->GetParamNeedSpill();
    }

    if(!inst->Getuselist().empty()) {
        int offset = 0;
        size_t local_param_size=0;
        for(auto it = spillnodes.rbegin(); it!=spillnodes.rend(); it++) {
            // spill to stack
            // load params to end of the frame
            int index = *it+1;
            Operand op = inst->GetOperand(index);
            RISCVMIR* store = nullptr;
            StackRegister* sreg = nullptr;
            switch(RISCVTyper(op->GetType())) {
                case riscv_i32:
                    sreg = new StackRegister(PhyRegister::sp, offset);
                    store = new RISCVMIR(RISCVMIR::_sw);
                    offset += 4;
                    break;
                case riscv_float32:
                    sreg = new StackRegister(PhyRegister::sp, offset);
                    store = new RISCVMIR(RISCVMIR::_fsw);
                    offset += 4;
                    break;
                case riscv_ptr:
                    sreg = new StackRegister(PhyRegister::sp, offset);
                    store = new RISCVMIR(RISCVMIR::_sd);
                    offset += 8;
                    break;
                default:
                    assert(0&&"Error param type");
            }
            if(inst->GetOperand(index)->isConst()&&inst->GetOperand(index)->GetType()!=FloatType::NewFloatTypeGet()) {
                auto li = new RISCVMIR(RISCVMIR::li);
                auto vreg = ctx.createVReg(RISCVTyper(inst->GetOperand(index)->GetType()));
                li->SetDef(vreg);
                li->AddOperand(Imm::GetImm(inst->GetOperand(index)->as<ConstantData>()));
                ctx(li);
                store->AddOperand(vreg);
            }
            else {
                store->AddOperand(M(inst->GetOperand(index)));
            }
            store->AddOperand(sreg);
            ctx(store);

            local_param_size += op->GetType()->get_size();
        }
        if (local_param_size > ctx.GetCurFunction()->GetMaxParamSize()) {
            ctx.GetCurFunction()->SetMaxParamSize(local_param_size);
        }

        int regint=PhyRegister::PhyReg::a0;
        int regfloat=PhyRegister::PhyReg::fa0;
        for(int index=1;index<inst->Getuselist().size();index++) {
            if(std::find(spillnodes.begin(), spillnodes.end(), index-1)!=spillnodes.end()) {
                continue;
            }
            else {
                Operand op = inst->GetOperand(index);
                if(ConstIRInt* constint = dynamic_cast<ConstIRInt*>(op)) {
                    auto li = new RISCVMIR(RISCVMIR::li);
                    PhyRegister* preg = PhyRegister::GetPhyReg(static_cast<PhyRegister::PhyReg>(regint));
                    call->AddOperand(preg);
                    li->SetDef(preg);
                    Imm* imm = Imm::GetImm(constint);
                    li->AddOperand(imm);
                    ctx.insert_val2mop(constint, imm);
                    ctx(li);
                    regint++;
                }
                else if(RISCVTyper(op->GetType())==riscv_i32 || RISCVTyper(op->GetType())==riscv_ptr) {
                    PhyRegister* preg = PhyRegister::GetPhyReg(static_cast<PhyRegister::PhyReg>(regint));
                    ctx(Builder(RISCVMIR::mv,{preg,M(op)}));
                    call->AddOperand(preg);
                    regint++;
                }
                else if(RISCVTyper(op->GetType())==riscv_float32) {
                    PhyRegister* freg = PhyRegister::GetPhyReg(static_cast<PhyRegister::PhyReg>(regfloat));
                    ctx(Builder(RISCVMIR::_fmv_s,{freg,M(op)}));
                    call->AddOperand(freg);
                    regfloat++;
                }
                else assert(0 && "CallInst selection illegal type");
            }
        }
    }

    ctx(call);

    if(!inst->GetUserlist().is_empty()){
        // ctx(Builder_withoutDef(RISCVMIR::call, inst));
        if(RISCVTyper(inst->GetOperand(0)->GetType())==RISCVType::riscv_float32) {
            call->SetDef(PhyRegister::GetPhyReg(PhyRegister::PhyReg::fa0));
            ctx(Builder(RISCVMIR::_fmv_s, {ctx.mapping(inst), PhyRegister::GetPhyReg(PhyRegister::PhyReg::fa0)}));
        }
        else if(RISCVTyper(inst->GetOperand(0)->GetType())==RISCVType::riscv_i32){
            call->SetDef(PhyRegister::GetPhyReg(PhyRegister::PhyReg::fa0));
            ctx(Builder(RISCVMIR::mv, {ctx.mapping(inst), PhyRegister::GetPhyReg(PhyRegister::PhyReg::a0)}));
        }
        else {
            // no return
        }
    }
    else {
        // ctx(Builder_withoutDef(RISCVMIR::call, inst));
    }
    #undef M
}

void RISCVISel::InstLowering(RetInst* inst){
    #define M(x) ctx.mapping(x)
    if(inst->Getuselist().empty() || inst->GetOperand(0)->isUndefVal()) {
        auto minst=new RISCVMIR(RISCVMIR::ret);
        ctx(minst);
    }
    else if(inst->GetOperand(0)&&inst->GetOperand(0)->GetType()==IntType::NewIntTypeGet()) {
        if(inst->GetOperand(0)->isConst()){
            ctx(Builder(RISCVMIR::li,{PhyRegister::GetPhyReg(PhyRegister::PhyReg::a0),M(inst->GetOperand(0))}));
        }
        else{
            ctx(Builder(RISCVMIR::mv,{PhyRegister::GetPhyReg(PhyRegister::PhyReg::a0),M(inst->GetOperand(0))}));
        }
        auto minst=new RISCVMIR(RISCVMIR::ret);
        minst->AddOperand(PhyRegister::GetPhyReg(PhyRegister::PhyReg::a0));
        ctx(minst);
    }
    else if(inst->GetOperand(0)&&inst->GetOperand(0)->GetType()==FloatType::NewFloatTypeGet()) {
        ctx(Builder(RISCVMIR::_fmv_s,{PhyRegister::GetPhyReg(PhyRegister::PhyReg::fa0),M(inst->GetOperand(0))}));
        auto minst=new RISCVMIR(RISCVMIR::ret);
        minst->AddOperand(PhyRegister::GetPhyReg(PhyRegister::PhyReg::fa0));
        ctx(minst);
    }
    else 
        assert(0&&"Invalid return type");
    #undef M
}

RISCVMOperand* RISCVISel::Li_Intimm(ConstIRInt* Intconst) {
    // int inttemp = Intconst->GetVal();
    // VirRegister* vreg = ctx.createVReg(RISCVType::riscv_i32);
    // if(inttemp>=-2048 && inttemp<2048) {
    //     Imm* const_imm = new Imm(Intconst);
    //     ctx(Builder(RISCVMIR::li, {vreg, const_imm}));
    // } else {
    //     int mod = inttemp%4096;
    //     if(mod==0) {
    //         //li .a int
    //         Imm* const_imm = new Imm(Intconst);
    //         ctx(Builder(RISCVMIR::li, {vreg, const_imm}));
    //     } else if ((mod>0&&mod<2048)||(mod>=-2048&&mod<0)) {
    //         //li .a int-m
    //         //addi .a, .a, m
    //         Imm* const_imm = new Imm(ConstIRInt::GetNewConstant(inttemp-mod));
    //         ctx(Builder(RISCVMIR::li, {vreg, const_imm}));
    //         Imm* mod_imm = new Imm(ConstIRInt::GetNewConstant(mod));
    //         ctx(Builder(RISCVMIR::_addiw, {vreg, vreg, mod_imm}));
    //     } else if (mod >=2048 && mod <4096) {
    //         //li .a int-m+4096
    //         //addi .a, .a, m-4096
    //         Imm* const_imm = new Imm(ConstIRInt::GetNewConstant(inttemp-mod+4096));
    //         ctx(Builder(RISCVMIR::li, {vreg, const_imm}));
    //         Imm* mod_imm = new Imm(ConstIRInt::GetNewConstant(mod-4096));
    //         ctx(Builder(RISCVMIR::_addiw, {vreg, vreg, mod_imm}));
    //     }   
    //     else if (mod>=-4095&&mod<-2048) {
    //         //li .a int-m-4096
    //         //addi .a, .a, m+4096
    //         Imm* const_imm = new Imm(ConstIRInt::GetNewConstant(inttemp-mod-4096));
    //         ctx(Builder(RISCVMIR::li, {vreg, const_imm}));
    //         Imm* mod_imm = new Imm(ConstIRInt::GetNewConstant(mod+4096));
    //         ctx(Builder(RISCVMIR::_addiw, {vreg, vreg, mod_imm}));
    //     } else assert(0&&"error imm");
    // }
    // return vreg;
    assert(0&&"Unreachable");
}

void RISCVISel::InstLowering(ZextInst* zext){
    auto mreg=ctx.mapping(zext->GetOperand(0));
    ctx.insert_val2mop(zext,mreg);
}

void RISCVISel::InstLowering(SextInst* sext) {
    // StarFive is 64bit machine
    auto mreg=ctx.mapping(sext->GetOperand(0));
    ctx.insert_val2mop(sext,mreg);
}

void RISCVISel::InstLowering(TruncInst* trunc) {
    ctx(Builder(RISCVMIR::_sext_w, trunc));
}

void RISCVISel::InstLowering(MinInst* min) {
    assert(!(min->GetOperand(0)->isConst()&&min->GetOperand(1)->isConst()));
    if(min->GetType()==IntType::NewIntTypeGet()) {
        if(ConstIRInt* constint = dynamic_cast<ConstIRInt*>(min->GetOperand(1))) {
            auto minst=new RISCVMIR(RISCVMIR::_min);
            minst->SetDef(ctx.mapping(min->GetDef()));
            minst->AddOperand(ctx.mapping(min->GetOperand(0)));
            minst->AddOperand(ctx.GetCurFunction()->GetUsedGlobalMapping(Imm::GetImm(constint)));
            ctx(minst);
        } else ctx(Builder(RISCVMIR::_min,min));
    }  else if(min->GetType()==FloatType::NewFloatTypeGet())
        ctx(Builder(RISCVMIR::_fmin_s,min));
    else assert(0&&"Invalid type");
};

void RISCVISel::InstLowering(MaxInst* max) {
    assert(!(max->GetOperand(0)->isConst()&&max->GetOperand(1)->isConst()));
    if(max->GetType()==IntType::NewIntTypeGet()) {
        if(ConstIRInt* constint = dynamic_cast<ConstIRInt*>(max->GetOperand(1))) {
            auto minst=new RISCVMIR(RISCVMIR::_max);
            minst->SetDef(ctx.mapping(max->GetDef()));
            minst->AddOperand(ctx.mapping(max->GetOperand(0)));
            minst->AddOperand(ctx.GetCurFunction()->GetUsedGlobalMapping(Imm::GetImm(constint)));
            ctx(minst);
        } else ctx(Builder(RISCVMIR::_max,max));
    }  else if(max->GetType()==FloatType::NewFloatTypeGet())
        ctx(Builder(RISCVMIR::_fmax_s,max));
    else assert(0&&"Invalid type");
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
    else if(auto zext=dynamic_cast<ZextInst*>(inst))InstLowering(zext);
    else if(auto sext=dynamic_cast<SextInst*>(inst))InstLowering(sext);
    else if(auto trunc=dynamic_cast<TruncInst*>(inst))InstLowering(trunc);
    else if(auto min=dynamic_cast<MinInst*>(inst))InstLowering(min);
    else if(auto max=dynamic_cast<MaxInst*>(inst))InstLowering(max);
    else if(auto sel=inst->as<SelectInst>())InstLowering(sel);
    else assert(0&&"Invalid Inst Type");
}

RISCVISel::RISCVISel(RISCVLoweringContext& _ctx, RISCVAsmPrinter*& asmprinter):ctx(_ctx),asmprinter(asmprinter){}

void RISCVISel::condition_helper(BinaryInst* inst){
    assert(inst->GetType()==BoolType::NewBoolTypeGet());
    assert(inst->GetOperand(0)->GetType()==inst->GetOperand(1)->GetType());
    assert(inst->GetOperand(0)->GetType()==BoolType::NewBoolTypeGet()||inst->GetOperand(0)->GetType()==IntType::NewIntTypeGet()||inst->GetOperand(1)->GetType()==FloatType::NewFloatTypeGet());
    bool isint=(inst->GetOperand(0)->GetType()!=FloatType::NewFloatTypeGet());
    switch (inst->getopration())
    {
    case BinaryInst::Op_E:{
        if(isint){
            // xor vreg0, a, b
            // seqz vreg1, vreg0
            auto vreg0=ctx.createVReg(riscv_i32);
            auto vreg1=ctx.createVReg(riscv_i32);
            ctx.insert_val2mop(inst->GetDef(),vreg1);
            ctx(Builder(RISCVMIR::_xor,{vreg0,ctx.mapping(inst->GetOperand(0)),ctx.mapping(inst->GetOperand(1))}));
            ctx(Builder(RISCVMIR::_seqz,{vreg1,vreg0}));
        }
        else{
            // feq.s vreg0, a, b
            auto vreg0=ctx.createVReg(riscv_i32);
            ctx.insert_val2mop(inst->GetDef(),vreg0);
            ctx(Builder(RISCVMIR::_feq_s,{vreg0,ctx.mapping(inst->GetOperand(0)),ctx.mapping(inst->GetOperand(1))}));
        }
        break;
    }
    case BinaryInst::Op_NE:{
        if(isint){
            // xor vreg0, a, b
            // snez vreg1, vreg0
            auto vreg0=ctx.createVReg(riscv_i32);
            auto vreg1=ctx.createVReg(riscv_i32);
            ctx.insert_val2mop(inst->GetDef(),vreg1);
            ctx(Builder(RISCVMIR::_xor,{vreg0,ctx.mapping(inst->GetOperand(0)),ctx.mapping(inst->GetOperand(1))}));
            ctx(Builder(RISCVMIR::_snez,{vreg1,vreg0}));
        }
        else{
            // feq.s vreg0, a, b
            // seqz vreg1, vreg0
            auto vreg0=ctx.createVReg(riscv_i32);
            auto vreg1=ctx.createVReg(riscv_i32);
            ctx.insert_val2mop(inst->GetDef(),vreg1);
            ctx(Builder(RISCVMIR::_feq_s,{vreg0,ctx.mapping(inst->GetOperand(0)),ctx.mapping(inst->GetOperand(1))}));
            ctx(Builder(RISCVMIR::_seqz,{vreg1,vreg0}));
        }
        break;
    }
    case BinaryInst::Op_G:{
        if(isint){
            // slt vreg0, b, a
            // if b<a, vreg0=1, that's a>b
            auto vreg0=ctx.createVReg(riscv_i32);
            ctx.insert_val2mop(inst->GetDef(),vreg0);
            ctx(Builder(RISCVMIR::_slt,{vreg0,ctx.mapping(inst->GetOperand(1)),ctx.mapping(inst->GetOperand(0))}));
        }
        else{
            // flt vreg0, b, a
            auto vreg0=ctx.createVReg(riscv_i32);
            ctx.insert_val2mop(inst->GetDef(),vreg0);
            ctx(Builder(RISCVMIR::_flt_s,{vreg0,ctx.mapping(inst->GetOperand(1)),ctx.mapping(inst->GetOperand(0))}));
        }
        break;
    }
    case BinaryInst::Op_GE:{
        if(isint){
            // slt vreg0, a, b: if a>=b, vreg0 will be 0
            // seqz vreg1, vreg0: thus vreg1 will be 1
            auto vreg0=ctx.createVReg(riscv_i32);
            auto vreg1=ctx.createVReg(riscv_i32);
            ctx.insert_val2mop(inst->GetDef(),vreg1);
            ctx(Builder(RISCVMIR::_slt,{vreg0,ctx.mapping(inst->GetOperand(0)),ctx.mapping(inst->GetOperand(1))}));
            ctx(Builder(RISCVMIR::_seqz,{vreg1,vreg0}));
        }
        else{
            // fle vreg0 b, a
            auto vreg0=ctx.createVReg(riscv_i32);
            ctx.insert_val2mop(inst->GetDef(),vreg0);
            ctx(Builder(RISCVMIR::_fle_s,{vreg0,ctx.mapping(inst->GetOperand(1)),ctx.mapping(inst->GetOperand(0))}));
        }
        break;
    }
    case BinaryInst::Op_LE:{
        if(isint){
            // slt vreg0, b, a: if a<=b vreg0 will be 0
            // seqz vreg1, vreg0: thus vreg1 will be 1
            auto vreg0=ctx.createVReg(riscv_i32);
            auto vreg1=ctx.createVReg(riscv_i32);
            ctx.insert_val2mop(inst->GetDef(),vreg1);
            ctx(Builder(RISCVMIR::_slt,{vreg0,ctx.mapping(inst->GetOperand(1)),ctx.mapping(inst->GetOperand(0))}));
            ctx(Builder(RISCVMIR::_seqz,{vreg1,vreg0}));
        }
        else{
            // fle.s
            auto vreg0=ctx.createVReg(riscv_i32);
            ctx.insert_val2mop(inst->GetDef(),vreg0);
            ctx(Builder(RISCVMIR::_fle_s,{vreg0,ctx.mapping(inst->GetOperand(0)),ctx.mapping(inst->GetOperand(1))}));
        }
        break;
    }
    case BinaryInst::Op_L:{
        if(isint){
            // slt vreg0, a, b: if a<b, vreg0 will be 1
            auto vreg0=ctx.createVReg(riscv_i32);
            ctx.insert_val2mop(inst->GetDef(),vreg0);
            ctx(Builder(RISCVMIR::_slt,{vreg0,ctx.mapping(inst->GetOperand(0)),ctx.mapping(inst->GetOperand(1))}));
        }
        else{
            // flt.s
            auto vreg0=ctx.createVReg(riscv_i32);
            ctx.insert_val2mop(inst->GetDef(),vreg0);
            ctx(Builder(RISCVMIR::_flt_s,{vreg0,ctx.mapping(inst->GetOperand(0)),ctx.mapping(inst->GetOperand(1))}));
        }
        break;
    }
    default:
        assert(0&&"Invalid operation");
    }
}