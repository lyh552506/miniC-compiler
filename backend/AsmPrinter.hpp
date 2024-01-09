#pragma once
#include "MachineCode.hpp"
#include "InstSelection.hpp"

void shiftpass(MachineFunction* machinefunction);
void shift(MachineUnit* unit);
void PrintCode(MachineUnit* unit, std::ofstream &outputFile);
void PrintCodeToTxt(MachineUnit* unit);
