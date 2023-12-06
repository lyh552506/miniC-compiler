#pragma once
#include <string>
#include <vector>
#include <unordered_map>
#include "MachineCode.hpp"

class AsmPrinter {
public:
    AsmPrinter(MachineUnit* unit);

    void PrintCode(MachineUnit* unit, std::ofstream &outputFile);
    void PrintCodeToTxt(MachineUnit* unit);
};