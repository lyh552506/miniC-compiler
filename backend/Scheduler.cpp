#include "../include/backend/Scheduler.hpp"

// Pre_RA_Scheduler
void Pre_RA_Scheduler::ScheduleOnModule(RISCVLoweringContext& ctx) {
    #ifdef DEBUG_SCHED
    static std::streambuf* cout_buf = std::cout.rdbuf();
    std::cout.rdbuf(Sched_debugfile.rdbuf());
    #endif
    for(auto& func : ctx.GetFunctions()) {
        for(auto block : *func) {
            ScheduleOnBlock(block);
        }
    }
    #ifdef DEBUG_SCHED
    std::cout.rdbuf(cout_buf);
    Sched_debugfile.close();
    #endif
}
void Pre_RA_Scheduler::ScheduleOnBlock(RISCVBasicBlock* block) {
    if(block->GetName() == ".LBB18") {
        int a=0;
    }
    SchedRegion region(block);
    BlockDepInfo* depInfo = new BlockDepInfo(block);
    #ifdef DEBUG_SCHED
    std::cout << "ScheduleOnBlock: " << block->GetName() << std::endl;
    #endif
    if(block->Size() > 1) {
        while(region.LastRegion()) {
            ScheduleOnRegion(region.begin, region.end, depInfo);
        }
    }
}

void Pre_RA_Scheduler::ScheduleOnRegion(mylist_iterator begin, mylist_iterator end, BlockDepInfo* depInfo) {
    // Build dependency graph, and compute info on graph.
    #ifdef DEBUG_SCHED
        std::cout << "ScheduleOnRegion: " << std::endl << " ---from---";
        (*begin)->printfull();
        std::cout << " ---to--- ";
        (*end)->printfull();
        std::cout << std::flush;
    #endif

    DependencyGraph depGraph(depInfo);
    depGraph.BuildGraph(begin, end);
    depGraph.ComputeHeight();
}


// Post_RA_Scheduler
void Post_RA_Scheduler::ScheduleOnModule(RISCVLoweringContext&) {

}

void Post_RA_Scheduler::ScheduleOnBlock(RISCVBasicBlock* block) {

}

void Post_RA_Scheduler::ScheduleOnRegion(mylist_iterator begin, mylist_iterator end, BlockDepInfo* depInfo) {
}