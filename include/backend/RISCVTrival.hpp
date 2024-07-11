#pragma once
#include "../../include/backend/RISCVMIR.hpp"
#include "../../include/backend/RISCVRegister.hpp"

namespace RISCVTrival{
    RISCVMIR* CopyFrom(VirRegister*,RISCVMOperand*);
};