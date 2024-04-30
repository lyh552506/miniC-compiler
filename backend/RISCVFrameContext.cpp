#include "RISCVFrameContext.hpp"
std::string& NamedMOperand::GetName() {return name;}
NamedMOperand::NamedMOperand(std::string _name,RISCVType _tp):RISCVMOperand(_tp),name(_name){}

void NamedMOperand::print(){
    std::cout<<name;
}

RISCVObject::RISCVObject(Type* _tp,std::string _name):NamedMOperand(_name,riscv_ptr),tp(_tp){}

RISCVFrameObject::RISCVFrameObject(Type* _tp,std::string _name):RISCVObject(_tp,_name){
    local=true;
}

void RISCVFrameObject::print(){
    std::cout<<"---";
    tp->print();
    std::cout<<"FrameObject:";
    NamedMOperand::print();
    std::cout<<"---";
}

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