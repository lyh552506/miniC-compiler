#pragma once
#include <fstream>
#include<iostream>
#include "Mcode.hpp"
#include "InstSelection.hpp"

void RegAlloca(Function* function);
MachineUnit* GenerateHir(Module* unit);
void ChangeConditionInsts(MachineUnit* unit);
//void PrintCode(Module* unit);
void PrintCodeToTxt(Module* unit);
