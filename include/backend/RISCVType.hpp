#pragma once
#include "../../include/lib/Type.hpp"
#include <cassert>

/// riscv_ptr   :   a pointer to some address() 
/// riscv_none  :   ?
enum RISCVType{
    riscv_i32,riscv_i64,riscv_float32,riscv_ptr,riscv_none
};

// This serves as an adapter function
// for some reason we may keep the Type System in backend
inline RISCVType RISCVTyper(Type* tp){
    if(dynamic_cast<PointerType*>(tp))return RISCVType::riscv_ptr;
    else if(tp==IntType::NewIntTypeGet())return RISCVType::riscv_i32;
    else if(tp==FloatType::NewFloatTypeGet())return RISCVType::riscv_float32;
    else if(tp==VoidType::NewVoidTypeGet())return RISCVType::riscv_none;
    else if(tp==BoolType::NewBoolTypeGet())return RISCVType::riscv_i32;
    else if(tp==Int64Type::NewInt64TypeGet())return RISCVType::riscv_i64;
    assert(0&&"Invalid Type");
}