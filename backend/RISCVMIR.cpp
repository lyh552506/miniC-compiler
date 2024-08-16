#include "../include/backend/RISCVMIR.hpp"


RISCVMOperand*& RISCVMIR:: GetDef() {return def;}
RISCVMOperand*& RISCVMIR::GetOperand(int ind){
    // if(def==nullptr)
    //     assert((0<=ind&&ind<operands.size())&&"Range Assertion");
    // else assert((-1<=ind&&ind<operands.size())&&"Range Assertion");

    // if(ind==-1&&def!=nullptr) {
    //     return def;
    // }
    assert((0<=ind&&ind<operands.size())&&"Range Assertion");
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
    if(name=="MarkDead")name="#"+name;
    if (name.find('_') != std::string::npos) name.erase(0,1);
    size_t pos=0;
    while((pos=name.find('_'))!=std::string::npos) name.replace(pos, 1, ".");
    if(name=="ret") {
        this->GetParent()->GetParent()->GetExit()->printfull();
        std::cout<<"\t"<< name <<" \n";
        return;
    }
    std::cout<<"\t"<< name <<" ";
    if (name=="call") {
        operands[0]->print();
        std::cout<<"\n";
    }
    else { 
        if(def!=nullptr) {
            def->print();
            if(operands.size()>0) std::cout << ", ";
        }
        
        for(int i=0;i<operands.size();i++){
            if(i==operands.size()-1&&opcode==RISCVMIR::_amoadd_w_aqrl)
                std::cout<<"(";                
            operands[i]->print();
            if(i==operands.size()-1&&opcode==RISCVMIR::_amoadd_w_aqrl)
                std::cout<<")";                
            if(i!=operands.size()-1)
                std::cout<<", ";
        }
        if(name=="fcvt.w.s") {
            std::cout<<", rtz";
        }
        std::cout <<'\n';
    } 
}

RISCVMIR *RISCVFunction::CreateSpecialUsageMIR(RISCVMOperand *val) {
  VirRegister *vreg = nullptr;
  RISCVMIR *mir = nullptr;
  // 常量
  if (auto imm = val->as<Imm>()) {
    if (imm->GetType() == riscv_float32)
      vreg = new VirRegister(riscv_float32);
    else
      vreg = new VirRegister(imm->GetType(), 0, 2);
    mir = new RISCVMIR(RISCVMIR::LoadImmReg);
  }
  // 局部变量(数组)
  else if (val->as<RISCVFrameObject>()) {
    vreg = new VirRegister(riscv_ptr, 0, 2);
    mir = new RISCVMIR(RISCVMIR::LoadLocalAddr);
  }
  // 全局变量
  else {
    vreg = new VirRegister(riscv_ptr, 0, 2);
    mir = new RISCVMIR(RISCVMIR::LoadGlobalAddr);
  }
  if (vreg->GetType() != riscv_float32)
    specialusage_remapping[vreg] = val;
  // Push into the entry block
  // FIXME: Currently we put it before the copy of the lowering local arguments.
  mir->SetDef(vreg);
  mir->AddOperand(val);

  return mir;
}

Register* RISCVFunction::GetUsedGlobalMapping(RISCVMOperand* val) {
  if (auto imm = val->as<Imm>())
    if (auto immi32 = imm->Getdata()->as<ConstIRInt>())
      if (immi32->GetVal() == 0)
        return PhyRegister::GetPhyReg(PhyRegister::zero);
  if (usedGlobals.find(val) == usedGlobals.end()) {
    auto mir = CreateSpecialUsageMIR(val);
    usedGlobals[val] = mir->GetDef()->as<VirRegister>();
    auto entryblock = front();
    entryblock->push_front(mir);
    }
    return usedGlobals[val];
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

void RISCVFunction::GenerateParamNeedSpill() {
    using ParamPtr=std::unique_ptr<Value>;
    BuildInFunction* buildin;
    if(buildin = dynamic_cast<BuildInFunction*>(func)) {
        param_need_spill = {};
        return;
    }
    int IntMax=8, FloatMax=8;
    Function* func=dynamic_cast<Function*>(this->func);
    std::vector<ParamPtr>& params = func->GetParams();
    int index =0;
    for(auto &i : params) {
        if(i->GetType()==FloatType::NewFloatTypeGet()) {
            if(FloatMax) {
                FloatMax--;
            }
            else {
                this->param_need_spill.push_back(index);
            }
        }
        // int & ptr type
        else {
            if(IntMax) {
                IntMax--;
            }
            else {
                this->param_need_spill.push_back(index);
            }
        }
        index++;
    }
}

std::vector<int>& RISCVFunction::GetParamNeedSpill() {return this->param_need_spill;}

// std::vector<std::unique_ptr<RISCVFrameObject>>& RISCVFunction::GetFrameObjects(){
//     return frame;
// }
void Terminator::RotateCondition(){
    assert(RISCVMIR::BeginBranch<branchinst->GetOpcode()&&branchinst->GetOpcode()<RISCVMIR::EndBranch&&branchinst->GetOpcode()!=RISCVMIR::_j&&"Bro is definitely mad");
    branchinst->SetMopcode(static_cast<RISCVMIR::RISCVISA>(branchinst->GetOpcode()^1));
    branchinst->SetOperand(2,falseblock);
    auto it=mylist<RISCVBasicBlock,RISCVMIR>::iterator(branchinst);
    ++it;
    assert(it!=branchinst->GetParent()->end());
    auto nxt_inst=*it;
    assert(nxt_inst->GetOpcode()==RISCVMIR::_j);
    nxt_inst->SetOperand(0,trueblock);
    std::swap(trueblock,falseblock);
}

void Terminator::makeFallthrough(RISCVBasicBlock* _candidate){
    if(trueblock==_candidate||falseblock==_candidate){
        if(!isUncond())
            if(trueblock==_candidate)
                RotateCondition();
        implictly=true;
        auto j=branchinst->GetParent()->back();
        delete j;
    }
}

RISCVBasicBlock::RISCVBasicBlock(std::string _name):NamedMOperand(_name,RISCVType::riscv_none){}

RISCVBasicBlock* RISCVBasicBlock::CreateRISCVBasicBlock(){
    static int cnt=0;
    return new RISCVBasicBlock(".LBB"+std::to_string(cnt++));
}

void RISCVBasicBlock::replace_succ(RISCVBasicBlock* from,RISCVBasicBlock* to){
    for(auto it=rbegin();it!=rend();--it){
        RISCVMIR* inst=*it;
        RISCVMIR::RISCVISA opcode = inst->GetOpcode();
        if(opcode<RISCVMIR::EndBranch&&opcode>RISCVMIR::BeginBranch){
            bool flag=false;
            for(int i=0;i<inst->GetOperandSize();i++){
                if(inst->GetOperand(i)==from){
                    inst->SetOperand(i, to);
                    flag=true;
                }
            }
            if(flag)return;
        }
    }
    assert(0&&"IMPOSSIBLE");
}

Terminator& RISCVBasicBlock::getTerminator() {
    if(term.implictly==true)return term;
    auto inst_size=Size();
    assert(inst_size>0&&"Bro is definitely mad");
    for(auto it=rbegin();it!=rend();--it){
      auto minst=*it;
      if(minst->GetOpcode()==RISCVMIR::ret){
        term.branchinst=nullptr;
        break;
      }
      if(RISCVMIR::BeginBranch<minst->GetOpcode()&&minst->GetOpcode()<RISCVMIR::EndBranch){
        if(minst->GetOpcode()==RISCVMIR::_j){
          term.branchinst=minst;
          term.trueblock=minst->GetOperand(0)->as<RISCVBasicBlock>();
        }
        else{
          term.branchinst=minst;
          term.falseblock=minst->GetOperand(2)->as<RISCVBasicBlock>();
          std::swap(term.trueblock,term.falseblock);
          break;
        }
      }
    }
    if(term.isUncond())term.SetProb(1);
    return term;
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

RISCVFunction::RISCVFunction(Value* _func):RISCVGlobalObject(_func->GetType(),_func->GetName()),func(_func), exit(".LBBexit"){
    frame.reset(new RISCVFrame(this));
    GenerateParamNeedSpill();
    exit.SetParent(this);
}


void RISCVBasicBlock::printfull(){
    if(this->GetName()==".LBBexit") {}
    else {
        NamedMOperand::print();
        std::cout<<":\n";
    }
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

uint64_t RISCVFunction::GetUsedPhyRegMask(){
    uint64_t flag=0u;
    for(auto bb:*this){
        for(auto inst:*bb){
            if(auto temp=inst->GetDef()){
                if(temp!=nullptr){
                    auto def=temp->as<PhyRegister>();
                    if(def!=nullptr)
                        flag|=PhyRegMask::GetPhyRegMask(def);
                }
            }
            for(int i=0;i<inst->GetOperandSize();i++){
                PhyRegister* reg=nullptr;
                if(auto sR=inst->GetOperand(i)->as<StackRegister>())
                    reg=sR->GetReg()->as<PhyRegister>();
                else
                    reg=inst->GetOperand(i)->as<PhyRegister>();
                if(reg!=nullptr)
                    flag|=PhyRegMask::GetPhyRegMask(reg);
            }
        }
    }
    return flag;
}

// RISCVFrame::RISCVFrame() {}
RISCVFrame::RISCVFrame(RISCVFunction* func) : parent(func) {}
StackRegister* RISCVFrame::spill(VirRegister* mop) {
    if(spillmap.find(mop)==spillmap.end()){
        frameobjs.emplace_back(std::make_unique<RISCVFrameObject>(mop));
        spillmap[mop]=frameobjs.back().get()->GetStackReg();
    }
    return spillmap[mop];
}
// StackRegister* RISCVFrame::spill(VirRegister* mop, StackRegister* sreg) {
    
//     if(spillmap.find(mop)==spillmap.end()){
//         frameobjs.emplace_back(std::make_unique<RISCVFrameObject>(mop));
//         spillmap[mop]=frameobjs.back().get()->GetStackReg();
//     }
//     return spillmap[mop];
// }

RISCVMIR* RISCVFrame::spill(PhyRegister* mop) {
    int type = mop->Getregenum();
    frameobjs.emplace_back(std::make_unique<RISCVFrameObject>(mop));
    StackRegister* sreg = frameobjs.back().get()->GetStackReg();
    RISCVMIR* store;
    if(type>=PhyRegister::begin_normal_reg && type<=PhyRegister::end_normal_reg) {
        store = new RISCVMIR(RISCVMIR::_sd);
    }
    else if(type>=PhyRegister::begin_float_reg && type<=PhyRegister::end_float_reg) {
        store = new RISCVMIR(RISCVMIR::_fsd);
    }
    else assert(0&&"wrong phyregister type");
    store->AddOperand(mop);
    store->AddOperand(sreg);
    return store;
}

RISCVMIR* RISCVFrame::load_to_preg(StackRegister* sreg,PhyRegister* mop) {
    int type = mop->Getregenum();
    RISCVMIR* load;
    if(type>=PhyRegister::begin_normal_reg && type<=PhyRegister::end_normal_reg) {
        load = new RISCVMIR(RISCVMIR::_ld);
    }
    else if(type>=PhyRegister::begin_float_reg && type<=PhyRegister::end_float_reg) {
        load = new RISCVMIR(RISCVMIR::_fld);
    }
    else assert(0&&"wrong phyregister type");
    load->SetDef(mop);
    load->AddOperand(sreg);
    return load;
}

// StackRegister* RISCVFrame::spill(Value* val) {
//     frameobjs.emplace_back(std::make_unique<RISCVFrameObject>(val));
//     return frameobjs.back().get()->GetStackReg();
// }

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
        int a =0;
    }
    frame_size += parent->GetMaxParamSize();
    int mod = frame_size % 16;
    if (mod!=0) {
        frame_size = frame_size + (16 - mod);
    }

    for(FramObj::iterator it = frameobjs.begin(); it != frameobjs.end(); it++) {
        std::unique_ptr<RISCVFrameObject>& obj = *it;
        // int off = 0 - (int)(obj->GetBeginAddOff()+obj->GetFrameObjSize());
        int off = 0 - (int)(obj->GetBeginAddOff());
        obj->GenerateStackRegister(off);
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
        Imm* imm5 = new Imm(ConstIRInt::GetNewConstant(temp_frame_size - frame_size));
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
    RISCVFunction* func = parent;
    auto exit_bb=func->GetExit();
    // for(auto block : *parent) {
        // for(mylist<RISCVBasicBlock,RISCVMIR>::iterator it=block->begin();it!=block->end();++it) {
            // RISCVMIR* inst = *it;
            // if (inst->GetOpcode() == ISA::ret) {
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
                
                if(temp_frame_size != frame_size) {
                    // it.insert_before(inst0);
                    exit_bb->push_back(inst0);
                }
                exit_bb->push_back(inst1);
                exit_bb->push_back(inst2);
                exit_bb->push_back(inst3);
                // it.insert_before(inst1);
                // it.insert_before(inst2);
                // it.insert_before(inst3);
            // }
        // } 
    // }
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