// #include<string>
// #include<iostream>
// #include<fstream>
// #include"MachineCode.hpp"
// #include"../lib/MagicEnum.hpp"

// int offset;
// int row = 1;
// int mark;
// //MachineOperand
// MachineOperand::MachineOperand() {
//     this->type =-1;
//     this->val = -1;
//     this->regnum = Register::a0;
// }

// MachineOperand::MachineOperand(int type, int val) {
//     this->type = type;
//     this->val = val;
//     this->regnum = Register::a0;
// }

// bool MachineOperand::operator==(const MachineOperand& other) const {
//     if(this->type == other.type && this->val == other.val)
//         return true;
//     else
//         return false;
// }

// bool MachineOperand::operator<(const MachineOperand& other) const {
//     if(this->type == other.type && this->val < other.val)
//         return true;
//     else
//         return false;
// }

// bool MachineOperand::isReg() {
//     if(this->type == REG)
//         return true;
//     else
//         return false;
// }

// bool MachineOperand::isImm() {
//     if(this->type == IMM)
//         return true;
//     else
//         return false;
// }

// // bool MachineOperand::isMem() {
// //     if(this->type == MEM)
// //         return true;
// //     else
// //         return false;
// // }

// bool MachineOperand::isLabel() {
//     if(this->type == LABEL)
//         return true;
//     else
//         return false;
// }

// // MachineInst *MachineOperand::getParent() {
// //     return this->parent;
// // }

// int MachineOperand::getType() {
//     return this->type;
// }

// int MachineOperand::getVal() {
//     return this->val;
// }

// int MachineOperand::getRegnum() {
//     return this->regnum;
// }

// auto MachineOperand::getRegName() {
//     return magic_enum::enum_name (this->regnum);
// }

// std::string MachineOperand::getlable() {
//     return this->lable;
// }

// // void MachineOperand::setParent(MachineInst *parent) {
// //     this->parent = parent;
// // }

// void MachineOperand::setReg(Register regnum) {
//     if(this->type != REG)
//         this->type = REG;
//     this->regnum = regnum;
// }

// //MachineInst
// // void MachineInst::setParent(MachineBlock *parent) {
// //     this->parent = parent;
// // }

// int MachineInst::getType() {
//     return this->type;
// }

// //MachineBinaryInst
// MachineBinaryInst::MachineBinaryInst(MachineBlock *parent, Binary_Inst opcode, MachineOperand *rd, MachineOperand *rs1, MachineOperand *rs2) {
//     this->type = InstType::Binary;
//     //this->parent = parent;
//     this->opcode = opcode;
//     this->rd = rd;
//     this->rs1 = rs1;
//     this->rs2 = rs2;
// }

// void MachineBinaryInst::PrintInst(std::ofstream &outputFile) {
//     row++;
//     if (this->opcode == Binary_Inst::And) {
//         outputFile << "and " << this->rd->getRegName() << ", " << this->rs1->getRegName() << ", " << this->rs2->getRegName() << std::endl;
//     }
//     else if (this->opcode == Binary_Inst::Or) {
//         outputFile << "or " << this->rd->getRegName() << ", " << this->rs1->getRegName() << ", " << this->rs2->getRegName() << std::endl;
//     }
//     else if (this->opcode == Binary_Inst::Xor) {
//         outputFile << "xor " << this->rd->getRegName() << ", " << this->rs1->getRegName() << ", " << this->rs2->getRegName() << std::endl;
//     }
//     else
//         outputFile << magic_enum::enum_name(this->opcode) << this->rd->getRegnum() << ", " << this->rs1->getRegnum() << ", " << this->rs2->getRegnum() << std::endl;
//     //std::cout << this->opcode << this->rs1->getRegnum() << this->rs2->getRegnum() << this->rs2->getRegnum() << std::endl;
// }

// //MachineLoadInst
// MachineLoadInst::MachineLoadInst(MachineBlock *parent, Load_Inst opcode, MachineOperand *rd, MachineOperand *rs1) {
//     this->type = InstType::Load;
//     // this->parent = parent;
//     this->opcode = opcode;
//     this->rd = rd;
//     this->rs1 = rs1;
//     this->rs2 = rs2;
// }

// void MachineLoadInst::PrintInst(std::ofstream &outputFile) {
//     row++;
//     if (this->opcode == Load_Inst::li) {
//     outputFile << "li" << this->rd->getRegName() << ", " << this->rs1->getVal() << std::endl;
//     }
//     else if (this->opcode == Load_Inst::la) {
//     outputFile << "la" << this->rd->getRegName() << ", " << this->rs1->getlable() << std::endl;
//     }
//     else {
//     outputFile << magic_enum::enum_name(this->opcode) << this->rd->getRegName() << ", %d(",offset;
//     outputFile << this->rs1->getRegName() << ")" << std::endl;
//     }
// }

// //MachineStoreInst
// MachineStoreInst::MachineStoreInst(Store_Inst opcode, MachineOperand *rd, MachineOperand *rs1, MachineOperand *rs2) {
//     this->type = InstType::Store;
//     //this->parent = parent;
//     this->opcode = opcode;
//     this->rd = rd;
//     this->rs1 = rs1;
//     this->rs2 = rs2;
// }

// MachineStoreInst::MachineStoreInst(MachineBlock *parent, Store_Inst opcode, MachineOperand *rd, MachineOperand *rs1, MachineOperand *rs2) {
//     this->type = InstType::Store;
//     //this->parent = parent;
//     this->opcode = opcode;
//     this->rd = rd;
//     this->rs1 = rs1;
//     this->rs2 = rs2;
// }

// void MachineStoreInst::PrintInst(std::ofstream &outputFile) {
//     row++;
//     outputFile << magic_enum::enum_name(this->opcode) << this->rs2->getRegName() << ", %d(",offset;
//     outputFile << this->rs1->getRegName() << ")" << std::endl;
// }

// //MachineBranchInst
// MachineBranchInst::MachineBranchInst(MachineBlock *parent,Branch_Inst opcode, MachineOperand *rs1, MachineOperand *rs2) {
//     this->type = InstType::Branch;
//     if (opcode > Branch_Inst::bne)
//         printf("error: wrong instruction!\n");
//     //this->parent = parent;
//     this->opcode = opcode;
//     this->rd = nullptr;
//     this->rs1 = rs1;
//     this->rs2 = rs2;
// }

// MachineBranchInst::MachineBranchInst(MachineBlock *parent,Branch_Inst opcode, MachineOperand *rs1) {
//     this->type = InstType::Branch;
//     if (opcode <= Branch_Inst::bne)
//         printf("error: wrong instruction!\n");
//     //this->parent = parent;
//     this->opcode = opcode;
//     this->rd = nullptr;
//     this->rs1 = rs1;
//     this->rs2 = nullptr;
// }

// void MachineBranchInst::PrintInst(std::ofstream &outputFile) {
//     row++;
//     if (this->opcode <= Branch_Inst::bne) {
//         outputFile << magic_enum::enum_name(this->opcode) << " " << this->rs1->getRegName() << ", " << this->rs2->getRegName() << ", " << "%d",offset;
//         outputFile << std::endl;
//     }
//     else {
//         outputFile << magic_enum::enum_name(this->opcode) << " " << this->rs1->getRegName() << ", " << "%d",offset;
//         outputFile << std::endl;
//     }
// }

// //MachineJumpInst
// MachineJumpInst::MachineJumpInst(MachineBlock *parent, Jump_Inst opcode, MachineOperand *rd) {
//     this->type = InstType::Jump;
//     //this->parent = parent;
//     this->opcode = opcode;
//     this->rd = rd;
//     this->rs1 = nullptr;
//     this->rs2 = nullptr;  
// }

// MachineJumpInst::MachineJumpInst(MachineBlock *parent, Jump_Inst opcode, MachineOperand *rd, MachineOperand *rs1) {
//     this->type = InstType::Jump;
//     //this->parent = parent;
//     this->opcode = opcode;
//     this->rd = rd;
//     this->rs1 = rs1;
//     this->rs2 = nullptr;
// }

// MachineJumpInst::MachineJumpInst(MachineBlock *parent, Jump_Inst opcode) {
//     //this->parent = parent;
//     this->opcode = opcode;
//     this->rd = nullptr;
//     this->rs1 = nullptr;
//     this->rs2 = nullptr;
// }

// MachineJumpInst::MachineJumpInst(MachineBlock *parent, Jump_Inst opcode, MachineOperand *rs1) {
//     //this->parent = parent;
//     this->opcode = opcode;
//     this->rd = nullptr;
//     this->rs1 = rs1;
//     this->rs2 = nullptr;
// }

// void MachineJumpInst::PrintInst(std::ofstream &outputFile) {
//     row++;
//     if (this->opcode == Jump_Inst::jal) {
//         outputFile << "jal " << this->rd->getRegName() << "%d",offset;
//         outputFile << std::endl;
//     }
//     else if (this->opcode == Jump_Inst::jalr) {
//         outputFile << "jalr " << this->rd->getRegName() << "%d",offset;
//         outputFile << "(" << this->rs1->getRegName() << ")" <<std::endl;
//     }
//     else if (this->opcode == Jump_Inst::j) {
//         outputFile << "j " << "%d",offset;
//         outputFile << std::endl;
//     }
//     else {
//         outputFile << "jr " << this->rs1->getRegName() << std::endl;
//     }
// }

// //MachineCmpInst
// MachineCmpInst::MachineCmpInst(MachineBlock *parent, Cmp_Inst opcode, MachineOperand *rd, MachineOperand *rs1, MachineOperand *rs2) {
//     this->type = InstType::Cmp;
//     //this->parent = parent;
//     this->opcode = opcode;
//     this->rd = rd;
//     this->rs1 = rs1;
//     this->rs2 = rs2;
// }

// MachineCmpInst::MachineCmpInst(MachineBlock *parent, Cmp_Inst opcode, MachineOperand *rd, MachineOperand *rs1) {
//     this->type = InstType::Cmp;
//     //this->parent = parent;
//     this->opcode = opcode;
//     this->rd = rd;
//     this->rs1 = rs1;
//     this->rs2 = nullptr; 
// }

// void MachineCmpInst::PrintInst(std::ofstream &outputFile) {
//     row++;
//     if (this->opcode == Cmp_Inst::slt) {
//         outputFile << "slt " << this->rd->getRegName() << ", " << this->rs1->getRegName() << this->rs2->getRegName() << std::endl;
//     }
//     else if (this->opcode == Cmp_Inst::slti) {
//         outputFile << "slt " << this->rd->getRegName() << ", " << this->rs1->getVal() << std::endl;
//     }
//     else {
//         outputFile << magic_enum::enum_name(this->opcode) << " " << this->rd->getRegName() << ", " << this->rs1->getRegName() << std::endl;
//     }
// }

// //PseudoInst
// PseudoInst::PseudoInst(MachineBlock *parent, Pseudo_Inst opcode, MachineOperand *rd, MachineOperand *rs1) {
//     this->type = InstType::Pseudo;
//     //this->parent = parent;
//     this->opcode = opcode;
//     this->rd = rd;
//     this->rs1 = rs1;
//     this->rs2 = nullptr;  
// }

// PseudoInst::PseudoInst(MachineBlock *parent, Pseudo_Inst opcode) {
//     this->type = InstType::Pseudo;
//     //this->parent = parent;
//     this->opcode = opcode;
//     this->rd = nullptr;
//     this->rs1 = nullptr;
//     this->rs2 = nullptr;
// }

// void PseudoInst::PrintInst(std::ofstream &outputFile) {
//     row++;
//     if (this->opcode == Pseudo_Inst::mv) {
//         outputFile << "mv " << this->rd->getRegName() << ", " << this->rs1->getRegName() << std::endl;
//     }
//     else if (this->opcode == Pseudo_Inst::ret) {
//         outputFile << "ret" << std::endl;
//     }
// }

// //MachineBlock
// MachineBlock::MachineBlock() {
//     // this->parent = parent;
//     // this->num = num;
// }

// void MachineBlock::addInst(MachineInst *inst) {
//     this->InstList.push_back(inst);
// }

// std::vector<MachineInst *> &MachineBlock::getInstList() {
//     return this->InstList;
// }

// //MachineFunction
// void MachineFunction::setstacksize() {
//     int argnum = this->paramList.size() + this->alloca_variables.size();
//     this->stacksize = 16 + argnum * 4;
//     //RISC-V 栈帧以16字节对齐
//     int x = this->stacksize % 16;
//     this->stacksize += x;
// }

// MachineFunction::MachineFunction() {
//     this->Funcname ;
//     this->paramList ;
//     this->alloca_variables ;
//     this->BlockList ;
//     setstacksize();
// }

// // int MachineFunction::getoffset(Function *func, char* name) {
// //     std::vector<std::string, int>*next = getoffset_list();
// //     while(next != NULL) {
// //         if(strcmp(next->name, name) == 0) {
// //             return next->offset;
// //         }
// //         else next = next->next;
// //     }
// //     return -1;
// // }

// int MachineFunction::getstacksize() {
//     return this->stacksize;
// }

// void MachineFunction::addBlock(MachineBlock *block) {
//     this->BlockList.push_back(block);
// }

// void MachineFunction::addParam(MachineOperand *param) {
//     this->paramList.push_back(param);
// }

// void MachineFunction::addAlloca(MachineOperand *alloca) {
//     this->alloca_variables.push_back(alloca);
// }

// std::string MachineFunction::getFuncName() {
//     return this->Funcname;
// }

// std::vector<MachineBlock *> &MachineFunction::getBlockList() {
//     return this->BlockList;
// }

// std::vector<MachineOperand *> &MachineFunction::getParams() {
//     return this->paramList;
// }

// std::vector<MachineOperand *> &MachineFunction::getAllocaVariables() {
//     return this->alloca_variables;
// }

// void MachineFunction::PrintInstStack(MachineUnit* Unit, std::ofstream &outputFile) {
//     //完成栈帧基本结构
//     row++;
//     outputFile << this->Funcname << std::endl;
//     row++;
//     outputFile << "    addi sp, sp, -" << this->stacksize << std::endl;
//     row++;
//     outputFile << "    sd ra, " << this->stacksize - 8 << "(sp)" << std::endl;
//     row++;
//     outputFile << "    sd s0, " << this->stacksize - 16 << "(sp)" << std::endl;
//     row++;
//     outputFile << "    addi s0, sp, " << this->stacksize << std::endl;
//     //打印保存参数部分
    
//     //打印保存局部变量部分

//     //打印函数体

//     //打印恢复状态部分
// }

// //MachineUnit
// MachineUnit::MachineUnit() {
//     for (auto& Fun : this->FunctionList) {
//         this->labelmap.insert(std::make_pair(Fun->getFuncName(), -1));
//     }
//     this->labelmap[FunctionList[0]->getFuncName()] = row;
// }

// bool MachineUnit::isLableLegal() {
//     for (auto& label : this->labelmap) {
//         if (label.second == -1) {
//             std::cout << "error: label " << label.first << " is not modified" << std::endl;
//             return false;
//         }
//     }
// }

// void MachineUnit::addFunction(MachineFunction *func) {
//     this->FunctionList.push_back(func);
// }

// std::vector<MachineFunction *> &MachineUnit::getFuncList() {
//     return this->FunctionList;
// }



// //  转换实例
// // #include <iostream>
// // #include <vector>
// // #include <unordered_map>
// // #include <string>

// // class Variable {};
// // class BasicBlock {};
// // class AllocaInst {};

// // class Function {
// // public:
// //     std::string name;
// //     using ParamPtr = std::unique_ptr<Variable>;
// //     using VarPtr = std::unique_ptr<Variable>;
// //     using BasicBlockPtr = std::unique_ptr<BasicBlock>;
// //     std::vector<ParamPtr> params;
// //     std::vector<VarPtr> alloca_variables;
// //     std::vector<BasicBlockPtr> bbs;
// //     void InsertAlloca(AllocaInst* ptr) {}
// // };

// // class MachineFunction {
// // public:
// //     std::unordered_map<std::string, int> Blockmap;
// //     int stacksize;
// // };

// // int main() {
// //     std::vector<Function> functionVec; // 原始的 Function 对象的 vector

// //     std::vector<MachineFunction> machineFunctionVec; // 转换后的 MachineFunction 对象的 vector

// //     // 遍历 functionVec，逐个转换并复制到 machineFunctionVec
// //     for (const auto& function : functionVec) {
// //         MachineFunction machineFunction;

// //         // 复制 Function 的成员变量到 MachineFunction
// //         machineFunction.Blockmap = function.Blockmap;
// //         machineFunction.stacksize = function.stacksize;

// //         // 将转换后的 MachineFunction 添加到 machineFunctionVec
// //         machineFunctionVec.push_back(machineFunction);
// //     }

// //     // 输出转换后的结果
// //     for (const auto& machineFunction : machineFunctionVec) {
// //         std::cout << "Blockmap size: " << machineFunction.Blockmap.size() << std::endl;
// //         std::cout << "Stacksize: " << machineFunction.stacksize << std::endl;
// //         std::cout << std::endl;
// //     }

// //     return 0;
// // }