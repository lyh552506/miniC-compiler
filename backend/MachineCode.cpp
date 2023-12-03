#include<string>
#include<iostream>
#include<fstream>
#include"MachineCode.hpp"
#include"../lib/MagicEnum.hpp"

int offset;

//MachineOperand
MachineOperand::MachineOperand() {
    this->type =-1;
    this->val = -1;
    this->regnum = Register::a0;
}

MachineOperand::MachineOperand(int type, int val) {
    this->type = type;
    this->val = val;
    this->regnum = Register::a0;
}

bool MachineOperand::operator==(const MachineOperand& other) const {
    if(this->type == other.type && this->val == other.val)
        return true;
    else
        return false;
}

bool MachineOperand::operator<(const MachineOperand& other) const {
    if(this->type == other.type && this->val < other.val)
        return true;
    else
        return false;
}

bool MachineOperand::isReg() {
    if(this->type == REG)
        return true;
    else
        return false;
}

bool MachineOperand::isImm() {
    if(this->type == IMM)
        return true;
    else
        return false;
}

// bool MachineOperand::isMem() {
//     if(this->type == MEM)
//         return true;
//     else
//         return false;
// }

bool MachineOperand::isLabel() {
    if(this->type == LABEL)
        return true;
    else
        return false;
}

MachineInst *MachineOperand::getParent() {
    return this->parent;
}

int MachineOperand::getType() {
    return this->type;
}

int MachineOperand::getVal() {
    return this->val;
}

int MachineOperand::getRegnum() {
    return this->regnum;
}

auto MachineOperand::getRegName() {
    return magic_enum::enum_name (this->regnum);
}

std::string MachineOperand::getlable() {
    return this->lable;
}

void MachineOperand::setParent(MachineInst *parent) {
    this->parent = parent;
}

void MachineOperand::setReg(Register regnum) {
    if(this->type != REG)
        this->type = REG;
    this->regnum = regnum;
}

//MachineInst
void MachineInst::setParent(MachineBlock *parent) {
    this->parent = parent;
}

int MachineInst::getnum() {
    return this->num;
}  

//BinaryInst
BinaryInst::BinaryInst(MachineBlock *parent, Binary_Inst opcode, MachineOperand *rd, MachineOperand *rs1, MachineOperand *rs2) {
    this->parent = parent;
    this->opcode = opcode;
    this->rd = rd;
    this->rs1 = rs1;
    this->rs2 = rs2;
    this->num = 0;
}

void BinaryInst::print(std::ofstream &outputFile) {
    if (this->opcode == Binary_Inst::And) {
        outputFile << "and " << this->rd->getRegName() << ", " << this->rs1->getRegName() << ", " << this->rs2->getRegName() << std::endl;
    }
    else if (this->opcode == Binary_Inst::Or) {
        outputFile << "or " << this->rd->getRegName() << ", " << this->rs1->getRegName() << ", " << this->rs2->getRegName() << std::endl;
    }
    else if (this->opcode == Binary_Inst::Xor) {
        outputFile << "xor " << this->rd->getRegName() << ", " << this->rs1->getRegName() << ", " << this->rs2->getRegName() << std::endl;
    }
    else
        outputFile << magic_enum::enum_name(this->opcode) << this->rd->getRegnum() << ", " << this->rs1->getRegnum() << ", " << this->rs2->getRegnum() << std::endl;
    //std::cout << this->opcode << this->rs1->getRegnum() << this->rs2->getRegnum() << this->rs2->getRegnum() << std::endl;
}

//LoadInst
LoadInst::LoadInst(MachineBlock *parent, Load_Inst opcode, MachineOperand *rd, MachineOperand *rs1) {
    this->parent = parent;
    this->opcode = opcode;
    this->rd = rd;
    this->rs1 = rs1;
    this->rs2 = rs2;
    this->num = 0;
}

void LoadInst::print(std::ofstream &outputFile) {
    if (this->opcode == Load_Inst::li) {
    outputFile << "li" << this->rd->getRegName() << ", " << this->rs1->getVal() << std::endl;
    }
    else if (this->opcode == Load_Inst::la) {
    outputFile << "la" << this->rd->getRegName() << ", " << this->rs1->getlable() << std::endl;
    }
    else {
    outputFile << magic_enum::enum_name(this->opcode) << this->rd->getRegName() << ", %d(",offset;
    outputFile << this->rs1->getRegName() << ")" << std::endl;
    }
}

//StoreInst
StoreInst::StoreInst(MachineBlock *parent, Store_Inst opcode, MachineOperand *rd, MachineOperand *rs1, MachineOperand *rs2) {
    this->parent = parent;
    this->opcode = opcode;
    this->rd = rd;
    this->rs1 = rs1;
    this->rs2 = rs2;
    this->num = 0;
}

void StoreInst::print(std::ofstream &outputFile) {
    outputFile << magic_enum::enum_name(this->opcode) << this->rs2->getRegName() << ", %d(",offset;
    outputFile << this->rs1->getRegName() << ")" << std::endl;
}

//BranchInst
BranchInst::BranchInst(MachineBlock *parent,Branch_Inst opcode, MachineOperand *rs1, MachineOperand *rs2) {
    if (opcode > Branch_Inst::bne)
        printf("error: wrong instruction!\n");
    this->parent = parent;
    this->opcode = opcode;
    this->rd = nullptr;
    this->rs1 = rs1;
    this->rs2 = rs2;
    this->num = 0;
}

BranchInst::BranchInst(MachineBlock *parent,Branch_Inst opcode, MachineOperand *rs1) {
    if (opcode <= Branch_Inst::bne)
        printf("error: wrong instruction!\n");
    this->parent = parent;
    this->opcode = opcode;
    this->rd = nullptr;
    this->rs1 = rs1;
    this->rs2 = nullptr;
    this->num = 0;
}

void BranchInst::print(std::ofstream &outputFile) {
    if (this->opcode <= Branch_Inst::bne) {
        outputFile << magic_enum::enum_name(this->opcode) << " " << this->rs1->getRegName() << ", " << this->rs2->getRegName() << ", " << "%d",offset;
        outputFile << std::endl;
    }
    else {
        outputFile << magic_enum::enum_name(this->opcode) << " " << this->rs1->getRegName() << ", " << "%d",offset;
        outputFile << std::endl;
    }
}

//JumpInst
JumpInst::JumpInst(MachineBlock *parent, Jump_Inst opcode, MachineOperand *rd) {
    this->parent = parent;
    this->opcode = opcode;
    this->rd = rd;
    this->rs1 = nullptr;
    this->rs2 = nullptr;
    this->num = 0;    
}

JumpInst::JumpInst(MachineBlock *parent, Jump_Inst opcode, MachineOperand *rd, MachineOperand *rs1) {
    this->parent = parent;
    this->opcode = opcode;
    this->rd = rd;
    this->rs1 = rs1;
    this->rs2 = nullptr;
    this->num = 0;
}

JumpInst::JumpInst(MachineBlock *parent, Jump_Inst opcode) {
    this->parent = parent;
    this->opcode = opcode;
    this->rd = nullptr;
    this->rs1 = nullptr;
    this->rs2 = nullptr;
    this->num = 0;
}

JumpInst::JumpInst(MachineBlock *parent, Jump_Inst opcode, MachineOperand *rs1) {
    this->parent = parent;
    this->opcode = opcode;
    this->rd = nullptr;
    this->rs1 = rs1;
    this->rs2 = nullptr;
    this->num = 0;
}

void JumpInst::print(std::ofstream &outputFile) {
    if (this->opcode == Jump_Inst::jal) {
        outputFile << "jal " << this->rd->getRegName() << "%d",offset;
        outputFile << std::endl;
    }
    else if (this->opcode == Jump_Inst::jalr) {
        outputFile << "jalr " << this->rd->getRegName() << "%d",offset;
        outputFile << "(" << this->rs1->getRegName() << ")" <<std::endl;
    }
    else if (this->opcode == Jump_Inst::j) {
        outputFile << "j " << "%d",offset;
        outputFile << std::endl;
    }
    else {
        outputFile << "jr " << this->rs1->getRegName() << std::endl;
    }
}

//CmpInst
CmpInst::CmpInst(MachineBlock *parent, Cmp_Inst opcode, MachineOperand *rd, MachineOperand *rs1, MachineOperand *rs2) {
    this->parent = parent;
    this->opcode = opcode;
    this->rd = rd;
    this->rs1 = rs1;
    this->rs2 = rs2;
    this->num = 0;  
}

CmpInst::CmpInst(MachineBlock *parent, Cmp_Inst opcode, MachineOperand *rd, MachineOperand *rs1) {
    this->parent = parent;
    this->opcode = opcode;
    this->rd = rd;
    this->rs1 = rs1;
    this->rs2 = nullptr;
    this->num = 0;     
}

void CmpInst::print(std::ofstream &outputFile) {
    if (this->opcode == Cmp_Inst::slt) {
        outputFile << "slt " << this->rd->getRegName() << ", " << this->rs1->getRegName() << this->rs2->getRegName() << std::endl;
    }
    else if (this->opcode == Cmp_Inst::slti) {
        outputFile << "slt " << this->rd->getRegName() << ", " << this->rs1->getVal() << std::endl;
    }
    else {
        outputFile << magic_enum::enum_name(this->opcode) << " " << this->rd->getRegName() << ", " << this->rs1->getRegName() << std::endl;
    }
}


//PseudoInst
PseudoInst::PseudoInst(MachineBlock *parent, Pseudo_Inst opcode, MachineOperand *rd, MachineOperand *rs1) {
    this->parent = parent;
    this->opcode = opcode;
    this->rd = rd;
    this->rs1 = rs1;
    this->rs2 = nullptr;
    this->num = 0;         
}

PseudoInst::PseudoInst(MachineBlock *parent, Pseudo_Inst opcode) {
    this->parent = parent;
    this->opcode = opcode;
    this->rd = nullptr;
    this->rs1 = nullptr;
    this->rs2 = nullptr;
    this->num = 0;    
}

void PseudoInst::print(std::ofstream &outputFile) {
    if (this->opcode == Pseudo_Inst::mv) {
        outputFile << "mv " << this->rd->getRegName() << ", " << this->rs1->getRegName() << std::endl;
    }
    else if (this->opcode == Pseudo_Inst::ret) {
        outputFile << "ret" << std::endl;
    }
}



