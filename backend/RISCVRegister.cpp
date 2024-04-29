#include "RISCVRegister.hpp"
#include "MagicEnum.hpp"

PhyRegister::PhyRegister(PhyReg _regenum):Register(RISCVType::riscv_none),regenum(_regenum){}

PhyRegister* PhyRegister::GetPhyReg(PhyReg _regnum) {
    static std::unordered_map<PhyReg, PhyRegister*> registry;
    auto it=registry.find(_regnum);
    if (it == registry.end())
        it=registry.emplace(_regnum, new PhyRegister(_regnum)).first;
    return it->second;
}

VirRegister::VirRegister(RISCVType tp):Register(tp){
    static int cnt=0;
    counter=cnt++;
}

void PhyRegister::print(){
    std::cout<<magic_enum::enum_name(regenum);
}

void VirRegister::print(){
    std::cout<<"%"<<counter;
}

LARegister::LARegister(RISCVType _type, std::string _name)
    :Register(_type),name(_name),regnum(LAReg::hi){}
LARegister::LARegister(RISCVType _type, std::string _name, VirRegister* _vreg)
    :Register(_type),name(_name),regnum(LAReg::lo),vreg(_vreg){}

void LARegister::print(){
    //todo
    std::cout<<"%"<< magic_enum::enum_name(regnum);
    std::cout<<"("<< name << ")";
    if(vreg!=nullptr) {
        std::cout << "(";
        vreg->print();
        std::cout << ")" << std::endl;
    }
}

