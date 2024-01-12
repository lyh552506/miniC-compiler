#include "Singleton.hpp"
int IR_MARK::GetNum(void* ptr){
    if(number.find(ptr)==number.end())number[ptr].first=cnt++;
    return number[ptr].first;
}
bool IR_MARK::mark(void* ptr){
    bool ret;
    if(ret=(number.find(ptr)==number.end()))number[ptr].first=cnt++;
    return ret;
}
bool& IR_MARK::isprint(void* ptr){
    return number[ptr].second;
}
void IR_MARK::Reset(){
    number.clear();
    cnt=0;
}