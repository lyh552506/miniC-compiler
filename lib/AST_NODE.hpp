#pragma once
#include <memory>
#include "List.hpp"
#include <list>
#include <string>
#include <iostream>
#include <cxxabi.h>
#include <cassert>
#include "MagicEnum.hpp"
#include "CFG.hpp"

enum AST_Type
{
    AST_INT,AST_FLOAT,AST_VOID,AST_ADD,AST_SUB,AST_MUL,AST_MODULO,AST_DIV,AST_GREAT,AST_GREATEQ,AST_LESS,AST_LESSEQ,AST_EQ,AST_ASSIGN,AST_NOTEQ,AST_NOT,AST_AND,AST_OR,
};

class AST_NODE;
class CompUnit;
template<typename T>
class Grammar_Assistance;
class ConstDecl;
class ConstDefs;
template <typename T>class InnerBaseExps;
class InitVal;
class InitVals;
class VarDecl;
class VarDefs;
class FuncDef;
class FuncParams;
class FuncParam;
class Block;
class BlockItems;
class AssignStmt;
class ExpStmt;
class WhileStmt;
class IfStmt;
class BreakStmt;
class ContinueStmt;
class ReturnStmt;
class LVal;
template<typename T>class BaseExp;
class FunctionCall;
template<typename T>class ConstValue;
template<typename T>class BaseDef;
using Owner=std::unique_ptr<AST_NODE>;
using Exps=InnerBaseExps<void>;
using CallParams=InnerBaseExps<int>;
using PrimaryExp=Grammar_Assistance<int>;
using UnaryExp=BaseExp<PrimaryExp>;//+-+-+!- primary
using MulExp=BaseExp<UnaryExp>;//*
using AddExp=BaseExp<MulExp>;//+ -
using RelExp=BaseExp<AddExp>;//> < >= <=
using EqExp=BaseExp<RelExp>;//==
using LAndExp=BaseExp<EqExp>;//&&
using LOrExp=BaseExp<LAndExp>;//||
using Decl=Grammar_Assistance<char>;
using BlockItem=Grammar_Assistance<void>; 
using VarDef=BaseDef<int>;
using ConstDef=BaseDef<void>;
using Stmt=AST_NODE;

/// @brief 最基础的AST_NODE，所有基础特性都应该放里面
class AST_NODE 
{
    /// @todo 可以加个enum type 表示这个是什么type，但是貌似 C++ 现在支持动态判定类型,指typeid
    public:
    virtual void codegen(){
        std::cerr<<"In AST some nodes are forbidden to call codegen()\n";
        assert(0);
    };
    virtual void print(int x)
    {
        for(int i=0;i<x;i++)std::cout<<"  ";
        
        int status;
        char* demangled_name = abi::__cxa_demangle(typeid(*this).name(), 0, 0, &status);
        assert(status==0);
        std::cout<<demangled_name;
        free(demangled_name);
    }
};

/// @brief 由某种表达式和运算符构建起来的链表
template<typename T>
class BaseExp:public AST_NODE
{
    private:
    std::list<AST_Type> oplist;
    List<T> ls;
    public:
    BaseExp(T* _data){
        ls.push_back(_data);
    }
    void push_back(AST_Type tp){
        oplist.push_back(tp);
    }
    void push_front(AST_Type tp){
        oplist.push_front(tp);
    }
    void push_back(T* data){
        ls.push_back(data);
    }
    void push_front(T* data){
        ls.push_front(data);
    }
    void print(int x) final {
        AST_NODE::print(x);
        std::cout<<'\n';
    }
    Operand GetOperand(){
        /// UnaryExp 是一元操作符，单独取出来研究
        if constexpr(std::is_same_v<T,PrimaryExp>){
            /// @note 可以优化？
            //num=!x equals to num=(x==0)?1:0;
            //num=+x useless 没人翻译
            //num=-x 字面意思
            T* data=ls.front();
            Operand ptr=data.GetOperand();
            for(auto i=oplist.rbegin();i!=oplist.rend();i++){
                switch (*i)
                {
                case AST_NOT:
                    ptr=Singleton<Module>().GenerateBinaryInst(0,BinaryInst::Op_Sub,ptr);
                    break;
                case AST_ADD:
                    break;
                case AST_SUB:
                    ptr=Singleton<Module>().GenerateBinaryInst(0,BinaryInst::Op_Sub,ptr);
                    break;
                default:
                    assert(0);
                    std::cerr<<"Wrong Operator in BinaryExp\n";
                    break;
                }
            }
        }
        else{
            /// @note 其他都是二元操作符

        }
    }
};

template<typename T>
class InnerBaseExps:public AST_NODE
{
    List<AddExp> ls;
    public:
    InnerBaseExps(AddExp* _data){
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
    std::vector<size_t> ConstValGet(){
        ///@todo 数组声明会用到
        static_assert(0);
        return vector<size_t>();
    }
    void print(int x) final {
        AST_NODE::print(x);
        std::cout<<'\n';
        for(auto &i:ls)i.print(x+1);
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
    InitVal(AST_NODE* _data){
        val.reset(_data);
    }
    void print(int x) final {
        AST_NODE::print(x);
        if(val==nullptr)
            std::cout<<":empty{}\n";
        else
            std::cout<<'\n',val->print(x+1);
    }
    void DealInitVal(Variable* structure){
        if(val==nullptr){
            ///@todo notice it's a empty initialize
            assert(0);
        }
        else if(InitVals* ivs=dynamic_cast<InitVals*>(val.get())){
            ///@todo 是个数组的初始化
            assert(0);
        }
        else if(AddExp* exp=dynamic_cast<AddExp*>(val.get())){
            assert(0);
        }
        else{
            assert(0);
        }
    }
};

template<typename T>
class BaseDef:public AST_NODE
{
    private:
    std::string ID;
    std::unique_ptr<Exps> array_descripters; 
    std::unique_ptr<InitVal> civ;
    public:
    BaseDef(std::string _id,Exps* _ad=nullptr,InitVal* _iv=nullptr):ID(_id),array_descripters(_ad),civ(_iv){}
    BaseDef(const BaseDef<T>&)=default;
    void codegen() final {
        // Singleton<InnerDataType>()
        if(array_descripters!=nullptr)
        {
            // Singleton<Module>().Generate(new IRArray(array_descripters->ConstValGet()));
            std::cerr<<"Array Not Implenmented!\n";
            assert(0);
        }
        else
        {
            /// @todo impl initval
            if(civ!=nullptr)std::cerr<<"InitVal not implemented!n";
            assert(civ==nullptr);
            auto tmp=new Variable(ID);
            Singleton<Module>().GenerateAlloca(tmp);
        }
    }
    void print(int x) final {
        AST_NODE::print(x);
        std::cout<<":"<<ID<<'\n';
        if(array_descripters!=nullptr)array_descripters->print(x+1);
        if(civ!=nullptr)civ->print(x+1);
    }
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
        for(auto&i:ls)
            i->codegen();
    }
    void print(int x) final {
        AST_NODE::print(x);
        std::cout<<'\n';
        for(auto &i:ls){
            i->print(x+1);
        }
    }
};

/// @brief 辅助语法单元，可能为几个中的一种,存一个AST_NODE*指针就好
template<typename T>
class Grammar_Assistance:public AST_NODE
{
    private:
    Owner ptr;
    public:
    Grammar_Assistance(AST_NODE* _ptr){
        ptr.reset(_ptr);   
    }
    void codegen() final {
        ptr->codegen();
    }
    void print(int x) final {
        ptr->print(x);
    }
    AST_NODE* GetPtr(){return ptr.get();}
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
        for(auto &i:ls)i->codegen();
    }
    void print(int x) final {
        for(auto &i:ls)i->print(x);
    }
};

class ConstDecl:public AST_NODE
{
    private:
    /// @brief  for float,1 for int
    AST_Type type;
    std::unique_ptr<ConstDefs> cdfs;
    public:
    ConstDecl(AST_Type tp,ConstDefs* content):type(tp),cdfs(content){
    }
    void codegen() final {
        /// @warning copy from VarDecl
        switch (type)
        {
        case AST_INT:
            Singleton<InnerDataType>()=IR_Value_INT;
            break;
        case AST_FLOAT:
            Singleton<InnerDataType>()=IR_Value_Float;
            break;
        case AST_VOID:
        default:
            std::cerr<<"void as variable is not allowed!\n";
            assert(0);
        }
        cdfs->codegen();
    }
    void print(int x) final {
        AST_NODE::print(x);
        std::cout<<":TYPE:"<<magic_enum::enum_name(type)<<'\n';
        cdfs->print(x+1);
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
    void print(int x) final{
        AST_NODE::print(x);
        std::cout<<'\n';
        for(auto &i:ls)i->print(x+1);
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
        for(auto&i:ls)
            i->codegen();
    }
    void print(int x) final{
        for(auto &i:ls)i->print(x);
    }
};

class VarDecl:public AST_NODE
{
    private:
    AST_Type type;
    std::unique_ptr<VarDefs> vdfs;
    public:
    VarDecl(AST_Type tp,VarDefs* ptr):type(tp),vdfs(ptr){}
    void codegen() final{
        switch (type)
        {
        case AST_INT:
            Singleton<InnerDataType>()=IR_Value_INT;
            break;
        case AST_FLOAT:
            Singleton<InnerDataType>()=IR_Value_Float;
            break;
        case AST_VOID:
        default:
            std::cerr<<"void as variable is not allowed!\n";
            assert(0);
        }
        vdfs->codegen();
    }
    void print(int x) final{
        AST_NODE::print(x);
        std::cout<<":"<<magic_enum::enum_name(type)<<'\n';
        vdfs->print(x+1);
    }
};

class FuncParam:public AST_NODE
{
    private:
    AST_Type tp;
    std::string ID;
    bool emptySquare;
    std::unique_ptr<Exps> array_subscripts;
    public:
    FuncParam(AST_Type _tp,std::string _id,bool is_empty=false,Exps* ptr=nullptr):tp(_tp),ID(_id),emptySquare(is_empty),array_subscripts(ptr){}
    void GetVariable(Function& tmp){
        auto get_type=[](AST_Type _tp){
            switch(_tp)
            {
                case AST_INT:
                    return InnerDataType::IR_Value_INT;
                case AST_FLOAT:
                    return InnerDataType::IR_Value_Float;
                default:
                    std::cerr<<"Wrong Type\n";
                    assert(0);
            }
        };
        tmp.push_param(new Variable(get_type(tp),ID));
    }
    void print(int x) final {
        AST_NODE::print(x);
        std::cout<<":"<<magic_enum::enum_name(tp);
        if(emptySquare==1)std::cout<<"ptr";
        std::cout<<ID;
        if(array_subscripts!=nullptr)array_subscripts->print(x+1);
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
    void GetVariable(Function& tmp){
        for(auto &i:ls)
            i->GetVariable(tmp);
        return;
    }
    void print(int x) final {
        for(auto &i:ls)i->print(x);
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
    void GetInst(Function& f){
        for(auto &i:ls){
            auto tmp=i->GetPtr();
            //BlockItem可能是Decl(Grammar_Assistance<char>)
            //或者AssignStmt ExpStmt Block WhileStmt
            //IfStmt BreakStmt ContinueStmt ReturnStmt
            if(auto dEcl=dynamic_cast<Decl*>(tmp)){

            }
            else if(auto assign=dynamic_cast<AssignStmt*>(tmp)){

            }
            else if(auto expstmt=dynamic_cast<ExpStmt*>(tmp)){

            }
            else if(auto whilestmt=dynamic_cast<WhileStmt*>(tmp)){

            }
            else if(auto ifstmt=dynamic_cast<IfStmt*>(tmp)){

            }
            else if(auto breakstmt=dynamic_cast<BreakStmt*>(tmp)){

            }
            else if(auto continuestmt=dynamic_cast<ContinueStmt*>(tmp)){

            }
            else assert(0);
        }
    }
    void print(int x) final {
        AST_NODE::print(x);
        std::cout<<'\n';
        for(auto &i:ls)i->print(x+1);
    }
};

class Block:public AST_NODE
{
    private:
    std::unique_ptr<BlockItems> items;
    public:
    Block(BlockItems* ptr):items(ptr){}
    void GetInst(Function& tmp){
        items->GetInst(tmp);
    }
    void print(int x) final {
        items->print(x);
    }
};

class FuncDef:public AST_NODE
{
    AST_Type tp;
    std::string ID;
    std::unique_ptr<FuncParams> params;
    std::unique_ptr<Block> function_body;
    public:
    FuncDef(AST_Type _tp,std::string _id,FuncParams* ptr,Block* fb):tp(_tp),ID(_id),params(ptr),function_body(fb){}
    void codegen() final{
        auto get_type=[](AST_Type _tp){
            switch(_tp)
            {
                case AST_INT:
                    return InnerDataType::IR_Value_INT;
                case AST_FLOAT:
                    return InnerDataType::IR_Value_Float;
                case AST_VOID:
                    return InnerDataType::IR_Value_VOID;
                default:
                    std::cerr<<"Wrong Type\n";
                    assert(0);
            }
        };
        auto& f=Singleton<Module>().GenerateFunction(get_type(tp),ID);
        Singleton<Module>().layer_increase();
        if(params!=nullptr)params->GetVariable(f);
        assert(function_body!=nullptr);
        function_body->GetInst(f);
        Singleton<Module>().layer_decrease();
    }
    void print(int x) final {
        AST_NODE::print(x);
        std::cout<<":"<<ID<<":"<<magic_enum::enum_name(tp)<<'\n';
        if(params!=nullptr)params->print(x+1);
        function_body->print(x+1);
    }
};

class LVal:public AST_NODE
{
    private:
    std::string ID;
    std::unique_ptr<Exps> array_descripters;
    public:
    LVal(std::string _id,Exps* ptr=nullptr):ID(_id),array_descripters(ptr){}
    void codegen() final{
        ///@todo impl codegen
    }
    void print(int x) final {
        AST_NODE::print(x);
        if(array_descripters!=nullptr)std::cout<<":with array descripters";
        std::cout<<":"<<ID<<'\n';
        if(array_descripters!=nullptr)array_descripters->print(x+1);
    }
};

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
    void print(int x) final {
        AST_NODE::print(x);
        std::cout<<'\n';
        assert(lv!=nullptr);
        lv->print(x+1);
        exp->print(x+1);   
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
    void print(int x) final {
        if(exp==nullptr)AST_NODE::print(x);
        else exp->print(x);
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
    void print(int x) final {
        AST_NODE::print(x);
        std::cout<<'\n';
        assert(condition!=nullptr&&stmt!=nullptr);
        condition->print(x+1);
        stmt->print(x+1);
    }
};

class IfStmt:public AST_NODE
{
    private:
    std::unique_ptr<LOrExp> condition;
    std::unique_ptr<Stmt> t,f;
    public:
    IfStmt(LOrExp* p0,Stmt* p1,Stmt* p2=nullptr):condition(p0),t(p1),f(p2){}
    void codegen() final{
        ///@todo impl codegen
    }
    void print(int x) final {
        AST_NODE::print(x);
        std::cout<<'\n';
        assert(t!=nullptr);
        t->print(x+1);
        if(f!=nullptr)f->print(x+1);
    }
}; 

/// @brief 这个很奇怪，因为break和continue本身就代表了一种信息
class BreakStmt:public AST_NODE
{
    void codegen() final{
        ///@todo impl codegen
    }
    void print(int x) final {
        AST_NODE::print(x);std::cout<<'\n';
    }
};

class ContinueStmt:public AST_NODE
{
    void codegen() final{
        ///@todo impl codegen
    }
    void print(int x) final {
        AST_NODE::print(x);std::cout<<'\n';
    }
};

class ReturnStmt:public AST_NODE
{
    std::unique_ptr<AddExp> return_val;
    public:
    ReturnStmt(AddExp* ptr=nullptr):return_val(ptr){}
    void codegen() final{
        ///@todo impl codegen
    }
    void print(int x) final {
        AST_NODE::print(x);std::cout<<'\n';
        if(return_val!=nullptr)return_val->print(x+1);
    }
};

class FunctionCall:public AST_NODE
{
    std::string id;
    std::unique_ptr<CallParams> cp;
    public:
    FunctionCall(std::string _id,CallParams* ptr=nullptr):id(_id),cp(ptr){}
    void codegen() final{
        ///@todo impl codegen
    }
    void print(int x) final {
        AST_NODE::print(x);
        std::cout<<id;
        if(cp!=nullptr)cp->print(x+1);
    }
};

template<typename T>
class ConstValue:public AST_NODE
{
    T data;
    public:
    ConstValue(T _data):data(_data){}
    void codegen() final{

    }
};