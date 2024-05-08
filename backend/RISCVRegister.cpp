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

void PhyRegister::print() { std::cout << magic_enum::enum_name(regenum); }

std::string PhyRegister::GetName() {
  auto x= magic_enum::enum_name(regenum);
  std::string str(x);
  return str;
}

std::string VirRegister::GetName() {
  std::ostringstream oss;
  oss << "%" << counter;
  std::string str= oss.str();
  return str;
}

void VirRegister::print() { std::cout << "%" << counter; }

LARegister::LARegister(RISCVType _type, std::string _name)
    : Register(_type,_name), regnum(LAReg::hi) {}
LARegister::LARegister(RISCVType _type, std::string _name, VirRegister *_vreg)
    : Register(_type,_name), regnum(LAReg::lo), vreg(_vreg) {}

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

StackRegister::StackRegister(PhyReg _regnum, int _offset)
    : PhyRegister(_regnum), offset(_offset) {}
void StackRegister::print() {
  std::cout << offset << "(" << magic_enum::enum_name(regenum) << ")";
}
