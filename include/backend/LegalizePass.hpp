#pragma once
#include "RISCVMIR.hpp"
#include "RISCVContext.hpp"
class LegalizeConstInt;

class Legalize {
    RISCVLoweringContext& ctx;
    public:
    Legalize(RISCVLoweringContext&);
    void LegalizePass(mylist<RISCVBasicBlock, RISCVMIR>::iterator);
    // 
    void StackAndFrameLegalize(int ,mylist<RISCVBasicBlock, RISCVMIR>::iterator&);
    void OffsetLegalize(int, mylist<RISCVBasicBlock, RISCVMIR>::iterator&);

    // Legalize const int
    void zeroLegalize(int, mylist<RISCVBasicBlock, RISCVMIR>::iterator&);
    void branchLegalize(int, mylist<RISCVBasicBlock, RISCVMIR>::iterator&);
    void noImminstLegalize(int, mylist<RISCVBasicBlock, RISCVMIR>::iterator&);
    void constintLegalize(int, mylist<RISCVBasicBlock, RISCVMIR>::iterator&);
    void MOpcodeLegalize(RISCVMIR*);
    bool isImminst(RISCVMIR::RISCVISA);
    void run();
    void run_afterRA();
};