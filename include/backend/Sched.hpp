#pragma once
#include <iostream>
#include <fstream>
#include <vector>
#include <unordered_map>
#include <unordered_set>
#include "../backend/RISCVMIR.hpp"
#include "../backend/SchedInfo.hpp"
using mylist_iterator = mylist<RISCVBasicBlock,RISCVMIR>::iterator;
// The Sunit, including attributes of Latency, MaxLatency, height and depth,
// is the unit of the scheduling algorithm.
    
class Sunit {
    friend class DependencyGraph;
private:
    uint32_t latency;
    uint32_t maxLatency;
    uint32_t height;
    uint32_t depth;
public:
    Sunit() = default;
};

using MOp2StackMap = std::unordered_map<RISCVMOperand*, std::stack<RISCVMIR*>>;
using RealSunit = std::pair<RISCVMIR*, Sunit*>;
class BlockDepInfo {
    friend class DependencyGraph;
    MOp2StackMap def2inst;
    MOp2StackMap use2inst;
    std::list<RealSunit> inst2sunit;
public:
    BlockDepInfo(RISCVBasicBlock*);
    void BuildBlockDepInfo(RISCVBasicBlock*);
};

// DependencyGraph
class DependencyGraph {
private:
    BlockDepInfo* depInfo;
    std::unordered_map<Sunit*, std::set<Sunit*>> adjList; 
    std::unordered_map<Sunit*, uint32_t> inDegree;

public:
    DependencyGraph(BlockDepInfo* depInfo): depInfo(depInfo){};
    void BuildGraph(mylist<RISCVBasicBlock,RISCVMIR>::iterator, mylist<RISCVBasicBlock,RISCVMIR>::iterator);
    void addDependency(Sunit*, Sunit*);
    void ComputeHeight();
    void ComputeDepth();
};

class SchedRegion {
    friend class Pre_RA_Scheduler;
    friend class Post_RA_Scheduler;
    RISCVBasicBlock* block;
    mylist_iterator begin;
    mylist_iterator end;
    mylist_iterator rbegin;
    mylist_iterator rend;

public:
    SchedRegion(RISCVBasicBlock* block);
    bool LastRegion();
    bool NextRegion();
};

bool isboundary(RISCVMIR*);
#ifdef DEBUG_SCHED
    static std::string Sched_debuginfo = "BackendTest/Sched.buginfo";
    static std::ofstream Sched_debugfile(Sched_debuginfo);
    static std::streambuf* cout_buf = std::cout.rdbuf();
#endif