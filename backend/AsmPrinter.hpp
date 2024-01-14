#pragma once
#include "Mcode.hpp"
//#include "MachineCode.hpp"
#include "InstSelection.hpp"

void RegAlloca(Function* function);
//void shift(MachineUnit* unit);
void PrintCode(Module* unit);
void PrintCodeToTxt(Module* unit);
