#pragma once
#include "AST_NODE.h"
#include "List.hpp"
/// @todo 这个东西应该包含的是Lexer的定义头
#include "yytokentype.hpp"
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

using ConstDef=VarDef;

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
    void push_back(AddExp* _data){
        ls.push_back(_data);
    }
    void codegen() final{
        ///@todo impl codegen
    }
};

class InitVal:public AST_NODE
{
    private:
    /// nullptr:{}
    /// AddExp
    /// ConstInitVals
    Owner val;
    public:
    /// @brief InitVal:{}
    InitVal()=default;
    /// @brief InitVal:ConstExp
    InitVal(AST_NODE* _data):val(_data){}
    void codegen() final {
        /// @todo 实现codegen
    }  
};

class InitVals:public AST_NODE
{
    List<InitVal> ls;
    public:
    InitVals(InitVal* _data){
        ls.push_back(_data);
    }
    void push_back(InitVal* _data){
        ls.push_back(_data);
    }
    void codegen() final{
        ///@todo impl codegen
    }
};

class VarDecl:public AST_NODE
{
    private:
    Type tp;
    std::unique_ptr<VarDefs> vdfs;
    public:
    VarDecl(VarDefs* ptr):vdfs(ptr){}
    void codegen() final{
        ///@todo impl codegen
    }
};

class VarDefs:public AST_NODE
{
    List<VarDef> ls;
    public:
    VarDefs(VarDef* vdf){
        push_back(vdf);
    }
    void push_back(VarDef* _data){
        ls.push_back(_data);
    }
    void codegen() final{
        ///@todo impl codegen
    }
};

class VarDef:public AST_NODE
{
    private:
    std::string ID;
    std::unique_ptr<Exps> array_descripters; 
    std::unique_ptr<InitVal> civ;
    public:
    VarDef(std::string _id,Exps* _ad,InitVal* _iv):ID(_id),array_descripters(_ad),civ(_iv){}
    void codegen() final {
        /// @todo 实现codegen
    }
};

class FuncDef:public AST_NODE
{
    Type tp;
    std::string ID;
    std::unique_ptr<FuncParams> params;
    FuncDef(Type _tp,std::string _id,FuncParams* ptr):tp(_tp),ID(_id),params(ptr){}
    void codegen() final{
        ///@todo impl codegen
    }
};

class FuncParams:public AST_NODE
{
    List<FuncParam> ls;
    public:
    FuncParams(FuncParam* ptr){
        ls.push_back(ptr);
    }
    void push_back(FuncParam* ptr){
        ls.push_back(ptr);
    }
    void codegen() final{
        ///@todo impl codegen
    }
};

class FuncParam:public AST_NODE
{
    private:
    Type tp;
    std::string ID;
    bool emptySquare;
    std::unique_ptr<Exps> array_subscripts;
    public:
    FuncParam(Type _tp,std::string _id,bool is_empty,Exps* ptr):tp(_tp),ID(_id),emptySquare(is_empty),array_subscripts(ptr){}
    void codegen() final{
        ///@todo impl codegen
    }
};

class Block:public AST_NODE
{
    private:
    std::unique_ptr<BlockItems> items;
    public:
    Block(BlockItems* ptr):items(ptr){}
    void codegen() final{
        ///@todo impl codegen
    }
};

class BlockItems:public AST_NODE
{
    List<BlockItem> ls;
    public:
    BlockItems(BlockItem* ptr){
        push_back(ptr);
    }
    void push_back(BlockItem* ptr){
        ls.push_back(ptr);
    }
    void codegen() final{
        ///@todo impl codegen
    }
};

using BlockItem=Grammar_Assistance; 

using Stmt=Grammar_Assistance;

class AssignStmt:public AST_NODE
{
    private:
    std::unique_ptr<LVal> lv;
    std::unique_ptr<AddExp> exp;
    public:
    AssignStmt(LVal* p1,AddExp* p2):lv(p1),exp(p2){}
    void codegen() final{
        ///@todo impl codegen
    }
};

/// @brief EmptyStmt直接不给翻译，就是只有';'的那种
class ExpStmt:public AST_NODE
{
    std::unique_ptr<AddExp> exp;
    public:
    ExpStmt(AddExp* ptr):exp(ptr){}
    void codegen() final{
        ///@todo impl codegen
    }
};

class WhileStmt:public AST_NODE
{
    private:
    std::unique_ptr<LOrExp> condition;
    std::unique_ptr<Stmt> stmt;
    public:
    WhileStmt(LOrExp* p1,Stmt* p2):condition(p1),stmt(p2){}
    void codegen() final{
        ///@todo impl codegen
    }
};

class IfStmt:public AST_NODE
{
    private:
    std::unique_ptr<LOrExp> condition;
    Stmt t,f;
    public:
    IfStmt(LOrExp* p0,Stmt* p1,Stmt* p2):condition(p0),t(p1),f(p2){}
    void codegen() final{
        ///@todo impl codegen
    }
}; 

/// @brief 这个很奇怪，因为break和continue本身就代表了一种信息
class BreakStmt:public AST_NODE
{
    void codegen() final{
        ///@todo impl codegen
    }
};

class ContinueStmt:public AST_NODE
{
    void codegen() final{
        ///@todo impl codegen
    }
};

class ReturnStmt:public AST_NODE
{
    std::unique_ptr<AddExp> return_val;
    public:
    ReturnStmt(AddExp* ptr):return_val(ptr){}
    void codegen() final{
        ///@todo impl codegen
    }
};

class LVal:public AST_NODE
{
    private:
    std::string ID;
    std::unique_ptr<Exps> array_descripters;
    public:
    LVal(std::string _id,Exps* ptr):ID(_id),array_descripters(ptr){}
    void codegen() final{
        ///@todo impl codegen
    }
};

/// @brief primaryexp中间也包含一下函数调用
using PrimaryExp=Grammar_Assistance;

class FunctionCall:public AST_NODE
{
    std::string id;
    std::unique_ptr<CallParams> cp;
    public:
    FunctionCall(std::string _id,CallParams* ptr):id(_id),cp(ptr){}
    void codegen() final{
        ///@todo impl codegen
    }
};

using CallParams=Exps;

/// @brief 由某种表达式和运算符构建起来的链表
template<typename T>
class BaseExp:public AST_NODE
{
    private:
    std::list<yytokentype> oplist;
    List<T> ls;
    public:
    BaseExp(T* _data){
        ls.push_back(_data);
    }
    void Merge_back(yytokentype op,T* next_MulExp){
        oplist.push_back(op);
        ls.push_back(next_MulExp);
    }
    void codegen() final {
        ///@todo
    }
};

using UnaryExp=BaseExp<PrimaryExp>;
using MulExp=BaseExp<UnaryExp>;
using AddExp=BaseExp<MulExp>;
using RelExp=BaseExp<AddExp>;
using EqExp=BaseExp<RelExp>;
using LAndExp=BaseExp<EqExp>;
using LOrExp=BaseExp<LAndExp>;