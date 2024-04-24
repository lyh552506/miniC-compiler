#include "RISCVRegister.hpp"
#include "MagicEnum.hpp"

PhyRegister::PhyRegister(PhyReg _regenum):Register(RISCVType::riscv_none),regenum(_regenum){}

VirRegister::VirRegister(RISCVType tp):Register(tp){
    static int cnt=0;
    counter=cnt++;
}

void PhyRegister::print(){
    std::cout<<"$"<<magic_enum::enum_name(regenum);
}

void VirRegister::print(){
    std::cout<<"%"<<counter;
}