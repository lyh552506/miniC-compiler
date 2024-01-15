#include "Mcode.hpp"
/*MachinInst*/
MachineInst::MachineInst(std::string opcode) : opcode(opcode) {}
MachineInst::MachineInst(std::string opcode, Operand rd, Operand rs1) : opcode(opcode), rd(rd), rs1(rs1) {
    // add_use(rd);
    // add_use(rs1);
}
MachineInst::MachineInst(std::string opcode, Operand rd, Operand rs1, Operand rs2) : opcode(opcode), rd(rd), rs1(rs1), rs2(rs2) {
    // add_use(rd);
    // add_use(rs1);
    // add_use(rs2);
}
void MachineInst::print() {
    std::cout << opcode << " ";
    std::cout << rd->GetName() << ", " << rs1->GetName() << ", " << rs2->GetName() << std::endl;
}


/*MachineBinaryInst*/
MachineBinaryInst::MachineBinaryInst(std::string opcode, Operand rd, Operand rs1, Operand rs2)
    : opcode(opcode), rd(rd), rs1(rs1), rs2(rs2) {
        // add_use(rd);
        // add_use(rs1);
        // add_use(rs2);
    }
void MachineBinaryInst::print() {
    std::cout << opcode << " ";
    std::cout << rd->GetName() << ", " << rs1->GetName() << ", " << rs2->GetName() << std::endl;
}

/*MachineCmpInst*/
MachineCmpInst::MachineCmpInst(std::string opcode, Operand rd, Operand rs1, Operand rs2)
    : opcode(opcode), rd(rd), rs1(rs1), rs2(rs2) {
        // add_use(rd);
        // add_use(rs1);
        // add_use(rs2);
    }
MachineCmpInst::MachineCmpInst(std::string opcode, Operand rd, Operand rs1)
    : opcode(opcode), rd(rd), rs1(rs1) {
        // add_use(rd);
        // add_use(rs1);
    }

/*MachineBasicBlock*/
void MachineBasicBlock::print_block_lable(int func_num, int block_num) {
    std::cout << ".LBB" << func_num << "_" << block_num << ":" << std::endl;
}

/*MachineFunction*/
MachineFunction::MachineFunction(Function* func) : func(func), offset(0), alloca_num(0), stacksize(0) {}
void MachineFunction::set_offset_map(size_t offset, std::string name) {
    offsetMap.insert(std::pair<size_t, std::string>(offset, name));
}
void MachineFunction::set_alloca_and_num() {
    alloca_num = 0;
    offset = 16;
    for (auto& Block : this->func->GetBasicBlock()) {
        for (auto Inst : *Block) {
            if (auto Tempinst = dynamic_cast<AllocaInst*>(Inst)) {
                if(Tempinst->GetType()->GetTypeEnum() == InnerDataType::IR_Value_VOID) {
                    continue;
                }
                this->offset += dynamic_cast<PointerType*>(Tempinst->GetType())->GetSubType()->get_size();
                set_offset_map(offset, Tempinst->GetName());
                this->alloca_num += 1;
            }
        }
    }
}
void MachineFunction::set_stacksize() {
    size_t temp = offset % 16;
    stacksize += offset +(16 - temp);
}
int MachineFunction::get_allocanum() {return this->alloca_num;}
int MachineFunction::get_stacksize() {return this->stacksize;}
void MachineFunction::print_func_name() {
    std::cout << this->func->GetName() << ":" << std::endl;
}
void MachineFunction::print_stack_frame() {
    this->set_alloca_and_num();
    this->set_stacksize();
    std::cout << "    addi sp, sp, -" << this->get_stacksize() << std::endl;
    std::cout << "    sd ra, " << this->get_stacksize() - 8 << "(sp)" << std::endl;
    std::cout << "    sd s0, " << this->get_stacksize() - 16 << "(sp)" << std::endl;
    std::cout << "    addi s0, sp, " << this->get_stacksize() << std::endl;
}
void MachineFunction::print_stack_offset() {
    std::map<size_t, std::string>::iterator item;
    int tmp = 16;
    int a = 0;
    for (item = offsetMap.begin(); item != offsetMap.end(); item++) {
        if ((item->first - tmp) == 4) {
            std::cout << "    sw a" << a << ", -" << item->first << "(s0)" << std::endl;
        }
        else if ((item->first - tmp) == 8) {
            std::cout << "    sw a" << a << ", -" << item->first << "(s0)" << std::endl;
        }
        else {
            //To Do
            //array
        }
        a++;
        if( a < 8 ) {
            continue;
        }
        else {
            std::cout << "Error: There are not enough regiters." << std::endl;
        }
        tmp = item->first;
    }
}
void MachineFunction::print_func_end() {
    std::cout << "    ld ra, " << this->get_stacksize() - 8 << "(sp)" << std::endl;
    std::cout << "    ld s0, " << this->get_stacksize() - 16 << "(sp)" << std::endl;
    std::cout << "    addi sp, sp, " << this->get_stacksize() << std::endl;
    std::cout << "    ret" << std::endl;
}