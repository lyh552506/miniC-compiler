#include "../include/backend/RegAlloc.hpp"
#include "../include/backend/LegalizePass.hpp"
void spill_reg(Operand vreg);
void get_frameObj(Operand vreg);

void RegAllocImpl::RunGCpass() {
  gc = new GraphColor(m_func, ctx);
  gc->RunOnFunc();
  delete gc;
}