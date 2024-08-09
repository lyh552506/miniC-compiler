#pragma once
#include "../../include/backend/RISCVMOperand.hpp"
#include "../../include/backend/RISCVRegister.hpp"
#include "../../include/lib/MagicEnum.hpp"
class StackRegister;

class NamedMOperand:public RISCVMOperand{
    std::string name;
    public:
    std::string& GetName();
    NamedMOperand(std::string,RISCVType);
    void print()override;
};

class OuterTag:public NamedMOperand{
    public:
    OuterTag(std::string);
    static OuterTag* GetOuterTag(std::string);
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
    RISCVType contextype;
    public:
    RISCVFrameObject();
    RISCVFrameObject(Value*);
    RISCVFrameObject(VirRegister*);
    RISCVFrameObject(PhyRegister*);
    void GenerateStackRegister(int);
    size_t GetFrameObjSize();
    size_t GetBeginAddOff();
    size_t GetEndAddOff();
    RISCVType GetContextType();
    void SetBeginAddOff(size_t);
    void SetEndAddOff(size_t);
    StackRegister*& GetStackReg();
    void print()override;
};

class StackRegister:public Register{
    int offset;
    Register* reg=nullptr;
    RISCVFrameObject* parent=nullptr;
    public:
    StackRegister(RISCVFrameObject*, PhyRegister::PhyReg, int);
    StackRegister(RISCVFrameObject*, VirRegister*, int);
    StackRegister(PhyRegister::PhyReg, int);
    StackRegister(VirRegister*, int);
    std::string GetName(){return rname;}
    int GetOffset(){return offset;}
    RISCVFrameObject*& GetParent();
    VirRegister* GetVreg();
    Register*& GetReg();
    void SetPreg(PhyRegister*&);
    void SetReg(Register*);
    void SetOffset(int);
    void print()final;
    bool isPhysical()final;
};