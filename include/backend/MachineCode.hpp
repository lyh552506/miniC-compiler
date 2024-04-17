// #pragma once
// #include<string>
// #include<vector>
// #include<iostream>  
// #include <unordered_map>
// #include"../lib/MagicEnum.hpp"
// #include"../lib/CFG.hpp"

// class MachineUnit;
// class MachineFunction;
// class MachineBlock;
// class MachineInst;

// class MachineOperand
// {
// private:
//     int type;
//     int val;
//     std::string lable;
// public:
// enum OperandType{
//     FREG,//虚拟寄存器
//     REG, 
//     IMM, 
//     //MEM, // MEM[REG + IMM]
//     LABEL //address lable
// };

// //The list of all registers
// enum Register {
//     x0 = 0, x1 = 1, x2 = 2, x3 = 3, x4 = 4, x5 = 5, x6 = 6, 
//     x7 = 7, x8 = 8, x9 = 9, x10 = 10, x11 = 11, x12 = 12, x13 = 13, 
//     x14 = 14, x15 = 15, x16 = 16, x17 = 17, x18 = 18, x19 = 19, 
//     x20 = 20, x21 = 21, x22 = 22, x23 = 23, x24 = 24, x25 = 25, 
//     x26 = 26, x27 = 27, x28 = 28, x29 = 29, x30 = 30, x31 = 31,
//     //0值寄存器
//     zero = x0,
//     //返回地址
//     ra = x1,
//     //栈指针
//     sp = x2,
//     //全局指针，通用指针
//     gp = x3,
//     //线程指针
//     tp = x4,
//     //临时数据或备用链接寄存器
//     t0 = x5,
//     //临时数据
//     t1 = x6,
//     t2 = x7,
//     //保存寄存器或帧指针
//     s0 = x8,
//     fp = x8,
//     //保存寄存器
//     s1 = x9,
//     //函数参数或返回值
//     a0 = x10,
//     a1 = x11,
//     //函数传递参数
//     a2 = x12,
//     a3 = x13,
//     a4 = x14,
//     a5 = x15,
//     a6 = x16,
//     a7 = x17,
//     //保存寄存器
//     s2 = x18,
//     s3 = x19,
//     s4 = x20,
//     s5 = x21,
//     s6 = x22,
//     s7 = x23,
//     s8 = x24,
//     s9 = x25,
//     s10 = x26,
//     s11 = x27,
//     //临时数据
//     t3 = x28,
//     t4 = x29,
//     t5 = x30,
//     t6 = x31
// };
// private:    
//     Register regnum;
// public:    
//     MachineOperand();
//     MachineOperand(int type, int val);

//     ~MachineOperand(){};

//     bool operator==(const MachineOperand&) const;
//     bool operator<(const MachineOperand&) const;
//     bool isReg();
//     bool isImm();
//     bool isMem();
//     bool isLabel();

//     //MachineInst *getParent();
//     int getType();
//     int getVal();
//     int getRegnum();
//     //auto getRegName();
//     auto MachineOperand::getRegName() {
//     return magic_enum::enum_name (this->regnum);
// }
//     std::string getlable();

//     //void setParent(MachineInst *parent);
//     void setReg(Register regnum);

//     friend std::ostream& operator<<(std::ostream& os, MachineOperand& operand) {
//         os << operand.getRegName();
//         return os;
//     }
// };

// class MachineInst
// {
// protected:
//     int type;
//     MachineOperand *rd;
//     MachineOperand *rs1;
//     MachineOperand *rs2;
//     // std::vector<MachineOperand *> defList;
//     // std::vector<MachineOperand *> useList;
// public:
// enum InstType {
//     Binary,
//     Load,
//     Store,
//     Branch,
//     Jump,
//     Cmp,
//     Neg, // 取反，取负数
//     Pseudo, // 伪指令
// };

//     //void setParent();
//     int getType();
//     // void addDef(MachineOperand *def);
//     // void addUse(MachineOperand *use);
//     virtual void PrintInst(std::ofstream &outputFile);
// };

// class MachineBinaryInst : public MachineInst
// {  
// public:
// enum Binary_Inst {
//     //and, or, xor 有问题
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
//     sll, //逻辑左移 sll rd, rs1, rs2
//     slli,
//     slliw,
//     sllw,
//     srl, //逻辑右移 srl rd, rs1, rs2
//     srlw,
//     srli, //逻辑右移立即数 srli rd, rs1, imm
//     srliw,
//     sra, //算术右移 sra rd, rs1, rs2
//     sraw, 
//     srai, //算术右移立即数 srai rd, rs1, imm
//     sraiw,
//     And, //按位与 and rd, rs1, rs2
//     andi,
//     Or, //按位或 or rd, rs1, rs2
//     ori,
//     Xor, //按位异或 xor rd, rs1, rs2
//     xori
// };
// private:
//     Binary_Inst opcode;
// public:
//     MachineBinaryInst(MachineBlock *parent, Binary_Inst opcode, MachineOperand *rd, MachineOperand *rs1, MachineOperand *rs2);
//     void PrintInst(std::ofstream &outputFile);
// };

// class MachineLoadInst : public MachineInst
// {
// public:
// enum Load_Inst {
//     lb, //加载 lb rd, offset(rs1)
//     lh,
//     lw,
//     ld,
//     li, //加载立即数 li rd, imm
//     la //加载地址 la rd, label
// };
// private: 
//     Load_Inst opcode;
// public:
//     MachineLoadInst(MachineBlock *parent, Load_Inst opcode, MachineOperand *rd, MachineOperand *rs1);
//     void PrintInst(std::ofstream &outputFile);
// };

// class MachineStoreInst : public MachineInst
// {
// public:
// enum Store_Inst {
//     sb, //存储 sb rs2, offset(rs1)
//     sh,
//     sw,
//     sd
// };
// private:
//     Store_Inst opcode;
// public:
//     MachineStoreInst(Store_Inst opcode, MachineOperand *rs2, MachineOperand *rs1, MachineOperand *offset);    
//     MachineStoreInst(MachineBlock *parent, Store_Inst opcode, MachineOperand *rs2, MachineOperand *rs1, MachineOperand *offset);
//     void PrintInst(std::ofstream &outputFile);
// };

// class MachineBranchInst : public MachineInst
// {
// public:
// enum Branch_Inst {
//     beq, //分支 beq rs1, rs2, offset
//     bge, // >=
//     bgt, // >
//     ble, // <=
//     blt, // <
//     bne, // !=  
//     beqz, // == 0 beqz rs1, offset
//     bgez,
//     bgtz,
//     blez,
//     bltz,
//     bnez
// };
// private:
//     Branch_Inst opcode;
// public:
//     MachineBranchInst(MachineBlock *parent, Branch_Inst opcode, MachineOperand *rs1, MachineOperand *rs2);
//     MachineBranchInst(MachineBlock *parent, Branch_Inst opcode, MachineOperand *rs1);
//     void PrintInst(std::ofstream &outputFile);
// };

// class MachineJumpInst : public MachineInst
// {
// public:
// enum Jump_Inst {
//     jal, //跳转并保存返回地址  jal rd, offset
//     jalr,// 跳转并保存返回地址 jalr rd, offset(rs1)
//     j, //跳转 j offset
//     jr, //跳转 jr rs1
// };
// private:
//     Jump_Inst opcode;
// public:
//     MachineJumpInst(MachineBlock *parent, Jump_Inst opcode, MachineOperand *rd);
//     MachineJumpInst(MachineBlock *parent, Jump_Inst opcode, MachineOperand *rd, MachineOperand *rs1);
//     MachineJumpInst(MachineBlock *parent, Jump_Inst opcode);
//     MachineJumpInst(MachineBlock *parent, Jump_Inst opcode, MachineOperand *rs1);
//     void PrintInst(std::ofstream &outputFile);
// };

// class MachineCmpInst : public MachineInst
// {
// public:
// enum Cmp_Inst {
//     slt, //有符号比较 slt rd, rs1, rs2
//     slti,//slti rd, rs1, imm
//     sltz,//sltz rd, rs1
//     snez,//sne rd, rs1
// };
// private:
//     Cmp_Inst opcode;
// public:
//     MachineCmpInst(MachineBlock *parent, Cmp_Inst opcode, MachineOperand *rd, MachineOperand *rs1, MachineOperand *rs2);
//     MachineCmpInst(MachineBlock *parent, Cmp_Inst opcode, MachineOperand *rd, MachineOperand *rs1);
//     void PrintInst(std::ofstream &outputFile);
// };

// class PseudoInst : public MachineInst
// {
// public:
// enum Pseudo_Inst {
//     // Nop, //空指令
//     // Auipc,
//     mv, //移动 mv rd, rs1
//     ret //返回 ret
// };
// private:
//     Pseudo_Inst opcode;
// public:
//     PseudoInst(MachineBlock *parent, Pseudo_Inst opcode, MachineOperand *rd, MachineOperand *rs1);
//     PseudoInst(MachineBlock *parent, Pseudo_Inst opcode);
//     void PrintInst(std::ofstream &outputFile);
// };

// class MachineBlock
// {
// private:
//     std::vector<MachineInst *> InstList;
//     // std::vector<MachineBlock *> pred;//前驱
//     // std::vector<MachineBlock *> succ;//后继
// public:
//     MachineBlock();
//     ~MachineBlock();
//     void addInst(MachineInst *inst);
//     std::vector<MachineInst *> &getInstList();
// };

// class MachineFunction 
// {
// private:
//     std::string Funcname;
//     std::vector<MachineBlock *> BlockList;
//     std::vector<MachineOperand *> paramList;
//     std::vector<MachineOperand *> alloca_variables;
//     std::unordered_map<std::string, int> Blockmap;
//     int stacksize;
// public:
//     // std::vector<std::string, int> offset_list;
//     // int  getoffset(Function *func, char* name);
//     // std::vector<std::string, int>* getoffset_list();
//     //offset_list offsetarray;
//     void setstacksize();
//     MachineFunction();
//     int getstacksize();

//     void addBlock(MachineBlock *block);
//     void addParam(MachineOperand *param);
//     void addAlloca(MachineOperand *alloca);
//     std::string getFuncName();
//     std::vector<MachineBlock *> &getBlockList();
//     std::vector<MachineOperand *> &getParams();
//     std::vector<MachineOperand *> &getAllocaVariables();

//     void PrintInstStack(MachineUnit* Unit, std::ofstream &outputFile);
// };

// class MachineUnit
// {
// private:
//     std::vector<MachineFunction *> FunctionList;
//     std::unordered_map<std::string, int> labelmap;
// public:
//     MachineUnit();
//     ~MachineUnit();
//     void addFunction(MachineFunction *func);
//     std::vector<MachineFunction *> &getFuncList();
//     bool isLableLegal();
// };