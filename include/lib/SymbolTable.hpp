#pragma once
#include "BaseCFG.hpp"
#include <map>
#include <stack>
#include <string>
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
        for(auto &i:rec.back())
            if(!i->empty())i->pop();
        rec.pop_back();
    }
    Value* GetValueByName(std::string name){
        auto &i=mp[name];
        assert(i!=nullptr&&!i->empty());
        return i->top();
    }
    void Register(std::string name,Value* val){
        auto &i=mp[name];
        if(i==nullptr)i.reset(new std::stack<Value*>());
        if(!rec.empty())rec.back().push_back(i.get());
        /// @todo 函数重定义是科学的
        i->push(val);
    }
    int IR_number(std::string str){
        static std::unordered_map<std::string,int> cnt;
        return cnt[str]++;
    }
};