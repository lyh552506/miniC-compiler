#include "RISCVMIR.hpp"
#include "RISCVContext.hpp"
class LegalizeConstInt {
    RISCVLoweringContext& ctx;
    public:
    LegalizeConstInt(RISCVLoweringContext&);
    void LegConstInt(RISCVMIR*, Imm*, mylist<RISCVBasicBlock,RISCVMIR>::iterator);
    void LegalizeMOpcode(RISCVMIR*);
    bool run();
};

class Legalize {
    RISCVLoweringContext& ctx;
    public:
    Legalize(RISCVLoweringContext&);
    void LegalizePass();
    void mvLegalize(mylist<RISCVBasicBlock, RISCVMIR>::iterator&);
    void run();
};