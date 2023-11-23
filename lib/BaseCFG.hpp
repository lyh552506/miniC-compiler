#pragma once
#include <vector>
#include <cassert>
#include "List.hpp"
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
    Use(User* __fat,Value* __usee):fat(__fat),usee(__usee){
        usee->add_user(this);
    }
    /// @brief 注意，调用这个方法的一定是User，所以我加了个鉴权
    void RemoveFromUserList(User* is_valid){
        assert(is_valid==fat);
        (*prev)=nxt;
        nxt->prev=prev;
    }
};
/// @brief prepare for Value to quickly find out its User
class UserList
{
    Use* head=nullptr;
    public:
    UserList()=default;
    void push_front(Use* _data){
        _data->nxt=head;
        if(head!=nullptr)head->prev=&(_data->nxt);
        _data->prev=&head;
    }
    /// @todo 给一个遍历的方法
};
class Value
{
    /// @brief 用来找到一个Value的所有User
    UserList userlist;
    InnerDataType tp;
    public:
    Value()=delete;
    Value(InnerDataType _tp):tp(_tp){}
    void add_user(Use* __data){
        userlist.push_front(__data);
    }
};
class User:public Value
{
    std::vector<Use> uselist;
    protected:
    void add_use(Value* __data){
        uselist.push_back(Use(this,__data));
    }
    public:
    User():Value(IR_Value_VOID){}
    User(InnerDataType tp):Value(tp){}
};
