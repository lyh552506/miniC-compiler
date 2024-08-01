#include "../include/backend/Scheduler.hpp"

// Pre_RA_Scheduler
void Pre_RA_Scheduler::ScheduleOnModule(RISCVLoweringContext& ctx) {
    for(auto& func : ctx.GetFunctions()) {
        for(auto block : *func) {
            ScheduleOnBlock(block);
        }
    }
}
void Pre_RA_Scheduler::ScheduleOnBlock(RISCVBasicBlock* block) {
    SchedRegion region(block);
    if(block->Size() > 1) {
        while(region.NextRegion()) {
            ScheduleOnRegion(region.begin, region.end);
        }
    }
}

void Pre_RA_Scheduler::ScheduleOnRegion(mylist<RISCVBasicBlock,RISCVMIR>::iterator, mylist<RISCVBasicBlock,RISCVMIR>::iterator) {

}


// Post_RA_Scheduler
void Post_RA_Scheduler::ScheduleOnModule(RISCVLoweringContext&) {

}

void Post_RA_Scheduler::ScheduleOnBlock(RISCVBasicBlock* block) {

}

void Post_RA_Scheduler::ScheduleOnRegion(mylist<RISCVBasicBlock,RISCVMIR>::iterator, mylist<RISCVBasicBlock,RISCVMIR>::iterator) {

}