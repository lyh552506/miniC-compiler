#pragma once 
#include "../include/backend/Sched.hpp"


void DependencyGraph::BuildGraph(mylist<RISCVBasicBlock,RISCVMIR>::iterator begin, mylist<RISCVBasicBlock,RISCVMIR>::iterator end){

}
void DependencyGraph::addDependency(const Sunit* a, const Sunit* b){

}


SchedRegion::SchedRegion(RISCVBasicBlock* BasicBlock) {
    this->block = BasicBlock;
    this->begin = BasicBlock->begin();
    this->end = BasicBlock->begin();
}

bool SchedRegion::NextRegion() {
    // Schedel region is from begin to the front inst of end. 
    begin = end;
    if(begin == block->begin()) {
        // Start division region.
    }
    else if(begin == block->end()) {
        return false;
    } 
    else {
        ++begin;
        ++end;
    }
    RISCVMIR* inst = *end;
    while(!isboundary(inst) || end != block->end()) {
        ++end;
    }
    return true;
}
using ISA = RISCVMIR::RISCVISA;
bool SchedRegion::isboundary(RISCVMIR* inst) {
    // if the inst modify the stack pointer
    // Actually, impossible here because we generate the frame after post-ra-sched.
    if(PhyRegister* phy = dynamic_cast<PhyRegister*>(inst->GetDef())) {
        PhyRegister::PhyReg reg = phy->Getregenum();
        if(reg == PhyRegister::sp || reg == PhyRegister::s0) {
            return true;
        }
    }
    // if the inst is the boundary of the block
    // if the inst is call inst
    ISA op = inst->GetOpcode();
    switch(op){
        // The division of block is strict, so we don't need to 
        // consider these insts anymore.

        // case ISA::ret :
        // case ISA::_j :
        // case ISA::_beq:
        // case ISA::_bne:
        // case ISA::_blt:
        // case ISA::_bge:
        // case ISA::_ble:
        // case ISA::_bgt:
        // case ISA::_bgeu:
        // case ISA::_bltu:
        // case ISA::_jal:
        // case ISA::_jalr:
        case ISA::call:
            return true;
        default :
            break;
    }
    return false;
}