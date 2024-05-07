#include "RISCVISel.hpp"
/// @todo 参数带有浮点数的情况

void LowerFormalArguments(Function* func, RISCVLoweringContext& ctx) {
    std::vector<std::unique_ptr<Value>>& params = func->GetParams();
    if (params.size()==0) {return;}
    else {
        int paramnum=params.size();
        int min=paramnum>8?8:paramnum;
        if(paramnum>8) {
            int offset =0;
            for(int i=paramnum-1; i>min-1; --i) {
                if(params[i]->GetType()->GetTypeEnum()==InnerDataType::IR_Value_INT) {
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
                else if(params[i]->GetType()->GetTypeEnum()==InnerDataType::IR_Value_Float) {
                    auto loadinst = new RISCVMIR(RISCVMIR::_flw);
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
        }

        int regnum=PhyRegister::PhyReg::a0;
        for (int i=0; i<min; ++i) {
            VirRegister* vreg = ctx.createVReg(RISCVTyper(params[i]->GetType()));
            auto minst = new RISCVMIR(RISCVMIR::mv);
            minst->SetDef(vreg);
            minst->AddOperand(PhyRegister::GetPhyReg(static_cast<PhyRegister::PhyReg>(regnum)));
            ctx.insert_val2mop(params[i].get(), vreg);
            ctx(minst);
            regnum+=1;
        }
    }
}