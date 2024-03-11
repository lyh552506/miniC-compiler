#include"AsmPrinter.hpp"

//寄存器分配 将剩余的虚拟寄存器分配到机器寄存器
void RegAlloca(Function* function) {
}

//打印机器指令
MachineUnit*  GenerateHir(Module* Unit) {
//void PrintCode(Module* Unit) {
    int func_num = 0;
    MachineUnit* machineunit = new MachineUnit(Unit);

    /*MachineFunction*/
    for (auto& Func : Unit->GetFuncTion()) {
        int block_num = 0;
        //打印每个Func，及栈帧
        MachineFunction* machinefunction = new MachineFunction(Func.get(), machineunit);
        if (machinefunction == nullptr) {
            std::cout << "machinefunction is nullptr" << std::endl;
        }
        machineunit->addMachineFunction(machinefunction);
        machinefunction->print_func_name();
        machinefunction->print_stack_frame();
        
        /*MachineBasicBlock*/
        //std::vector<MachineBasicBlock*> Mvector;
        for (auto it = Func->begin(); it != Func->end(); ++it) {
            BasicBlock* Block = *it;
            MachineBasicBlock* machineblock = new MachineBasicBlock(Block, machinefunction);
            machineblock->set_lable(func_num, block_num);
            machinefunction->set_lable_map(Block->GetName(), machineblock->get_name());
            //Mvector.push_back(machineblock);
            machinefunction->addMachineBasicBlock(machineblock);
            block_num++;
        }
        block_num = 0;
        for (auto& machineblock : machinefunction->getMachineBasicBlocks()) {
            //打印MachineBasicBlock的标签
            if (block_num != 0) {
                machineblock->print_block_lable();
            }
            /*MachineInst*/
            for (auto Inst : *(machineblock->get_block())) {
                //生成机器指令 
                MachineInst* machineinst = InstSelect(machineblock, *Inst);
                machineblock->addMachineInst(machineinst);
                //打印每个Inst
                machineinst->print();
            }
            /*MachineBlock End*/
            block_num++;
        }
        /*MachineFunction End*/
        func_num++;
    }
    return machineunit; 
}

void ChangeConditionInsts(MachineUnit* unit) {
    for (auto& machinefunction : unit->getMachineFunctions()) {
        for (auto& machineblock : machinefunction->getMachineBasicBlocks()) {
            std::vector<MachineInst*> minsts  = machineblock->getMachineInsts();
            for (std::vector<MachineInst*>::iterator it = minsts.begin(); it != minsts.end(); ++it) {
                MachineInst* machineinst = *it;
                MachineInst* nextinst = *(it+1);
                std::string opcode = machineinst->GetOpcode().substr(0,4);
                std::string nextopcode = nextinst->GetOpcode();
                if( opcode == "icmp" ) {
                    printf("Find icmp!\n");
                    if (nextopcode == "branch") {
                        printf("Find branch!\n");
                    }
                    else {}
                }
                else {}
            }
        }
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
        //PrintCode(unit);
        MachineUnit* Munit = GenerateHir(unit);
        //ChangeConditionInsts(Munit);
        ChangeBranch(Munit);
        // std::cout.rdbuf(coutBuffer);
        outputFile.close(); // 关闭文件
    } else {
        std::cout << "Unable to open the file." << std::endl;
    }
}