#pragma once
#include "List.hpp"

/// @brief 最基础的AST_NODE，所有基础特性都应该放里面
class AST_NODE 
{
    private:
    /// @todo 可以加个enum type 表示这个是什么type，但是貌似 C++ 现在支持动态判定类型
    public:
    virtual void codegen()=0;
};

/// @brief CompUnit是一个由Decl和FuncDef组成的链表
class CompUnit:public AST_NODE
{
    private:
    List<AST_NODE> ls;
    public:
    void merge(std::unique_ptr<AST_NODE> __data){
        ls.push_back(__data);
    }
    void codegen() final {
        /// @todo 实现codegen
    }
};