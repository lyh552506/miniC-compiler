#include<string>
#include<fstream>
#include"MachineCode.hpp"

//MachineOperand
MachineOperand::MachineOperand() {
    this->type =-1;
    this->val = -1;
    this->regnum = -1;
}

MachineOperand::MachineOperand(int type, int val) {
    this->type = type;
    this->val = val;
    this->regnum = -1;
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

bool MachineOperand::isMem() {
    if(this->type == MEM)
        return true;
    else
        return false;
}

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

std::string MachineOperand::getlable() {
    return this->lable;
}

void MachineOperand::setParent(MachineInst *parent) {
    this->parent = parent;
}

void MachineOperand::setReg(int regnum) {
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
BinaryInst::BinaryInst(MachineBlock *parent, int opcode, MachineOperand *rd, MachineOperand *rs1, MachineOperand *rs2) {
    this->parent = parent;
    this->opcode = opcode;
    this->rd = rd;
    this->rs1 = rs1;
    this->rs2 = rs2;
    this->num = 0;
}

void BinaryInst::print(std::ofstream &outputFile) {
    outputFile << this->opcode << this->rd->getRegnum() << this->rs1->getRegnum() << this->rs2->getRegnum() << std::endl;
}

