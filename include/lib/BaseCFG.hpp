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
#include <set>
#include <unordered_set>
class User;
class Value;
class BasicBlock;
class Function;
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
    ~Use(){
        RemoveFromUserList(fat);
    };
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
    int size=0;
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
        bool operator==(const iterator& other)const{return ptr==other.ptr;}
        bool operator!=(const iterator& other)const{return ptr!=other.ptr;}
    };
    iterator begin(){return iterator(this->head);}
    iterator end(){return iterator(nullptr);}
    bool is_empty(){return head==nullptr;}
    Use*& Front(){return head;}
    Use* back() {
        if (is_empty()) {
            return nullptr;
        }
        Use* current = head;
        while (current->nxt != nullptr) {
            current = current->nxt;
        }
        return current;
    }
    int& GetSize(){return size;}
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
    virtual Value* clone(std::unordered_map<Value*,Value*>&);
    /// @warning Value的析构应该反着来，如果userlist没有析构，那么就先析构userlist
    virtual ~Value();
    Value()=delete;
    Value(Type*);
    void print();
    InnerDataType GetTypeEnum();
    virtual Type* GetType();
    bool Negative_tag = false;
    bool Change = false;
    void SetType(Type* _ty){ tp = _ty;}
    void add_user(Use* __data);
    virtual bool isConst(){return false;}
    void RAUW(Value* val); //ReplaceAllUseWith
    void SetName(std::string newname);
    virtual std::string GetName();
    UserList& GetUserlist(){return userlist;};
    virtual bool isGlobal();
    virtual inline bool isParam(){return false;};
    bool isUndefVal();
    bool isConstZero();
    bool isConstOne();
    int GetUserListSize(){return GetUserlist().GetSize();}
    std::unordered_set<Function*> ReadFunc;
    template<typename T>
    T* as(){return dynamic_cast<T*>(this);}
};
using Operand=Value*;
// class Constant:public User
// {};
class User:public Value,public list_node<BasicBlock,User>
{
  public:
    enum OpID
    {
        None,
        // Terminators
        UnCond,
        Cond,
        Ret,
        // Memory
        Alloca,
        Load,
        Store,
        Memcpy,
        // Binary
        Add,
        Sub,
        Mul,
        Div,
        Mod,
        And,
        Or,
        Xor,
        Eq,
        Ne,
        Ge,
        L,
        Le,
        G,
        // Other
        Gep,
        Phi,
        Call,
        Zext,
        Sext,
        Trunc,
        FP2SI,
        SI2FP,
        BinaryUnknown,
        Max,
        Min,
        Select
    };
    OpID id;
    using UsePtr=std::unique_ptr<Use>;
    protected:
    std::vector<UsePtr> uselist;
    public:
    void add_use(Value* __data);
    virtual void print()=0;
    virtual ~User()=default;
    User();
    User(Type* tp);
    virtual Value* clone(std::unordered_map<Operand,Operand>&)override;
    virtual Operand GetDef();
    void ClearRelation();//在EraseFromBasic()前调用
    bool IsTerminateInst();
    bool IsCondInst();
    bool IsUncondInst();
    bool IsBinary();
    std::vector<UsePtr>& Getuselist(){return this->uselist;}
    int GetUseIndex(Use* Op);
    inline Operand GetOperand(int i){return uselist[i]->GetValue();}
    bool Alive = false;
    bool HasSideEffect();
    void RSUW(int,Operand);
    void RSUW(Use* u,Operand);
    inline OpID GetInstId(){ return id; }
    void FullReplace(User*);
    User* CloneInst();   //此处是复制一个全新的
};

class ConstantData:public Value
{
    public:
    virtual ConstantData* clone(std::unordered_map<Operand,Operand>&)override;
    ConstantData()=delete;
    ConstantData(Type* tp);
    static ConstantData* getNullValue(Type* tp);
    bool isConst()final{return true;}
    bool isZero();
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

class ConstSize_t:public ConstantData
{
    size_t val;
    ConstSize_t(size_t);
    public:
    static ConstSize_t* GetNewConstant(size_t=0);
    size_t GetVal();
};
