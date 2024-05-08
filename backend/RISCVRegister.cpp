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
        std::cout << ")";
        // std::cout << ")" << std::endl;
    }
}

StackRegister::StackRegister(PhyReg _regnum, int _offset)
    :PhyRegister(_regnum),offset(_offset){}
void StackRegister::print(){
    std::cout << offset <<"(" << magic_enum::enum_name(regenum) <<")";
}

RegisterList::RegisterList() {
    using PhyReg=PhyRegister::PhyReg;
    // reglist_param_int
    PhyReg regenum = PhyReg::a0;
    while(regenum<=PhyReg::a7) {
        PhyRegister* preg = PhyRegister::GetPhyReg(regenum);
        reglist_param_int.push_back(preg);
        regenum = PhyReg(regenum + 1);
    }
    // reglist_temp_int
    regenum = PhyReg::t0;
    while(regenum<=PhyReg::t2) {
        PhyRegister* preg = PhyRegister::GetPhyReg(regenum);
        reglist_temp_int.push_back(preg);
        regenum = PhyReg(regenum + 1);
    }
    regenum = PhyReg::t3;
    while(regenum<=PhyReg::t6) {
        PhyRegister* preg = PhyRegister::GetPhyReg(regenum);
        reglist_temp_int.push_back(preg);
        regenum = PhyReg(regenum + 1);
    }
    // reglist_param_float
    regenum = PhyReg::fa0;
    while(regenum<=PhyReg::fa7) {
        PhyRegister* preg = PhyRegister::GetPhyReg(regenum);
        reglist_param_float.push_back(preg);
        regenum = PhyReg(regenum + 1);
    }
    // reglist_temp_float
    regenum = PhyReg::ft0;
    while(regenum<=PhyReg::ft7) {
        PhyRegister* preg = PhyRegister::GetPhyReg(regenum);
        reglist_temp_float.push_back(preg);
        regenum = PhyReg(regenum + 1);
    }
    regenum = PhyReg::ft8;
    while(regenum<=PhyReg::ft11) {
        PhyRegister* preg = PhyRegister::GetPhyReg(regenum);
        reglist_temp_float.push_back(preg);
        regenum = PhyReg(regenum + 1);
    }

}

RegisterList& RegisterList::GetPhyRegList() {
    static RegisterList reglist;
    return reglist;
}
std::vector<PhyRegister*>& RegisterList::GetReglistParamInt() {return reglist_param_int;}
std::vector<PhyRegister*>& RegisterList::GetReglistTempInt() {return reglist_temp_int;}
std::vector<PhyRegister*>& RegisterList::GetReglistParamFloat() {return reglist_param_float;}
std::vector<PhyRegister*>& RegisterList::GetReglistTempFloat() {return reglist_temp_float;}
