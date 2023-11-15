#pragma once
template <typename T>
T& Singleton(){
    static T inner;
    return inner;
}