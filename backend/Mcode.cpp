#include "Mcode.hpp"

// MachineBinaryInst::MachineBinaryInst(Binary_Inst opcode, Operand rd, Operand rs1, Operand rs2) 
//     : opcode(opcode), rd(rd), rs1(rs1), rs2(rs2) {
//         add_use(rd);
//         add_use(rs1);
//         add_use(rs2);
//     }

MachineBinaryInst::MachineBinaryInst(std::string oprator, Operand rd, Operand rs1, Operand rs2)
    : oprator(oprator), rd(rd), rs1(rs1), rs2(rs2) {
        add_use(rd);
        add_use(rs1);
        add_use(rs2);
    }


// void MachineBinaryInst::printmachineinst(std::ofstream &outputFile) {
//     // outputFile << magic_enum::enum_name(opcode) << " ";
//     // outputFile << this << std::endl;
//     //outputFile << rd->GetName() << ", " << rs1->GetName() << ", " << rs2->GetName() << std::endl;
//     std::cout << magic_enum::enum_name(opcode) << " ";
//     std::cout << rd->GetName() << ", " << rs1->GetName() << ", " << rs2->GetName() << std::endl;
// }
 
void MachineBinaryInst::printinst() {
    //std::cout << magic_enum::enum_name(opcode) << " ";
    std::cout << oprator << " ";
    std::cout << rd->GetName() << ", " << rs1->GetName() << ", " << rs2->GetName() << std::endl;
}
