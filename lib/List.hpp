#pragma once
#include <list>
#include <memory>
/// @brief 设计的先发劣势，要写什么自己加，最简单的一集
/// @tparam T 
template<typename T>
class List:public std::list<std::unique_ptr<T>>
{
    using Father=std::list<std::unique_ptr<T>>;
    using DataType=std::unique_ptr<T>;
    public:
    void push_front(T* data){
        Father::push_front(DataType(data));
    }
    void push_back(T* data){
        Father::push_back(DataType(data));
    }
};

template<typename Fat>
class list_node
{
    list_node* prev;
    list_node* next;
    Fat* fat;
    
    public:
    list_node(){
        this->prev=nullptr;
        this->next=nullptr;
    };
    virtual void EraseFromParent(){
        if(this->prev!=nullptr)this->prev->next=this->next;
        if(this->next!=nullptr)this->next->prev=this->prev;
    }
    virtual Fat* GetParent(){return this->fat;};
};

