#include "RISCVRegister.hpp"
#include "MagicEnum.hpp"

bool Register::ignoreLA() {
    if(PhyRegister* preg = dynamic_cast<PhyRegister*>(this)) {
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
        std::cout << ")";
        // std::cout << ")" << std::endl;
    }
}

StackRegister::StackRegister(PhyReg _regnum, int _offset)
    :PhyRegister(_regnum),offset(_offset){}
void StackRegister::print(){
    std::cout << offset <<"(" << magic_enum::enum_name(regenum) <<")";
}

