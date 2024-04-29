// Immediate number specification
#pragma once
#include "RISCVContext.hpp"

void li_Intimm() {
    int imm;
    int mod = imm%4096;
    if(mod==0) {
        //li a
    } else if (mod>0 && mod<2048) {
        //li a-m
        //addi a, a, m
    } else if (mod >=2048 && mod <4095) {
        //li a-m+4096
        //addi a, a, m
    }
    else assert(0&"error imm");
}