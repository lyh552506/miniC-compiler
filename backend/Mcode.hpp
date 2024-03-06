#pragma once
#include "../lib/BaseCFG.hpp"
#include "../lib/CFG.hpp"
#include <variant>
class MachineFunction;
class MachineBasicBlock;

class MachineInst : public User {
    protected:
    MachineBasicBlock* mbb;
    Operand rd;
    Operand rs1;
    Operand rs2;
    std::string opcode;
    public:
    MachineInst(MachineBasicBlock* mbb, std::string opcode);
    MachineInst(MachineBasicBlock* mbb, std::string opcode, Operand rd);
    MachineInst(MachineBasicBlock* mbb, std::string opcode, Operand rd, Operand rs1);
    MachineInst(MachineBasicBlock* mbb, std::string opcode, Operand rd, Operand rs1, Operand rs2);
    MachineBasicBlock* get_machinebasicblock();
    std::string GetOpcode();
    virtual void print();
};
// class MachineBinaryInst : public MachineInst {
// enum Binary_Inst {
//     //算数运算
//     add, //加法 add rd, rs1, rs2
//     addw,
//     addi, // addi rd, rs1, imm  
//     addiw,
//     sub, //减法 sub rd, rs1, rs2
//     subw,
//     mul, //乘法 mul rd, rs1, rs2
//     mulh,
//     mulw,
//     div, //除法 div rd, rs1, rs2
//     divw,
//     rem, //取余 rem rd, rs1, rs2
//     remw,
//     // sll, //逻辑左移 sll rd, rs1, rs2
//     // slli,
//     // slliw,
//     // sllw,
//     // srl, //逻辑右移 srl rd, rs1, rs2
//     // srlw,
//     // srli, //逻辑右移立即数 srli rd, rs1, imm
//     // srliw,
//     // sra, //算术右移 sra rd, rs1, rs2
//     // sraw, 
//     // srai, //算术右移立即数 srai rd, rs1, imm
//     // sraiw,
//     And, //按位与 and rd, rs1, rs2
//     andi,
//     Or, //按位或 or rd, rs1, rs2
//     ori,
//     // Xor, //按位异或 xor rd, rs1, rs2
//     // xori
// };
// public:
//     // MachineBinaryInst(std::string opcode, Operand rd, Operand rs1, Operand rs2);//imm
//     void print() {};
// };

// class MachineLoadInst : public MachineInst {
// private:
//     Operand rd;
//     Operand offset;
//     Operand rs1;
// enum Load_Inst {
//     lb, //加载 lb rd, offset(rs1)
//     lh,
//     lw,
//     ld,
//     li, //加载立即数 li rd, imm
//     la //加载地址 la rd, label
// };
//     Load_Inst opcode;
// public:
//     MachineLoadInst(Load_Inst opcode, Operand rd, Operand offset, Operand rs1);//imm
//     void printmachineinst(std::ofstream &outputFile) final;
// };

// class MachineStoreInst : public MachineInst {
// private:
//     Operand rs1;
//     Operand offset;
//     Operand rs2;
// enum Store_Inst {
//     sb, //存储 sb rs2, offset(rs1)
//     sh,
//     sw,
//     sd
// };
//     Store_Inst opcode;
// public:
//     MachineStoreInst(Store_Inst opcode, Operand rs2, Operand offset, Operand rs1);
//     void printmachineinst(std::ofstream &outputFile) final;
// };

// class MachineBranchInst : public MachineInst {
// private:
//     Operand rs1;
//     Operand rs2;
//     Operand offset;
// enum Branch_Inst {
//     beq, //分支 beq rs1, rs2, offset
//     bge, // >=
//     bgt, // >
//     ble, // <=
//     blt, // <
//     bne, // !=  bne = 6;
//     beqz, // == 0 beqz rs1, offset
//     bgez,
//     bgtz,
//     blez,
//     bltz,
//     bnez
// };
//     Branch_Inst opcode;
// public:
//     MachineBranchInst(Branch_Inst opcode, Operand rs1, Operand rs2, Operand offset);
//     MachineBranchInst(Branch_Inst opcode, Operand rs1, Operand offset);
//     void printmachineinst(std::ofstream &outputFile) final;
// };

// class MachineJumpInst : public MachineInst {
// private:
//     Operand rd;
//     Operand rs1;
//     Operand offset;
// enum Jump_Inst {
//     jal, //跳转并保存返回地址  jal rd, offset
//     jalr,// 跳转并保存返回地址 jalr rd, offset(rs1)
//     j, //跳转 j offset
//     jr, //跳转 jr rs1
// };
//     Jump_Inst opcode;
// public:
//     MachineJumpInst(Jump_Inst opcode, Operand rd, Operand offset);
//     MachineJumpInst(Jump_Inst opcode, Operand rd, Operand offset, Operand rs1);
//     MachineJumpInst(Jump_Inst opcode, Operand offset);
//     MachineJumpInst(Jump_Inst opcode, Operand rs1);
//     //j,jr 等还需处理
//     void printmachineinst(std::ofstream &outputFile) final;
// };

// class MachineCmpInst : public MachineInst {
// private:
// enum Cmp_Inst {
//     slt, //有符号比较 slt rd, rs1, rs2
//     slti,//slti rd, rs1, imm
//     sltz,//sltz rd, rs1
//     snez,//sne rd, rs1
// };
// public:
//     // MachineCmpInst(std::string opcode, Operand rd, Operand rs1, Operand rs2);//imm
//     // MachineCmpInst(std::string opcode, Operand rd, Operand rs1);
//     // void print();
// };

// class PseudoInst : public MachineInst {
// private:
//     Operand rd;
//     Operand rs1;
// enum Pseudo_Inst {
//     // Nop, //空指令
//     // Auipc,
//     mv, //移动 mv rd, rs1
//     ret //返回 ret
// };
//     Pseudo_Inst opcode;
// public:
//     PseudoInst(Pseudo_Inst opcode, Operand rd, Operand rs1);
//     PseudoInst(Pseudo_Inst opcode);
//     void printmachineinst(std::ofstream &outputFile) final;
// };

class MachineBasicBlock {
    protected:
    BasicBlock* block;
    MachineFunction* mfuc;
    std::string name;
    public:
    MachineBasicBlock(BasicBlock* block, MachineFunction* parent);
    void set_lable(int func_num, int block_num);
    std::string get_name();
    void set_name(std::string name);
    BasicBlock* get_block();
    MachineFunction* get_parent();
    void print_block_lable(int func_num, int block_num);
};

class MachineFunction {
    protected:
    Function* func;
    size_t offset;
    int alloca_num;
    size_t stacksize;
    std::map<std::string, size_t> offsetMap;
    //std::map<size_t, std::string> offsetMap;
    public:
    MachineFunction(Function* func);
    void set_offset_map(std::string name, size_t offset);
    void set_alloca_and_num();
    void set_stacksize();

    size_t get_offset(std::string name);
    int get_allocanum();
    int get_stacksize();

    void print_func_name();
    void print_stack_frame();
    void print_stack_offset();
    void print_func_end();
};