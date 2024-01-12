#pragma once
#include <vector>
#include <cassert>
#include "List.hpp"
#include <variant>
#include <functional>
#include <iostream>
#include <cxxabi.h>
#include "Type.hpp"
#include <string>
class User;
class Value;
class Use
{
    friend class UserList;
    /// @brief 使用者
    User* fat=nullptr;
    /// @brief 被使用者
    Value* usee=nullptr;
    /// @brief 下一个Use
    Use* nxt=nullptr;
    /// @brief 管理这个Use的指针
    Use** prev=nullptr;
    public:
    Use()=delete;
    Use(User*,Value*);
    /// @brief 注意，调用这个方法的一定是User，所以我加了个鉴权
    void RemoveFromUserList(User* is_valid);
    Value* GetValue();
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
    int number=-1;
    std::string name; 
    /// @brief 存储所有的User
    UserList userlist;
    protected:
    std::shared_ptr<Type> tp;
    public:
    virtual ~Value()=default;
    Value()=delete;
    Value(std::shared_ptr<Type> _tp);
    Value(InnerDataType _tp);
    /// @brief 为dump出ll作准备
    void SetNum(int&);
    int GetNum();
    /// @brief 增加std::strign name
    std::string GetName();
    void print(int&);    
    /// @brief Type System还在被批判的过程中 
    InnerDataType GetType();
    std::shared_ptr<Type> CopyType();
    /// @brief  
    void add_user(Use* __data);
    virtual bool isConst(){return false;}
};
using Operand=Value*;
class User:public Value
{
    using UsePtr=std::unique_ptr<Use>;
    protected:
    std::vector<UsePtr> uselist;
    void add_use(Value* __data);
    public:
    virtual void print(int&)=0;
    /// @brief 新增打印机器指令的接口
    virtual void printmachineinst(std::ofstream &outputFile)=0;
    /// @brief 
    User();
    User(InnerDataType tp);
    User(std::shared_ptr<Type> tp);
    virtual Operand GetDef();
};
class ConstIRInt:public Value
{
    int val;
    public:
    ConstIRInt(int);
    int GetVal();
    bool isConst()final{return true;}
};
class ConstIRFloat:public Value
{
    float val;
    public:
    ConstIRFloat(float);
    float GetVal();
    bool isConst()final{return true;}
};