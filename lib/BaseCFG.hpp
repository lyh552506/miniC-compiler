#pragma once
#include <vector>
#include <cassert>
#include "List.hpp"
#include <variant>
#include <functional>
#include <iostream>
#include <cxxabi.h>
#include "Type.hpp"
class User;
class Value;
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
    std::shared_ptr<Type> tp;
    public:
    virtual ~Value()=default;
    Value()=delete;
    Value(std::shared_ptr<Type> _tp);
    Value(InnerDataType _tp);
    InnerDataType GetType();
    std::shared_ptr<Type> CopyType();
    void add_user(Use* __data);
    virtual void print();
};
class User:public Value
{
    std::vector<Use> uselist;
    protected:
    void add_use(Value* __data);
    std::unique_ptr<Value> def=nullptr;
    public:
    User();
    User(std::shared_ptr<Type> tp);
    void print();
    Value* GetDef();
};
class ConstIRInt:public Value
{
    int val;
    public:
    ConstIRInt();
};
class ConstIRFloat:public Value
{
    float val;
    public:
    ConstIRFloat();
};