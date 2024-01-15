#pragma once
#include "../lib/BaseCFG.hpp"
#include "../lib/CFG.hpp"
#include <variant>
class MachineInst : public User {
    public: virtual void printinst() = 0;
    void print() {};  
};
class MachineBinaryInst : public MachineInst {
private:
    Operand rd;
    Operand rs1;
    Operand rs2;
enum Binary_Inst {
    //算数运算
    add, //加法 add rd, rs1, rs2
    addw,
    addi, // addi rd, rs1, imm  
    addiw,
    sub, //减法 sub rd, rs1, rs2
    subw,
    mul, //乘法 mul rd, rs1, rs2
    mulh,
    mulw,
    div, //除法 div rd, rs1, rs2
    divw,
    rem, //取余 rem rd, rs1, rs2
    remw,
    // sll, //逻辑左移 sll rd, rs1, rs2
    // slli,
    // slliw,
    // sllw,
    // srl, //逻辑右移 srl rd, rs1, rs2
    // srlw,
    // srli, //逻辑右移立即数 srli rd, rs1, imm
    // srliw,
    // sra, //算术右移 sra rd, rs1, rs2
    // sraw, 
    // srai, //算术右移立即数 srai rd, rs1, imm
    // sraiw,
    And, //按位与 and rd, rs1, rs2
    andi,
    Or, //按位或 or rd, rs1, rs2
    ori,
    // Xor, //按位异或 xor rd, rs1, rs2
    // xori
};
    Binary_Inst opcode;
    std::string oprator;
public:
    // MachineBinaryInst(Binary_Inst opcode, Operand rd, Operand rs1, Operand rs2);//imm
    // friend std::ofstream& operator<<(std::ostream& os, const MachineBinaryInst& inst) {
    //     os << inst.rd->GetName() << ", " << inst.rs1->GetName() << ", " << inst.rs2->GetName();
    //     return os;
    //}
    MachineBinaryInst(std::string oprator, Operand rd, Operand rs1, Operand rs2);//imm

    //void printmachineinst(std::ofstream &outputFile) ;
    void print(int&) {};
    void printinst();
};

// class MachineLoadInst : public User {
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

// class MachineStoreInst : public User {
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

// class MachineBranchInst : public User {
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

// class MachineJumpInst : public User {
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

// class MachineCmpInst : public User {
// private:
//     Operand rd;
//     Operand rs1;
//     Operand rs2;
//     //Operand imm;
// enum Cmp_Inst {
//     slt, //有符号比较 slt rd, rs1, rs2
//     slti,//slti rd, rs1, imm
//     sltz,//sltz rd, rs1
//     snez,//sne rd, rs1
// };
//     Cmp_Inst opcode;
// public:
//     MachineCmpInst(Cmp_Inst opcode, Operand rd, Operand rs1, Operand rs2);//imm
//     MachineCmpInst(Cmp_Inst opcode, Operand rd, Operand rs1);
//     void printmachineinst(std::ofstream &outputFile) final;
// };

// class PseudoInst : public User {
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

class MachineBasicBlock :public BasicBlock {
    int block_num;
    public:
    void print_block_lable(int func_num);
};

class MachineFunction : public Function {
    int func_num;
    int offset;
    std::map<std::string, int> offsetMap;
    public:
    int get_func_num();
    int get_stack_size();
    int get_offset(std::string name);
    //alloca 指令中找name?
    //临时寄存器能否找到变量名？
    std::map<std::string, int> set_offset_map(std::string& name, int& offset);
    void print_func_name();
    void print_stack_frame();
};