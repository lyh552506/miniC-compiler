#include "RISCVISel.hpp"

void LowerFormalArguments(Function* func, RISCVLoweringContext& ctx) {
    std::vector<std::unique_ptr<Value>>& params = func->GetParams();
    if (params.size()==0) {return;}
    else {
        // ctx(Builder(RISCVMIR::mv, {ctx.createVReg(RISCVTyper(inst->GetType())), PhyRegister::GetPhyReg(PhyRegister::PhyReg::a0)}));
        int paramnum=params.size();
        int max_param=9;
        int min=std::min(paramnum, max_param);
        if(min>9) {
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
                ctx(minst);
                regnum+=i;
            }
        }
    }
}