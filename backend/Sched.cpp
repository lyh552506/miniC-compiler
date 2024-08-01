#include "../include/backend/Sched.hpp"
using mylist_iterator = mylist<RISCVBasicBlock,RISCVMIR>::iterator;
void DependencyGraph::BuildGraph(mylist_iterator begin, mylist_iterator end){
    for(mylist_iterator it = begin; it != end; ++it) {
        RISCVMIR* inst = *it;
        Sunit* sunit = new Sunit();
        inst2sunit.push_back(std::make_pair(inst, sunit));

        if(inst->GetDef() != nullptr) {
            def2inst[inst->GetDef()].push(inst);
        }
        for(int i=0; i<inst->GetOperandSize(); i++) {
            if(inst->GetOperand(i) != nullptr) {
                use2inst[inst->GetOperand(i)].push(inst);
            }
        }
    }
    auto GetSunit = [&](RISCVMIR* inst) {
        for(auto pair : inst2sunit) {
            if(pair.first == inst)
                return pair.second;
        }
        assert(0 && "impossible");
    };

    for(auto it = inst2sunit.rbegin(); it != inst2sunit.rend(); --it) {
        RISCVMIR*& inst = it->first;
        Sunit*& sunit = it->second;
        for(int i=0; i<inst->GetOperandSize(); i++) {
            if(inst->GetOperand(i) != nullptr) {
                if(!def2inst[inst->GetOperand(i)].empty()) {
                    addDependency(GetSunit(inst), GetSunit(def2inst[inst->GetOperand(i)].top()));
                }
            }
            if(inst->GetDef() != nullptr) {
                def2inst[inst->GetDef()].pop();
            }
        }
    }
}
// use sunit point to def sunit
void DependencyGraph::addDependency(Sunit* use, Sunit* def){
    if(adjList[use].find(def) == adjList[def].end()) {
        adjList[use].insert(def);
        inDegree[def]++;
    }
}

void DependencyGraph::ComputeHeight() {
    
}

void DependencyGraph::ComputeDepth() {
    
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
        if(isboundary(*begin)) {
            ++begin;
            ++end;
        }
    }
    else if(begin == block->end()) {
        return false;
    } 
    else {
        ++begin;
        ++end;
    }
    while(end != block->end()) { 
        if(!isboundary(*end)) ++end;
        else return true;
    }
    return false;
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