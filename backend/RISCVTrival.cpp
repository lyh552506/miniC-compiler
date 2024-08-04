#include "../include/backend/RISCVTrival.hpp"

RISCVMIR* RISCVTrival::CopyFrom(VirRegister* dst,RISCVMOperand* src){
    RISCVMIR* copyinst = nullptr;
    if(auto imm=src->as<Imm>()){
        assert(imm->GetType()==RISCVType::riscv_i32);
        copyinst=new RISCVMIR(RISCVMIR::li);
    }
    else if(dst->GetType()==RISCVType::riscv_float32 && src->GetType()==RISCVType::riscv_float32) {
        copyinst=new RISCVMIR(RISCVMIR::_fmv_s);
    }
    else{
        copyinst=new RISCVMIR(RISCVMIR::mv);
    }
    // else assert(0&&"Error Type!");
        copyinst->SetDef(dst);
        copyinst->AddOperand(src);
    return copyinst;
}