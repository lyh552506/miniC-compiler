#include "Singleton.hpp"
int IR_MARK::GetNum(void* ptr){
    if(number.find(ptr)==number.end())number[ptr]=cnt++;
    return number[ptr];
}
void IR_MARK::Reset(){
    number.clear();
    cnt=0;
}