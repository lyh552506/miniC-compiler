#include<iostream>
#include<fstream>
#include"MachineCode.hpp"
#include"AsmPrinter.hpp"

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

                machineblock->addInst(machineinst);
            }
            machinefunction->addBlock(machineblock);
        }
        unit->addFunction(machinefunction);
    }
}

void AsmPrinter::PrintCode(MachineUnit* Unit, std::ofstream &outputFile) {
    for (auto& Func : Unit->getFuncList()) {
        //打印每个Func，及栈帧
        Func->PrintInstStack(Unit, outputFile);
        for (auto& Block : Func->getBlockList()) {
            //打印每个Block，计算偏移量
            
            for (auto& Inst : Block->getInstList()) {
                //进行指令匹配

                //打印每个Inst
                Inst->PrintInst(outputFile);

            }
            //打印每个Block的跳转
        }
        //打印每个Func的返回
    }
}

void AsmPrinter::PrintCodeToTxt(MachineUnit* unit) {
    std::ofstream outputFile("output.ll", std::ios::app); // 以追加模式打开文件
    if (outputFile.is_open()) {
        PrintCode(unit, outputFile);
        outputFile.close(); // 关闭文件
    } else {
        std::cout << "Unable to open the file." << std::endl;
    }
}