#include "RegAlloc.hpp"
void spill_reg(Operand vreg);
void get_frameObj(Operand vreg);

void RegAllocImpl::RunGCpass(){
    gc=new GraphColor(m_func,availble);
    gc->RunOnFunc();
}