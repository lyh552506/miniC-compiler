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
    void CalcReg2Reg(MachineBasicBlock* block);
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
    std::map<Operand, std::vector<MachineInst*>> Reg2Mov; // 寄存器MOV指令映射
    std::map<Operand, std::vector<Operand>> Reg2Reg; // 同时使用的寄存器映射
    std::unordered_set<Operand> Regs;   // Machine register
    public:
    std::map<Operand, std::vector<MachineInst*>> GetReg2Mov() { return Reg2Mov; }
    std::map<Operand, std::vector<Operand>> GetReg2Reg() { return Reg2Reg; }
    std::unordered_set<Operand> GetMachineRegs() { return Regs; }
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
    bool verify(std::unordered_map<Operand, std::vector<RegLiveInterval>> Liveinterval);
    std::unordered_map<Operand, std::vector<RegLiveInterval>>& Simplify(std::unordered_map<Operand, std::vector<RegLiveInterval>> Liveinterval);
    public:
    LiveInterval(MachineFunction* f) : func(f), BlockLiveInfo() {}
    std::unordered_map<Operand, std::vector<RegLiveInterval>> GetRegLiveInterval(MachineBasicBlock* block) \
    { return RegLiveness[block]; }
};