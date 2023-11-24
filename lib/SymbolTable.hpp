#pragma once
#include "BaseCFG.hpp"
#include <map>
#include <stack>
/// @brief same layer with same name is illegal 
class SymbolTable
{
    protected:
    using recoder=std::stack<Value*>*;
    std::map<std::string,std::unique_ptr<std::stack<Value*>>> mp;
    std::vector<std::vector<recoder>> rec;
    public:
    void layer_increase(){
        rec.push_back(std::vector<recoder>());
    }
    void layer_decrease(){
        /// @todo 放进变量表的指针现在没有东西去析构
        rec.pop_back();
    }
    Value* GetValueByName(std::string name){
        auto &i=mp[name];
        assert(!i->empty());
        i->top();
    }
    void Register(std::string name,Value* val){
        auto &i=mp[name];
        if(i==nullptr)i.reset(new std::stack<Value*>());
        rec.back().push_back(i.get());
        /// @todo 函数重定义是科学的
        i->push(val);
    }
};