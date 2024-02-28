#include"AsmPrinter.hpp"

//寄存器分配 将剩余的虚拟寄存器分配到机器寄存器
void RegAlloca(Function* function) {
}

//打印机器指令
void PrintCode(Module* Unit) {
    int func_num = 0;
    /*MachineFunction*/
    for (auto& Func : Unit->GetFuncTion()) {
        int block_num = 0;
        //打印每个Func，及栈帧
        MachineFunction* machinefunction = new MachineFunction(Func.get());
        if (machinefunction == nullptr) {
            std::cout << "machinefunction is nullptr" << std::endl;
        }
        machinefunction->print_func_name();
        machinefunction->print_stack_frame();
        
        /*MachineBasicBlock*/
        std::vector<MachineBasicBlock*> Mvector;

        for (auto it = Func->begin(); it != Func->end(); ++it) {
            BasicBlock* Block = *it;
            MachineBasicBlock* machineblock = new MachineBasicBlock(Block, machinefunction);
            machineblock->set_lable(func_num, block_num);
            machinefunction->set_lable_map(Block->GetName(), machineblock->get_name());
            Mvector.push_back(machineblock);
            block_num++;
        }
        block_num = 0;
        for (auto& machineblock : Mvector) {
            //打印MachineBasicBlock的标签
            if (block_num != 0) {
                machineblock->print_block_lable();
            }
            /*MachineInst*/
            for (auto Inst : *(machineblock->get_block())) {
                //生成机器指令 
                MachineInst* machineinst = InstSelect(machineblock, *Inst);
                //打印每个Inst
                machineinst->print();
            }
            block_num++;
        }
        /*MachineFunction End*/
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
