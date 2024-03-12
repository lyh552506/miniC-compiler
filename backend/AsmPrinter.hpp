#pragma once
#include <fstream>
#include<iostream>
#include "Mcode.hpp"
#include "InstSelection.hpp"

void RegAlloca(Function* function);
MachineUnit* GenerateMir(Module* unit);
void AsmPrinter(MachineUnit* unit);
void PrintCodeToTxt(Module* unit);
