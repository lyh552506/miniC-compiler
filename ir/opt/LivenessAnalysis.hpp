#pragma once
#include "CFG.hpp"
#include <set>

class LivenessAnalysis
{
    private:
    void GetBlockLivein(BasicBlock* block);
    void GetBlockLiveout(BasicBlock* block);
    void iterate(Function* func);
    void RunOnFunc(Function *func);
    std::map<BasicBlock*, bool> UnChanged;
    bool isChanged = false;
    Function* F;
    public:
    std::map<BasicBlock*, std::set<Value*>> BlockLivein;
    std::map<BasicBlock*, std::set<Value*>> BlockLiveout;
    void RunOnFunction();
    void PrintPass();
    LivenessAnalysis(Function* f) : F(f), BlockLivein{}, BlockLiveout{}, UnChanged{} {};

};