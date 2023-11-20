#include<iostream>
#include<fstream>
#include"LLVM_IR.hpp"

class InstructionSelection : public LLVM_IR
{
public:
    InstructionSelection();

    ~InstructionSelection();
    
    void run();

};
