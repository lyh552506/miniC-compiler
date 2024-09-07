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

struct Enable_Parallel{
    bool flag=false;
};

struct Inline_Recursion{
    bool flag=false;
};