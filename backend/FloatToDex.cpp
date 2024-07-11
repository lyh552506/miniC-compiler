#include "../include/backend/FloatToDex.hpp"

void getFloatIEEE(float value) {
    const unsigned char* bytes = reinterpret_cast<const unsigned char*>(&value);
    
}
int binaryToDecimal(const std::string& binStr) {
    int decimal = 0;
    for (char bit : binStr) {
        decimal *= 2;
        if (bit == '1') {
            decimal += 1;
        }
    }
    return decimal;
}