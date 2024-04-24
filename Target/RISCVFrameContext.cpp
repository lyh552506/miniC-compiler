#include "RISCVFrameContext.hpp"

NamedMOperand::NamedMOperand(std::string _name):RISCVMOperand(),name(_name){}

void NamedMOperand::print(){
    std::cout<<name;
}

RISCVObject::RISCVObject(Type* _tp,std::string _name):NamedMOperand(_name),tp(_tp){}

RISCVFrameObject::RISCVFrameObject(Type* _tp,std::string _name):RISCVObject(_tp,_name){
    local=true;
}

void RISCVFrameObject::print(){
    std::cout<<"---";
    tp->print();
    std::cout<<"FrameObject:";
    NamedMOperand::print();
    std::cout<<"---\n";
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