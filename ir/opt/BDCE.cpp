#include "BDCE.hpp"

void DCE::Pass()
{

}
// static bool eliminateDeadCode(Function &F, TargetLibraryInfo *TLI) {
//   bool MadeChange = false;
//   SmallSetVector<Instruction *, 16> WorkList;
//   // Iterate over the original function, only adding insts to the worklist
//   // if they actually need to be revisited. This avoids having to pre-init
//   // the worklist with the entire function's worth of instructions.
//   for (inst_iterator FI = inst_begin(F), FE = inst_end(F); FI != FE;) {
//     Instruction *I = &*FI;
//     ++FI;

//     // We're visiting this instruction now, so make sure it's not in the
//     // worklist from an earlier visit.
//     if (!WorkList.count(I))
//       MadeChange |= DCEInstruction(I, WorkList, TLI);
//   }

//   while (!WorkList.empty()) {
//     Instruction *I = WorkList.pop_back_val();
//     MadeChange |= DCEInstruction(I, WorkList, TLI);
//   }
//   return MadeChange;
// }

bool DCE::RunOnBlock(BasicBlock* block)
{
    bool Changed = false;
    for(User* inst : *block)
    {
        if(isDeadInst(inst))
        {
            inst->EraseFromParent();
            Changed = true;
        }
    }
    return Changed;
}

bool DCE::DCEInst(User* inst, std::vector<User*> Worklist)
{
    if(isDeadInst(inst))
    {
        for(auto& use_ : inst->Getuselist())
        {
            Value* op = use_->usee;
            if(!op->GetUserlist().is_empty() || inst == op)
                continue;
            if(User* inst_ = dynamic_cast<User*>(op))
            {
                if(isDeadInst(inst_))
                    Worklist.push_back(inst_);
            }
        }
        inst->ClearRelation();
        inst->EraseFromParent();
        return true;
    }
    return false;
}

bool DCE::isDeadInst(User* inst)
{

}