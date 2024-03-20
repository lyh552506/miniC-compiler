#include "gir.hpp"

LiInst::LiInst(Operand _A):User(_A->GetType()) {
    add_use(_A);
}

XorInst::XorInst(Operand _A, std::string opcode, Operand _B) {
    this->SetOpcode(opcode);
    add_use(_A);
    add_use(_B);
}
std::string XorInst::GetOpcode() {
    return this->opcode;
}
void XorInst::SetOpcode(std::string opcode) {
    this->opcode =opcode;
}

