#pragma once
#include "../../include/backend/BackendPass.hpp"
#include "../../include/backend/RISCVMIR.hpp"

class PostRACalleeSavedLegalizer:public BackEndPass<RISCVFunction>{
    public:
    bool run(RISCVFunction*)override;
};