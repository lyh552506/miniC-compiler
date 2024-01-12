#pragma once
#include <map>
template <typename T>
T& Singleton(){
    static T inner;
    return inner;
}
struct IR_CONSTDECL_FLAG
{
    bool flag;
};
class IR_MARK
{
    int cnt=0;
    std::map<void*,int> number;
    public:
    int GetNum(void*);
    void Reset();
};