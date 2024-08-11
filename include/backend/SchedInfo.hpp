#pragma once 
#include "RISCVMIR.hpp"
using ISA = RISCVMIR::RISCVISA;
enum PIPELINE : uint32_t{
    PipelineVoid = 0,
    PipelineA = 1 << 0,
    PipelineB = 1 << 1,
    PipelineAB = PipelineA | PipelineB,
    PipelineDiv = 1 << 2,
    PipelineFDiv = 1 << 3
};
class SchedInfo {
    friend class DependencyGraph;
private:
    uint32_t WriteRes;
    uint32_t ReadAdvance;
    uint32_t Pipeline;
public:
    SchedInfo(ISA op) {
        if(op>ISA::BeginShift && op<ISA::EndShift) {
            WriteRes = 3;
            ReadAdvance = 2;
            Pipeline = PipelineAB;
        }
        else if(op>ISA::BeginArithmetic && op<=ISA::_subw) {
            WriteRes = 3;
            ReadAdvance = 2;
            Pipeline = PipelineAB;
        }
        else if(op==ISA::_lui) {
            WriteRes = 3;
            ReadAdvance = 0;
            Pipeline = PipelineAB;
        }
        else if(op>=ISA::_mul && op<=ISA::_mulw) {
            WriteRes = 3;
            ReadAdvance = 2;
            Pipeline = PipelineB;
        }
        else if(op>=ISA::_div && op<=ISA::_remu) {
            WriteRes = 66;
            // Release = [1, 65]
            ReadAdvance = 2;
            Pipeline = PipelineDiv;
        }
        else if(op>=ISA::_divw && op<ISA::EndArithmetic) {
            WriteRes = 34;
            // Release = [1, 33]
            ReadAdvance = 2;
            Pipeline = PipelineDiv;
        }
        else if(op>ISA::BeginLogic && op<ISA::EndLogic) {
            WriteRes = 3;
            ReadAdvance = 2;
            Pipeline = PipelineB;
        }
        else if(op>ISA::BeginComp && op<ISA::EndComp) {
            WriteRes = 3;
            ReadAdvance = 2;
            Pipeline = PipelineAB;
        }
        else if(op>ISA::BeginBranch && op<ISA::EndBranch) {
            assert(0 && "Branch not supported");
        }
        else if(op>ISA::BeginJumpAndLink && op<ISA::EndJumpAndLink) {
            assert(0 && "Jump not supported");
        }
        else if(op>ISA::BeginLoadMem && op<ISA::EndLoadMem) {
            WriteRes = 3;
            ReadAdvance = 2;
            Pipeline = PipelineA;
        }
        else if(op>ISA::BeginStoreMem && op<ISA::EndStoreMem) {
            WriteRes = 3;
            ReadAdvance = 0;
            Pipeline = PipelineA;
        }
        else if(op>ISA::BeginFloatMV && op<ISA::EndFloatMV) {
            WriteRes = 3;
            ReadAdvance = 0;
            Pipeline = PipelineB;
        }
        else if(op>ISA::BeginFloatConvert && op<ISA::EndFloatConvert) {
            WriteRes = 3;
            ReadAdvance = 0;
            Pipeline = PipelineB;
        }
        else if(op>ISA::BeginFloatLoadMem && op<ISA::EndFloatLoadMem) {
            WriteRes = 2;
            ReadAdvance = 0;
            Pipeline = PipelineA;
        }
        else if(op>ISA::BeginFloatStoreMem && op<ISA::EndFloatStoreMem) {
            WriteRes = 3;
            ReadAdvance = 0;
            Pipeline = PipelineA;
        }
        else if(op>ISA::BeginFloatArithmetic && op<=ISA::_fnmsub_s) {
            WriteRes = 5;
            ReadAdvance = 0;
            Pipeline = PipelineB;
        }
        else if(op==ISA::_fdiv_s) {
            WriteRes = 27;
            // Release = [1, 26]
            ReadAdvance = 0;
            Pipeline = PipelineFDiv;
        }
        else if(op==ISA::_fsqrt_s) {
            WriteRes = 27;
            // Release = [1, 27]
            ReadAdvance = 0;
            Pipeline = PipelineFDiv;
        }
        else if(op>=ISA::_fsgnj_s && op<=ISA::_fge_s) {
            WriteRes = 3;
            ReadAdvance = 0;
            Pipeline = PipelineB;
        }
        else if(op==ISA::mv || op==ISA::li) {
            WriteRes = 3;
            ReadAdvance = 2;
            Pipeline = PipelineAB;
        }
        else if(op==ISA::call || op==ISA::ret) {
            // call inst will be deleted in adjlist and indegree map;
            // assert(0 && "Call and Ret not supported");
        }
        else if(op==ISA::LoadGlobalAddr) {
            // lui + addi
            WriteRes = 6;
            ReadAdvance = 2;
            Pipeline = PipelineAB;
        }
        else if(op==ISA::LoadImmReg) {
            // int: li
            // float: lui + flw
            WriteRes = 5;
            ReadAdvance = 2;
            Pipeline = PipelineA;
        }
        else if(op==ISA::LoadLocalAddr) {
            // addi
            WriteRes = 3;
            ReadAdvance = 2;
            Pipeline = PipelineAB;
        }
        else if(op==ISA::MarkDead) {
            assert(0 && "MarkDead not supported");
        }
        else if(op==ISA::LoadImm12) {
            WriteRes = 1;
            ReadAdvance = 0;
            Pipeline = PipelineAB;
        }
        else if(op==ISA::LoadImm32) {
            WriteRes = 3;
            ReadAdvance = 0;
            Pipeline = PipelineAB;
        }
        else if(op==ISA::LoadFromStack) {
            WriteRes = 6;
            // ReadAdvance = 0;
            // Pipeline = PipelineAB;
        }
        // else if(op==ISA::StackAlloc) {
        //     WriteRes = 0;
        //     ReadAdvance = 0;
        //     Pipeline = PipelineVoid;
        // }
    }
    inline uint32_t get_Pipeline() {return Pipeline;}
};