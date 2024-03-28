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
    //
    Module* unit;
    MachineUnit* Machineunit;

    public:
    AsmPrinter(std::string filename, Module* unit);

    void RegAlloca(Function* function);
    MachineUnit* GenerateMir(Module* unit);
    void PrintInst(MachineUnit* unit);

    void printAsm();
    void PrintToTxt();

    friend textSegment;
    friend globlvar;
    friend tempvar;
};

class textSegment {
    private:
    MachineUnit* Machineunit;
    std::vector<functionSegment*> function_list;

    public:
    textSegment(MachineUnit* Machineunit);
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
    void PrintFuncSegment();
};

class dataSegment {
    private:
    std::vector<globlvar*> globlvar_list;//.data or .bss
    std::vector<tempvar*> tempvar_list;//.data
    Module* unit;
    protected:
    enum section {
        data,
        bss
    };
    public:
    dataSegment(Module* unit);
    void GenerateGloblvarList(Module* unit);
    void GenerateTempvarList(MachineUnit* Machineunit);


};

class globlvar : public dataSegment{
    private:
    //structure
    std::string name;
    section sec;
    int align;
    std::string ty="object";
    int size;
    std::vector<std::variant<int , float>> init_vector;
    //
    dataSegment* parent;

    public:
    globlvar(std::string name, section sec, int align, int size, std::vector<std::variant<int , float>> init_vector);

};

class tempvar : public dataSegment{
    private:
    //structure
    std::string name;
    section sec;
    int align;
    std::vector<std::variant<int , float>> init_vector;
    //
    dataSegment* parent;

    public:
    tempvar(std::string name, section sec, int align, std::vector<std::variant<int , float>> init_vector);
};