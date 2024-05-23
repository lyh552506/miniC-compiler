#pragma once
#include "BackendPass.hpp"
#include "CFG.hpp"
#include "RISCVContext.hpp"
#include "RISCVRegister.hpp"
#include "RISCVMIR.hpp"
#include "BaseCFG.hpp"
#include <algorithm>

void LowerFormalArguments(Function* func, RISCVLoweringContext& ctx);

class RISCVISel:public BackEndPass<Function>{
    RISCVLoweringContext& ctx;
    RISCVMIR* Builder(RISCVMIR::RISCVISA,User*);
    RISCVMIR* Builder_withoutDef(RISCVMIR::RISCVISA,User*);
    RISCVMIR* Builder(RISCVMIR::RISCVISA,std::initializer_list<RISCVMOperand*>);
    RISCVMIR* Builder_withoutDef(RISCVMIR::RISCVISA _isa,std::initializer_list<RISCVMOperand*> list);
    void InstLowering(User*);
    void InstLowering(AllocaInst*);
    void InstLowering(StoreInst*);
    void InstLowering(LoadInst*);
    void InstLowering(FPTSI*);
    void InstLowering(SITFP*);
    void InstLowering(UnCondInst*);
    void InstLowering(CondInst*);
    void InstLowering(BinaryInst*);
    //
    void InstLowering(GetElementPtrInst*);
    //
    void InstLowering(PhiInst*);
    //
    void InstLowering(CallInst*);
    void InstLowering(RetInst*);
 
    RISCVMOperand* Li_Intimm(ConstIRInt* Intconst);
    public:
    RISCVISel(RISCVLoweringContext&);
    bool run(Function*);
};

