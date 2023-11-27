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

int MachineOperand::getVal() {
    return this->val;
}

int MachineOperand::getReg() {
    return this->regnum;
}

int MachineOperand::getType() {
    return this->type;
}

MachineInst *MachineOperand::getParent() {
    return this->parent;
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