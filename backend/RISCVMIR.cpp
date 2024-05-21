#include "RISCVMIR.hpp"


RISCVMOperand*& RISCVMIR:: GetDef() {return def;}
RISCVMOperand*& RISCVMIR::GetOperand(int ind){
    assert(0<=ind&&ind<operands.size()&&"Range Assertion");
    return operands[ind];
}

void RISCVMIR::SetDef(RISCVMOperand* def){
    this->def=def;
}
void RISCVMIR::SetOperand(int ind, RISCVMOperand* op){
    assert(0<=ind&&ind<operands.size()&&"Range Assertion");
    operands[ind]=op;
}
void RISCVMIR::AddOperand(RISCVMOperand* op){
    operands.push_back(op);
}
void RISCVMIR::SetMopcode(RISCVISA isa) {
    this->opcode=isa;
}

void RISCVMIR::printfull(){
    std::string name(magic_enum::enum_name(opcode));
    if (name.find('_') != std::string::npos) name.erase(0,1);
    size_t pos=0;
    while((pos=name.find('_'))!=std::string::npos) name.replace(pos, 1, ".");
    std::cout<<"\t"<< name <<" ";
    
    if(name=="ret") {std::cout<<"\n";}
    else if (name=="call") {
        operands[0]->print();
    }
    else {
        if(def!=nullptr) {
            def->print();
            if(operands.size()>0) std::cout << ", ";
        }
        
        for(int i=0;i<operands.size();i++){
            operands[i]->print();
            if(i!=operands.size()-1)
                std::cout<<", ";
        }
        // std::cout << std::endl;
        std::cout <<'\n';
    }
}

std::unique_ptr<RISCVFrame>& RISCVFunction::GetFrame() {
    return frame;
}

size_t RISCVFunction::GetMaxParamSize() {
    return max_param_size;
}
void RISCVFunction::SetMaxParamSize(size_t size) {
    max_param_size=size;
}
// std::vector<std::unique_ptr<RISCVFrameObject>>& RISCVFunction::GetFrameObjects(){
//     return frame;
// }

RISCVBasicBlock::RISCVBasicBlock(std::string _name):NamedMOperand(_name,RISCVType::riscv_none){}

RISCVBasicBlock* RISCVBasicBlock::CreateRISCVBasicBlock(){
    static int cnt=0;
    return new RISCVBasicBlock(".LBB"+std::to_string(cnt++));
}

void RISCVBasicBlock::replace_succ(RISCVBasicBlock* from,RISCVBasicBlock* to){
    for(auto it=rbegin();it!=rend();++it){
        RISCVMIR* inst=*it;
        RISCVMIR::RISCVISA opcode = inst->GetOpcode();
        if(opcode<RISCVMIR::EndBranch&&opcode>RISCVMIR::BeginBranch){
            bool flag=false;
            for(int i=0;i<inst->GetOperandSize();i++){
                if(inst->GetOperand(i)==from){
                    inst->SetDef(to);
                    flag=true;
                }
            }
            if(flag)return;
        }
    }
    assert(0&&"IMPOSSIBLE");
}

void RISCVBasicBlock::push_before_branch(RISCVMIR* minst) {
    assert(this->Size()!=0 && "Empty BasicBlock"); 
    for(auto it=this->rbegin(); it!=this->rend(); --it) {
        RISCVMIR* inst=*it;
        RISCVMIR::RISCVISA opcode = inst->GetOpcode();
        if(opcode<RISCVMIR::BeginBranch || opcode>RISCVMIR::EndBranch) {
            assert(!(opcode==RISCVMIR::ret)&&"ret"); 
            it.insert_after(minst);
            return;
        } 
    }
    this->push_front(minst);
}

RISCVFunction::RISCVFunction(Value* _func):RISCVGlobalObject(_func->GetType(),_func->GetName()),func(_func){
    frame.reset(new RISCVFrame(this));
}


void RISCVBasicBlock::printfull(){
    NamedMOperand::print();
    std::cout<<":\n";
    for(auto minst:*this)
        minst->printfull();
}

/// @todo the entry bb, or prologue bb will be generated by RISCVFunction after RA, and will be named as entry?
void RISCVFunction::printfull(){
    
    NamedMOperand::print();
    std::cout<<":\n";
    for(auto mbb:*this){
        mbb->printfull();
        // if(mbb!=this->back())
        //     std::cout<<"\n";
    }
}

// RISCVFrame::RISCVFrame() {}
RISCVFrame::RISCVFrame(RISCVFunction* func) : parent(func) {}
StackRegister* RISCVFrame::spill(VirRegister* mop) {
    /// @todo 
    // put the spilled element to the same block in the stack
    // for (auto& obj : frameobjs) {
    //     // if (obj->GetName() == mop->GetName()) {
    //     //     return obj->Get;
    //     // }
    // }
    frameobjs.emplace_back(std::make_unique<RISCVFrameObject>(mop));
    return frameobjs.back().get()->GetStackReg();
}
StackRegister* RISCVFrame::spill(Value* val) {
    frameobjs.emplace_back(std::make_unique<RISCVFrameObject>(val));
    return frameobjs.back().get()->GetStackReg();
}

std::vector<std::unique_ptr<RISCVFrameObject>>& RISCVFrame::GetFrameObjs() {return frameobjs;}

void RISCVFrame::GenerateFrame() {
    /// @todo
    using FramObj = std::vector<std::unique_ptr<RISCVFrameObject>>;
    frame_size = 16;
    std::sort(frameobjs.begin(), frameobjs.end(),
              [](const std::unique_ptr<RISCVFrameObject>& lhs,
                 const std::unique_ptr<RISCVFrameObject>& rhs) {
                    return lhs->GetFrameObjSize() < rhs->GetFrameObjSize();
              });
    for(FramObj::iterator it = frameobjs.begin(); it != frameobjs.end(); it++) {
        std::unique_ptr<RISCVFrameObject>& obj = *it;
        obj->SetEndAddOff(frame_size);
        frame_size += obj->GetFrameObjSize();
        obj->SetBeginAddOff(frame_size);
    }
    frame_size += parent->GetMaxParamSize();
    int mod = frame_size % 16;
    if (mod!=0) {
        frame_size = frame_size + (16 - mod);
    }

    for(FramObj::iterator it = frameobjs.begin(); it != frameobjs.end(); it++) {
        std::unique_ptr<RISCVFrameObject>& obj = *it;
        int off = 0 - static_cast<int>(obj->GetBeginAddOff()+obj->GetFrameObjSize());
        obj->GenerateStackRegister(off);
    }

    // Replace BegAddrRegister to Imm for the LegalConst pass is useful.
    for(auto block: *parent) {
        for(auto inst: *block) {
            if(inst->GetOperandSize()==2) {
                if(BegAddrRegister* breg = dynamic_cast<BegAddrRegister*>(inst->GetOperand(1))) {
                    int bregin_address = static_cast<int>(breg->GetFrameObj()->GetBeginAddOff()); 
                    Imm* imm = new Imm(ConstIRInt::GetNewConstant(0-bregin_address));
                    inst->SetOperand(1,imm);
                }
            }
        }
    }
}

void RISCVFrame::GenerateFrameHead() {
    using PhyReg=PhyRegister::PhyReg;
    using ISA=RISCVMIR::RISCVISA;
    PhyRegister* sp = PhyRegister::GetPhyReg(PhyReg::sp);
    PhyRegister* s0 = PhyRegister::GetPhyReg(PhyReg::s0);
    PhyRegister* ra = PhyRegister::GetPhyReg(PhyReg::ra);
    int temp_frame_size = frame_size;
    if( frame_size>2047) {
        // 以合法方式保存sp.s0
        // temp_frame_size = frame_size % 4096;
        temp_frame_size = frame_size % 2048;
    }
    
    // addi sp, sp, -temp_frame_size
    RISCVMIR* inst1 = new RISCVMIR(ISA::_addi);
    Imm* imm1 = new Imm(ConstIRInt::GetNewConstant(0-temp_frame_size));
    inst1->SetDef(sp);
    inst1->AddOperand(sp);
    inst1->AddOperand(imm1);
    //sd ra, temp_frame_size-8(sp)
    RISCVMIR* inst2 = new RISCVMIR(ISA::_sd);
    StackRegister* sp_stack2 = new StackRegister(PhyReg::sp, temp_frame_size-8);
    inst2->AddOperand(ra);
    inst2->AddOperand(sp_stack2);
    //sd s0, temp_frame_size-16(sp)
    RISCVMIR* inst3 = new RISCVMIR(ISA::_sd);
    StackRegister* sp_stack3 = new StackRegister(PhyReg::sp, temp_frame_size-16);
    inst3->AddOperand(s0);
    inst3->AddOperand(sp_stack3);

    //addi s0, sp, temp_frame_size
    RISCVMIR* inst4 = new RISCVMIR(ISA::_addi);
    Imm* imm4 = new Imm(ConstIRInt::GetNewConstant(temp_frame_size));
    inst4->SetDef(s0);
    inst4->AddOperand(sp);
    inst4->AddOperand(imm4);

    //addi sp, sp, framesize-temp_frame_size
    if(frame_size != temp_frame_size) {
        RISCVMIR* inst5 = new RISCVMIR(ISA::_addi);
        Imm* imm5 = new Imm(ConstIRInt::GetNewConstant(frame_size - temp_frame_size));
        inst5->SetDef(sp);
        inst5->AddOperand(sp);
        inst5->AddOperand(imm5);

        parent->front()->begin().insert_before(inst5);
    }

    parent->front()->begin().insert_before(inst4);
    parent->front()->begin().insert_before(inst3);
    parent->front()->begin().insert_before(inst2);
    parent->front()->begin().insert_before(inst1);
}

void RISCVFrame::GenerateFrameTail() {
    using PhyReg=PhyRegister::PhyReg;
    using ISA=RISCVMIR::RISCVISA;
    PhyRegister* sp = PhyRegister::GetPhyReg(PhyReg::sp);
    PhyRegister* s0 = PhyRegister::GetPhyReg(PhyReg::s0);
    PhyRegister* ra = PhyRegister::GetPhyReg(PhyReg::ra);

    int temp_frame_size = frame_size;
    if( frame_size>2047) {
        // 以合法方式保存sp.s0
        // temp_frame_size = frame_size % 4096;
        temp_frame_size = frame_size % 2048;
    }
    // addi sp, sp, framesize-temp_frame_size
    RISCVMIR* inst0 = new RISCVMIR(ISA::_addi);
    if(temp_frame_size != frame_size) {
        Imm* imm0 = new Imm(ConstIRInt::GetNewConstant(frame_size - temp_frame_size));
        inst0->SetDef(sp);
        inst0->AddOperand(sp);
        inst0->AddOperand(imm0);
    }
    // ld ra, temp_frame_size-8(sp)
    RISCVMIR* inst1 = new RISCVMIR(ISA::_ld);
    StackRegister* sp_stack1 = new StackRegister(PhyReg::sp, temp_frame_size-8);
    inst1->SetDef(ra);
    inst1->AddOperand(sp_stack1);
    // ld s0, temp_frame_size-16(sp)
    RISCVMIR* inst2 = new RISCVMIR(ISA::_ld);
    StackRegister* sp_stack2 = new StackRegister(PhyReg::sp, temp_frame_size-16);
    inst2->SetDef(s0);
    inst2->AddOperand(sp_stack2);
    // addi sp, sp, temp_frame_size
    RISCVMIR* inst3 = new RISCVMIR(ISA::_addi);
    Imm* imm3 = new Imm(ConstIRInt::GetNewConstant(temp_frame_size));
    inst3->SetDef(sp);
    inst3->AddOperand(sp);
    inst3->AddOperand(imm3);

    for(auto block : *parent) {
        for(mylist<RISCVBasicBlock,RISCVMIR>::iterator it=block->begin();it!=block->end();++it) {
            RISCVMIR* inst = *it;
            if (inst->GetOpcode() == ISA::ret) {
                if(temp_frame_size != frame_size) {
                    it.insert_before(inst0);
                }
                it.insert_before(inst1);
                it.insert_before(inst2);
                it.insert_before(inst3);
            }
        } 
    }
}

void RISCVFrame::AddCantBeSpill(RISCVMOperand* reg) {
    auto it=std::find(cantbespill.begin(), cantbespill.end(), reg);
    if(it != cantbespill.end()) {
        return;
    } 
    cantbespill.push_back(reg);
}

bool RISCVFrame::CantBeSpill(RISCVMOperand* reg) {
    auto it=std::find(cantbespill.begin(), cantbespill.end(), reg);
    if(it == cantbespill.end()) {
        return false;
    } else return true;
} 