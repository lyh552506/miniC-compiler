#pragma once
#include "BackendPass.hpp"
#include "RISCVMIR.hpp"

class PostRACalleeSavedLegalizer:public BackEndPass<RISCVFunction>{
    public:
    bool run(RISCVFunction*)override;
};