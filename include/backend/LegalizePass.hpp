#pragma once
#include "RISCVMIR.hpp"
#include "RISCVContext.hpp"
class LegalizeConstInt;

class Legalize {
    RISCVLoweringContext& ctx;
    public:
    Legalize(RISCVLoweringContext&);
    void mvLegalize(mylist<RISCVBasicBlock, RISCVMIR>::iterator&);
    void freamobjLegalize(int, mylist<RISCVBasicBlock, RISCVMIR>::iterator&);
    void StackRegLegalize(int, mylist<RISCVBasicBlock, RISCVMIR>::iterator&);
    void stackOffsetLegalize(int, mylist<RISCVBasicBlock, RISCVMIR>::iterator&);
    void run();
};

class LegalizeConstInt {
    RISCVLoweringContext& ctx;
    public:
    LegalizeConstInt(RISCVLoweringContext&);
    void LegConstInt(RISCVMIR*, Imm*, mylist<RISCVBasicBlock,RISCVMIR>::iterator);
    void LegalizeMOpcode(RISCVMIR*);
    bool run();
};