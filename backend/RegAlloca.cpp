// 
#include "AsmPrinter.hpp"
void spill_reg(Operand vreg);
void get_frameObj(Operand vreg);

enum REG {
    r0,
    r1,
    r2,
    r3,
    r4,
    r5,
    r6,
    r7,
    r8,
    r9,
    r10,
    r11,
    r12,
    r13,
    r14,
    r15,
    r16,
    r17,
    r18,
    r19,
    r20,
   r21,
};
//%hi %lo

class reginfo {
    public:
    REG reg;
    std::vector<REG> reginfo;
    // 0 空 1 用
};