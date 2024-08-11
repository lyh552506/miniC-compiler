#include "../include/backend/Sched.hpp"
using ISA = RISCVMIR::RISCVISA;
bool isLoadinst (RISCVMIR* inst) {
    ISA opcode = inst->GetOpcode();
    return (opcode > ISA::BeginLoadMem && opcode < ISA::EndLoadMem)\
        || (opcode > ISA::BeginFloatLoadMem && opcode < ISA::EndFloatLoadMem);
};
bool isStoreinst (RISCVMIR* inst) {
    ISA opcode = inst->GetOpcode();
    return (opcode > ISA::BeginStoreMem && opcode < ISA::EndStoreMem)\
        || (opcode > ISA::BeginFloatStoreMem && opcode < ISA::EndFloatStoreMem);
};

BlockDepInfo::BlockDepInfo(RISCVBasicBlock* block)
    : block(block) {
    BuildBlockDepInfo(block->begin(), block->end());
}
BlockDepInfo::BlockDepInfo(RISCVBasicBlock* block, mylist_iterator begin, mylist_iterator end)
    : block(block) {
    BuildBlockDepInfo(begin, end);
}

void BlockDepInfo::BuildBlockDepInfo(mylist_iterator begin, mylist_iterator end) {
    for(mylist_iterator it = begin; it != end; ++it) {
        RISCVMIR* inst = *it;
        if(isboundary(inst)) continue;
        Sunit* sunit = new Sunit();
        inst2sunit.push_back(std::make_pair(inst, sunit));
        Sunit2InstMap[sunit] = inst;

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
    auto GetWriteReg = [&](RISCVMIR* inst) {
        return SchedInfo(inst->GetOpcode()).WriteRes;
    };
    auto GetReadAdvance = [&](RISCVMIR* inst) {
        return SchedInfo(inst->GetOpcode()).ReadAdvance;
    };
    std::list<RealSunit> inst2sunitLocal;
    for(mylist_iterator it = begin; it != end; ++it) {
        inst2sunitLocal.push_back(GetRealSunit(*it));
    }

    for(auto it = inst2sunitLocal.rbegin(); it != inst2sunitLocal.rend(); ++it) {
        RISCVMIR*& inst = it->first;
        Sunit*& sunit = it->second;
        sunits.push_back(sunit);
        // Glue info
        if(isLoadinst(inst) || isStoreinst(inst)) {
            GlueList.push_back(sunit);
        }
        if(adjList.find(sunit) == adjList.end()) {
            adjList[sunit] = {};
            inDegree[sunit];
        }
        Sunit* def = nullptr;
        if(inst->GetDef() != nullptr) {
            if(std::stack<RISCVMIR*>& stack = depInfo->def2inst[inst->GetDef()]; stack.size() != 0) {
                def = GetSunit(stack.top());
            }
            depInfo->def2inst[inst->GetDef()].pop();
        }
        // Dependency info and latency computation
        for(int i=0; i<inst->GetOperandSize(); i++) {
            RISCVMOperand*& op = inst->GetOperand(i);
            std::stack<RISCVMIR*>& stack = depInfo->use2inst[op];
            stack.pop();
            // latency info
            if(op != nullptr) {
                if(!depInfo->def2inst[op].empty()) {
                    RISCVMIR* definst = depInfo->def2inst[inst->GetOperand(i)].top();
                    addDependency(GetSunit(inst), GetSunit(definst));
                    sunit->latency = GetWriteReg(definst) > sunit->latency ? GetWriteReg(definst): sunit->latency;             
                }
                else if(Imm* imm = dynamic_cast<Imm*>(op)) {
                    // loadimm32 is a special case.
                    sunit->latency = SchedInfo(ISA::LoadImm32).WriteRes;
                }
                else if(RISCVFrameObject* sreg = dynamic_cast<RISCVFrameObject*>(op)) {
                    sunit->latency = SchedInfo(ISA::LoadFromStack).WriteRes;
                }
                else {
                    // the use's def is not in this block
                    // sunit->latency = 0;
                }
            }
        }
        if(inst->GetDef() != nullptr) {
            if(std::stack<RISCVMIR*>& stack = depInfo->use2inst[inst->GetDef()]; stack.size() != 0) {
                if(RISCVMIR* useinst = stack.top()) {
                    Sunit*& use = GetSunit(useinst);
                    if(adjList[use].find(def) == adjList[use].end()) {
                        AntiDepMap[use] = def;
                        adjList.erase(use);
                    }
                    #ifdef DEBUG_SCHED
                    std::cout << "---AntiDependency---" << std::endl << "def->";
                    inst->printfull();
                    std::cout << "use<-";
                    useinst->printfull();
                    #endif
                    // if(adjList[def].size() == 0) {
                    //     AntiDepMap[use] = def;
                    //     adjList.erase(use);
                    // }
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
    if(adjList[use].find(def) == adjList[use].end()) {
        adjList[use].insert(def);
        inDegree[def]++;
    }
}

void DependencyGraph::ComputeHeight() {
    for(auto& it: sunits) {
        Sunit* sunit = it;
        if(inDegree[sunit]==0) {
            sunit->height = 0;
        }
        for(auto ind = adjList[it].begin(); ind != adjList[it].end(); ++ind) {
            Sunit* def = *ind;
            def->height = def->height > (sunit->height + def->latency) ? def->height : (sunit->height + def->latency);
        }
        #ifdef DEBUG_SCHED
        std::cout << "height: " << sunit->height;
        depInfo->Sunit2InstMap[sunit]->printfull();
        std::cout << std::flush;
        #endif
    }
}

void DependencyGraph::ComputeDepth() {
    
}
Sunit*& DependencyGraph::GetSunit(RISCVMIR* inst) {
    for(auto& pair : depInfo->inst2sunit) {
        if(pair.first == inst)
            return pair.second;
    }
    assert(0 && "impossible");
}
void DependencyGraph::RemoveAntiDep(Sunit* sunit) {
    for(auto it = AntiDepMap.begin(); it != AntiDepMap.end();) {
        if(it->second == sunit) {
            it = AntiDepMap.erase(it);
        }
        else ++it;
    }
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
        if(isboundary(*rbegin)) {
            --rend;
        }
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
    return true;
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