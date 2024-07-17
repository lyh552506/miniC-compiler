#pragma once
#include "../../include/backend/RISCVMOperand.hpp"

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
        
        begin_normal_reg=zero,
        end_normal_reg=t6,
        begin_float_reg=ft0,
        end_float_reg=ft11,

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
    /// @return (1<<regenum), if valid 
    inline uint64_t GetPhyRegMask(){
        assert(regenum<64&&"incorrect regnum");
        return ((uint64_t)1)<<regenum;
    };
    inline bool isCallerSaved(){
        if(regenum==PhyReg::ra)return true;
        if(regenum>=PhyReg::t0&&regenum<=PhyReg::t2)return true;
        if(regenum>=PhyReg::a0&&regenum<=PhyReg::a7)return true;
        if(regenum>=PhyReg::t3&&regenum<=PhyReg::t6)return true;
        if(regenum>=PhyReg::ft0&&regenum<=PhyReg::ft7)return true;
        if(regenum>=PhyReg::fa0&&regenum<=PhyReg::fa7)return true;
        if(regenum>=PhyReg::ft8&&regenum<=PhyReg::ft11)return true;
        return false;
    };
    inline bool isCalleeSaved(){
        // if(regenum==sp)return true;
        if(regenum==s1)return true;
        // if(regenum>=PhyReg::s0&&regenum<=PhyReg::s1)return true;
        if(regenum>=PhyReg::s2&&regenum<=PhyReg::s11)return true;
        if(regenum>=PhyReg::fs0&&regenum<=PhyReg::fs1)return true;
        if(regenum>=PhyReg::fs2&&regenum<=PhyReg::fs11)return true;
        return false;
    };
};

namespace PhyRegMask{
    /// for a phyregister 
    PhyRegister* GetPhyReg(uint64_t);
    uint64_t GetPhyRegMask(PhyRegister*);
    bool isCallerSaved(uint64_t);
    bool isCalleeSaved(uint64_t);
    
    /// for a phyregister group
    void visit(uint64_t,std::function<void(uint64_t)>);
};

class VirRegister:public Register{
    int counter;
    uint32_t penalty_spill;
    uint32_t penalty_reload;

  public:
    inline uint32_t GetPenaltySpill() { return penalty_spill; };
    inline uint32_t GetPenaltyReload() { return penalty_reload; };
    VirRegister(RISCVType, uint32_t = 6, uint32_t = 6);
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
    LARegister(RISCVType, std::string, Register*);
    void print()final;
    Register*& GetVreg();
    void SetReg(PhyRegister*&);
    std::string GetName(){return rname;}
    bool isPhysical()final{return true;};
};

class RegisterList {
    private:
    std::vector<PhyRegister*> reglist_int;
    std::vector<PhyRegister*> reglist_float;
    std::vector<PhyRegister*> reglist_caller;
    std::vector<PhyRegister*> reglist_test;

    RegisterList();
    RegisterList(const RegisterList&) = delete;
    RegisterList& operator=(const RegisterList&) = delete;
    public:
    static RegisterList& GetPhyRegList();
    std::vector<PhyRegister*>& GetReglistInt();
    std::vector<PhyRegister*>& GetReglistFloat();
    std::vector<PhyRegister*>& GetReglistTest();
    std::vector<PhyRegister*>& GetReglistCaller();
};


