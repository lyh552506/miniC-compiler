#pragma once
#include <CFG.hpp>

class LiInst : public User
{
    public:
    LiInst(Operand _A);
    void print()final {};
};

class XorInst : public User
{
    private:
    std::string opcode;
    public:
    XorInst(Operand _A, std::string opcode, Operand _B);
    std::string GetOpcode();
    void SetOpcode(std::string opcode);
    void print()final {};
};

void RSUW (User* inst1, int num1, User* inst2, int num2);