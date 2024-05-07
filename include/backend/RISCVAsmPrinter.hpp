#pragma once
#include <fstream>
#include <iostream>
#include <sstream>
#include "RISCVFrameContext.hpp"
#include "RISCVMIR.hpp"
#include "RISCVISel.hpp"
#include "FloatToDex.hpp"
#include "MagicEnum.hpp"
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
    void SetTextSegment(textSegment*);
    dataSegment*& GetData();
    void printAsmGlobal();
    void printAsmText();
    void printAsmTempFloat();
    void printAsm();
};

class dataSegment {
    private:
    std::vector<globlvar*> globlvar_list;//.data
    std::vector<tempvar*> tempvar_list;//.data
    public:
    dataSegment(Module* module, RISCVLoweringContext& ctx);
    void GenerateGloblvarList(Module* module, RISCVLoweringContext& ctx);
    void GenerateTempvarList(RISCVLoweringContext& ctx);
    std::vector<tempvar*> get_tempvar_list();
    void Change_LoadConstFloat(RISCVMIR* inst, tempvar* tempfloat, mylist<RISCVBasicBlock,RISCVMIR>::iterator it, Imm* used);
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
    textSegment(RISCVLoweringContext& ctx);
    void GenerateFuncList(RISCVLoweringContext& ctx);
    void PrintTextSegment();
};

class functionSegment {
    private:
    //structure
    int align;
    std::string name;
    std::string ty="function";
    RISCVFunction* func;
    int size;
    public:
    functionSegment(RISCVFunction* func);
    void PrintFuncSegment();
};