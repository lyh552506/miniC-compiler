#pragma once
#include "../../include/backend/RISCVType.hpp"
#include "../../include/lib/BaseCFG.hpp"
class Register;
/// @brief  Just need a type currently
class RISCVMOperand{
    RISCVType tp;
    public:
    RISCVMOperand(RISCVType _tp):tp(_tp){};
    RISCVType GetType(){return tp;}
    virtual void print()=0;
    template<typename T>
    T* as(){
        return dynamic_cast<T*>(this);
    }
    // bool ignoreLA();
    Register* ignoreLA();
};

/// @note A wrapper for the constant data
/// @note should be legalize later 
class Imm:public RISCVMOperand{
    ConstantData* data;
    public:
    Imm(ConstantData*);
    ConstantData* Getdata();
    static Imm* GetImm(ConstantData*);
    void print()final;
};