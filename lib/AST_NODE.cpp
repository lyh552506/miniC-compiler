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
};

class VarDecl:public AST_NODE
{
    private:
    Type tp;
    std::unique_ptr<VarDefs> vdfs;
    public:
    VarDecl(VarDefs* ptr):vdfs(ptr){}
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
};

class Block:public AST_NODE
{
    private:
    std::unique_ptr<BlockItems> items;
    public:
    Block(BlockItems* ptr):items(ptr){}
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
};

/// @brief EmptyStmt直接不给翻译，就是只有';'的那种
class ExpStmt:public AST_NODE
{
    std::unique_ptr<AddExp> exp;
    public:
    ExpStmt(AddExp* ptr):exp(ptr){}
};

class WhileStmt:public AST_NODE
{
    private:
    std::unique_ptr<LorExp> condition;
    std::unique_ptr<Stmt> stmt;
    public:
    WhileStmt(LorExp* p1,Stmt* p2):condition(p1),stmt(p2){}
};

class IfStmt:public AST_NODE
{
    private:
    LorExp condition;
    Stmt t,f;
    public:
    IfStmt(LorExp* p0,Stmt* p1,Stmt* p2):condition(p0),t(p1),f(p2){}
}; 

/// @brief 这个很奇怪，因为break和continue本身就代表了一种信息
class BreakStmt:public AST_NODE
{
    
};

class ContinueStmt:public AST_NODE
{

};

class ReturnStmt:public AST_NODE
{
    std::unique_ptr<AddExp> return_val;
    public:
    ReturnStmt(AddExp* ptr):return_val(ptr){}
};

class LVal:public AST_NODE
{
    private:
    std::string ID;
    std::unique_ptr<Exps> array_descripters;
    public:
    LVal(std::string _id,Exps* ptr):ID(_id),array_descripters(ptr){}
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

