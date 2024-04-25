#pragma once
#include "RISCVType.hpp"
#include "BaseCFG.hpp"
/// @brief  Just need a type currently
class RISCVMOperand{
    RISCVType tp;
    public:
    /// RISCVMOperand();
    RISCVMOperand(RISCVType);
    virtual RISCVType GetType(){return tp;};
    virtual void print()=0;
    template<typename T>
    T* as(){
        return dynamic_cast<T*>(this);
    }
};

/// @note A wrapper for the constant data
/// @note should be legalize later 
class Imm:public RISCVMOperand{
    ConstantData* data;    
    public:
    Imm(ConstantData*);
    static Imm* GetImm(ConstantData*);
    void print()final;
};