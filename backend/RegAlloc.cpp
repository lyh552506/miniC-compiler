#include "RegAlloc.hpp"
#include "LegalizePass.hpp"
void spill_reg(Operand vreg);
void get_frameObj(Operand vreg);

void RegAllocImpl::RunGCpass(){
    gc=new GraphColor(m_func, ctx);
    gc->RunOnFunc();

    // Generate Frame of current Function
    // And generate the head and tail of frame here
    RISCVFrame& frame = *m_func->GetFrame();
    frame.GenerateFrame();
    frame.GenerateFrameHead();
    frame.GenerateFrameTail();

    Legalize legal(ctx);
    legal.run();

    gc->RunOnFunc();
}