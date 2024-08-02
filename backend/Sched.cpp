#include "../include/backend/Sched.hpp"

BlockDepInfo::BlockDepInfo(RISCVBasicBlock* block) {
    BuildBlockDepInfo(block);
}

void BlockDepInfo::BuildBlockDepInfo(RISCVBasicBlock* block) {
    for(mylist_iterator it = block->begin(); it != block->end(); ++it) {
        RISCVMIR* inst = *it;
        if(isboundary(inst)) continue;
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
}

void DependencyGraph::BuildGraph(mylist_iterator begin, mylist_iterator end){
    auto GetRealSunit = [&](RISCVMIR* inst) {
        for(auto pair : depInfo->inst2sunit) {
            if(pair.first == inst)
                return pair;
        }
        assert(0 && "impossible");
    };
    std::list<RealSunit> inst2sunitLocal;
    for(mylist_iterator it = begin; it != end; ++it) {
        inst2sunitLocal.push_back(GetRealSunit(*it));
    }
    auto GetSunit = [&](RISCVMIR* inst) {
        for(auto pair : depInfo->inst2sunit) {
            if(pair.first == inst)
                return pair.second;
        }
        assert(0 && "impossible");
    };
    auto GetWriteReg = [&](RISCVMIR* inst) {
        return SchedInfo(inst->GetOpcode()).WriteRes;
    };
    auto GetReadAdvance = [&](RISCVMIR* inst) {
        return SchedInfo(inst->GetOpcode()).ReadAdvance;
    };

    for(auto it = inst2sunitLocal.rbegin(); it != inst2sunitLocal.rend(); ++it) {
        RISCVMIR*& inst = it->first;
        Sunit*& sunit = it->second;
        // def
        if(inst->GetDef() != nullptr) {
            depInfo->def2inst[inst->GetDef()].pop();
        }
        // use
        using ISA = RISCVMIR::RISCVISA;
        for(int i=0; i<inst->GetOperandSize(); i++) {
            RISCVMOperand*& op = inst->GetOperand(i);
            if(op != nullptr) {
                if(!depInfo->def2inst[inst->GetOperand(i)].empty()) {
                    RISCVMIR* definst = depInfo->def2inst[inst->GetOperand(i)].top();
                   
                    
                    // inst->printfull();
                    // std::cout << std::flush;
                   
                    addDependency(GetSunit(inst), GetSunit(definst));
                    sunit->latency = GetWriteReg(definst) > sunit->latency ? GetWriteReg(definst): sunit->latency;             
                }
                else if(Imm* imm = dynamic_cast<Imm*>(op)) {
                    // loadimm32 is a special case.
                    sunit->latency = SchedInfo(ISA::LoadImm32).WriteRes;
                }
                else {
                    // the use's def is not in this block
                    sunit->latency = 0;
                }
            }
        }
        if(sunit->latency > 0) 
            sunit->latency -= GetReadAdvance(inst);

        #ifdef DEBUG_SCHED
        std::cout << "latency: " << sunit->latency << "  ";
        inst->printfull();
        std::cout << std::flush;
        #endif
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
    this->end = begin;
    this->rbegin = BasicBlock->rbegin();
    this->rend = rbegin;
}
bool SchedRegion::LastRegion() {
    // Schedel region is from begin to the previous inst of end. 
    rbegin = rend;
    if(rbegin == block->rbegin()) {
        // Start division region.
        if(isboundary(*rbegin)) {
            --rend;
        }
    }
    else if(rbegin == block->rend()) {
        return false;
    } 
    else {
        --rend;
    }
    while(rend != block->rend()) { 
        if(!isboundary(*rend)) --rend;
        else {
            begin = rend;
            ++begin;
            end = rbegin;
            return true;
        }
    }
    begin = block->begin();
    end = rbegin;
}
bool SchedRegion::NextRegion() {
    // Schedel region is from begin to the previous inst of end. 
    begin = end;
    if(begin == block->begin()) {
        // Start division region.
        if(isboundary(*begin)) {
            ++begin;
            ++end;
        }
    }
    if(begin == block->end()) {
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
bool isboundary(RISCVMIR* inst) {
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

        case ISA::ret :
        case ISA::_j :
        case ISA::_beq:
        case ISA::_bne:
        case ISA::_blt:
        case ISA::_bge:
        case ISA::_ble:
        case ISA::_bgt:
        case ISA::_bgeu:
        case ISA::_bltu:
        case ISA::_jal:
        case ISA::_jalr:
        case ISA::call:
            return true;
        default :
            break;
    }
    return false;
}