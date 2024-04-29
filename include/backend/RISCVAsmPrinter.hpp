#pragma once
#include <fstream>
#include <iostream>
#include <sstream>
#include "RISCVFrameContext.hpp"
#include "RISCVMIR.hpp"
#include "RISCVISel.hpp"
#include "FloatToDex.hpp"
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
class RISCVAsmPrinter {
    protected:
    std::string filename;
    textSegment* text;
    dataSegment* data;
    public:
    RISCVAsmPrinter(std::string filename, Module* unit, RISCVLoweringContext& ctx);
    ~RISCVAsmPrinter() = default;
    void printAsmGlobal();
    void printAsmText();
    void printAsmTempFloat();
};

class dataSegment {
    private:
    std::vector<globlvar*> globlvar_list;//.data
    std::vector<tempvar*> tempvar_list;//.data
    public:
    dataSegment(Module* module, RISCVLoweringContext& ctx);
    void GenerateGloblvarList(Module* module, RISCVLoweringContext& ctx);
    void GenerateTempvarList(Module* module);
    std::vector<tempvar*> get_tempvar_list();
    //
    void Change_LoadConstFloat(Value* inst, tempvar* tempfloat, std::list<Value*>::iterator it, Operand used);
    void PrintDataSegment_Globval();
    void PrintDataSegment_Tempvar();
};

class globlvar: public RISCVGlobalObject{
    private:
    //structure
    int align;
    std::string ty="object";
    int size;
    std::vector<std::variant<int , float>> init_vector;
    public:
    globlvar(Variable* data);
    ~globlvar() = default;
    void generate_array_init(Initializer* arry_init, Type* basetype);
    void PrintGloblvar();
};

class tempvar: public RISCVTempFloatObject{
    private:
    //structure
    int num_lable;
    int align;
    float init;
    public:
    tempvar(int num_lable, float init);
    ~tempvar() = default;
    std::string Getname();
    void PrintTempvar();
};

class textSegment {
    private:
    std::vector<functionSegment*> function_list;
    public:
    textSegment(Module* module);
    void GenerateFuncList(Module* module);
    void PrintTextSegment();
};

class functionSegment {
    private:
    //structure
    int align;
    std::string name;
    std::string ty="function";
    int size;
    public:
    functionSegment(Function* func);
    void PrintFuncSegment();
};