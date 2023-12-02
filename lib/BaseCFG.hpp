#pragma once
#include <vector>
#include <cassert>
#include "List.hpp"
#include <variant>
#include <functional>
#include <iostream>
#include <cxxabi.h>
class User;
class Value;
/// @brief Use关系，User析构时析构
enum InnerDataType
{
    IR_Value_INT,IR_Value_VOID,IR_Value_Float
};
class Use
{
    friend class UserList;
    User* fat=nullptr;
    Value* usee=nullptr;
    Use* nxt=nullptr;
    Use** prev=nullptr;
    public:
    Use()=delete;
    Use(User*,Value*);
    /// @brief 注意，调用这个方法的一定是User，所以我加了个鉴权
    void RemoveFromUserList(User* is_valid);
};
/// @brief prepare for Value to quickly find out its User
class UserList
{
    Use* head=nullptr;
    public:
    UserList()=default;
    void push_front(Use* _data);
};
class Value
{
    /// @brief 用来找到一个Value的所有User
    UserList userlist;
    InnerDataType tp;
    public:
    virtual ~Value()=default;
    Value()=delete;
    Value(InnerDataType _tp);
    InnerDataType GetType();
    void add_user(Use* __data);
    virtual void print();
};
class User:public Value
{
    std::vector<Use> uselist;
    protected:
    void add_use(Value* __data);
    public:
    User();
    User(InnerDataType tp);
    void print();
};
class Operand:public std::variant<Value*,int,float>
{
    using InnerOperand=std::variant<Value*,int,float>;
    public:
    Operand(int num);
    Operand(Value* num);
    Operand(float num);
    InnerDataType GetType();
};