#include "RISCVTrival.hpp"

RISCVMIR* RISCVTrival::CopyFrom(VirRegister* dst,RISCVMOperand* src){
    auto copyinst=new RISCVMIR(RISCVMIR::mv);
    copyinst->SetDef(dst);
    copyinst->AddOperand(src);
    return copyinst;
}