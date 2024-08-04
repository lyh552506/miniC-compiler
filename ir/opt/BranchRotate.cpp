#include "../../include/ir/opt/BranchRotate.hpp"
#include "../../include/lib/BaseCFG.hpp"
#include "../../include/lib/CFG.hpp"
#include "../../include/lib/Singleton.hpp"

bool BranchRotate::Run()
{
    /*
    Test for And Or 
    Value *op1 = ConstIRBoolean::GetNewConstant(true);
    Value *op2 = ConstIRBoolean::GetNewConstant(false);
    auto binary = new BinaryInst(op1, BinaryInst::Op_And, op2);
    BasicBlock* block = func->front();
    block->push_front(binary);
    */
   bool modified = false;
   std::vector<std::pair<BasicBlock*, std::set<PhiInst*>>> NeedHandle;
   modified |= Handle(NeedHandle);
   ReWritePhi(NeedHandle);
   return modified;
}
