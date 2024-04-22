#pragma once
#include <bitset>
#include <iostream>

// 使用联合体来共享内存空间
union FloatBits {
    float floatValue;
    unsigned int intBits;
};
int binaryToDecimal(const std::string& binStr);
