#include"AsmPrinter.hpp"
//AsmPrinter
AsmPrinter::AsmPrinter(std::string filename, Module* unit) 
    : filename(filename), unit(unit) {
}

//寄存器分配 将剩余的虚拟寄存器分配到机器寄存器
void AsmPrinter::RegAlloca(Function* function) {
}

//生成机器指令
MachineUnit* AsmPrinter::GenerateMir(Module* Unit) {
    int func_num = 0;
    MachineUnit* machineunit = new MachineUnit(Unit);

    /*MachineFunction*/
    for (auto& Func : Unit->GetFuncTion()) {
        int block_num = 0;
        MachineFunction* machinefunction = new MachineFunction(Func.get(), machineunit);
        if (machinefunction == nullptr) {
            std::cout << "machinefunction is nullptr" << std::endl;
        }
        machineunit->addMachineFunction(machinefunction);
        
        /*MachineBasicBlock*/
        for (auto it = Func->begin(); it != Func->end(); ++it) {
            BasicBlock* Block = *it;
            MachineBasicBlock* machineblock = new MachineBasicBlock(Block, machinefunction);
            machineblock->set_lable(func_num, block_num);
            machinefunction->set_lable_map(Block->GetName(), machineblock->get_name());
            machinefunction->addMachineBasicBlock(machineblock);
            block_num++;
        }
        block_num = 0;
        for (auto& machineblock : machinefunction->getMachineBasicBlocks()) {
            
            /*MachineInst*/
            BasicBlock* block = machineblock->get_block();
            for (auto it = block->begin(); it != block->end(); ++it) {
                User* Inst = *it;
                //生成机器指令 
                MachineInst* machineinst = InstSelect(machineblock, *Inst);
                add_inst(machineinst, machineblock, it);
            } 
            /*MachineBlock End*/
            block_num++;
        }
        /*MachineFunction End*/
        func_num++;
    }
    return machineunit; 
}

void AsmPrinter::PrintInst(MachineUnit* unit) {
    for (auto& machinefunction : unit->getMachineFunctions()) {
        machinefunction->print_func_name();
        machinefunction->print_stack_frame();
        for (auto& machineblock : machinefunction->getMachineBasicBlocks()) {
            machineblock->print_block_lable();
            for (auto& machineinst : machineblock->getMachineInsts()) {
                machineinst->print();
            }
        }
        machinefunction->print_func_end();
    }
    Singleton<Module>().Test();
}

// void AsmPrinter::printAsm() {
// }

//dump出机器指令文本
void AsmPrinter::PrintToTxt() {
    std::ofstream outputFile("output.a", std::ios::out); // 以追加模式打开文件
    if (outputFile.is_open()) {

        //std::cout << "opended successfully" << std::endl;
        // // std::cout 重定向到文件
        // std::streambuf* coutBuffer = std::cout.rdbuf();
        // std::cout.rdbuf(outputFile.rdbuf());

        MachineUnit* Munit = GenerateMir(unit);
        PrintInst(Munit);
        //ChangeConditionInsts(Munit);
        //ChangeBranch(Munit);

        // std::cout.rdbuf(coutBuffer);
        outputFile.close(); // 关闭文件
    } else {
        std::cout << "Unable to open the file." << std::endl;
    }
}

//textSegment
textSegment::textSegment(MachineUnit* Machineunit) 
    : Machineunit(Machineunit) {}
void textSegment::GenerateFuncList(MachineUnit* Machineunit) {
    for (auto& machinefunction : Machineunit->getMachineFunctions()) {
        functionSegment* funcSeg = new functionSegment(machinefunction);
        function_list.push_back(funcSeg);
    }
}
void textSegment::PrintTextSegment() {
    //std::cout << "    .text" << std::endl;
    for (auto& functionSegment : function_list) {
        functionSegment->PrintFuncSegment();
    }
}

//functionSegment
functionSegment::functionSegment(MachineFunction* function)
    : machinefunction(machinefunction) {
    align = 1;
    name = function->get_function()->GetName();
    size = -1;
}
void functionSegment::PrintFuncSegment() {
    std::cout << "    .align " << align << std::endl;
    std::cout << "    .globl " << name << std::endl;
    std::cout << "    .type " << name << ", " << ty << std::endl;
    std::cout << name << ":" << std::endl;
    machinefunction->print_stack_frame();
    for (auto& machineblock : machinefunction->getMachineBasicBlocks()) {
        machineblock->print_block_lable();
        for (auto& machineinst : machineblock->getMachineInsts()) {
            machineinst->print();
        }
    }
    machinefunction->print_func_end();
    if(size == -1)
        std::cout << "    .size " << name << ", " << "-" << name << std::endl;
}

//dataSegment
dataSegment::dataSegment(Module* unit) 
    : unit(unit) {}

void dataSegment::GenerateGloblvarList(Module* unit) {
    
}
//globlvar


//tempvar
