#pragma once
#include "RISCVMOperand.hpp"

/// @brief 这个写成接口吧...
class Register:public RISCVMOperand{
    protected:
    std::string rname;
    public:
    Register(RISCVType _tp):RISCVMOperand(_tp){};
    Register(RISCVType _tp,std::string_view _name):RISCVMOperand(_tp),rname(_name){};
    virtual bool isPhysical()=0;
    virtual std::string GetName()=0;
};

class PhyRegister:public Register{
    public:
    enum PhyReg{
        zero,ra,sp,gp,tp,t0,t1,t2,s0,s1,
        a0,a1,a2,a3,a4,a5,a6,a7,
        s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,
        t3,t4,t5,t6,
        ft0,ft1,ft2,ft3,ft4,ft5,ft6,ft7,
        fs0,fs1,fa0,fa1,
        fa2,fa3,fa4,fa5,fa6,fa7,
        fs2,fs3,fs4,fs5,fs6,fs7,fs8,fs9,fs10,fs11,
        ft8,ft9,ft10,ft11,
        _NULL,
        x0=zero,x1=ra,x2=sp,x3=gp,x4=tp,x5=t0,x6=t1,x7=t2,x8=s0,x9=s1,
        x10=a0,x11=a1,x12=a2,x13=a3,x14=a4,x15=a5,x16=a6,x17=a7,
        x18=s2,x19=s3,x20=s4,x21=s5,x22=s6,x23=s7,x24=s8,x25=s9,x26=s10,x27=s11,
        x28=t3,x29=t4,x30=t5,x31=t6
    }regenum;
    protected:
    PhyRegister(PhyReg);
    public:
    static PhyRegister* GetPhyReg(PhyReg);
    PhyReg Getregenum(){return regenum;};
    void print();
    std::string GetName();
    bool isPhysical()final{return true;};
};

class VirRegister:public Register{
    int counter;
    public:
    VirRegister(RISCVType);
    std::string GetName();
    void print()final;
    bool isPhysical()final{return false;};
};

/// @brief 用于加载地址的特殊寄存器，形如%hi(L0) %lo(L0)
/// Not finished
class LARegister:public Register{
    Register* vreg=nullptr;
    public:
    enum LAReg {
        hi,lo
    } regnum;
    LARegister(RISCVType, std::string);
    LARegister(RISCVType, std::string, LAReg);
    LARegister(RISCVType, std::string, VirRegister*);
    void print()final;
    Register*& GetVreg();
    void SetReg(PhyRegister*&);
    std::string GetName(){return rname;}
    bool isPhysical()final{return true;};
};

class RegisterList {
    private:
    // static RegisterList* reglist;
    std::vector<PhyRegister*> reglist_int;
    std::vector<PhyRegister*> reglist_float;
    std::vector<PhyRegister*> reglist_test;
    // std::vector<PhyRegister*> reglist_param_int;
    // std::vector<PhyRegister*> reglist_temp_int;
    // std::vector<PhyRegister*> reglist_param_float;
    // std::vector<PhyRegister*> reglist_temp_float;
    RegisterList();
    RegisterList(const RegisterList&) = delete;
    RegisterList& operator=(const RegisterList&) = delete;
    public:
    static RegisterList& GetPhyRegList();
    std::vector<PhyRegister*>& GetReglistInt();
    std::vector<PhyRegister*>& GetReglistFloat();
    std::vector<PhyRegister*>& GetReglistTest();
    // std::vector<PhyRegister*>& GetReglistParamInt();
    // std::vector<PhyRegister*>& GetReglistTempInt();
    // std::vector<PhyRegister*>& GetReglistParamFloat();
    // std::vector<PhyRegister*>& GetReglistTempFloat();
};


