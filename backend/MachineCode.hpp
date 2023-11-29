#pragma once
#include<string>
#include<vector>

class MachineUnit;
class MachineFunction;
class MachineBlock;
class MachineInst;

class MachineOperand
{
private:
    MachineInst *parent;
    int type;
    int val;
    std::string lable;
    int regnum;

public:
enum OperandType{
    REG, 
    IMM, 
    MEM, // MEM[REG + IMM]
    LABEL //address lable
};
    MachineOperand();
    MachineOperand(int type, int val);

    ~MachineOperand(){};

    bool operator==(const MachineOperand&) const;
    bool operator<(const MachineOperand&) const;
    bool isReg();
    bool isImm();
    bool isMem();
    bool isLabel();

    MachineInst *getParent();
    int getType();
    int getVal();
    int getRegnum();
    std::string getlable();

    void setParent(MachineInst *parent);
    void setReg(int regnum);
};

class MachineInst
{
private:
    MachineBlock *parent;
    int type;
    int opcode;
    MachineOperand *rd;
    MachineOperand *rs1;
    MachineOperand *rs2;
    int num;
    std::vector<MachineOperand *> defList;
    std::vector<MachineOperand *> useList;
public:
    MachineInst();
    MachineInst(int opcode, MachineOperand *rd, MachineOperand *rs1, MachineOperand *rs2);
    MachineInst(int opcode, MachineOperand *rd, MachineOperand *rs1);
    MachineInst(int opcode, MachineOperand *rd);
    MachineInst(int opcode);

enum InstType {
    Binary,
    Load,
    Store,
    Branch,
    Jump,
    Cmp,
    Neg, // 取反，取负数
    Pseudo, // 伪指令
};
    void setParent(MachineBlock *parent);
    void setOpcode(int opcode);
    void setnum(int num);
    void setop(MachineOperand *rd);
    
    void addDef(MachineOperand *def);
    void addUse(MachineOperand *use);
    
    int getnum();
};

class BinaryInst : public MachineInst
{  
public:
enum Binary_Inst {
    //算数运算
    Add, //加法 add rd, rs1, rs2
    Addw,
    Addi, // addi rd, rs1, imm  
    Addiw,
    Sub, //减法 sub rd, rs1, rs2
    Subw,
    Mul, //乘法 mul rd, rs1, rs2
    Mulh,
    Mulw,
    Div, //除法 div rd, rs1, rs2
    Divw,
    Rem, //取余 rem rd, rs1, rs2
    Remw,
    Sll, //逻辑左移 sll rd, rs1, rs2
    Slli,
    Slliw,
    Sllw,
    Srl, //逻辑右移 srl rd, rs1, rs2
    Srlw,
    Srli, //逻辑右移立即数 srli rd, rs1, imm
    Srliw,
    Sra, //算术右移 sra rd, rs1, rs2
    Sraw, 
    Srai, //算术右移立即数 srai rd, rs1, imm
    Sraiw,
    And, //按位与 and rd, rs1, rs2
    Andi,
    Or, //按位或 or rd, rs1, rs2
    Ori,
    Xor, //按位异或 xor rd, rs1, rs2
    Xori
};
 

    BinaryInst(int opcode, MachineOperand *rd, MachineOperand *rs1, MachineOperand *rs2);
    void print();
};

class LoadInst : public MachineInst
{
public:
enum Load_Inst {
    Lb, //加载 lb rd, offset(rs1)
    Lh,
    Lw,
    Ld
};
    LoadInst(int opcode, MachineOperand *rd, MachineOperand *rs1, MachineOperand *rs2);
    void print();
};

class StoreInst : public MachineInst
{
public:
enum Store_Inst {
    Sb, //存储 sb rs2, offset(rs1)
    Sh,
    Sw,
    Sd
};
    StoreInst(int opcode, MachineOperand *rd, MachineOperand *rs1, MachineOperand *rs2);
    void print();

};

class BranchInst : public MachineInst
{
public:
enum Branch_Inst {
    Beq, //分支 beq rs1, rs2, offset
    Beqz, // == 0
    Bge, // >=
    Bgez,
    Bgt, // >
    Bgtz,
    Ble, // <=
    Blez,
    Blt, // <
    Bltz,
    Bne, // !=
    Bnez
};
    BranchInst(int opcode, MachineOperand *rd, MachineOperand *rs1, MachineOperand *rs2);
    void print();

};

class JumpInst : public MachineInst
{
public:
enum Jump_Inst {
    J, //跳转 j offset
    Jr, //跳转 jr rs1
    Jal, //跳转并保存返回地址  jal offset
    Jalr,// 跳转并保存返回地址 jalr rs1
};
    JumpInst(int opcode, MachineOperand *rd, MachineOperand *rs1, MachineOperand *rs2);
    void print();

};

class CmpInst : public MachineInst
{
public:
enum Cmp_Inst {
    Slt, //有符号比较 slt rd, rs1, rs2
    Slti,
    Sltz,
    Snez
};
    CmpInst(int opcode, MachineOperand *rd, MachineOperand *rs1, MachineOperand *rs2);
    void print();

};

class PseudoInst : public MachineInst
{
public:
enum Pseudo_Inst {
    // Nop, //空指令
    // Auipc,
    Li, //加载立即数 li rd, imm
    La, //加载地址 la rd, label
    Mv, //移动 mv rd, rs1
    Ret //返回 ret
};
    PseudoInst(int opcode, MachineOperand *rd, MachineOperand *rs1, MachineOperand *rs2);
    void print();

};

class MachineBlock
{
private:
    MachineFunction *parent;
    int num;
    std::vector<MachineInst *> InstList;

    std::vector<MachineBlock *> pred;//前驱
    std::vector<MachineBlock *> succ;//后继

public:
    MachineBlock(MachineFunction *parent, int num);
    std::vector<MachineInst *> &getInsts();
};

class MachineFunction
{
private:
    MachineUnit *parent;
    std::vector<MachineBlock *> BlockList;
    std::vector<MachineOperand *> arglist;
    int stacksize;
    int offset;

public:
    MachineFunction(MachineUnit *parent);

    int getstacksize();
    int getoffset();

    void setstacksize(int size);
    void setoffset(int offset);

    void print();
};

class MachineUnit
{
private:
    std::vector<MachineFunction *> FuncList;

public:
    MachineUnit();

    ~MachineUnit();

    std::vector<MachineFunction *> &getFuncs();
};
