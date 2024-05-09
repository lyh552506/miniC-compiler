#pragma once
#include "RISCVMOperand.hpp"
#include "RISCVRegister.hpp"
// #include "RISCVMIR.hpp"
class RISCVFunction;

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
    size_t begin_addr_offsets;
    StackRegister* reg=nullptr;
    size_t size;
    std::string name;
    public:
    RISCVFrameObject(Value*);
    RISCVFrameObject(VirRegister*);
    void GenerateStackRegister();
    // RISCVFrameObject(Type*,std::string);
    void print()override;
};

class RISCVFrame{
    private:
    RISCVFunction* parent;
    std::vector<std::unique_ptr<RISCVFrameObject>> frameobjs;
    public:
    RISCVFrame(RISCVFunction*);
    // RISCVFrame();
    void spill(VirRegister*);
    void spill(Value*);
    std::vector<std::unique_ptr<RISCVFrameObject>>& GetFrameObjs();
    void GenerateFrame();
};