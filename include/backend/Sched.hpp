#pragma once
#include <iostream>
#include <vector>
#include <unordered_map>
#include <unordered_set>
#include "../backend/RISCVMIR.hpp"
#include "../backend/SchedInfo.hpp"
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

// DependencyGraph
class DependencyGraph {
private:
    std::unordered_map<Sunit*, std::set<Sunit*>> adjList; 
    std::unordered_map<Sunit*, uint32_t> inDegree;

    using MOp2StackMap = std::unordered_map<RISCVMOperand*, std::stack<RISCVMIR*>>;
    MOp2StackMap def2inst;
    MOp2StackMap use2inst;
    using RealSunit = std::pair<RISCVMIR*, Sunit*>;
    std::list<RealSunit> inst2sunit;
public:
    void BuildGraph(mylist<RISCVBasicBlock,RISCVMIR>::iterator, mylist<RISCVBasicBlock,RISCVMIR>::iterator);
    void addDependency(Sunit*, Sunit*);
    void ComputeHeight();
    void ComputeDepth();
};

class SchedRegion {
    friend class Pre_RA_Scheduler;
    friend class Post_RA_Scheduler;
    RISCVBasicBlock* block;
    mylist<RISCVBasicBlock,RISCVMIR>::iterator begin;
    mylist<RISCVBasicBlock,RISCVMIR>::iterator end;
public:
    SchedRegion(RISCVBasicBlock* block);
    bool NextRegion();
    bool isboundary(RISCVMIR*);
};


