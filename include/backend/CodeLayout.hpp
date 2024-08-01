#pragma once
#include "../../include/backend/BackendPass.hpp"
#include "../../include/backend/RISCVMIR.hpp"

class CodeLayout:public BackEndPass<RISCVFunction>{
    public:
    static std::vector<double> getFreq(std::vector<std::vector<double>>& mat,int n);
    bool run(RISCVFunction*)override;
};