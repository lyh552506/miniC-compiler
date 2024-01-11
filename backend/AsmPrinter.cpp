#include<iostream>
#include<fstream>
#include"AsmPrinter.hpp"

//将栈帧中参数对应虚拟寄存器分配到机器寄存器
void shiftpass(MachineFunction* machinefunction) {
    
}

//合法化
void shift(MachineUnit* unit) {
    for (auto& Fun : Singleton<Module>().getFuncList()) {
        MachineFunction* machinefunction;
        //todo
        //匹配生成参数及变量的vector
        // machinefunction->addParam();
        // machinefunction->addAlloca();
        for (auto& Block : Fun->getBlockList()) {
            MachineBlock* machineblock;
            for (auto& Inst : Block->getInstList()) {
                MachineInst* machineinst;
                //指令选择
                machineinst=InstSelect(Inst);
                machineblock->addInst(machineinst);
            }
            machinefunction->addBlock(machineblock);
            //将栈帧中参数对应虚拟寄存器分配到机器寄存器
            shiftpass(machinefunction);
        }
        unit->addFunction(machinefunction);
    }
}

//寄存器分配 将剩余的虚拟寄存器分配到机器寄存器


//打印机器指令
void PrintCode(MachineUnit* Unit, std::ofstream &outputFile) {
    for (auto& Func : Unit->getFuncList()) {
        //打印每个Func，及栈帧
        Func->PrintInstStack(Unit, outputFile);
        for (auto& Block : Func->getBlockList()) {
            //打印每个Block，计算偏移量
            
            for (auto& Inst : Block->getInstList()) {
                //生成机器指令

                //打印每个Inst
                Inst->PrintInst(outputFile);

            }
            //打印每个Block的跳转
        }
        //打印每个Func的返回
    }
}

//dump出机器指令文本
void PrintCodeToTxt(MachineUnit* unit) {
    std::ofstream outputFile("output.ll", std::ios::app); // 以追加模式打开文件
    if (outputFile.is_open()) {
        PrintCode(unit, outputFile);
        outputFile.close(); // 关闭文件
    } else {
        std::cout << "Unable to open the file." << std::endl;
    }
}
