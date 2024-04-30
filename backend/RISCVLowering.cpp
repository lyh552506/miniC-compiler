#include "RISCVLowering.hpp"
#include "PhiElimination.hpp"

RISCVAsmPrinter* asmprinter;
void RISCVModuleLowering::LowerGlobalArgument(Module* m){
    // need file name
    asmprinter = new RISCVAsmPrinter("file", m, ctx);
    asmprinter->printAsmGlobal();
    // assert(0&&"Handled later");
}

bool RISCVModuleLowering::run(Module* m){
    LowerGlobalArgument(m);
    // start lowering function
    RISCVFunctionLowering funclower(ctx);
    auto& funcS=m->GetFuncTion();
    for(auto &func:funcS){
        if(funclower.run(func.get())){
            func->print();
            std::cerr<<"FUNC Lowering failed\n";
        }
    }
    
    ctx.print();
    return false;
}

bool RISCVFunctionLowering::run(Function* m){
    /// @note after isel, all insts will be User with an opcode. Only call, ret is not dealt with after this 
    /// @todo deal with alloca and imm
    /// @todo a scheduler can be added here, before or when emitting code to 3-address code
    /// @note This is destory SSA form to 3-address code with mixture of phy and vir regs
    ctx(ctx.mapping(m)->as<RISCVFunction>());
    LowerFormalArguments(m);
    RISCVISel isel(ctx);
    isel.run(m);
    PhiElimination phi(ctx);
    phi.run(m);
    // Register Allocation

    return false;
}

void RISCVFunctionLowering::LowerFormalArguments(Function* func) {
    std::vector<std::unique_ptr<Value>>& params = func->GetParams();
    if (params.size()==0) {return;}
    else {
        // ctx(Builder(RISCVMIR::mv, {ctx.createVReg(RISCVTyper(inst->GetType())), PhyRegister::GetPhyReg(PhyRegister::PhyReg::a0)}));
        int paramnum=params.size();
        int max_param=8;
        int min=std::min(paramnum, max_param);
        if(min>8) {
            int offset =0;
            for(int i=paramnum; i>min; --i) {
                if(params[paramnum]->GetType()->GetTypeEnum()==InnerDataType::IR_Value_Float) 
                    offset+=4;
                else if(params[paramnum]->GetType()->GetTypeEnum()==InnerDataType::IR_Value_INT)
                    offset+=4;
                else if(params[paramnum]->GetType()->GetTypeEnum()==InnerDataType::IR_PTR)
                    offset+=8;
                else assert(0&&"Error type in param");
            }
        
            for(int i=paramnum; i>min; --i) {
                if(params[i]->GetType()->GetTypeEnum()==InnerDataType::IR_Value_Float\
                || params[i]->GetType()->GetTypeEnum()==InnerDataType::IR_Value_INT) {
                    auto loadinst = new RISCVMIR(RISCVMIR::_lw);
                    VirRegister* vreg = ctx.createVReg(RISCVTyper(params[i]->GetType()));
                    loadinst->SetDef(vreg);
                    PhyRegister* preg = PhyRegister::GetPhyReg(PhyRegister::PhyReg::s0);
                    StackRegister* stackreg = new StackRegister(PhyRegister::PhyReg::s0, offset);
                    loadinst->AddOperand(stackreg);
                    ctx.insert_val2mop(params[i].get(), vreg);
                    ctx(loadinst); 
                    offset+=4;
                }
                else if(params[i]->GetType()->GetTypeEnum()==InnerDataType::IR_PTR){
                    auto loadinst = new RISCVMIR(RISCVMIR::_ld);
                    VirRegister* vreg = ctx.createVReg(RISCVTyper(params[i]->GetType()));
                    loadinst->SetDef(vreg);
                    PhyRegister* preg = PhyRegister::GetPhyReg(PhyRegister::PhyReg::s0);
                    StackRegister* stackreg = new StackRegister(PhyRegister::PhyReg::s0, offset);
                    loadinst->AddOperand(stackreg);
                    ctx.insert_val2mop(params[i].get(), vreg);
                    ctx(loadinst);
                    offset+=8;
                }
                else assert(0&&"Error type in param");

            }
        } else {
            for (int i=0; i<min; ++i) {
                int regnum=PhyRegister::PhyReg::a0;
                VirRegister* vreg = ctx.createVReg(RISCVTyper(params[i]->GetType()));
                auto minst = new RISCVMIR(RISCVMIR::mv);
                minst->SetDef(vreg);
                minst->AddOperand(PhyRegister::GetPhyReg(static_cast<PhyRegister::PhyReg>(regnum)));
                ctx.insert_val2mop(params[i].get(), vreg);
                regnum+=i;
            }
        }
    }
}