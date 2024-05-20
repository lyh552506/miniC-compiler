#pragma once
#include "RISCVMOperand.hpp"
#include "RISCVRegister.hpp"

class NamedMOperand:public RISCVMOperand{
    std::string name;
    public:
    std::string& GetName();
    NamedMOperand(std::string,RISCVType);
    void print()override;
};

/// @brief A ptr type to some mem address
class RISCVObject:public NamedMOperand{
    protected:
    Type* tp;
    bool local;
    public:
    RISCVObject(Type*,std::string);
    RISCVObject(std::string);
};

/// @brief pointer to machine function or a machine global value
class RISCVGlobalObject:public RISCVObject{
    public:
    RISCVGlobalObject(Type*,std::string name);
    void print()override;
};

class RISCVTempFloatObject:public RISCVObject{
    public:
    RISCVTempFloatObject(std::string name);
    void print()override;
};


/// @brief A local variable's pointer
class RISCVFrameObject:public RISCVMOperand{
    /// @brief set later after RA
    size_t begin_addr_offsets=0;
    size_t end_addr_offsets=0;
    StackRegister* reg;
    size_t size=0;
    std::string name; 
    public:
    RISCVFrameObject(Value*);
    RISCVFrameObject(VirRegister*);
    void GenerateStackRegister(int);
    size_t GetFrameObjSize();
    size_t GetBeginAddOff();
    size_t GetEndAddOff();
    void SetBeginAddOff(size_t);
    void SetEndAddOff(size_t);
    StackRegister*& GetStackReg();
    void print()override;
};

class BegAddrRegister:public Register{
    RISCVFrameObject* frameobj;
    public:
    BegAddrRegister(RISCVFrameObject*);
    void print()final;
    RISCVFrameObject*& GetFrameObj() {return frameobj;}
    std::string GetName() {return rname;}
    bool isPhysical()final{return true;}
};