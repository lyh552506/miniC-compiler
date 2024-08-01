#pragma once 
#include "../backend/Sched.hpp"
#include "../backend/RISCVContext.hpp"
class Scheduler {
    std::list<Sunit*> Sequence;
    std::list<Sunit*> Abailable;
    std::vector<Sunit*> Pending;
    uint32_t CurCycle;
public:
    virtual void  ScheduleOnModule(RISCVLoweringContext&) = 0;
    virtual void ScheduleOnBlock(RISCVBasicBlock*) = 0;
    virtual void ScheduleOnRegion(mylist<RISCVBasicBlock,RISCVMIR>::iterator, mylist<RISCVBasicBlock,RISCVMIR>::iterator) = 0;
};

class Pre_RA_Scheduler: public Scheduler {
public:
    void ScheduleOnModule(RISCVLoweringContext&) override;
    void ScheduleOnBlock(RISCVBasicBlock*) override;
    void ScheduleOnRegion(mylist<RISCVBasicBlock,RISCVMIR>::iterator, mylist<RISCVBasicBlock,RISCVMIR>::iterator) override;
};

class Post_RA_Scheduler: public Scheduler {
public:
    void ScheduleOnModule(RISCVLoweringContext&) override;
    void ScheduleOnBlock(RISCVBasicBlock*) override;
    void ScheduleOnRegion(mylist<RISCVBasicBlock,RISCVMIR>::iterator, mylist<RISCVBasicBlock,RISCVMIR>::iterator) override;
};