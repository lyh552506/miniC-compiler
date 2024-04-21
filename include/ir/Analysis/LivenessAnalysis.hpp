#pragma once
#include "Mcode.hpp"
#include "CFG.hpp"
#include <set>

class LivenessAnalysis
{
    private:
    void GetBlockLivein(MachineBasicBlock* block);
    void GetBlockLiveout(MachineBasicBlock* block);
    void iterate(MachineFunction* func);
    void RunOnFunc(MachineFunction *func);
    std::map<MachineBasicBlock*, bool> UnChanged;
    bool isChanged = false;
    MachineFunction* F;
    public:
    std::map<MachineBasicBlock*, std::set<Value*>> BlockLivein;
    std::map<MachineBasicBlock*, std::set<Value*>> BlockLiveout;
    void RunOnFunction();
    void PrintPass();
    LivenessAnalysis(MachineFunction* f) : F(f), BlockLivein{}, BlockLiveout{}, UnChanged{} {};

};