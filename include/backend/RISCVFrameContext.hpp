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
};

/// @brief A local variable's pointer
class RISCVFrameObject:public RISCVObject{
    /// @brief set later after RA
    size_t begin_addr_offsets;
    StackRegister* reg=nullptr;
    public:
    RISCVFrameObject(Type*,std::string);
    void print()override;
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

