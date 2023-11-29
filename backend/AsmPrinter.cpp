#include<iostream>
#include<fstream>
#include"MachineCode.hpp"

void printToLL() {
    std::ofstream outputFile("output.ll", std::ios::app); // 以追加模式打开文件
    BinaryInst inst = BinaryInst(nullptr, BinaryInst::Add, new MachineOperand(MachineOperand::REG, 1), new MachineOperand(MachineOperand::REG, 2), new MachineOperand(MachineOperand::REG, 3));
    if (outputFile.is_open()) {
        inst.print(outputFile);
        
        outputFile.close(); // 关闭文件
    } else {
        std::cout << "Unable to open the file." << std::endl;
    }
}

int main() {
    printToLL();
    return 0;
}