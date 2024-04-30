#pragma once
#include "RISCVMIR.hpp"
#include "RISCVRegister.hpp"

namespace RISCVTrival{
    RISCVMIR* CopyFrom(VirRegister*,RISCVMOperand*);
};