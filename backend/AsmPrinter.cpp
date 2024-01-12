#include<iostream>
#include<fstream>
#include"AsmPrinter.hpp"


//寄存器分配 将剩余的虚拟寄存器分配到机器寄存器
void RegAlloca(Function* function) {
}

// //合法化
// void shift(MachineUnit* unit) {
//     for (auto& Fun : Singleton<Module>().getFuncList()) {
//         MachineFunction* machinefunction;
//         //todo
//         //匹配生成参数及变量的vector
//         // machinefunction->addParam();
//         // machinefunction->addAlloca();
//         for (auto& Block : Fun->getBlockList()) {
//             MachineBlock* machineblock;
//             for (auto& Inst : Block->getInstList()) {
//                 MachineInst* machineinst;
//                 //指令选择
//                 machineinst=InstSelect(Inst);
//                 machineblock->addInst(machineinst);
//             }
//             machinefunction->addBlock(machineblock);
//             //将栈帧中参数对应虚拟寄存器分配到机器寄存器
//             shiftpass(machinefunction);
//         }
//         unit->addFunction(machinefunction);
//     }
// }

//打印机器指令
void PrintCode(Module& Unit, std::ofstream &outputFile) {
    for (auto& Func : Unit.getFuncList()) {
        //打印每个Func，及栈帧
        MachineFunction* machinefunction = dynamic_cast<MachineFunction*>(Func.get());
        machinefunction->print_func_name();
        machinefunction->print_stack_frame();
        for (auto& Block : Func->getBlockList()) {
            //打印每个Block的标签
            MachineBasicBlock* machineblock = dynamic_cast<MachineBasicBlock*>(Block.get());
            machineblock->print_block_lable(machinefunction->get_func_num());
            for (auto& Inst : Block->getInstList()) {
                //生成机器指令
                User* machineinst = InstSelect(*Inst.get());
                //打印每个Inst
                machineinst->printmachineinst(outputFile);
            }
            //打印每个Block的跳转

        }
        //打印每个Func的返回
    }
}

//dump出机器指令文本
void PrintCodeToTxt(Module& unit) {
    std::ofstream outputFile("output.ll", std::ios::app); // 以追加模式打开文件
    if (outputFile.is_open()) {
        std::cout << "opended successfully" << std::endl;
        //std::cout 重定向到文件
        std::streambuf* coutBuffer = std::cout.rdbuf();
        std::cout.rdbuf(outputFile.rdbuf());
        PrintCode(unit, outputFile);
        std::cout.rdbuf(coutBuffer);
        outputFile.close(); // 关闭文件
        std::cout << "Output redirected to file." << std::endl;
    } else {
        std::cout << "Unable to open the file." << std::endl;
    }
}
