#pragma once
#include "BackendPass.hpp"
#include "CFG.hpp"
#include "RISCVContext.hpp"


class RISCVISel:public BackEndPass<Function>{
    RISCVLoweringContext& ctx;
    RISCVMIR* Builder(RISCVMIR::RISCVISA,User*);
    RISCVMIR* Builder(RISCVMIR::RISCVISA,std::initializer_list<RISCVMOperand*>);
    void InstLowering(User*);
    void InstLowering(AllocaInst*);
    void InstLowering(StoreInst*);
    void InstLowering(LoadInst*);
    void InstLowering(FPTSI*);
    void InstLowering(SITFP*);
    void InstLowering(UnCondInst*);
    void InstLowering(CondInst*);
    void InstLowering(BinaryInst*);
    void InstLowering(GetElementPtrInst*);
    void InstLowering(PhiInst*);
    void InstLowering(CallInst*);
    void InstLowering(RetInst*);
    public:
    RISCVISel(RISCVLoweringContext&);
    bool run(Function*);
};