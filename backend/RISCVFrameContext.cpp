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
    size=val->GetType()->get_size();
}
RISCVFrameObject::RISCVFrameObject(VirRegister* val) : RISCVMOperand(val->GetType()) {
    size = 8;
}

void RISCVFrameObject::GenerateStackRegister() {
    /// @todo
}

void RISCVFrameObject::print(){
    std::cout<<"---";
    std::cout<<"FrameObject";
    std::cout<<"---";
}

// RISCVFrame::RISCVFrame() {}
RISCVFrame::RISCVFrame(RISCVFunction* func) : parent(func) {}
void RISCVFrame::spill(VirRegister* mop) {
    frameobjs.emplace_back(std::make_unique<RISCVFrameObject>(mop));
}
void RISCVFrame::spill(Value* val) {
    frameobjs.emplace_back(std::make_unique<RISCVFrameObject>(val));
}

std::vector<std::unique_ptr<RISCVFrameObject>>& RISCVFrame::GetFrameObjs() {return frameobjs;}

void RISCVFrame::GenerateFrame() {
    /// @todo
}