#pragma once
#include <fstream>
#include<iostream>
#include "Mcode.hpp"
#include "InstSelection.hpp"

void RegAlloca(Function* function);
MachineUnit* GenerateMir(Module* unit);
void AsmPrinter(MachineUnit* unit);
void PrintCodeToTxt(Module* unit);

class globlvar;
class Segment;
class textSegment;
class dataSegment;
class sectionSegment;

class AsmPrinter {
    protected:
    std::vector<Segment> segments;
    std::string filename;
    Module* unit;

    public:
    AsmPrinter(std::string filename, Module* unit);

};
class globlvar {

};
class Segment {

};
class textSegment : public Segment{
    private:
    int align;

};

class dataSegment : public Segment{

};

// sbss or rodata
class sectionSegment : public Segment{
    private:
    int align;
};