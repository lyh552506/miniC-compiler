#pragma once
#include "CFG.hpp"
#include <set>

class LivenessAnalysis
{
    private:
    void GetBlockLivein(BasicBlock* block);
    void GetBlockLiveout(BasicBlock* block);
    void iterate(Function* func);
    void RunOnFunction(Function *func);
    std::map<BasicBlock*, bool> UnChanged;
    bool isChanged = false;
    void PrintInfo(Function* func);
    public:
    std::map<BasicBlock*, std::set<Value*>> BlockLivein;
    std::map<BasicBlock*, std::set<Value*>> BlockLiveout;
    void pass(Function* func);
    
    LivenessAnalysis()=default;

};