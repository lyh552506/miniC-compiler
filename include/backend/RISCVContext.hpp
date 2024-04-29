#pragma once
#include "RISCVMIR.hpp"
#include "RISCVRegister.hpp"
/// @note This class intend to store the context of the lowering process
/// maybe Singleton is a good choice
/// Should this be responsible for managing memories for operands?
class RISCVLoweringContext{
    std::map<Value*,RISCVMOperand*> val2mop;
    // std::map<Register*,std::string> reg2str;
    /// @warning inner impl use pointers for access, so an unique_ptr will be nice to avoid vector's reallocation
    using MFuncPtr=std::unique_ptr<RISCVFunction>;
    std::vector<MFuncPtr> functions;
    /// @todo should we add an entry here? Or we should output functions in any order?
    RISCVFunction* cur_func;
    RISCVBasicBlock* cur_mbb;

    /// @note
    /// case 1: user    : return a vreg of correndsponding type
        /// case 1.1 alloca : return an RISCVFrameObject, and insert it to current function   
    /// case 2: bb      : return a mbb
    /// case 3: consts  : return a imm
    /// case 4: function: return a machine function
    /// strategy: when its not in the map, create a new one
    /// This works as a factory but is not responsible for delete yet 
    RISCVMOperand* Create(Value*);
    public:  
    //
    void operator()(RISCVMIR*);
    void operator()(RISCVBasicBlock*);
    void operator()(RISCVFunction*);
    void insert_val2mop(Value*, RISCVMOperand*);
    RISCVMOperand* mapping(Value*);
    VirRegister* createVReg(RISCVType);
    std::vector<MFuncPtr>& GetFunctions();
    // std::vector<MFuncPtr> Get;
    void print();
};