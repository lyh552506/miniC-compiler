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
bool isLoadinst (RISCVMIR* inst);
bool isStoreinst (RISCVMIR* inst);
class GlueChain;

class Sunit {
    friend class DependencyGraph;
private:
    uint32_t latency;
    uint32_t maxLatency;
    uint32_t height;
    uint32_t depth;
public:
    Sunit() = default;
    inline uint32_t get_latency() const {return latency;}
    inline uint32_t get_maxLatency() const {return maxLatency;}
    inline uint32_t get_height() const {return height;}
    inline uint32_t get_depth() const {return depth;}
    inline void set_maxLatency(uint32_t laten) {maxLatency = laten;}
};

using MOp2StackMap = std::unordered_map<RISCVMOperand*, std::stack<RISCVMIR*>>;
using RealSunit = std::pair<RISCVMIR*, Sunit*>;
class BlockDepInfo {
    friend class DependencyGraph;
    RISCVBasicBlock* block;
    MOp2StackMap def2inst;
    MOp2StackMap use2inst;
    std::list<RealSunit> inst2sunit;
    std::unordered_map<Sunit*, RISCVMIR*> Sunit2InstMap;
public:
    BlockDepInfo(RISCVBasicBlock*);
    BlockDepInfo(RISCVBasicBlock*, mylist_iterator, mylist_iterator);
    void BuildBlockDepInfo(mylist_iterator, mylist_iterator);
    inline RISCVBasicBlock*& get_block() {return block;}
    inline MOp2StackMap& get_def2inst() {return def2inst;}
    inline MOp2StackMap& get_use2inst() {return use2inst;}
    inline std::list<RealSunit>& get_inst2sunit() {return inst2sunit;}
    inline std::unordered_map<Sunit*, RISCVMIR*>& get_Sunit2InstMap() {return Sunit2InstMap;}
};

// DependencyGraph
class DependencyGraph {
private:
    BlockDepInfo* depInfo;
    std::vector<Sunit*> sunits;
    std::map<Sunit*, std::set<Sunit*>> adjList; 
    std::unordered_map<Sunit*, uint32_t> inDegree;
    std::list<Sunit*> GlueList;
    std::unordered_map<Sunit*, Sunit*> AntiDepMap;
public:
    friend class Scheduler;
    friend class Pre_RA_Scheduler;
    DependencyGraph(BlockDepInfo* depInfo): depInfo(depInfo){};
    /// @brief Build dependency graph from begin to end, that means build graph
    /// from top to bottom.
    void BuildGraph(mylist<RISCVBasicBlock,RISCVMIR>::iterator, mylist<RISCVBasicBlock,RISCVMIR>::iterator);
    void addDependency(Sunit*, Sunit*);
    /// @brief Compute height of each node in the graph in order form bottom to top.
    void ComputeHeight();
    /// @brief Compute depth of each node in the graph in order form top to bottom.
    void ComputeDepth();
    inline BlockDepInfo*& get_depInfo() {return depInfo;}
    inline std::list<Sunit*>& get_GlueList() {return GlueList;}
    inline std::unordered_map<Sunit*, Sunit*>& get_AntiDepMap() {return AntiDepMap;}
    Sunit*& GetSunit(RISCVMIR*);
    void RemoveAntiDep(Sunit*);
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
    inline RISCVBasicBlock*& getBlock() {return block;}
    bool LastRegion();
    bool NextRegion();
};

bool isboundary(RISCVMIR*);



#ifdef DEBUG_SCHED
    static std::string Sched_debuginfo = "BackendTest/Sched.buginfo";
    
#endif