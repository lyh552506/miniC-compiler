#include "RISCVRegister.hpp"
#include "MagicEnum.hpp"
#include <sstream>
#include <string>

PhyRegister::PhyRegister(PhyReg _regenum)
    : Register(RISCVType::riscv_none, magic_enum::enum_name(_regenum)),
      regenum(_regenum) {}

PhyRegister *PhyRegister::GetPhyReg(PhyReg _regnum) {
  static std::unordered_map<PhyReg, PhyRegister *> registry;
  auto it = registry.find(_regnum);
  if (it == registry.end())
    it = registry.emplace(_regnum, new PhyRegister(_regnum)).first;
  return it->second;
}
VirRegister::VirRegister(RISCVType tp) : Register(tp) {
  static int cnt = 0;
  counter = cnt++;
  //set name
  std::ostringstream oss;
  oss << "%" << counter;
  rname= oss.str();
}

PhyRegister* PhyRegMask::GetPhyReg(uint64_t flag){
  for(uint8_t i=0u;i<64u;i++){
    if(flag==(((uint64_t)1)<<i)){
      auto regenum = PhyRegister::PhyReg(i);
      return PhyRegister::GetPhyReg(regenum);
    }
  }
  assert("Can not get here");
}

uint64_t PhyRegMask::GetPhyRegMask(PhyRegister* reg) {
  return ((uint64_t)1) << static_cast<uint64_t>(reg->Getregenum());
}

bool PhyRegMask::isCallerSaved(uint64_t flag) {
  auto reg = GetPhyReg(flag);
  return reg->isCallerSaved();
}

bool PhyRegMask::isCalleeSaved(uint64_t flag) {
  auto reg = GetPhyReg(flag);
  return reg->isCalleeSaved();
}

void PhyRegMask::visit(uint64_t flag, std::function<void(uint64_t)> func) {
  for(uint8_t i=0u;i<64u;i++){
    if(flag&(((uint64_t)1)<<i)){
      func((uint64_t)1<<i);
      return;
    }
  }
}

void PhyRegister::print() { std::cout << magic_enum::enum_name(regenum); }

std::string PhyRegister::GetName() {
  auto x= magic_enum::enum_name(regenum);
  std::string str(x);
  return str;
}
std::string VirRegister::GetName() {
    return "."+std::to_string(counter);
}
void VirRegister::print(){
    std::cout<<"%"<<counter;
}
// std::string VirRegister::GetName() {
//   std::ostringstream oss;
//   oss << "%" << counter;
//   std::string str= oss.str();
//   return str;
// }

LARegister::LARegister(RISCVType _type, std::string _name)
    : Register(_type,_name), regnum(LAReg::hi) {}
LARegister::LARegister(RISCVType _type, std::string _name, LAReg _regenum)
    : Register(_type,_name), regnum(_regenum) {}
LARegister::LARegister(RISCVType _type, std::string _name, VirRegister *_vreg)
    : Register(_type,_name), regnum(LAReg::lo), vreg(_vreg) {}

Register*& LARegister::GetVreg() { return vreg; }
void LARegister::SetReg(PhyRegister* &_reg) { vreg = _reg; }
void LARegister::print() {
  // todo
  std::cout << "%" << magic_enum::enum_name(regnum);
  std::cout << "(" << rname << ")";
  if (vreg != nullptr) {
    std::cout << "(";
    vreg->print();
    std::cout << ")";
    // std::cout << ")" << std::endl;
  }
}

RegisterList::RegisterList() {
    using PhyReg=PhyRegister::PhyReg;
    // reglist_int
    // t0 & t1 will not be regalloced, and it is real temp register
    PhyReg regenum = PhyReg::t2;
    while(regenum<=PhyReg::t6) {
        PhyRegister* preg = PhyRegister::GetPhyReg(regenum);
        reglist_int.push_back(preg);
        regenum = PhyReg(regenum + 1);
    }

    // reglist_float
    regenum = PhyReg::ft0;
    while(regenum<=PhyReg::ft11) {
        PhyRegister* preg = PhyRegister::GetPhyReg(regenum);
        reglist_float.push_back(preg);
        regenum = PhyReg(regenum + 1);
    }

    // reglist_test
    regenum = PhyReg::a0;
    while(regenum<=PhyReg::a3) {
      PhyRegister* preg = PhyRegister::GetPhyReg(regenum);
      reglist_test.push_back(preg);
      regenum = PhyReg(regenum + 1);
    }

    // reglist_caller
    // regenum = PhyReg::t0;
    // while(regenum<=PhyReg::t2) {
    //   PhyRegister* preg = PhyRegister::GetPhyReg(regenum);
    //   reglist_caller.push_back(preg);
    //   regenum = PhyReg(regenum + 1);
    // }
    PhyRegister* preg = PhyRegister::GetPhyReg(PhyReg::t2);
    reglist_caller.push_back(preg);
    regenum = PhyReg::a0;
    while(regenum<=PhyReg::a7) {
      PhyRegister* preg = PhyRegister::GetPhyReg(regenum);
      reglist_caller.push_back(preg);
      regenum = PhyReg(regenum + 1);
    }
    regenum = PhyReg::t3;
    while(regenum<=PhyReg::t6) {
      PhyRegister* preg = PhyRegister::GetPhyReg(regenum);
      reglist_caller.push_back(preg);
      regenum = PhyReg(regenum + 1);
    }
}

RegisterList& RegisterList::GetPhyRegList() {
    static RegisterList reglist;
    return reglist;
}
std::vector<PhyRegister*>& RegisterList::GetReglistInt() {return reglist_int;}
std::vector<PhyRegister*>& RegisterList::GetReglistFloat() {return reglist_float;}
std::vector<PhyRegister*>& RegisterList::GetReglistTest() {return reglist_test;}
std::vector<PhyRegister*>& RegisterList::GetReglistCaller() {return reglist_caller;}