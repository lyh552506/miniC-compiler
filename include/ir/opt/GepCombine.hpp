#pragma once
#include "CFG.hpp"
#include "PassManagerBase.hpp"

class GepCombine : public _PassManagerBase<GepCombine, Function> {
public:
    GepCombine();

private:

};