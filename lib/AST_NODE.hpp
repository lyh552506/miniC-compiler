#pragma once
#include <memory>
#include "List.hpp"
#include <list>
#include <string>
#include <cassert>
#include "MagicEnum.hpp"
#include "CFG.hpp"

// extern int yylineno;

enum AST_Type
{
    AST_INT,AST_FLOAT,AST_VOID,AST_ADD,AST_SUB,AST_MUL,AST_MODULO,AST_DIV,AST_GREAT,AST_GREATEQ,AST_LESS,AST_LESSEQ,AST_EQ,AST_ASSIGN,AST_NOTEQ,AST_NOT,AST_AND,AST_OR,
};

class AST_NODE;
class CompUnit;//codegen, acquire what's in list has codegen
class Grammar_Assistance;
class ConstDecl;//codegen(CompUnit) GetInst
class ConstDefs;//codegen(CompUnit) GetInst
class InnerBaseExps;//
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
class BaseDef;

class LocType
{
    public:
    int begin;
    int end;
    void SET(const LocType&);
    LocType();
    LocType(int);
    LocType& operator=(const LocType&)=default;
};

struct GetInstState
{
    BasicBlock* current_building;
    BasicBlock* break_block;
    BasicBlock* continue_block;
};

/// @brief 最基础的AST_NODE，所有基础特性都应该放里面
class AST_NODE:public LocType
{
    /// @todo 可以加个enum type 表示这个是什么type，但是貌似 C++ 现在支持动态判定类型,指typeid
    public:
    virtual ~AST_NODE()=default;
    virtual void codegen();
    virtual void print(int x);
};
class HasOperand:public AST_NODE
{
    public:
    virtual Operand GetOperand(BasicBlock* block)=0;
};
class Stmt:public AST_NODE
{
    public:
    /// @return 如果这个GetInst已经用到了下一个BasicBlock，则让GetInst自己创建，让后通过返回值修改 block=xx->GetInst(block,exit);
    virtual BasicBlock* GetInst(GetInstState)=0;
};
/// @brief 由某种表达式和运算符构建起来的链表
template<typename T>
class BaseExp:public HasOperand
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
        // AST_NODE::print(x);
        // std::cout<<'\n';
        if(!oplist.empty()){
            for(int i=0;i<x;i++)std::cout<<"  ";
            std::cout<<magic_enum::enum_name(oplist.front())<<" Level Expression\n";
        }
        for(auto&i:ls)i->print(x+!oplist.empty());
    }
    void GetOperand(BasicBlock* block,BasicBlock* is_true,BasicBlock* is_false){
        std::cerr<<"Only prepare for short circuit\n";
        assert(0);
    }
    Operand GetOperand(BasicBlock* block) final{
        /// UnaryExp 是一元操作符，单独取出来研究
        if constexpr(std::is_same_v<T,HasOperand>){
            /// @note 可以优化？
            //num=!x equals to num=(x==0)?1:0;
            //num=+x useless 没人翻译
            //num=-x 字面意思
            Operand ptr=ls.front()->GetOperand(block);
            for(auto i=oplist.rbegin();i!=oplist.rend();i++){
                switch (*i)
                {
                case AST_NOT:
                    switch(ptr->GetType()->GetTypeEnum())
                    {
                        case IR_Value_INT:
                            if(dynamic_cast<BoolType*>(ptr->GetType()))
                                ptr=BasicBlock::GenerateBinaryInst(block,ptr,BinaryInst::Op_E,ConstIRBoolean::GetNewConstant());
                            else
                                ptr=BasicBlock::GenerateBinaryInst(block,ptr,BinaryInst::Op_E,ConstIRInt::GetNewConstant());
                            break;
                        case IR_Value_Float:ptr=BasicBlock::GenerateBinaryInst(block,ConstIRFloat::GetNewConstant(),BinaryInst::Op_E,ptr);break;
                        case IR_PTR:ptr=BasicBlock::GenerateBinaryInst(block,ConstPtr::GetNewConstant(ptr->GetType()),BinaryInst::Op_E,ptr);break;
                        default:assert(0);
                    }
                case AST_ADD:
                    break;
                case AST_SUB:
                    // if(dynamic_cast<BoolType*>(ptr->GetType()))break;
                    if(ptr->GetType()->GetTypeEnum()==IR_Value_INT)
                        ptr=BasicBlock::GenerateBinaryInst(block,ConstIRInt::GetNewConstant(),BinaryInst::Op_Sub,ptr);
                    else 
                        ptr=BasicBlock::GenerateBinaryInst(block,ConstIRFloat::GetNewConstant(),BinaryInst::Op_Sub,ptr);
                    break;
                default:
                    assert(0);
                    std::cerr<<"Wrong Operator in BinaryExp\n";
                    break;
                }
            }
            return ptr;
        }
        else{
            /// @note 其他都是二元操作符
            auto i=ls.begin();
            auto oper=(*i)->GetOperand(block);
            for(auto &j:oplist){
                i++;
                auto another=(*i)->GetOperand(block);
                BinaryInst::Operation opcode;
                switch (j)
                {
                case AST_ADD:opcode=BinaryInst::Op_Add;break;
                case AST_SUB:opcode=BinaryInst::Op_Sub;break;
                case AST_DIV:opcode=BinaryInst::Op_Div;break;
                case AST_MUL:opcode=BinaryInst::Op_Mul;break;
                case AST_EQ:opcode=BinaryInst::Op_E;break;
                case AST_AND:opcode=BinaryInst::Op_And;break;
                case AST_GREAT:opcode=BinaryInst::Op_G;break;
                case AST_LESS:opcode=BinaryInst::Op_L;break;
                case AST_GREATEQ:opcode=BinaryInst::Op_GE;break;
                case AST_LESSEQ:opcode=BinaryInst::Op_LE;break;
                case AST_MODULO:opcode=BinaryInst::Op_Mod;break;
                case AST_NOTEQ:opcode=BinaryInst::Op_NE;break;
                case AST_OR:opcode=BinaryInst::Op_Or;break;
                default:
                    std::cerr<<"No such Opcode\n";
                    assert(0);
                }
                oper=BasicBlock::GenerateBinaryInst(block,oper,opcode,another);
            }
            return oper;
        }
    }
};

using UnaryExp=BaseExp<HasOperand>;//+-+-+!- primary
using MulExp=BaseExp<UnaryExp>;//*
using AddExp=BaseExp<MulExp>;//+ -
using RelExp=BaseExp<AddExp>;//> < >= <=

template<>
inline Operand BaseExp<RelExp>::GetOperand(BasicBlock* block){
    auto i=ls.begin();
    auto oper=(*i)->GetOperand(block);
    if(oplist.size()==0&&oper->GetType()!=BoolType::NewBoolTypeGet()){
        switch(oper->GetType()->GetTypeEnum())
        {
            case IR_PTR:oper=block->GenerateBinaryInst(block,oper,BinaryInst::Op_NE,ConstPtr::GetNewConstant(oper->GetType()));break;
            case IR_Value_INT:oper=block->GenerateBinaryInst(block,oper,BinaryInst::Op_NE,ConstIRInt::GetNewConstant());break;
            case IR_Value_Float:oper=block->GenerateBinaryInst(block,oper,BinaryInst::Op_NE,ConstIRFloat::GetNewConstant());break;
            default:assert(0);
        }
        return oper;
    }
    for(auto &j:oplist){
        i++;
        auto another=(*i)->GetOperand(block);
        BinaryInst::Operation opcode;
        switch (j)
        {
        case AST_EQ:opcode=BinaryInst::Op_E;break;
        case AST_NOTEQ:opcode=BinaryInst::Op_NE;break;
        default:
            std::cerr<<"Wrong Opcode for EqExp\n";
            assert(0);
        }
        oper=BasicBlock::GenerateBinaryInst(block,oper,opcode,another);
    }
    return oper;
}

using EqExp=BaseExp<RelExp>;//==

template<>
inline void BaseExp<EqExp>::GetOperand(BasicBlock* block,BasicBlock* is_true,BasicBlock* is_false){
    for(auto &i:ls){
        auto tmp=i->GetOperand(block);
        if(auto Const=dynamic_cast<ConstIRBoolean*>(tmp)){
            if(Const->GetVal()==true){
                if(i.get()!=ls.back().get())continue;
                else{
                    block->GenerateUnCondInst(is_true);
                    return;
                }
            }
            else{
                block->GenerateUnCondInst(is_false);
                return;
            }
        }
        if(i.get()!=ls.back().get()){
            auto nxt_building=block->GenerateNewBlock();
            block->GenerateCondInst(tmp,nxt_building,is_false);
            block=nxt_building;
        }
        else block->GenerateCondInst(tmp,is_true,is_false);
    }
}

using LAndExp=BaseExp<EqExp>;//&&

template<>
inline void BaseExp<LAndExp>::GetOperand(BasicBlock* block,BasicBlock* is_true,BasicBlock* is_false){
    for(auto &i:ls){
        if(i.get()!=ls.back().get()){
            auto nxt_building=block->GenerateNewBlock();
            i->GetOperand(block,is_true,nxt_building);
            if(!nxt_building->GetUserlist().is_empty())
                block=nxt_building;
            else{
                /// @note 说明直接短路到is_true，可以结束了
                nxt_building->EraseFromParent();
                return;
            }
        }
        else i->GetOperand(block,is_true,is_false);
    }
}

using LOrExp=BaseExp<LAndExp>;//||

class InnerBaseExps:public AST_NODE
{
    protected:
    List<AddExp> ls;
    public:
    InnerBaseExps(AddExp* _data);
    void push_front(AddExp* _data);
    void push_back(AddExp* _data);
    void print(int x);
};

class Exps:public InnerBaseExps//数组声明修饰符/访问修饰符号
{
    public:
    Exps(AddExp* _data);
    Type* GetDeclDescipter();
    Type* GetDeclDescipter(Type*);
    std::vector<Operand> GetVisitDescripter(BasicBlock*);
};

class CallParams:public InnerBaseExps//函数调用时的Params
{
    public:
    CallParams(AddExp* _data);
    std::vector<Operand> GetParams(BasicBlock* block);
};

class InitVals:public AST_NODE
{
    List<InitVal> ls;
    public:
    InitVals(InitVal* _data);
    void push_back(InitVal* _data);
    void print(int x);
    Operand GetOperand(Type*,BasicBlock*);
};

class InitVal:public AST_NODE
{
    private:
    std::unique_ptr<AST_NODE> val;
    public:
    InitVal()=default;
    InitVal(AST_NODE* _data);
    void print(int x);
    Operand GetFirst(BasicBlock*);
    Operand GetOperand(Type*,BasicBlock*);
};

class BaseDef:public Stmt
{
    protected:
    std::string ID;
    std::unique_ptr<Exps> array_descripters; 
    std::unique_ptr<InitVal> civ;
    public:
    BaseDef(std::string _id,Exps* _ad,InitVal* _iv);
    BasicBlock* GetInst(GetInstState)final;
    void codegen();
    void print(int x);
};

class VarDef:public BaseDef
{
    public:
    VarDef(std::string _id,Exps* _ad=nullptr,InitVal* _iv=nullptr);
};
class ConstDef:public BaseDef
{
    public:
    ConstDef(std::string,Exps*,InitVal*);
};

/// @brief CompUnit是一个由Decl和FuncDef组成的链表，链表里面是AST_NODE*
class CompUnit:public AST_NODE
{
    private:
    List<AST_NODE> ls;
    public:
    CompUnit(AST_NODE* __data);
    void push_front(AST_NODE* __data);
    void push_back(AST_NODE* __data);
    void codegen();
    void print(int x);
};


class ConstDefs:public Stmt
{
    List<ConstDef> ls;
    public:
    ConstDefs(ConstDef* __data);
    void push_back(ConstDef* __data);
    void codegen();
    void print(int x);
    BasicBlock* GetInst(GetInstState)final;
};

class ConstDecl:public Stmt
{
    private:
    AST_Type type;
    std::unique_ptr<ConstDefs> cdfs;
    public:
    ConstDecl(AST_Type tp,ConstDefs* content);
    BasicBlock* GetInst(GetInstState)final;
    void codegen();
    void print(int x);
};

class VarDefs:public Stmt
{
    List<VarDef> ls;
    public:
    VarDefs(VarDef* vdf);
    void push_back(VarDef* _data);
    void codegen();
    void print(int x);
    BasicBlock* GetInst(GetInstState)final;
};

class VarDecl:public Stmt
{
    private:
    AST_Type type;
    std::unique_ptr<VarDefs> vdfs;
    public:
    VarDecl(AST_Type tp,VarDefs* ptr);
    BasicBlock* GetInst(GetInstState)final;
    void codegen();
    void print(int x);
};

class FuncParam:public AST_NODE
{
    private:
    AST_Type tp;
    std::string ID;
    bool emptySquare;
    std::unique_ptr<Exps> array_subscripts;
    public:
    FuncParam(AST_Type _tp,std::string _id,bool is_empty=false,Exps* ptr=nullptr);
    void GetVariable(Function& tmp);
    void print(int x);
};

class FuncParams:public AST_NODE
{
    List<FuncParam> ls;
    public:
    FuncParams(FuncParam* ptr);
    void push_back(FuncParam* ptr);
    void GetVariable(Function& tmp);
    void print(int x);
};

class BlockItems:public Stmt
{
    List<Stmt> ls;
    public:
    BlockItems(Stmt* ptr);
    void push_back(Stmt* ptr);
    BasicBlock* GetInst(GetInstState)final;
    void print(int x);
};

class Block:public Stmt
{
    private:
    std::unique_ptr<BlockItems> items;
    public:
    Block(BlockItems* ptr);
    BasicBlock* GetInst(GetInstState)final;
    void print(int x);
};

class FuncDef:public AST_NODE
{
    AST_Type tp;
    std::string ID;
    std::unique_ptr<FuncParams> params;
    std::unique_ptr<Block> function_body;
    public:
    FuncDef(AST_Type _tp,std::string _id,FuncParams* ptr,Block* fb);
    void codegen();
    void print(int x);
};

class LVal:public HasOperand
{
    private:
    std::string ID;
    std::unique_ptr<Exps> array_descripters;
    public:
    LVal(std::string _id,Exps* ptr=nullptr);
    Operand GetPointer(BasicBlock* block);
    Operand GetOperand(BasicBlock* block);
    std::string GetName();
    void print(int x);
};

class AssignStmt:public Stmt
{
    private:
    std::unique_ptr<LVal> lv;
    std::unique_ptr<AddExp> exp;
    public:
    AssignStmt(LVal* p1,AddExp* p2);
    BasicBlock* GetInst(GetInstState)final;
    void print(int x);
};

/// @brief EmptyStmt直接不给翻译，就是只有';'的那种
class ExpStmt:public Stmt
{
    std::unique_ptr<AddExp> exp;
    public:
    ExpStmt(AddExp* ptr);
    BasicBlock* GetInst(GetInstState)final;
    void print(int x);
};

class WhileStmt:public Stmt
{
    private:
    std::unique_ptr<LOrExp> condition;
    std::unique_ptr<Stmt> stmt;
    public:
    WhileStmt(LOrExp* p1,Stmt* p2);
    BasicBlock* GetInst(GetInstState)final;
    void print(int x);
};

class IfStmt:public Stmt
{
    private:
    std::unique_ptr<LOrExp> condition;
    std::unique_ptr<Stmt> t,f;
    public:
    IfStmt(LOrExp* p0,Stmt* p1,Stmt* p2=nullptr);
    BasicBlock* GetInst(GetInstState)final;
    void print(int x);
}; 

/// @brief 这个很奇怪，因为break和continue本身就代表了一种信息
class BreakStmt:public Stmt
{
    BasicBlock* GetInst(GetInstState)final;
    void print(int x);
};

class ContinueStmt:public Stmt
{
    BasicBlock* GetInst(GetInstState)final;
    void print(int x);
};

class ReturnStmt:public Stmt
{
    std::unique_ptr<AddExp> return_val;
    public:
    ReturnStmt(AddExp* ptr=nullptr);
    BasicBlock* GetInst(GetInstState)final;
    void print(int x);
};

class FunctionCall:public HasOperand
{
    std::string id;
    std::unique_ptr<CallParams> cp;
    public:
    FunctionCall(std::string _id,CallParams* ptr=nullptr);
    Operand GetOperand(BasicBlock* block);
    void print(int x);
};

template<typename T>
class ConstValue:public HasOperand
{
    T data;
    public:
    ConstValue(T _data):data(_data){}
    Operand GetOperand(BasicBlock* block){
        if(std::is_same<T,int>::value)return ConstIRInt::GetNewConstant(data);
        else return ConstIRFloat::GetNewConstant(data);
    }
    void print(int x)final{
        AST_NODE::print(x);
        std::cout<<":"<<data<<'\n';
    }
};