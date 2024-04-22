#pragma once
#include <fstream>
#include<iostream>
#include <sstream>
#include "Mcode.hpp"
#include "InstSelection.hpp"
#include "FloatToDex.hpp"
#include "LivenessAnalysis.hpp"
class globlvar;
class tempvar;
class functionSegment;
class textSegment;
class dataSegment;
enum SegmentType {
        TEXT,
        DATA,
        BSS,
        RODATA
};
SegmentType ChangeSegmentType(SegmentType newtype);
void PrintSegmentType(SegmentType newtype, SegmentType* oldtype);
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
    //void PrintInst(MachineUnit* unit);
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
    MachineFunction* machinefunction;
    public:
    functionSegment(MachineFunction* machinefunction);
    //~functionSegment() = default;
    void PrintFuncSegment();
};

class dataSegment {
    private:
    std::vector<globlvar*> globlvar_list;//.data
    std::vector<tempvar*> tempvar_list;//.data
    MachineUnit* Machineunit;
    public:
    dataSegment(MachineUnit* Machineunit);
    ~dataSegment() = default;
    void GenerateGloblvarList(MachineUnit* Machineunit);
    void GenerateTempvarList(MachineUnit* Machineunit);
    std::vector<tempvar*> get_tempvar_list();
    void Change_LoadConstFloat(MachineInst* machineinst, tempvar* tempfloat, std::list<MachineInst *>::iterator it, Operand used);
    void PrintDataSegment_Globval();
    void PrintDataSegment_Tempvar();
};

class globlvar{
    private:
    //structure
    std::string name;
    int align;
    std::string ty="object";
    int size;
    std::vector<std::variant<int , float>> init_vector;

    public:
    globlvar(Variable* data);
    ~globlvar() = default;
    // std::string get_sec();
    void generate_array_init(Initializer* arry_init, Type* basetype);
    void PrintGloblvar();
};

class tempvar{
    private:
    //structure
    int num_lable;
    std::string name;
    int align;
    // std::vector<std::variant<int , float>> init_vector;
    float init;
    public:
    tempvar(int num_lable, float init);
    ~tempvar() = default;
    std::string Getname();

    void PrintTempvar();
};