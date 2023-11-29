#pragma once
#include <string>
#include <vector>
#include "MachineCode.hpp"
//The list of all registers
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

class AsmPrinter {
private:
    // std::vector<MachineInst *> InstList;
    int regstatu[32];

public:
    AsmPrinter();
    ~AsmPrinter();

    bool isregbusy(int regnum);

    void regalloc(MachineInst *inst);

    void printMachineCode(MachineInst *inst);


};