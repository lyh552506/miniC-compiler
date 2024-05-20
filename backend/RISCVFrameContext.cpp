#include "RISCVFrameContext.hpp"
std::string& NamedMOperand::GetName() {return name;}
NamedMOperand::NamedMOperand(std::string _name,RISCVType _tp):RISCVMOperand(_tp),name(_name){}

void NamedMOperand::print(){
    std::cout<<name;
}

RISCVObject::RISCVObject(Type* _tp,std::string _name):NamedMOperand(_name,riscv_ptr),tp(_tp){}
RISCVObject::RISCVObject(std::string _name):NamedMOperand(_name,riscv_ptr) {}
RISCVGlobalObject::RISCVGlobalObject(Type* _tp,std::string _name):RISCVObject(_tp,_name){
    local=false;
}
void RISCVGlobalObject::print(){
    std::cout<<"***";
    tp->print();
    std::cout<<"GlobalObject:";
    NamedMOperand::print();
    std::cout<<"***\n";
}

RISCVTempFloatObject::RISCVTempFloatObject(std::string _name):RISCVObject(FloatType::NewFloatTypeGet(), _name){
    local=true;
}
void RISCVTempFloatObject::print() {}

// RISCVFrameObject::RISCVFrameObject(Type* _tp,std::string _name):RISCVObject(_tp,_name){
//     local=true;
// }

RISCVFrameObject::RISCVFrameObject(Value* val) : RISCVMOperand(RISCVTyper(val->GetType())) {
    name = val->GetName();
    reg = new StackRegister(PhyRegister::PhyReg::s0, begin_addr_offsets);
    if (PointerType* pointtype = dynamic_cast<PointerType*>(val->GetType())) {
        size=pointtype->GetSubType()->get_size();
    }
    // will we meet arraytype here?
    else if (ArrayType* arrtype = dynamic_cast<ArrayType*>(val->GetType())) {
        size=arrtype->get_size();
    }
    else size=val->GetType()->get_size();
}
RISCVFrameObject::RISCVFrameObject(VirRegister* val) : RISCVMOperand(val->GetType()) {
    reg = new StackRegister(PhyRegister::PhyReg::s0, begin_addr_offsets);
    name = val->GetName();
    size = 8;
}

void RISCVFrameObject::GenerateStackRegister(int offset) {
    /// @todo
    reg->SetOffset(offset);
}
size_t RISCVFrameObject::GetFrameObjSize() {return size;}
size_t RISCVFrameObject::GetBeginAddOff() {return begin_addr_offsets;}
void RISCVFrameObject::SetBeginAddOff(size_t add) {begin_addr_offsets = add;}
StackRegister*& RISCVFrameObject::GetStackReg() {return reg;}
void RISCVFrameObject::print(){
    // std::cout<<"---";
    // std::cout<<"FrameObject";
    // std::cout<<"---";
    reg->print();
}

BegAddrRegister::BegAddrRegister(RISCVFrameObject* _frameobj)
    : Register(riscv_i32), frameobj(_frameobj) {}
void BegAddrRegister::print() {
  std::cout << frameobj->GetBeginAddOff();
}