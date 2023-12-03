#pragma once
#include <string>
#include <vector>
#include <unordered_map>
#include "MachineCode.hpp"

class AsmPrinter {
private:
    int row;
    std::unordered_map<std::string, int> labelmap;
    std::vector<MachineFunction *> FuncList;

public:
    AsmPrinter(MachineUnit* unit);

    void PrintCode(MachineUnit* unit, std::ofstream &outputFile);
    void PrintCodeToTxt(MachineUnit* unit);
};