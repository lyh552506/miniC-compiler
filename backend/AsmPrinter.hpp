#pragma once
#include <fstream>
#include<iostream>
#include "Mcode.hpp"
#include "InstSelection.hpp"

class globlvar;
class tempvar;
class functionSegment;
class textSegment;
class dataSegment;

class AsmPrinter {
    protected:
    std::string filename;
    textSegment* text;
    dataSegment* data;

    Module* unit;
    MachineUnit* Machineunit;

    public:
    AsmPrinter(std::string filename, Module* unit);
    ~AsmPrinter() = default;
    
    void RegAlloca(Function* function);
    MachineUnit* GenerateMir(Module* unit);

    void PrintInst(MachineUnit* unit);
    void printAsm();
};

class textSegment {
    private:
    MachineUnit* Machineunit;
    std::vector<functionSegment*> function_list;

    public:
    textSegment(MachineUnit* Machineunit);
    ~textSegment() = default;
    void GenerateFuncList(MachineUnit* Machineunit);
    void PrintTextSegment();
};

class functionSegment {
    private:
    //structure
    int align;
    std::string name;
    std::string ty="function";
    int size;
    //
    MachineFunction* machinefunction;
    public:
    functionSegment(MachineFunction* machinefunction);
    //~functionSegment() = default;
    void PrintFuncSegment();
};

class dataSegment {
    private:
    std::vector<globlvar*> globlvar_list;//.data
    std::vector<globlvar*> globlvar_undef_list;//.bss
    std::vector<tempvar*> tempvar_list;//.data
    MachineUnit* Machineunit;

    public:
    dataSegment(MachineUnit* Machineunit);
    ~dataSegment() = default;
    void GenerateGloblvarList(MachineUnit* Machineunit);
    void GenerateTempvarList(MachineUnit* Machineunit);

};

class globlvar{
    private:
    //structure
    std::string name;
    std::string sec;
    int align;
    std::string ty="object";
    int size;
    std::vector<std::variant<int , float>> init_vector;

    public:
    globlvar(Variable* data);
    ~globlvar() = default;
    std::variant<int, float> generate_array_init(Initializer* arry_init);

};

class tempvar{
    private:
    //structure
    std::string name;
    std::string sec;
    int align;
    std::vector<std::variant<int , float>> init_vector;

    public:
    tempvar(std::string name, std::string sec, int align, std::vector<std::variant<int , float>> init_vector);
    ~tempvar() = default;
};