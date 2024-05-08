#include "RISCVMOperand.hpp"
#include "RISCVRegister.hpp"
#include <map>
// bool RISCVMOperand::isReg(){
//     return false;
// }

// RISCVType RISCVMOperand::GetType(){
//     return tp;
// }

// RISCVMOperand::RISCVMOperand(){}

bool RISCVMOperand::ignoreLA() {
    if(dynamic_cast<Imm*>(this))
        return true;
    else if(PhyRegister* preg = dynamic_cast<PhyRegister*>(this)) {
        PhyRegister::PhyReg regenum = preg->Getregenum();
        using PhyReg=PhyRegister::PhyReg;
        if(regenum==PhyReg::zero || regenum==PhyReg::ra\
        || regenum==PhyReg::sp || regenum==PhyReg::gp\
        || regenum==PhyReg::tp || regenum==PhyReg::s0)
        return 1;
    }
    else if (LARegister* lareg = dynamic_cast<LARegister*>(this)) 
        return 1;
    else if (StackRegister* sreg = dynamic_cast<StackRegister*>(this)) 
        return 1;
    else return 0;
}
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