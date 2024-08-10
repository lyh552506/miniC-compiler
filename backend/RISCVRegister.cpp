#include "../include/backend/RISCVRegister.hpp"
#include "../include/lib/MagicEnum.hpp"
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
VirRegister::VirRegister(RISCVType tp, uint32_t _spill, uint32_t _reload)
    : Register(tp) {
  penalty_spill = _spill;
  penalty_reload = _reload;
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
  assert(0&&"Can not get here");
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
LARegister::LARegister(RISCVType _type, std::string _name, Register *_vreg)
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
    reglist_int.push_back(PhyRegister::GetPhyReg(PhyReg::t2));
    PhyReg regenum = PhyReg::a0;
    auto PushReg_Added = [&](std::vector<PhyRegister*>& list) {
        list.push_back(PhyRegister::GetPhyReg(regenum));
        regenum = PhyReg(regenum + 1);
    };
    while(regenum<=PhyReg::a7) {
      PushReg_Added(reglist_int);
    }
    regenum = PhyReg::t3;
    while(regenum<=PhyReg::t6) {
      PushReg_Added(reglist_int);
    }
    reglist_int.push_back(PhyRegister::GetPhyReg(PhyReg::s1));
    regenum = PhyReg::s2;
    while(regenum<=PhyReg::s11) {
      PushReg_Added(reglist_int);
    }

    // reglist_float
    regenum = PhyReg::ft0;
    while(regenum<=PhyReg::ft7) {
      PushReg_Added(reglist_float);
    }
    regenum = PhyReg::fa0;
    while(regenum<=PhyReg::fa7) {
      PushReg_Added(reglist_float);
    }
    regenum = PhyReg::ft8;
    while(regenum<=PhyReg::ft11) {
      PushReg_Added(reglist_float);
    }
    regenum = PhyReg::fs0;
    while(regenum<=PhyReg::fs1) {
      PushReg_Added(reglist_float);
    }
    regenum = PhyReg::fs2;
    while(regenum<=PhyReg::fs11) {
      PushReg_Added(reglist_float);
    }


    // reglist_test
    regenum = PhyReg::a0;
    while(regenum<=PhyReg::a3) {
      PushReg_Added(reglist_test);
    }

    // reglist_caller
    reglist_caller.push_back(PhyRegister::GetPhyReg(PhyReg::t2));
    regenum = PhyReg::a0;
    while(regenum<=PhyReg::a7) {
      PushReg_Added(reglist_caller);
    }
    regenum = PhyReg::t3;
    while(regenum<=PhyReg::t6) {
      PushReg_Added(reglist_caller);
    }
    regenum = PhyReg::ft0;
    while(regenum <= PhyReg::ft7) {
      PushReg_Added(reglist_caller);
    }
    regenum = PhyReg::fa0;
    while(regenum <= PhyReg::fa7) {
      PushReg_Added(reglist_caller);
    }
    regenum = PhyReg::ft8;
    while(regenum <= PhyReg::ft11) {
      PushReg_Added(reglist_caller);
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