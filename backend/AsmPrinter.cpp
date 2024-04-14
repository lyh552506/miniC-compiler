#include"AsmPrinter.hpp"
//AsmPrinter
AsmPrinter::AsmPrinter(std::string filename, Module* unit) 
    : filename(filename), unit(unit) {

    MachineUnit* Munit = GenerateMir(unit);
    this->Machineunit = Munit;

    textSegment* textseg = new textSegment(Machineunit);
    this->text = textseg;

    dataSegment* data = new dataSegment(Machineunit);
    this->data = data;
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
                //生成需要放在数据段的内容
                if (GetOperand(Inst, 0)->isConst()){

                }
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
void AsmPrinter::printAsm() {
    std::ofstream outputFile("output.a", std::ios::out); // 以追加模式打开文件
    if (outputFile.is_open()) {

        //std::cout << "opended successfully" << std::endl;
        // // std::cout 重定向到文件
        // std::streambuf* coutBuffer = std::cout.rdbuf();
        // std::cout.rdbuf(outputFile.rdbuf());

        std::cout << "    .file  \"" << filename << "\"" << std::endl;
        std::cout << "    .attribute arch, \"rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0\"" << std::endl;
        std::cout << "    .attribute unaligned_access, 0" << std::endl; 
        std::cout << "    .attribute stack_align, 16" << std::endl;
        std::cout << "    .text" << std::endl;

        this->text->PrintTextSegment();

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
    : Machineunit(Machineunit) {
    GenerateFuncList(Machineunit);
}
void textSegment::GenerateFuncList(MachineUnit* Machineunit) {
    for (auto& machinefunction : Machineunit->getMachineFunctions()) {
        functionSegment* funcSeg = new functionSegment(machinefunction);
        function_list.push_back(funcSeg);
    }
}
void textSegment::PrintTextSegment() {
    for (auto& functionSegment : function_list) {
        functionSegment->PrintFuncSegment();
    }
}

//functionSegment
functionSegment::functionSegment(MachineFunction* function)
    : machinefunction(function) {
    align = 1;
    name = function->get_function()->GetName();
    size = -1;
}
void functionSegment::PrintFuncSegment() {
    std::cout << "    .align  " << align << std::endl;
    std::cout << "    .globl  " << name << std::endl;
    std::cout << "    .type  " << name << ", @" << ty << std::endl;
    // std::cout << name << ":" << std::endl;
    machinefunction->print_func_name();
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
dataSegment::dataSegment(MachineUnit* Machineunit) 
    : Machineunit(Machineunit) {
    GenerateGloblvarList(Machineunit);
    //GenerateTempvarList(Machineunit);
}
void dataSegment::GenerateGloblvarList(MachineUnit* Machineunit) {
    for(auto& data : Machineunit->get_module()->GetGlobalVariable()) {
        globlvar* gvar = new globlvar(data.get());
            globlvar_list.push_back(gvar);
    }
}

//globlvar
globlvar::globlvar(Variable* data) {
    name = data->get_name();
    InnerDataType tp = data->GetType()->GetTypeEnum();
    int align;
    if(tp == InnerDataType::IR_Value_INT || tp == InnerDataType::IR_Value_Float) {
        align = 2;
        size = 4;
        if (data->GetInitializer()) {
            sec = "data";
            std::string num = data->GetInitializer()->GetName();
            if(tp == InnerDataType::IR_Value_INT) {
                int init = std::stoi(num);
                init_vector.push_back(init);
            }
            if(tp == InnerDataType::IR_Value_Float) {
                float init = std::stof(num);
                init_vector.push_back(init);
            }
        }
        else {
            sec = "bss";
        }
    }
    else if (tp == InnerDataType::IR_ARRAY) {
        align = 3;
        Type* basetype = dynamic_cast<HasSubType*>(data->GetType())->get_baseType();
        if(Initializer* arry_init = dynamic_cast<Initializer*>(data->GetInitializer())) {
            size = arry_init->GetType()->get_size();
            int init_size = arry_init->size();
            if (init_size == 0) {
                sec = "bss";
            }
            else {
                sec = "data";
                int limi = dynamic_cast<ArrayType*>(arry_init->GetType())->GetNumEle();
                for(int i=0;i<limi;i++){
                    if(i < init_size){
                        if(auto inits=dynamic_cast<Initializer*>((*arry_init)[i])) {
                            //递归
                            generate_array_init(inits, basetype);  
                        }
                        else {//Leaf 
                            std::string num = (*arry_init)[i]->GetName();
                            if(basetype->GetTypeEnum() == IR_Value_INT) {
                                int init = std::stoi(num);
                                init_vector.push_back(init);
                            }
                            else if (basetype->GetTypeEnum() == IR_Value_Float) {
                                float init = std::stof(num);
                                init_vector.push_back(init);
                            }
                        }
                    }
                    else {
                        Type* temptp = dynamic_cast<ArrayType*>(arry_init->GetType())->GetSubType();
                        size_t zeronum = temptp->get_size() / basetype->get_size();
                        for(int i=0; i<zeronum; i++) {
                            if(basetype->GetTypeEnum() == IR_Value_INT) {
                                init_vector.push_back(static_cast<int>(0));
                            }
                            else if (basetype->GetTypeEnum() == IR_Value_Float) {
                                init_vector.push_back(static_cast<float>(0));                        
                            }
                        }
                    }
                }
            } 
        }
        else {
            sec = "bss";
        }
    }
    else align = -1;//Error
}
std::string globlvar::get_sec() {return sec;}
void globlvar::generate_array_init(Initializer* arry_init, Type* basetype) {
    int init_size = arry_init->size();
    int limi = dynamic_cast<ArrayType*>(arry_init->GetType())->GetNumEle();
    if (init_size == 0) {
        for (int i=0; i<limi; i++) {
            if (basetype->GetTypeEnum() == IR_Value_INT) {
                init_vector.push_back(static_cast<int>(0));
            }
            else if (basetype->GetTypeEnum() == IR_Value_Float) {
                init_vector.push_back(static_cast<float>(0));   
            }
        }
    }
    else {
        for(int i=0; i<limi; i++) {
            if(i<init_size) {
                if(auto inits=dynamic_cast<Initializer*>((*arry_init)[i]))
                    generate_array_init(inits, basetype);
                else {
                        std::string num = (*arry_init)[i]->GetName();
                        if(basetype->GetTypeEnum() == IR_Value_INT) {
                            int init = std::stoi(num);
                            init_vector.push_back(init);
                        }
                        else if (basetype->GetTypeEnum() == IR_Value_Float) {
                            float init = std::stof(num);
                            init_vector.push_back(init);
                        }                    
                }
            }
            else {
                Type* temptp = dynamic_cast<ArrayType*>(arry_init->GetType())->GetSubType();
                size_t zeronum = temptp->get_size() / basetype->get_size();
                    for(int i=0; i<zeronum; i++) {
                    if (basetype->GetTypeEnum() == IR_Value_INT) {
                        init_vector.push_back(static_cast<int>(0));
                    }
                    else if (basetype->GetTypeEnum() == IR_Value_Float) {
                        init_vector.push_back(static_cast<float>(0));   
                    }
                }
            }
        }
    }
}

//tempvar
