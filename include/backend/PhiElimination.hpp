#pragma once
#include "../../include/backend/BackendPass.hpp"
#include "../../include/backend/RISCVContext.hpp"

/// @note use this after instruction selection
/// @note do not change any piece of basicblock and their jump target
class PhiElimination: public BackEndPass<Function>{
    RISCVLoweringContext& cxt;
    std::map<BasicBlock*,std::map<BasicBlock*,RISCVBasicBlock*>> CopyBlockFinder;
    RISCVBasicBlock* find_copy_block(BasicBlock*,BasicBlock*);
    void runOnGraph(BasicBlock* pred,BasicBlock* succ,std::vector<std::pair<RISCVMOperand*,RISCVMOperand*>>&);
    void runonBasicBlock(BasicBlock* dst);
    public:
    bool run(Function*)override;
    PhiElimination(RISCVLoweringContext& _cxt):cxt(_cxt){};
};