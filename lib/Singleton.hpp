#pragma once
template <typename T>//单例模式
T& Singleton(){
    static T inner;
    return inner;
}
struct IR_CONSTDECL_FLAG
{
    bool flag;
};