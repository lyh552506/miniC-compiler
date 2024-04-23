#pragma once
#include "../lib/BaseCFG.hpp"
#include "../lib/CFG.hpp"
#include "gir.hpp"
#include "my_stl.hpp"
#include <variant>
#include <list>
class MachineUnit;
class MachineFunction;
class MachineBasicBlock;
class MachineInst : public User {
    friend class BlockLiveInfo;
    protected:
    User* IR;
    MachineBasicBlock* mbb;
    Operand rd;
    Operand rs1;
    Operand rs2;
    std::string opcode;
    int offset;
    Operand def;
    std::vector<Operand> used;
    public:
    MachineInst() = default;
    MachineInst(MachineBasicBlock* mbb, std::string opcode);
    MachineInst(MachineBasicBlock* mbb, std::string opcode, Operand rd);
    MachineInst(MachineBasicBlock* mbb, std::string opcode, Operand rd, Operand rs1);
    MachineInst(MachineBasicBlock* mbb, std::string opcode, Operand rd, Operand rs1, Operand rs2);
    MachineInst(User* IR, MachineBasicBlock* mbb, std::string opcode);
    MachineInst(User* IR, MachineBasicBlock* mbb, std::string opcode, Operand rd);
    MachineInst(User* IR, MachineBasicBlock* mbb, std::string opcode, Operand rd, Operand rs1);
    MachineInst(User* IR, MachineBasicBlock* mbb, std::string opcode, Operand rd, Operand rs1, Operand rs2);
    User* getIR();
    MachineBasicBlock* get_machinebasicblock();
    std::string GetOpcode();
    void SetOpcode(std::string opcode);
    Operand GetRd();
    Operand GetRs1();
    Operand GetRs2();
    Operand GetDefs();
    std::vector<Operand>& GetUses();
    // bool isVirtual(Operand Op);
    void SetRd(Operand rd);
    void SetRs1(Operand rs1);
    void SetRs2(Operand rs2);
    void SetDefs(Operand def);
    void print();
};

class MachineBasicBlock {
    protected:
    BasicBlock* block;
    MachineFunction* mfuc;
    std::string name;
    std::list<MachineInst*> minsts;
    int succNum;//后继块的数量
    public:
    MachineBasicBlock(BasicBlock* block, MachineFunction* parent);
    void set_lable(int func_num, int block_num);
    void set_succNum(int succNum);
    std::string get_name();
    int get_succNum();
    void set_name(std::string name);
    void addMachineInst(MachineInst* minst);
    std::list<MachineInst*>& getMachineInsts();
    BasicBlock* get_block();
    MachineFunction* get_parent();
    void print_block_lable();
};

class MachineFunction {
    protected:
    Function* func;
    MachineUnit* Munit;
    size_t offset;
    int alloca_num;
    size_t stacksize;
    std::vector<MachineBasicBlock*> mblocks;
    std::map<std::string, size_t> offsetMap;
    std::map<BasicBlock*, MachineBasicBlock*> blockMap;
    std::map<std::string, std::string> lableMap;
    public:
    MachineFunction(Function* func, MachineUnit* Munit);
    void set_offset_map(std::string name, size_t offset);
    void set_lable_map(std::string name, std::string lable);
    void set_blockMap(BasicBlock* bb, MachineBasicBlock* mbb);
    void set_alloca_and_num();
    void set_stacksize();

    Function* get_function();
    MachineUnit* get_machineunit();
    void addMachineBasicBlock(MachineBasicBlock* mblock);
    std::vector<MachineBasicBlock*>& getMachineBasicBlocks();
    std::map<BasicBlock*, MachineBasicBlock*>& get_blockMap();
    MachineBasicBlock* get_mbbFrombb(BasicBlock* block);
    MachineBasicBlock* GetBlock(std::string name);
    size_t get_offset(std::string name);
    std::string get_lable(std::string name);
    int get_allocanum();
    int get_stacksize();

    void print_func_name();
    void print_stack_frame();
    void print_stack_offset();
    void print_func_end();
};

class MachineUnit {
    protected:
    Module* unit;
    std::vector<MachineFunction*> mfuncs;
    public:
    MachineUnit(Module* unit);
    Module* get_module();
    void addMachineFunction(MachineFunction* mfuncs);
    std::vector<MachineFunction*>& getMachineFunctions();
};