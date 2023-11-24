//The list of all registers
#pragma once
enum Register {
    x0 = 0, x1 = 1, x2 = 2, x3 = 3, x4 = 4, x5 = 5, x6 = 6, 
    x7 = 7, x8 = 8, x9 = 9, x10 = 10, x11 = 11, x12 = 12, x13 = 13, 
    x14 = 14, x15 = 15, x16 = 16, x17 = 17, x18 = 18, x19 = 19, 
    x20 = 20, x21 = 21, x22 = 22, x23 = 23, x24 = 24, x25 = 25, 
    x26 = 26, x27 = 27, x28 = 28, x29 = 29, x30 = 30, x31 = 31,

    //0值寄存器
    zero = x0,
    //返回地址
    ra = x1,
    //栈指针
    sp = x2,
    //全局指针，通用指针
    gp = x3,
    //线程指针
    tp = x4,
    //临时数据或备用链接寄存器
    t0 = x5,
    //临时数据
    t1 = x6,
    t2 = x7,
    //保存寄存器或帧指针
    s0 = x8,
    fp = x8,
    //保存寄存器
    s1 = x9,
    //函数参数或返回值
    a0 = x10,
    a1 = x11,
    //函数传递参数
    a2 = x12,
    a3 = x13,
    a4 = x14,
    a5 = x15,
    a6 = x16,
    a7 = x17,
    //保存寄存器
    s2 = x18,
    s3 = x19,
    s4 = x20,
    s5 = x21,
    s6 = x22,
    s7 = x23,
    s8 = x24,
    s9 = x25,
    s10 = x26,
    s11 = x27,
    //临时数据
    t3 = x28,
    t4 = x29,
    t5 = x30,
    t6 = x31
};

//list of RISC_V instructions
enum RISC_V_Inst {
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
    Bnez,
    J, //跳转 j offset
    Jr, //跳转 jr rs1
    Jal, //跳转并保存返回地址  jal offset
    Jalr,// 跳转并保存返回地址 jalr rs1

    La, //加载地址 la rd, label
    Li, //加载立即数 li rd, imm
    Lb, //加载 lb rd, offset(rs1)
    Lh,
    Lw,
    Ld,
    Sb, //存储 sb rs2, offset(rs1)
    Sh,
    Sw,
    Sd,

    //Nop, //空指令
    //Auipc,
    Mv, //移动 mv rd, rs1
    Ret, //返回 ret

    And, //按位与 and rd, rs1, rs2
    Andi,
    Or, //按位或 or rd, rs1, rs2
    Ori,
    Not, //按位取反 not rd, rs1
    Xor, //按位异或 xor rd, rs1, rs2
    Xori,
    //Neg, //取负数
    //Negw,

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

    Slt, //有符号比较 slt rd, rs1, rs2
    Slti,
    Sltz,
    Snez  
};

class AsmPrinter {
    
};