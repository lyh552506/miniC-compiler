#pragma once
#include "../../include/backend/RISCVMIR.hpp"
#include "../../include/backend/RISCVContext.hpp"
class LegalizeConstInt;

class Legalize {
    RISCVLoweringContext& ctx;
    public:
    Legalize(RISCVLoweringContext&);
    void LegalizePass(mylist<RISCVBasicBlock, RISCVMIR>::iterator);
    void LegalizePass_before(mylist<RISCVBasicBlock, RISCVMIR>::iterator);
    void LegalizePass_after(mylist<RISCVBasicBlock, RISCVMIR>::iterator);
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
    void run_beforeRA();
    void run_afterRA();
};