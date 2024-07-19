#include "../include/backend/RISCVMOperand.hpp"
#include "../include/backend/RISCVFrameContext.hpp"
#include "../include/backend/RISCVMIR.hpp"
#include "../include/backend/RISCVRegister.hpp"
#include <map>
// bool RISCVMOperand::isReg(){
//     return false;
// }

// RISCVType RISCVMOperand::GetType(){
//     return tp;
// }

// RISCVMOperand::RISCVMOperand(){}

// bool RISCVMOperand::ignoreLA() {
//   if (dynamic_cast<Imm *>(this))
//     return true;
//     // reutrn nullptr;
//   else if (PhyRegister *preg = dynamic_cast<PhyRegister *>(this)) {
//     PhyRegister::PhyReg regenum = preg->Getregenum();
//     using PhyReg = PhyRegister::PhyReg;
//     if (regenum == PhyReg::zero || regenum == PhyReg::ra ||
//         regenum == PhyReg::sp || regenum == PhyReg::gp ||
//         regenum == PhyReg::tp || regenum == PhyReg::s0)
//       return true;
//     else
//       return false;
//   } else if (LARegister *lareg = dynamic_cast<LARegister *>(this))
//     return true;
//   else if (StackRegister *sreg = dynamic_cast<StackRegister *>(this))
//     return true;
//   else if (dynamic_cast<RISCVFrameObject *>(this))
//     return true;
//   else if(dynamic_cast<RISCVBasicBlock*>(this))
//     return true;
//   else if(dynamic_cast<RISCVGlobalObject*>(this))
//     return true;
//   else
//     return false;
// }

Register* RISCVMOperand::ignoreLA() {
  if (dynamic_cast<Imm *>(this))
    return nullptr;
  else if (PhyRegister *preg = dynamic_cast<PhyRegister *>(this)) {
    PhyRegister::PhyReg regenum = preg->Getregenum();
    using PhyReg = PhyRegister::PhyReg;
    if (regenum == PhyReg::zero || regenum == PhyReg::ra ||
        regenum == PhyReg::sp || regenum == PhyReg::gp ||
        regenum == PhyReg::tp || regenum == PhyReg::s0 ||
        regenum == PhyReg::_NULL)
      return nullptr;
    else
      return preg;
  } else if (LARegister *lareg = dynamic_cast<LARegister *>(this)) {
    return lareg->GetVreg();
  }
  else if (StackRegister *sreg = dynamic_cast<StackRegister *>(this)) {
    return sreg->GetVreg();
  }
  else if (dynamic_cast<RISCVFrameObject *>(this))
    return nullptr;
  else if(dynamic_cast<RISCVBasicBlock*>(this))
    return nullptr;
  else if(dynamic_cast<RISCVMIR*>(this))
    return nullptr;
  else if(dynamic_cast<RISCVGlobalObject*>(this))
    return nullptr;
  else if(auto reg = dynamic_cast<Register*>(this))
    return reg;
  else 
    return nullptr;
}
Imm::Imm(ConstantData *_data)
    : RISCVMOperand(RISCVTyper(_data->GetType())), data(_data) {
} // RISCVTyper(_data->GetType())),data(_data
ConstantData *Imm::Getdata() { return data; }
Imm *Imm::GetImm(ConstantData *_data) {
  using Manager = std::unique_ptr<Imm>;
  static std::map<ConstantData *, Manager> mapping;
  if (mapping.find(_data) == mapping.end())
    mapping[_data] = std::make_unique<Imm>(_data);
  return mapping[_data].get();
}

void Imm::print() {
  // data->GetType()->print();
  // std::cout<<" ";
  data->print();
}