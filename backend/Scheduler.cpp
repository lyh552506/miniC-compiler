#include "../include/backend/Scheduler.hpp"

bool Scheduler::isFinish(DependencyGraph* depGraph) {
    for(auto& pair: depGraph->inDegree) {
        if(pair.second != 0) {
            return false;
        }
    }
    return true;
}
void Scheduler::nextCycle() {
    if(PlaneNode.empty()) {
        CurCycle++;
        return ;
    }
    assert(0&&"Still node in PlaneNode");
}


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
    DependencyGraph* depGraph = new DependencyGraph(depInfo);
    depGraph->BuildGraph(begin, end);
    depGraph->ComputeHeight();

    Schedule(depGraph);

}
void Pre_RA_Scheduler::Schedule(DependencyGraph* depGraph) {
    auto Plane2Avail = [&](Sunit* sunit) {
        Available.push_back(sunit);
        PlaneNode.erase(std::remove(PlaneNode.begin(), PlaneNode.end(), sunit), PlaneNode.end());
    };
    auto Plaen2Pend = [&](Sunit* sunit) {
        Pending.push_back(sunit);
        PlaneNode.erase(std::remove(PlaneNode.begin(), PlaneNode.end(), sunit), PlaneNode.end());
    };
    auto Avail2Seq = [&](Sunit* sunit) {
        Sequence.push_back(sunit);
        Available.erase(std::remove(Available.begin(), Available.end(), sunit), Available.end());
    };
    auto Pend2Avail = [&](Sunit* sunit) {
        Available.push_back(sunit);
        Pending.erase(std::remove(Pending.begin(), Pending.end(), sunit), Pending.end());
    };
    while(!isFinish(depGraph)) {
        for(auto& pair: depGraph->inDegree) {
            if(pair.second == 0) {
                PlaneNode.push_back(pair.first);
                for(auto& node: depGraph->adjList[pair.first]) {
                    depGraph->inDegree[node]--;
                }
            }
        }
        for(auto& node: PlaneNode) {
            if(CurCycle < node->get_latency()) {

            }
        }
    }
}


// Post_RA_Scheduler
void Post_RA_Scheduler::ScheduleOnModule(RISCVLoweringContext&) {

}

void Post_RA_Scheduler::ScheduleOnBlock(RISCVBasicBlock* block) {

}

void Post_RA_Scheduler::ScheduleOnRegion(mylist_iterator begin, mylist_iterator end, BlockDepInfo* depInfo) {
}

void Post_RA_Scheduler::Schedule(DependencyGraph* depGraph) {
}