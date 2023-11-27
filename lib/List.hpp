#pragma once
#include <list>
/// @brief 要写什么自己加，最简单的一集
/// @tparam T 
template<typename T>
class List:public std::list<std::unique_ptr<T>>
{
    public:
    void push_front(T* data){
        this->push_front(data);
    }
    void push_back(T* data){
        this->push_back(data);
    }
};