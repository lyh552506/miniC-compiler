#include "../include/backend/Scheduler.hpp"

template<typename T_from, typename T_to>
void Scheduler::transfer(Sunit* sunit, T_from &container_from, T_to& container_to) {
    container_to.push_back(sunit);
    // container_from.erase(std::remove(container_from.begin(), container_from.end(), sunit), container_from.end());
}
bool Scheduler::isFinish(DependencyGraph* depGraph) {
    // for(auto& pair: depGraph->inDegree) {
    //     if(pair.second != -1) {
    //         return false;
    //     }
    // }
    // return true;
    if(Sequence.size() == depGraph->adjList.size()) return true;
    return false;
}
bool Scheduler::compareSunit(const Sunit* a, const Sunit* b) {
    if(a->get_latency() == b->get_latency()) {
        if(a->get_height() == b->get_height()) {
            return a->get_depth() < b->get_depth();
        }
        return a->get_height() > b->get_height();
    }
    return a->get_latency() < b->get_latency();
}
void Scheduler::nextCycle() {
    if(PlaneNode.empty()) {
        CurCycle++;
        return ;
    }
    assert(0&&"Still node in PlaneNode");
}
void Scheduler::Schedule_clear() {
    PlaneNode.clear();
    Pending.clear();
    Available.clear();
    Sequence.clear();
    CurCycle = 0;
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
    Schedule_clear();
}
void Pre_RA_Scheduler::Schedule(DependencyGraph* depGraph) {
    while(!isFinish(depGraph)) {
        for(auto& pair: depGraph->inDegree) {
            if(pair.second == 0) {
                PlaneNode.push_back(pair.first);
                for(auto& node: depGraph->adjList[pair.first]) {
                    depGraph->inDegree[node]--;
                }
                depGraph->inDegree[pair.first] = -1;
            }
        }
        #ifdef DEBUG_SCHED
            std::cout << "---PlaneNode---" << std::endl;
            for(auto& node: PlaneNode) {
                for(auto& it: depGraph->depInfo->get_inst2sunit()) {
                    if(it.second == node) {
                        it.first->printfull();
                    }
                }
            }
            std::cout << "---PlaneNodeEnd---" << std::endl;
        #endif
        
        for(auto it = PlaneNode.begin(); it != PlaneNode.end();) {
            if(CurCycle >= (*it)->get_latency()) {
                transfer(*it, PlaneNode, Available);
                it = PlaneNode.erase(it);
            }
            else {
                transfer(*it, PlaneNode, Pending);
                it = PlaneNode.erase(it);
            }
        }
        // the first sunit is the highest priority
        std::sort(Pending.begin(), Pending.end(), compareSunit);
        for(auto it = Pending.begin(); it != Pending.end();) {
            if(CurCycle >= (*it)->get_maxLatency()) {
                transfer(*it, Pending, Available);
                it = Pending.erase(it);
            }
        }
        auto getInstPipeline = [&](Sunit* sunit) {
            return SchedInfo(depGraph->depInfo->get_Sunit2InstMap()[sunit]->GetOpcode()).get_Pipeline();
        };
        std::sort(Available.begin(), Available.end(), compareSunit);
        for(auto it = Available.begin(); it != Available.end();) {
            // Consider the pipeline
            if(isPipelineReady(getInstPipeline(*it))) {
                transfer(*it, Available, Sequence);
                it = Available.erase(it);
            }

        }
        nextCycle();
    }
    #ifdef DEBUG_SCHED
        std::cout << "---Sequence---" << std::endl;
        for(auto& node: Sequence) {
            for(auto& it: depGraph->depInfo->get_inst2sunit()) {
                if(it.second == node) {
                    it.first->printfull();
                }
            }
        }
        std::cout << "---SequenceEnd---" << std::endl;
    #endif
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