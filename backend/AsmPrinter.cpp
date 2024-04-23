#include"AsmPrinter.hpp"
SegmentType __oldtype=TEXT;
SegmentType* oldtype = &__oldtype;
SegmentType ChangeSegmentType(SegmentType newtype) {
    return newtype;
}
void PrintSegmentType(SegmentType newtype, SegmentType* oldtype) {
    if (newtype == *oldtype) return;
    else {
        *oldtype = ChangeSegmentType(newtype);
        if (newtype == TEXT) 
            std::cout << "    .text" << std::endl;
        else if (newtype == DATA) 
            std::cout << "    .data" << std::endl;
        else if (newtype == BSS)
            std::cout << "    .bss" << std::endl;
        else if (newtype == RODATA)
            std::cout << "    .section    .rodata" << std::endl;
        else 
            std::cout << "ERROR: Illegal SegmentType" << std::endl;
    }
}

//AsmPrinter
AsmPrinter::AsmPrinter(std::string filename, Module* unit) 
    : filename(filename), unit(unit) {
    
    MachineUnit* Munit = GenerateMir(unit);
    this->Machineunit = Munit;

    dataSegment* data = new dataSegment(Machineunit);
    this->data = data;

    textSegment* textseg = new textSegment(Machineunit);
    this->text = textseg;
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
            machinefunction->set_blockMap(Block, machineblock);
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

// void AsmPrinter::PrintInst(MachineUnit* unit) {
//     for (auto& machinefunction : unit->getMachineFunctions()) {
//         machinefunction->print_func_name();
//         machinefunction->print_stack_frame();
//         for (auto& machineblock : machinefunction->getMachineBasicBlocks()) {
//             machineblock->print_block_lable();
//             for (auto& machineinst : machineblock->getMachineInsts()) {
//                 machineinst->print();
//             }
//         }
//         machinefunction->print_func_end();
//     }
//     Singleton<Module>().Test();
// }
void AsmPrinter::printAsm() {
    std::ofstream outputFile("output.a", std::ios::out); // 以追加模式打开文件
    if (outputFile.is_open()) {
        std::cout << "    .file  \"" << filename << "\"" << std::endl;
        std::cout << "    .attribute arch, \"rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0\"" << std::endl;
        std::cout << "    .attribute unaligned_access, 0" << std::endl; 
        std::cout << "    .attribute stack_align, 16" << std::endl;
        std::cout << "    .text" << std::endl;
        this->data->PrintDataSegment_Globval();
        this->text->PrintTextSegment();
        this->data->PrintDataSegment_Tempvar();

        outputFile.close();
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
    PrintSegmentType(TEXT, oldtype);
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
    //machinefunction->print_func_end();
    if(size == -1)
        std::cout << "    .size " << name << ", " << "-" << name << std::endl;
}

//dataSegment
dataSegment::dataSegment(MachineUnit* Machineunit) 
    : Machineunit(Machineunit) {
    GenerateGloblvarList(Machineunit);
    GenerateTempvarList(Machineunit);
}
void dataSegment::GenerateGloblvarList(MachineUnit* Machineunit) {
    for(auto& data : Machineunit->get_module()->GetGlobalVariable()) {
        globlvar* gvar = new globlvar(data.get());
            globlvar_list.push_back(gvar);
    }
}
void dataSegment::GenerateTempvarList(MachineUnit* Machineunit) {
    int num_lable=0; // 用于浮点常量计数
    for (auto& machinefuntion : Machineunit->getMachineFunctions()) {
        for (auto& machineblock : machinefuntion->getMachineBasicBlocks()) {
            std::list<MachineInst*>& minsts = machineblock->getMachineInsts();
            for (std::list<MachineInst*>::iterator it = minsts.begin(); it != minsts.end(); ++it) {
                MachineInst* machineinst = *it;
                if(machineinst->GetUses().empty()) {
                    continue;
                }
                //生成需要放在只读数据段的内容， 应该只有浮点常量
                for(auto& used : machineinst->GetUses()) {
                    if (auto constfloat = dynamic_cast<ConstIRFloat*>(used)) {
                        tempvar* tempfloat = new tempvar(num_lable, constfloat->GetVal());
                        num_lable++;
                        tempvar_list.push_back(tempfloat); 
                        //在代码中修改加载方式；
                        Change_LoadConstFloat(machineinst, tempfloat, it, used);
                    }
                }
            }
        }
    }
}
std::vector<tempvar*> dataSegment::get_tempvar_list() {return tempvar_list;}
void dataSegment::Change_LoadConstFloat(MachineInst* machineinst, tempvar* tempfloat, std::list<MachineInst *>::iterator it, Operand used) {
    std::string opcode = machineinst->GetOpcode();
    MachineBasicBlock* block = machineinst->get_machinebasicblock();
    std::list<MachineInst*>& insts = block->getMachineInsts();
    Type* backendptr = new BackendPtr();
    Operand rd = new Value(backendptr);
    Operand rs1 = new Value(backendptr);
    Operand rs2 = new Value(backendptr);
    std::string nameHi = "\%hi(" + tempfloat->Getname() + ")";
    rs1->SetName(nameHi);
    std::string nameLo = "\%lo(" + tempfloat->Getname() + ")";
    rs2->SetName(nameLo);
    MachineInst* inst1 = new MachineInst(machineinst->get_machinebasicblock(), "lui", rd, rs1); // lui  a5, %hi(lable)
    MachineInst* inst2 = new MachineInst(machineinst->get_machinebasicblock(), "addi", rd, rd, rs1);// addi  a5, a5, %lo(lable)
    it = insts.insert(it, inst1);
    ++it;
    it = insts.insert(it, inst2); 
    ++it;
    used->SetName(rd->GetName());
    // if(opcode == "sw")
    //     machineinst->GetRd()->SetName(rd->GetName());
    // else {
    //     machineinst->GetRs1
    // }
}  
void dataSegment::PrintDataSegment_Globval() {
    for(auto& gvar : globlvar_list) {
        gvar->PrintGloblvar();
    }
}
void dataSegment::PrintDataSegment_Tempvar() {
    for(auto& gvar : tempvar_list) {
        gvar->PrintTempvar();
    }
}

//globlvar
globlvar::globlvar(Variable* data) {
    name = data->get_name();
    InnerDataType tp = data->GetType()->GetTypeEnum();
    if(tp == InnerDataType::IR_Value_INT || tp == InnerDataType::IR_Value_Float) {
        align = 2;
        size = 4;
        if (data->GetInitializer()) {
            // sec = "data";
            if(tp == InnerDataType::IR_Value_INT) {
                std::string num = data->GetInitializer()->GetName();
                int init = std::stoi(num);
                init_vector.push_back(init);
            }
            if(tp == InnerDataType::IR_Value_Float) {
                ConstIRFloat* temp = dynamic_cast<ConstIRFloat*>(data->GetInitializer());
                float init = temp->GetVal();
                init_vector.push_back(init);
            }
        }
        // else {
        //     sec = "bss";
        // }
    }
    else if (tp == InnerDataType::IR_ARRAY) {
        align = 3;
        Type* basetype = dynamic_cast<HasSubType*>(data->GetType())->get_baseType();
        if(Initializer* arry_init = dynamic_cast<Initializer*>(data->GetInitializer())) {
            size = arry_init->GetType()->get_size();
            int init_size = arry_init->size();
            if (init_size == 0) {
                // sec = "bss";
            }
            else {
                // sec = "data";
                int limi = dynamic_cast<ArrayType*>(arry_init->GetType())->GetNumEle();
                for(int i=0;i<limi;i++){
                    if(i < init_size){
                        if(auto inits=dynamic_cast<Initializer*>((*arry_init)[i])) {
                            //递归
                            generate_array_init(inits, basetype);  
                        }
                        else {//Leaf 
                            if(basetype->GetTypeEnum() == IR_Value_INT) {
                                std::string num = (*arry_init)[i]->GetName();
                                int init = std::stoi(num);
                                init_vector.push_back(init);
                            }
                            else if (basetype->GetTypeEnum() == IR_Value_Float) {
                                ConstIRFloat* temp = dynamic_cast<ConstIRFloat*>((*arry_init)[i]);
                                float init = temp->GetVal();
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
            // undefined arr;
            size = data->GetType()->get_size();
            // sec = "bss";
        }
    }
    else align = -1;//Error
}
// std::string globlvar::get_sec() {return sec;}
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
                        if(basetype->GetTypeEnum() == IR_Value_INT) {
                            std::string num = (*arry_init)[i]->GetName();
                            int init = std::stoi(num);
                            init_vector.push_back(init);
                        }
                        else if (basetype->GetTypeEnum() == IR_Value_Float) {
                            ConstIRFloat* temp = dynamic_cast<ConstIRFloat*>((*arry_init)[i]);
                            float init = temp->GetVal();
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

void globlvar::PrintGloblvar() {
    if (init_vector.empty()) {
        std::cout << "    .globl  " << name << std::endl;
        PrintSegmentType(BSS, oldtype);
        std::cout << "    .align  " << align << std::endl;
        std::cout << "    .type  " << name << ", @" << ty << std::endl;
        std::cout << "    .size  " << name << ", " << size << std::endl;
        std::cout << name << ":" << std::endl;
        std::cout << "    .zero  " << size << std::endl; 
    }
    else {
        std::cout << "    .globl  " << name << std::endl;
        PrintSegmentType(DATA, oldtype);
        std::cout << "    .align  " << align << std::endl;
        std::cout << "    .type  " << name << ", @" << ty << std::endl;
        std::cout << "    .size  " << name << ", " << size << std::endl;
        std::cout << name << ":" << std::endl;
        int zero_count=0;
        for(auto& init : init_vector) {
            bool is_zero = std::visit([](auto&& value){return value==0;}, init);
            if(is_zero) {
                zero_count+=4;
            }
            else {
                if(zero_count!=0) {
                    std::cout << "    .zero  " << zero_count << std::endl;
                    zero_count = 0;
                }
    
                if(std::holds_alternative<int>(init)) {
                    std::cout << "    .word  " << std::get<int>(init) << std::endl;
                }
                else {
                    //float type
                    FloatBits bits;
                    bits.floatValue = std::get<float>(init); 
                    std::string binaryString = std::bitset<32>(bits.intBits).to_string();
                    int decNum = binaryToDecimal(binaryString);
                    std::cout << "    .word  " << decNum << std::endl;
                }
            }
            if (&init == &init_vector.back() && is_zero) {
                std::cout << "    .zero  " << zero_count << std::endl;
            }
        }
    }

}

//tempvar
tempvar::tempvar(int num_lable, float init) : 
    num_lable(num_lable), align(2), init(init) {
    name = ".LC"+ std::to_string(num_lable);
}
std::string tempvar::Getname() {
    return name;
}
void tempvar::PrintTempvar() {
    PrintSegmentType(RODATA, oldtype);
    std::cout << "    .align  " << align << std::endl;
    std::cout << name << ":" << std::endl;
    FloatBits bits;
    bits.floatValue = init;
    std::string binaryString = std::bitset<32>(bits.intBits).to_string();
    int decNum = binaryToDecimal(binaryString);
    std::cout << "    .word  " << decNum << std::endl;
}
