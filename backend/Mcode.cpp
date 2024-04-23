#include "Mcode.hpp"

/*MachinInst*/
//without IR
MachineInst::MachineInst(MachineBasicBlock* mbb,std::string opcode) 
    : mbb(mbb), opcode(opcode), offset(0), def(NULL), used(NULL) {}    
MachineInst::MachineInst(MachineBasicBlock* mbb,std::string opcode, Operand rd) 
    : mbb(mbb), opcode(opcode), rd(rd), offset(0), def(NULL), used(NULL) {}
MachineInst::MachineInst(MachineBasicBlock* mbb,std::string opcode, Operand rd, Operand rs1) 
    : mbb(mbb), opcode(opcode), rd(rd), rs1(rs1), offset(0), def(NULL), used(NULL) {}
MachineInst::MachineInst(MachineBasicBlock* mbb,std::string opcode, Operand rd, Operand rs1, Operand rs2) 
    : mbb(mbb), opcode(opcode), rd(rd), rs1(rs1), rs2(rs2), offset(0), def(NULL), used(NULL) {}
//with IR
MachineInst::MachineInst(User* IR, MachineBasicBlock* mbb,std::string opcode) 
    : IR(IR), mbb(mbb), opcode(opcode), offset(0), def(NULL), used(NULL) {}
MachineInst::MachineInst(User* IR, MachineBasicBlock* mbb,std::string opcode, Operand rd) 
    : IR(IR), mbb(mbb), opcode(opcode), rd(rd), offset(0), def(NULL), used(NULL) {}
MachineInst::MachineInst(User* IR, MachineBasicBlock* mbb,std::string opcode, Operand rd, Operand rs1) 
    : IR(IR), mbb(mbb), opcode(opcode), rd(rd), rs1(rs1), offset(0), def(NULL), used(NULL) {}
MachineInst::MachineInst(User* IR, MachineBasicBlock* mbb,std::string opcode, Operand rd, Operand rs1, Operand rs2) 
    : IR(IR), mbb(mbb), opcode(opcode), rd(rd), rs1(rs1), rs2(rs2), offset(0), def(NULL), used(NULL) {}
User* MachineInst::getIR() {return this->IR;}
MachineBasicBlock* MachineInst::get_machinebasicblock() {return this->mbb;}
std::string MachineInst::GetOpcode() {return opcode;}
void MachineInst::SetOpcode(std::string opcode) {this->opcode = opcode;}
Operand MachineInst::GetRd() {return rd;}
Operand MachineInst::GetRs1() {return rs1;}
Operand MachineInst::GetRs2() {return rs2;}
Operand MachineInst::GetDefs(){return def;}
std::vector<Operand>& MachineInst::GetUses() {return this->used;}
// bool MachineInst::isVirtual(Operand Op) { 
//     if (Op->GetName().find(".LBB")) {return 0;}
//     else {return Op->GetName()[0] == '.' ;}
// }
void MachineInst::SetRd(Operand rd) {this->rd = rd;}
void MachineInst::SetRs1(Operand rs1) {this->rs1 = rs1;}
void MachineInst::SetRs2(Operand rs2) {this->rs2 = rs2;}
void MachineInst::SetDefs(Operand def) {this->def = def;}

void MachineInst::print() {
    if (opcode == "alloca") {
        return;   
    }
    else if (opcode == "sw") {
        std::cout << "    " << opcode << " " << rd->GetName() << ", -"; 
        std::cout << mbb->get_parent()->get_offset(rs1->GetName()) << "(s0)" << std::endl;
        // std::cout << mbb->get_parent()->get_offset(rs1->GetName()) << "(";
        // std::cout << rs1->GetName() << ")" << std::endl;
        // rs1->SetName("s0");
    }
    else if (opcode == "lw") {
        std::cout << "    " << opcode << " " << rd->GetName() << ", -"; 
        std::cout << mbb->get_parent()->get_offset(rs1->GetName()) << "(s0)" << std::endl;
        // std::cout << mbb->get_parent()->get_offset(rs1->GetName()) << "(";
        // std::cout << rs1->GetName() << ")" << std::endl;
        // rs1->SetName("s0");
    }
    else if (opcode == "fcvt.s.w") {
        std::cout << "    " << opcode << " " << rd->GetName() << ", ";
        std::cout << rs1->GetName() << std::endl;
    }
    else if (opcode == "fcvt.w.s") {
        std::cout << "    " << opcode << " " << rd->GetName() << ", ";
        std::cout << rs1->GetName() << " , rtz" << std::endl;
    }
    else if (opcode == "j") {
        std::cout << "    " << opcode << " ";
        std::string lable = mbb->get_parent()->get_lable(rd->GetName());
        std::cout << lable << std::endl;
    }
    else if (opcode == "beqz") {
        std::cout << "    " << opcode << " ";
        std::string lable2 = mbb->get_parent()->get_lable(rs2->GetName());
        std::cout << rd->GetName() << ", " << lable2 << std::endl;
    }
    else if (opcode == "call" ) {
        std::cout << "    " << opcode << " ";
        std::cout << rd->GetName() << std::endl;
    }
    else if (opcode == "ret") {
        if (rd == nullptr) {
            std::cout << "    ret" << std::endl;
        }
        else {
            std::cout << "    lw a0, " << rd->GetName() << std::endl; 
            this->get_machinebasicblock()->get_parent()->print_func_end();
        }
    }
    else if (opcode == "li") {
        std::cout << "    li " << rd->GetName() << ", " << rs1->GetName() << std::endl;
    }
    else if (opcode == "xori") {
        std::cout << "    xori " << rd->GetName() << ", " << rs1->GetName() << ", " << rs2->GetName() << std::endl; 
    }
    else if (opcode == "white") {
        std::cout << "Error: No Such Instruction." << std::endl;
    }
    else {
        //binary & other
        std::cout << "    " << opcode << " ";
        if(rd&&rs1&&rs2) {
            std::cout << rd->GetName() << ", " << rs1->GetName() << ", " << rs2->GetName() << std::endl;
        }
        else if (rd&&rs1) {
            std::cout << rd->GetName() << ", " << rs1->GetName() << std::endl;
        }
        else if (rd) {
            std::cout << rd->GetName() << std::endl;
        }
        else 
            std::cout << std::endl;
    }
}

/*MachineBasicBlock*/
MachineBasicBlock::MachineBasicBlock(BasicBlock* block, MachineFunction* parent)
    : block(block), mfuc(parent), succNum(0) {}
void MachineBasicBlock::set_lable(int func_num, int block_num) {
    name = ".LBB" + std::to_string(func_num) + "_" + std::to_string(block_num);
}
void MachineBasicBlock::set_succNum(int succNum) {
    this->succNum = succNum;
}
std::string MachineBasicBlock::get_name() {return this->name;}
int MachineBasicBlock::get_succNum() {return this->succNum;}
void MachineBasicBlock::set_name(std::string name) {this->name = name;}
void MachineBasicBlock::addMachineInst(MachineInst* minst) {
    this->minsts.push_back(minst);
}
std::list<MachineInst*>& MachineBasicBlock::getMachineInsts() {
    return this->minsts;
}
BasicBlock* MachineBasicBlock::get_block() {return this->block;}
MachineFunction* MachineBasicBlock::get_parent() {return this->mfuc;}
void MachineBasicBlock::print_block_lable() {
    std::cout << name << ":" << std::endl;
} 

/*MachineFunction*/
MachineFunction::MachineFunction(Function* func, MachineUnit* Munit) 
    : func(func),  Munit(Munit), offset(0), alloca_num(0), stacksize(0) {}
void MachineFunction::set_offset_map(std::string name, size_t offset) {
    offsetMap.insert(std::pair<std::string, size_t>(name, offset));
}
void MachineFunction::set_lable_map(std::string name, std::string lable) {
    lableMap.insert(std::pair<std::string, std::string>(name, lable));
}
void MachineFunction::set_blockMap(BasicBlock* bb, MachineBasicBlock* mbb) {
    blockMap.insert(std::pair<BasicBlock*, MachineBasicBlock*>(bb, mbb));
}
void MachineFunction::set_alloca_and_num() {
    alloca_num = 0;
    offset = 16;
    
    for (auto it = this->func->begin(); it != this->func->end(); ++it) {
        BasicBlock* Block = *it;
        for (auto Inst : *Block) {
            if (auto Tempinst = dynamic_cast<AllocaInst*>(Inst)) {
                if(Tempinst->GetType()->GetTypeEnum() == InnerDataType::IR_Value_VOID) {
                    continue;
                }
                this->offset += dynamic_cast<PointerType*>(Tempinst->GetType())->GetSubType()->get_size();
                set_offset_map(Tempinst->GetName(), offset);
                this->alloca_num += 1;
            }
        }
    }
}
void MachineFunction::set_stacksize() {
    size_t temp = offset % 16;
    stacksize += offset +(16 - temp);
}
Function* MachineFunction::get_function() {return this->func;}
MachineUnit* MachineFunction::get_machineunit() {return this->Munit;}
void MachineFunction::addMachineBasicBlock(MachineBasicBlock* mblock) {
    this->mblocks.push_back(mblock);
}
std::vector<MachineBasicBlock*>& MachineFunction::getMachineBasicBlocks() {
    return this->mblocks;
}
std::map<BasicBlock*, MachineBasicBlock*>& MachineFunction::get_blockMap() {
    return this->blockMap;
}
MachineBasicBlock* MachineFunction::get_mbbFrombb(BasicBlock* block) {
    return blockMap.find(block)->second;
}
MachineBasicBlock* MachineFunction::GetBlock(std::string name)
{
    for(MachineBasicBlock* block : mblocks)
    {
        if(block->get_name() == name)
            return block;
    }
    return nullptr;
}
size_t MachineFunction::get_offset(std::string name) {
    return offsetMap.find(name)->second;
}
std::string MachineFunction::get_lable(std::string name) {
    return lableMap.find(name)->second;
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
    //To DO : 考虑寄存器个数
    // std::map<size_t, std::string>::iterator item;
    // int tmp = 16;
    // int a = 0;
    // for (item = offsetMap.begin(); item != offsetMap.end(); item++) {
    //     if ((item->first - tmp) == 4) {
    //         std::cout << "    sw a" << a << ", -" << item->first << "(s0)" << std::endl;
    //     }
    //     else if ((item->first - tmp) == 8) {
    //         std::cout << "    sw a" << a << ", -" << item->first << "(s0)" << std::endl;
    //     }
    //     else {
    //         //To Do
    //         //array
    //     }
    //     a++;
    //     if( a < 8 ) {
    //         continue;
    //     }
    //     else {
    //         std::cout << "Error: There are not enough regiters." << std::endl;
    //     }
    //     tmp = item->first;
    // }
}
void MachineFunction::print_func_end() {
    std::cout << "    ld ra, " << this->get_stacksize() - 8 << "(sp)" << std::endl;
    std::cout << "    ld s0, " << this->get_stacksize() - 16 << "(sp)" << std::endl;
    std::cout << "    addi sp, sp, " << this->get_stacksize() << std::endl;
    std::cout << "    ret" << std::endl;
}

//MachineUnit
MachineUnit::MachineUnit(Module* unit) : unit(unit) {}
Module* MachineUnit::get_module() {return unit;}
void MachineUnit::addMachineFunction(MachineFunction* mfuncs) {
    this->mfuncs.push_back(mfuncs);
}
std::vector<MachineFunction*>& MachineUnit::getMachineFunctions() {
    return this->mfuncs;
}

