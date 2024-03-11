#pragma once
#include <fstream>
#include<iostream>
#include "Mcode.hpp"
#include "InstSelection.hpp"

void RegAlloca(Function* function);
void PrintCode(Module* unit);
void PrintCodeToTxt(Module* unit);
