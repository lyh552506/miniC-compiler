#include "TrivalOperation.hpp"

RISCVMIR* emitCopy(VirRegister* dst,RISCVMOperand* src){
    if(auto reg=dynamic_cast<VirRegister*>(src)){
        
    }
    else if(auto imm=dynamic_cast<Imm*>(src)){

    }
    assert(0&&"Can't handle this type of operand");
}