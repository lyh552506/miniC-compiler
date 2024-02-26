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

        if(inst->is_empty())
        {
            
        }

    }
  while (!WorkList.empty()) {
    Instruction *I = *WorkList.begin();
    WorkList.erase(WorkList.begin());    // Get an element from the worklist...

    if (!I->use_empty())                 // Don't muck with dead instructions...
      if (Constant *C = ConstantFoldInstruction(I, DL, TLI)) {
        // Add all of the users of this instruction to the worklist, they might
        // be constant propagatable now...
        for (User *U : I->users())
          WorkList.insert(cast<Instruction>(U));

        // Replace all of the uses of a variable with uses of the constant.
        I->replaceAllUsesWith(C);

        // Remove the dead instruction.
        WorkList.erase(I);
        if (isInstructionTriviallyDead(I, TLI)) {
          I->eraseFromParent();
          ++NumInstKilled;
        }

        // We made a change to the function...
        Changed = true;
      }
  }
  return Changed;
}
