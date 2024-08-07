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
    if(a->get_maxLatency() == b->get_maxLatency()) {
        if(a->get_height() == b->get_height()) {
            return a->get_depth() < b->get_depth();
        }
        return a->get_height() > b->get_height();
    }
    return a->get_maxLatency() < b->get_maxLatency();
}
void Scheduler::nextCycle() {
    if(PlaneNode.empty()) {
        CurCycle++;
        PipelineMask = 0;
        return ;
    }
    assert(0&&"Still node in PlaneNode");
}
void Scheduler::Schedule_clear() {
    PlaneNode.clear();
    Pending.clear();
    Available.clear();
    Sequence.clear();
    PipelineDivLatency = 0;
    PipelineFDivLatency = 0;
    CurCycle = 0;
}
bool Scheduler::isPipelineReady(RISCVMIR* inst) {
    RISCVMIR::RISCVISA op = inst->GetOpcode();
    SchedInfo *info = new SchedInfo(op);
    uint32_t pipeline = info->get_Pipeline();
    if(pipeline == PIPELINE::PipelineA || pipeline == PIPELINE::PipelineB) {
        if(pipeline & PipelineMask) {
            return false;
        }
        PipelineMask |= pipeline;
        return true;
    }
    else if(pipeline == PIPELINE::PipelineAB) {
        if(pipeline & PipelineMask == pipeline) {
            return false;
        }
        if(pipeline & PipelineMask == PIPELINE::PipelineA) {
            // issule to PipelineB
            PipelineMask |= PIPELINE::PipelineB;
            return true;
        }
        // issule to PipelineA
        PipelineMask |= PIPELINE::PipelineA;
        return true;
    }
    // Actually, both PipelineDiv and PipelineFDiv will occpuy PipelineB.
    else if(pipeline == PIPELINE::PipelineDiv) {
        if(PipelineDivLatency >= CurCycle) {
            return false;
        }
        if(op>=ISA::_div && op<=ISA::_remu) {
            PipelineDivLatency += 65;
        }
        else if(op>=ISA::_divw && op<ISA::EndArithmetic) {
            PipelineDivLatency += 33;
        }
        PipelineMask |= PIPELINE::PipelineB;
        return true;
    }
    else if(pipeline == PIPELINE::PipelineFDiv) {
        if(PipelineFDivLatency >= CurCycle) {
            return false;
        }
        if(op==ISA::_fdiv_s) {
            PipelineFDivLatency +=26;
        }
        else if(op==ISA::_fsqrt_s) {
            PipelineFDivLatency += 27;
        }
        PipelineMask |= PIPELINE::PipelineB;
        return true;
    }
}

void Scheduler::Swap_region(mylist_iterator begin, mylist_iterator end, BlockDepInfo* depInfo) {
    if(Sequence.size()==0) {
        return;
    }
    std::list<RISCVMIR*> sched_list;
    for(auto& sunit: Sequence) {
        sched_list.push_back(depInfo->get_Sunit2InstMap()[sunit]);
    }
    RISCVBasicBlock*& block = depInfo->get_block();
    block->swap_region(*begin, *end, sched_list);
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
    Swap_region(begin, end, depInfo);
    
}
void Pre_RA_Scheduler::Schedule(DependencyGraph* depGraph) {
    while(!isFinish(depGraph)) {
        for(auto& pair: depGraph->inDegree) {
            if(pair.second == 0) {
                PlaneNode.push_back(pair.first);
                // for(auto& node: depGraph->adjList[pair.first]) {
                //     depGraph->inDegree[node]--;
                // }
                depGraph->inDegree[pair.first] = -1;
            }
        }
        #ifdef DEBUG_SCHED
            std::cout << "---PlaneNode---" << std::endl;
            for(auto& node: PlaneNode) {
                depGraph->depInfo->get_Sunit2InstMap()[node]->printfull();
            }
            std::cout << "---PlaneNodeEnd---" << std::endl;
        #endif
        
        for(auto it = PlaneNode.begin(); it != PlaneNode.end();) {
            if(CurCycle >= (*it)->get_latency()) {
                transfer(*it, PlaneNode, Available);
                for(auto& node: depGraph->adjList[*it]) {
                    depGraph->inDegree[node]--;
                }
                it = PlaneNode.erase(it);
            }
            else {
                (*it)->set_maxLatency(CurCycle + (*it)->get_latency());
                transfer(*it, PlaneNode, Pending);
                it = PlaneNode.erase(it);
            }
        }
        // the first sunit is the highest priority
        std::sort(Pending.begin(), Pending.end(), compareSunit);
        for(auto it = Pending.begin(); it != Pending.end();) {
            if(CurCycle >= (*it)->get_maxLatency()) {
                transfer(*it, Pending, Available);
                for(auto& node: depGraph->adjList[*it]) {
                    depGraph->inDegree[node]--;
                }
                it = Pending.erase(it);
                continue;
            }
            break;
        }

        auto getInstInfo = [&](Sunit* sunit) {
            return depGraph->depInfo->get_Sunit2InstMap()[sunit];
        };
        std::sort(Available.begin(), Available.end(), compareSunit);
        std::vector<Sunit *> temp;
        for(auto it = Available.begin(); it != Available.end();) {
            // Consider the pipeline
            if(isPipelineReady(getInstInfo(*it))) {
                transfer(*it, Available, Sequence);
                it = Available.erase(it);

            }
            else {
                transfer(*it, Available, temp);
                it = Available.erase(it);
            }
        }
        for(auto& it: temp) {
            transfer(it, temp, Available);
        }
        temp.clear();
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