#include"AsmPrinter.hpp"

//寄存器分配 将剩余的虚拟寄存器分配到机器寄存器
void RegAlloca(Function* function) {
}

//打印机器指令
void PrintCode(Module* Unit) {
    int func_num = 0;
    for (auto& Func : Unit->GetFuncTion()) {
        int block_num = 0;
        //打印每个Func，及栈帧
        MachineFunction* machinefunction = new MachineFunction(Func.get());
        if (machinefunction == nullptr) {
            std::cout << "machinefunction is nullptr" << std::endl;
        }
        machinefunction->print_func_name();
        machinefunction->print_stack_frame();
        //machinefunction->print_stack_offset();
        for (auto& Block : Func->GetBasicBlock()) {
            //打印每个Block的标签
            MachineBasicBlock* machineblock = new MachineBasicBlock(Block.get(), machinefunction);
            if (block_num != 0) {
                machineblock->print_block_lable(func_num, block_num);
            }
            for (auto Inst : *Block) {
                //生成机器指令 
                MachineInst* machineinst = InstSelect(machineblock, *Inst);
                //打印每个Inst
                machineinst->print();
                //alloca指令此处未作处理
                //特殊：ret 语句
            }
            //打印每个Block的跳转
            block_num++;
        }
        //打印每个Func的返回
        machinefunction->print_func_end();
        func_num++;
    }
}

//dump出机器指令文本
void PrintCodeToTxt(Module* unit) {
    std::ofstream outputFile("output.a", std::ios::out); // 以追加模式打开文件
    if (outputFile.is_open()) {
        //std::cout << "opended successfully" << std::endl;
        // // std::cout 重定向到文件
        // std::streambuf* coutBuffer = std::cout.rdbuf();
        // std::cout.rdbuf(outputFile.rdbuf());
        PrintCode(unit);
        // std::cout.rdbuf(coutBuffer);
        outputFile.close(); // 关闭文件
    } else {
        std::cout << "Unable to open the file." << std::endl;
    }
}
