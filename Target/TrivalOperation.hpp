/// @note PLEASE ONLY INCLUDE IT IN CPP, NOT IN HEADERS
#pragma once
#include "RISCVMIR.hpp"
#include "RISCVRegister.hpp"

RISCVMIR* emitCopy(VirRegister* dst,RISCVMOperand* src);

// RISCVMIR* emitCopy(RISCVMOperand*);