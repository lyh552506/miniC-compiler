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
class BasicBlock;
class Use
{
    public:
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
    User*& SetUser();
    Value*& SetValue();
    Value* GetValue();
    User* GetUser();
    
};
/// @brief prepare for Value to quickly find out its User
class UserList
{
    Use* head=nullptr;
    public:
    UserList()=default;
    void push_front(Use* _data);
    class iterator{
        Use *ptr;
        public:
        iterator(Use *_ptr):ptr(_ptr){}

        iterator& operator++(){
            ptr=ptr->nxt;
            return *this;
        }

        // iterator& operator--(){
        //     ptr=*(ptr->prev);
        //     return *this;
        // }

        Use* operator*(){return ptr;}
        bool operator==(const iterator& other){return ptr==other.ptr;}
        bool operator!=(const iterator& other){return ptr!=other.ptr;}
    };
    iterator begin(){return iterator(this->head);}
    iterator end(){return iterator(nullptr);}
    bool is_empty(){return head==nullptr;}
    Use*& Front(){return head;}
};
class Value
{
    friend class Module;
    /// @brief 存储所有的User
    UserList userlist;
    protected:
    std::string name;
    Type* tp;
    public:
    virtual ~Value()=default;
    Value()=delete;
    Value(Type*);
    void print();
    InnerDataType GetTypeEnum();
    virtual Type* GetType();
    void add_user(Use* __data);
    virtual bool isConst(){return false;}
    void RAUW(Value* val); //ReplaceAllUseWith
    void SetName(std::string newname);
    virtual std::string GetName();
    UserList& GetUserlist(){return userlist;};
    bool isGlobVal(){return false;};
    bool isUndefVal();
    bool isConstZero();
    bool isConstOne();
    int BelongsToExp;
};
using Operand=Value*;
// class Constant:public User
// {};
class User:public Value,public list_node<BasicBlock,User>
{
    using UsePtr=std::unique_ptr<Use>;
    protected:
    std::vector<UsePtr> uselist;
    public:
    void add_use(Value* __data);
    virtual void print()=0;
    User();
    User(Type* tp);
    virtual Operand GetDef();
    void ClearRelation();//在EraseFromBasic()前调用
    std::vector<UsePtr>& Getuselist(){return this->uselist;}
    bool CanDel = false;
    bool IsTerminateInst();
};

class ConstantData:public Value
{
    public:
    ConstantData()=delete;
    ConstantData(Type* tp);
    bool isConst()final{return true;}
};

class ConstIRBoolean:public ConstantData
{
    bool val;
    ConstIRBoolean(bool);
    public:
    static ConstIRBoolean* GetNewConstant(bool=false);
    bool GetVal();
};

class ConstIRInt:public ConstantData
{
    int val;
    ConstIRInt(int);
    public:
    static ConstIRInt* GetNewConstant(int=0);
    int GetVal();
};

class ConstIRFloat:public ConstantData
{
    float val;
    ConstIRFloat(float);
    public:
    static ConstIRFloat* GetNewConstant(float=0);
    float GetVal();
    double GetValAsDouble() const { return static_cast<double>(val);}
};

class ConstPtr:public ConstantData
{
    ConstPtr(Type*);
    public:
    static ConstPtr* GetNewConstant(Type*);
};
