#pragma once
#include "../../include/backend/BackendPass.hpp"
#include "../../include/backend/RISCVMIR.hpp"

// 只考虑src是j到这个块的情况
class DeleteDeadBlock:public BackEndPass<RISCVFunction>{
    public:
    bool run(RISCVFunction*)override;
};