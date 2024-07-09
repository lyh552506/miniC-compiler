#pragma once
#include "BackendPass.hpp"
#include "RISCVMIR.hpp"


// If it change the code, return true please.
class DeadCodeElimination:public BackEndPass<RISCVFunction>{
    public:
    bool run(RISCVFunction*);
};
