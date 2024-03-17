#pragma once
#include <CFG.hpp>

class LiInst : public User
{
    public:
    LiInst(Operand _A);
    void print()final;
};

class XorInst : public User
{
    public:
    XorInst(Operand _A, std::string opcode, Operand _B);
    void print()final;
};
