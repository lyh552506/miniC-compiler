#include "ConstantFold.hpp"
#include <set>

class ConstantProp : public ConstantFolding
{
    bool RunOnBlock(BasicBlock &block);
    private:
    bool changed = false;
};

bool ConstantProp::RunOnBlock(BasicBlock &block) 
{
  // Initialize the worklist to all of the instructions ready to process...
    std::set<User*> WorkList;
    for(User* inst:block)
        WorkList.insert(inst);
    while(!WorkList.empty())
    {
        User* inst = *WorkList.begin();
        WorkList.erase(WorkList.begin()); // Get an element from the worklist
        if(inst->Getuselist().empty())
        {
            if(Value *C = ConstantFoldInstruction(inst, &block))
            {
            // Add all of the users of this instruction to the worklist, they might
            // be constant propagatable now...
            for(Use* U:inst->GetUserlist())
                WorkList.insert(U->GetUser());
            // Replace all of the uses of a variable with uses of the constant.
            inst->RAUW(C);
            // Remove the dead instruction.
            WorkList.erase(inst);
            if(isInstructionTriviallyDead(inst))
                inst->EraseFromParent();
            // We made a change to the function.
            changed = true;
        }
        return changed;
    }
    }
}
