#pragma once
#include "AST_NODE.h"
#include "List.hpp"
#include <list>
#include <string>

/// @todo 这个应该在Lexer.hpp里面
enum Type
{
    T_int,T_float,T_void
};

/// @brief 最基础的AST_NODE，所有基础特性都应该放里面
class AST_NODE 
{
    /// @todo 可以加个enum type 表示这个是什么type，但是貌似 C++ 现在支持动态判定类型,指typeid
    public:
    virtual void codegen()=0;
};

/// @brief CompUnit是一个由Decl和FuncDef组成的链表，链表里面是AST_NODE*
class CompUnit:public AST_NODE
{
    private:
    List<AST_NODE> ls;
    public:
    CompUnit(AST_NODE* __data){
        push_back(__data);
    }
    void push_front(AST_NODE* __data){
        ls.push_front(__data);
    }
    void push_back(AST_NODE* __data){
        ls.push_back(__data);
    }
    void codegen() final {
        /// @todo 实现codegen
    }
};

/// @brief 辅助语法单元，可能为几个中的一种,存一个AST_NODE*指针就好
class Grammar_Assistance:public AST_NODE
{
    private:
    Owner ptr;
    public:
    Grammar_Assistance(AST_NODE* _ptr){
        ptr.reset(_ptr);   
    }
    void codegen() final {
        /// @todo 实现codegen
    }
};

using Decl=Grammar_Assistance;

class ConstDecl:public AST_NODE
{
    private:
    /// @brief  for float,1 for int
    Type type;
    std::unique_ptr<ConstDefs> cdfs;
    public:
    ConstDecl(Type tp,ConstDefs* content):type(tp),cdfs(content){
    }
    void codegen() final {
        /// @todo 实现codegen
    }
};

class ConstDefs:public AST_NODE
{
    List<ConstDef> ls;
    public:
    ConstDefs(ConstDef* __data){
        push_back(__data);
    }
    void push_back(ConstDef* __data){
        ls.push_back(__data);
    }
    void codegen() final{
        ///@todo impl codegen
    }
};

class ConstDef:public AST_NODE
{
    private:
    std::string ID;
    std::unique_ptr<Exps> array_descripters; 
    std::unique_ptr<InitVal> civ;
    public:
    ConstDef(std::string _id,Exps* _ad,InitVal* _iv):ID(_id),array_descripters(_ad),civ(_iv){}
    void codegen() final {
        /// @todo 实现codegen
    }
};

class Exps:public AST_NODE
{
    List<AddExp> ls;
    public:
    Exps(AddExp* _data){
        push_front(_data);
    }
    void push_front(AddExp* _data){
        ls.push_front(_data);
    }
};

/// @brief 由MulExp和乘法运算符构建起来的链表
class AddExp:public AST_NODE
{
    private:
    List<AST_NODE> ls;
    public:
    AddExp(AST_NODE* _data){
        ls.push_back(_data);
    }
    void Merge_back(AST_NODE* op,AST_NODE* next_MulExp){
        ls.push_back(op);
        ls.push_back(next_MulExp);
    }
};

class InitVal:public AST_NODE
{
    private:
    Owner cexp;//解决就是一个ConstExp的情况
    std::list<InitVal> civs;

    public:
    /// @note 注意规约时第四表达式的处理
    
    void codegen() final {
        /// @todo 实现codegen
    }  
};

using InitVals=std::list<InitVal>;

class VarDecl:public AST_NODE
{
    private:
    Type tp;
    VarDefs vdfs;
};

using VarDefs=std::list<VarDef>;

class VarDef:public AST_NODE
{
    std::string ID;
    std::list<AddExp> array_descripters;
    InitVals iv;
    public:
    void codegen() final {
        /// @todo 实现codegen
    }
};

class FuncDef:public AST_NODE
{
    private:
    Type tp;
    std::string ID;
    FuncParams params;
};

using FuncParams=std::list<FuncParam>;

class FuncParam:public AST_NODE
{
    private:
    Type tp;
    std::string ID;
    bool emptySquare;
    std::list<AddExp> array_descripters;
};

class Block:public AST_NODE
{
    private:
    BlockItems items;
};

using BlockItems=std::list<BlockItem>;

using BlockItem=Grammar_Assistance;

using Stmt=Grammar_Assistance;

class AssignStmt:public AST_NODE
{
    private:
    LVal lv;
    AddExp exp;
    public:
};

/// @brief 有点不好处理...
class ExpStmt:public AST_NODE
{
    
};

class WhileStmt:public AST_NODE
{
    private:
    LorExp condition;
    Stmt stmt;
    public:

};

class IfStmt:public AST_NODE
{
    private:
    LorExp condition;
    Stmt t,f;
}; 

/// @brief 记录下一个Stmt的起点
class BreakStmt:public AST_NODE
{

};

class ContinueStmt:public AST_NODE
{

};

class ReturnStmt:public AST_NODE
{

};

class LVal:public AST_NODE
{
    private:
    std::string ID;
    std::list<AddExp> array_descripters;
    public:

};

/// @brief primaryexp中间也包含一下函数调用
using PrimaryExp=Grammar_Assistance;

class UnaryExp:public AST_NODE
{
    private:
    std::list<UnaryOp> oplist;
    PrimaryExp pexp;
};

using CallParams=std::list<AddExp>;

