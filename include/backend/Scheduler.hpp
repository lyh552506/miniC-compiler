#pragma once 
#include "../backend/Sched.hpp"
#include "../backend/RISCVContext.hpp"

class Scheduler {
protected:
    std::vector<Sunit*> PlaneNode;
    std::list<Sunit*> Available;
    std::vector<Sunit*> Pending;
    std::list<Sunit*> Sequence;
    uint32_t CurCycle;
public:
    virtual void  ScheduleOnModule(RISCVLoweringContext&) = 0;
    virtual void ScheduleOnBlock(RISCVBasicBlock*) = 0;
    virtual void ScheduleOnRegion(mylist_iterator, mylist_iterator, BlockDepInfo*) = 0;
    virtual void Schedule(DependencyGraph*) = 0;
    bool isFinish(DependencyGraph*);
    void nextCycle();
};

class Pre_RA_Scheduler: private Scheduler {
public:
    void ScheduleOnModule(RISCVLoweringContext&) override;
    void ScheduleOnBlock(RISCVBasicBlock*) override;
    void ScheduleOnRegion(mylist_iterator, mylist_iterator, BlockDepInfo*) override;
    void Schedule(DependencyGraph*) override;

};

class Post_RA_Scheduler: private Scheduler {
public:
    void ScheduleOnModule(RISCVLoweringContext&) override;
    void ScheduleOnBlock(RISCVBasicBlock*) override;
    void ScheduleOnRegion(mylist_iterator, mylist_iterator, BlockDepInfo*) override;
    void Schedule(DependencyGraph*) override;
};


