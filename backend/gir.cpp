#include "gir.hpp"

LiInst::LiInst(Operand _A):User(_A->GetType()) {
    add_use(_A);
}
void LiInst::print() {
    std::cout << "    li " << this->GetDef()->GetName() << " ";
    std::cout << (this->Getuselist())[0]->GetValue()->GetName() << std::endl;
}

XorInst::XorInst(Operand _A, std::string opcode, Operand _B) {
    this->SetName(opcode);
    add_use(_A);
    add_use(_B);
}
void XorInst::print() {
    std::cout << "    " << this->GetName()  << " ";
    std::cout << this->GetDef()->GetName() << " ";
    std::cout << (this->Getuselist())[0]->GetValue()->GetName() << " ";
    std::cout << (this->Getuselist())[1]->GetValue()->GetName() << std::endl;
}

