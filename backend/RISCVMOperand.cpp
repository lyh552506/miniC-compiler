#include "RISCVMOperand.hpp"
#include <map>
// bool RISCVMOperand::isReg(){
//     return false;
// }

// RISCVType RISCVMOperand::GetType(){
//     return tp;
// }

// RISCVMOperand::RISCVMOperand(){}

Imm::Imm(ConstantData* _data):RISCVMOperand(RISCVTyper(_data->GetType())), data(_data){} //RISCVTyper(_data->GetType())),data(_data
ConstantData* Imm::Getdata() {return data;}
Imm* Imm::GetImm(ConstantData* _data){
    using Manager=std::unique_ptr<Imm>;
    static std::map<ConstantData*,Manager> mapping;
    if(mapping.find(_data)==mapping.end())
        mapping[_data]=std::make_unique<Imm>(_data);
    return mapping[_data].get();
}

void Imm::print(){
    // data->GetType()->print();
    // std::cout<<" ";
    data->print();
}