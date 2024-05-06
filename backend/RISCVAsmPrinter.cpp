#include "RISCVAsmPrinter.hpp"

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
RISCVAsmPrinter::RISCVAsmPrinter(std::string filename, Module* unit, RISCVLoweringContext& ctx) 
    : filename(filename){ 
    dataSegment* data = new dataSegment(unit,ctx);
    this->data = data;
}

void RISCVAsmPrinter::printAsmGlobal() {
    std::cout << "    .file  \"" << filename << "\"" << std::endl;
    std::cout << "    .attribute arch, \"rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0\"" << std::endl;
    std::cout << "    .attribute unaligned_access, 0" << std::endl; 
    std::cout << "    .attribute stack_align, 16" << std::endl;
    std::cout << "    .text" << std::endl;
    this->data->PrintDataSegment_Globval();
}

void RISCVAsmPrinter::printAsm() {
    this->printAsmGlobal();
    this->text->PrintTextSegment();
    this->data->PrintDataSegment_Tempvar();
}

//textSegment
textSegment::textSegment(Module* module) {
    GenerateFuncList(module);
}
void textSegment::GenerateFuncList(Module* module) {
    for (auto& function : module->GetFuncTion()) {
        functionSegment* funcSeg = new functionSegment(function.get());
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
functionSegment::functionSegment(Function* function) {
    align = 1;
    name = function->GetName();
    size = -1;
}
void functionSegment::PrintFuncSegment() {
    std::cout << "    .align  " << align << std::endl;
    std::cout << "    .globl  " << name << std::endl;
    std::cout << "    .type  " << name << ", @" << ty << std::endl;
    // std::cout << name << ":" << std::endl;
    // machinefunction->print_func_name();
    // machinefunction->print_stack_frame();
    // for (auto& machineblock : machinefunction->getMachineBasicBlocks()) {
    //     machineblock->print_block_lable();
    //     for (auto& machineinst : machineblock->getMachineInsts()) {
    //         machineinst->print();
    //     }
    // }
    // machinefunction->print_func_end();
    if(size == -1)
        std::cout << "    .size " << name << ", " << "-" << name << std::endl;
}

//dataSegment
dataSegment::dataSegment(Module* module, RISCVLoweringContext& ctx) {
    GenerateGloblvarList(module, ctx);
    // GenerateTempvarList(module);
}
void dataSegment::GenerateGloblvarList(Module* module, RISCVLoweringContext& ctx) {
    for(auto& data : module->GetGlobalVariable()) {
        globlvar* gvar = new globlvar(data.get());
        ctx.insert_val2mop(Singleton<Module>().GetValueByName(data->get_name()), gvar);
        globlvar_list.push_back(gvar);
    }
}
void dataSegment::GenerateTempvarList(Module* module) {
    // int num_lable=0; // 用于浮点常量计数
    // for (auto& funtion : module->GetFuncTion()) {
    //     for (auto& block : funtion.get()->GetBasicBlock()) {
    //         for () {

    //         }
    //         // std::list<MachineInst*>& minsts = block->();
    //         for (std::list<MachineInst*>::iterator it = minsts.begin(); it != minsts.end(); ++it) {
    //             MachineInst* machineinst = *it;
    //             if(machineinst->GetUses().empty()) {
    //                 continue;
    //             }
    //             //生成需要放在只读数据段的内容， 应该只有浮点常量
    //             for(auto& used : machineinst->GetUses()) {
    //                 if (auto constfloat = dynamic_cast<ConstIRFloat*>(used)) {
    //                     tempvar* tempfloat = new tempvar(num_lable, constfloat->GetVal());
    //                     num_lable++;
    //                     tempvar_list.push_back(tempfloat); 
    //                     //在代码中修改加载方式；
    //                     Change_LoadConstFloat(machineinst, tempfloat, it, used);
    //                 }
    //             }
    //         }
    //     }
    // }
}
std::vector<tempvar*> dataSegment::get_tempvar_list() {return tempvar_list;}
// void dataSegment::Change_LoadConstFloat(MachineInst* machineinst, tempvar* tempfloat, std::list<MachineInst *>::iterator it, Operand used) {
//     std::string opcode = machineinst->GetOpcode();
//     MachineBasicBlock* block = machineinst->get_machinebasicblock();
//     std::list<MachineInst*>& insts = block->getMachineInsts();
//     Type* backendptr = new BackendPtr();
//     Operand rd = new Value(backendptr);
//     Operand rs1 = new Value(backendptr);
//     Operand rs2 = new Value(backendptr);
//     std::string nameHi = "\%hi(" + tempfloat->Getname() + ")";
//     rs1->SetName(nameHi);
//     std::string nameLo = "\%lo(" + tempfloat->Getname() + ")";
//     rs2->SetName(nameLo);
//     MachineInst* inst1 = new MachineInst(machineinst->get_machinebasicblock(), "lui", rd, rs1); // lui  a5, %hi(lable)
//     MachineInst* inst2 = new MachineInst(machineinst->get_machinebasicblock(), "addi", rd, rd, rs1);// addi  a5, a5, %lo(lable)
//     it = insts.insert(it, inst1);
//     ++it;
//     it = insts.insert(it, inst2); 
//     ++it;
//     used->SetName(rd->GetName());
//     // if(opcode == "sw")
//     //     machineinst->GetRd()->SetName(rd->GetName());
//     // else {
//     //     machineinst->GetRs1
//     // }
// }  
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
globlvar::globlvar(Variable* data):RISCVGlobalObject(data->GetType(),data->get_name()){
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
        std::cout << "    .globl  " << this->GetName() << std::endl;
        PrintSegmentType(BSS, oldtype);
        std::cout << "    .align  " << align << std::endl;
        std::cout << "    .type  " << this->GetName() << ", @" << ty << std::endl;
        std::cout << "    .size  " << this->GetName() << ", " << size << std::endl;
        std::cout << this->GetName() << ":" << std::endl;
        std::cout << "    .zero  " << size << std::endl; 
    }
    else {
        std::cout << "    .globl  " << this->GetName() << std::endl;
        PrintSegmentType(DATA, oldtype);
        std::cout << "    .align  " << align << std::endl;
        std::cout << "    .type  " << this->GetName() << ", @" << ty << std::endl;
        std::cout << "    .size  " << this->GetName() << ", " << size << std::endl;
        std::cout << this->GetName() << ":" << std::endl;
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
    RISCVTempFloatObject("file"), num_lable(num_lable), align(2), init(init) {
    this->GetName() = ".LC"+ std::to_string(num_lable);
}
std::string tempvar::Getname() {
    return this->GetName();
}
void tempvar::PrintTempvar() {
    // PrintSegmentType(RODATA, oldtype);
    // std::cout << "    .align  " << align << std::endl;
    // std::cout << this->GetName() << ":" << std::endl;
    // FloatBits bits;
    // bits.floatValue = init;
    // std::string binaryString = std::bitset<32>(bits.intBits).to_string();
    // int decNum = binaryToDecimal(binaryString);
    // std::cout << "    .word  " << decNum << std::endl;
}
