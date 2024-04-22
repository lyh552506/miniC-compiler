#pragma once
#include "Mcode.hpp"
#include "CFG.hpp"
#include <unordered_set>

class BlockLiveInfo : public MachineInst
{
    private:
    void GetBlockLivein(MachineBasicBlock* block);
    void GetBlockLiveout(MachineBasicBlock* block);
    void iterate(MachineFunction* func);
    void RunOnFunc(MachineFunction *func);
    void CalcReg2Mov(MachineBasicBlock* block);
    void CalcRegInterfer(MachineBasicBlock* block);
    void CalInstLive(MachineBasicBlock* block);
    std::map<MachineBasicBlock*, bool> UnChanged;
    bool isChanged = false;
    MachineFunction* F;
    protected:
    std::map<MachineBasicBlock*, std::unordered_set<Value*>> Uses; // block uses
    std::map<MachineBasicBlock*, std::unordered_set<Value*>> Defs; // block defs
    std::map<MachineInst*, std::set<Value*>> InstLive;
    std::map<MachineBasicBlock*, std::set<Value*>> BlockLivein;
    std::map<MachineBasicBlock*, std::set<Value*>> BlockLiveout;
    std::map<MachineBasicBlock*, std::unordered_map<Operand, std::vector<MachineInst*>>> Reg2Mov; // 寄存器MOV指令映射
    std::map<MachineBasicBlock*, std::unordered_map<Operand, std::vector<Operand>>> RegInterfer; // 同时使用的寄存器映射
    std::map<MachineBasicBlock*, std::unordered_set<Operand>> Regs;   // Machine register
    public:
    std::unordered_map<Operand, std::vector<MachineInst*>> GetReg2Mov(MachineBasicBlock* block) { return Reg2Mov[block]; }
    std::unordered_map<Operand, std::vector<Operand>> GetRegInterfer(MachineBasicBlock* block) { return RegInterfer[block]; }
    std::unordered_set<Operand> GetMachineRegs(MachineBasicBlock* block) { return Regs[block]; }
    void RunOnFunction();
    void PrintPass();
    bool count(Operand Op) { return InstLive[this].count(Op); }
    BlockLiveInfo(MachineFunction* f) : F(f), BlockLivein{}, BlockLiveout{}, UnChanged{} {};
    BlockLiveInfo() = default;
};

struct RegLiveInterval
{
    int start;
    int end;
};

class LiveInterval : public BlockLiveInfo
{
    MachineFunction* func;
    protected:
    std::unordered_map<MachineInst*, int> instNum;
    std::unordered_map<MachineBasicBlock*, BlockLiveInfo*> BlockInfo;
    std::map<MachineBasicBlock*, std::unordered_map<Operand, std::vector<RegLiveInterval>>> RegLiveness;
    private:
    void init();
    void computeLiveIntervals();
    void PrintAnalysis();
    bool verify(std::unordered_map<Operand, std::vector<RegLiveInterval>> Liveinterval);
    std::unique_ptr<BlockLiveInfo> blockinfo;
    public:
    LiveInterval(MachineFunction* f) : func(f), BlockLiveInfo() {}
    std::unordered_map<Operand, std::vector<RegLiveInterval>> GetRegLiveInterval(MachineBasicBlock* block) \
    { return RegLiveness[block]; }
    void RunOnFunc();
};