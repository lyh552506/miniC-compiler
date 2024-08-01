#pragma once
#include <unordered_map>
#include <iostream>
#include <vector>
#include <queue>
#include <unordered_map>
#include <unordered_set>
#include "RISCVMIR.hpp"
// The Sunit, including attributes of Latency, MaxLatency, height and depth,
// is the unit of the scheduling algorithm.
class Sunit {
private:
    RISCVMIR* inst;
    uint32_t latency;
    uint32_t maxLatency;
    uint32_t height;
    uint32_t depth;
public:
    Sunit(RISCVMIR* inst): inst(inst) {}
};

// DependencyGraph
class DependencyGraph {
private:
    std::unordered_map<Sunit*, std::unordered_set<Sunit*>> adjList; 
    std::unordered_map<Sunit*, uint32_t> inDegree;

public:
    void BuildGraph(mylist<RISCVBasicBlock,RISCVMIR>::iterator, mylist<RISCVBasicBlock,RISCVMIR>::iterator);
    void addDependency(const Sunit*, const Sunit*);
};

class SchedRegion {
    RISCVBasicBlock* block;
    mylist<RISCVBasicBlock,RISCVMIR>::iterator begin;
    mylist<RISCVBasicBlock,RISCVMIR>::iterator end;
public:
    SchedRegion(RISCVBasicBlock* block);
    bool NextRegion();
};


