#pragma once 
#include "../backend/Sched.hpp"
#include "../backend/RISCVContext.hpp"

class Scheduler {
protected:
    std::vector<Sunit*> PlaneNode;
    std::vector<Sunit*> Available;
    std::vector<Sunit*> Pending;
    std::list<Sunit*> Sequence;
    uint32_t CurCycle = 0;
    // Pipeline status
    uint32_t PipelineMask = 0;
    uint32_t PipelineDivLatency = 0;
    uint32_t PipelineFDivLatency = 0;
public:
    virtual void  ScheduleOnFunction(RISCVLoweringContext&) = 0;
    virtual void ScheduleOnBlock(RISCVBasicBlock*) = 0;
    virtual void ScheduleOnRegion(mylist_iterator, mylist_iterator, BlockDepInfo*) = 0;
    virtual void Schedule(DependencyGraph*) = 0;
    template<typename T_from, typename T_to>
    void transfer(Sunit* , T_from &container_from, T_to& container_to);
    bool isFinish(DependencyGraph*);
    static bool compareSunit(const Sunit*, const Sunit*);
    inline void nextCycle();
    inline void Schedule_clear();
    bool isPipelineReady(RISCVMIR*);
    void Swap_region(mylist_iterator, mylist_iterator, BlockDepInfo*);

};

class Pre_RA_Scheduler: private Scheduler {
public:
    void ScheduleOnFunction(RISCVLoweringContext&) override;
    void ScheduleOnBlock(RISCVBasicBlock*) override;
    void ScheduleOnRegion(mylist_iterator, mylist_iterator, BlockDepInfo*) override;
    void Schedule(DependencyGraph*) override;
};

class Post_RA_Scheduler: private Scheduler {
public:
    void ScheduleOnFunction(RISCVLoweringContext&) override;
    void ScheduleOnBlock(RISCVBasicBlock*) override;
    void ScheduleOnRegion(mylist_iterator, mylist_iterator, BlockDepInfo*) override;
    void Schedule(DependencyGraph*) override;
};


