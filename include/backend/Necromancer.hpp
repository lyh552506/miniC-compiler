#pragma once
#include "BackendPass.hpp"
#include "RISCVMIR.hpp"
#include "RegAlloc.hpp"

/// @brief 关于 Type， 因为后端的 Type 指针不用告诉你指向的是什么，所以用 void type 代替
/// 所以其实只有i32,f32,ptr 三种类型...
/// LAREGISTER:     %hi/%lo这种很难去评判，直接整体当作一个东西，最好是同一个指针
/// STACKREGISTER:  可以看作 use offset和里面的register，评价是User
/// OBJECT: 只要保证是同一个指针，还是可以分析的
/// VREG:
/// PREG: 好说

class RISCVSSAAlias{
    RISCVMOperand* realname;
    public:
    virtual RISCVMOperand* getAlias();
    void setAlias(RISCVMOperand*);
};

/// @brief IMM/LAREGISTER/OutSideDefine
class RISCVSSAValue:public Value, public RISCVSSAAlias{
    public:
    enum SSAValueUsage{
        isIMM,
        isLARegister,
        isDefinedOutside,
    };
    private:
    SSAValueUsage usage;
    public:
    SSAValueUsage getValueUsage();
    RISCVSSAValue(RISCVMOperand*);
};

/// @brief 只有一个def的指令
/// call 语句怎么办？
/// call 语句 def 一坨
/// call 语句除了 a0/fa0 被用到，其他被直接用到的情况完全非法
/// (未定义行为，所以视为只def了一个也行）
/// ~~感谢指令集~~

/// load store 和 call 需要强制确保相对顺序关系，类似 glue
/// 如果不要glue的话，就没办法脱离mir完全变为dag形式
/// ***或者沿用list形式保留一个RISCVSSABasicBlock的形式，也行***
class RISCVSSAInstruction:public User,public list_node<RISCVSSABasicBlock,RISCVSSAInstruction>,public RISCVSSAAlias{
    RISCVMIR::RISCVISA opcode;
    public:
    void print()final;
    void setOpcode(RISCVMIR::RISCVISA);
    RISCVMIR::RISCVISA getOpcode();
    RISCVSSAInstruction(Type*);
    RISCVMIR* reEmit();
};

class RISCVSSABasicBlock:public mylist<RISCVSSABasicBlock,RISCVSSAInstruction>,public RISCVSSAAlias{
    // bro who is responsible the memory management
    std::vector<std::unique_ptr<Value*>> MemoryManager;
    public:
    RISCVSSAValue* getSSAValue(RISCVMOperand*);
    RISCVSSAInstruction* getSSAInstruction(RISCVMIR::RISCVISA,RISCVMOperand*);
    RISCVSSAInstruction* getSSAInstruction(RISCVMIR::RISCVISA,Type*);
    
    void reEmit();
    RISCVSSABasicBlock(RISCVBasicBlock*);
};

class Necromancer:public BackEndPass<RISCVFunction>{    
    std::unordered_map<RISCVBasicBlock*,std::unique_ptr<RISCVSSABasicBlock>> storage;
    void runOnBasicBlock(std::set<MOperand>&,std::set<MOperand>&,RISCVBasicBlock*);
    public:
    RISCVSSABasicBlock* getSSABasicBlock(RISCVBasicBlock*);
    bool run(RISCVFunction*) override;
};