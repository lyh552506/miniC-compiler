#pragma once
#include "RISCVMOperand.hpp"

/// @brief 这个写成接口吧...
class Register:public RISCVMOperand{
    RISCVType tp;
    public:
    Register(RISCVType _tp):RISCVMOperand(),tp(_tp){};
    virtual bool isPhysical()=0;
};

class PhyRegister:public Register{
    public:
    enum PhyReg{
        x0,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,
        x16,x17,x18,x19,x20,x21,x22,x23,x24,x25,x26,x27,x28,x29,x30,x31,
        f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,
        f16,f17,f18,f19,f20,f21,f22,f23,f24,f25,f26,f27,f28,f29,f30,f31,
        zero=x0,ra=x1,sp=x2,gp=x3,tp=x4,t0=x5,t1=x6,t2=x7,s0=x8,s1=x9,
        a0=x10,a1=x11,a2=x12,a3=x13,a4=x14,a5=x15,a6=x16,a7=x17,
        s2=x18,s3=x19,s4=x20,s5=x21,s6=x22,s7=x23,s8=x24,s9=x25,s10=x26,s11=x27,
        t3=x28,t4=x29,t5=x30,t6=x31
    }regenum;
    protected:
    PhyRegister(PhyReg);
    public:
    static PhyRegister* GetPhyReg(PhyReg);
    void print();
    bool isPhysical()final{return true;};
};

class VirRegister:public Register{
    int counter;
    public:
    VirRegister(RISCVType);
    void print()final;
    bool isPhysical()final{return false;};
};

/// @brief 用于加载地址的特殊寄存器，形如%hi(L0) %lo(L0)
/// Not finished
class LARegister:public Register{
    enum LAReg {
        hi,lo
    } regnum;
    std::string name;
    VirRegister* vreg=nullptr;
    public:
    LARegister(RISCVType, std::string);
    LARegister(RISCVType, std::string, VirRegister*);
    void print()final;
    bool isPhysical()final{return true;};
};

class StackRegister:public PhyRegister{
    int offset;
    public:
    StackRegister(PhyReg, int);
    void print()final;
};