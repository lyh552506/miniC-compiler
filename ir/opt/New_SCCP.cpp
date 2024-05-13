#include "New_SCCP.hpp"


// getFeasibleSuccessors - Return a vector of booleans to indicate which
// successors are reachable from a given terminator instruction.
void SCCPSolver::getFeasibleSuccessors(UnCondInst& inst, std::vector<bool>& Succs)
{
    Succs.resize(1);
    Succs[0] = true;
    return;
}

void SCCPSolver::getFeasibleSuccessors(CondInst& inst, std::vector<bool>& Succs)
{
    LatticeVal BCValue = getValueState(inst.Getuselist()[0]->usee);
    ConstantData* C = BCValue.getConstantInt();
    if(!C)
    {
        // Overdefined condition variables, and branches on unfoldable constant
        // conditions, mean the branch could go either way.
        if(!BCValue.isUnknown())
            Succs[0] = Succs[1] = true;
        return;
    }
    #ifdef SYSY_ENABLE_MIDDLE_END
        dbgs() << "Unknown terminator instruction: " << inst->GetName() << '\n';
    #endif
}

// isEdgeFeasible - Return true if the control flow edge from the 'From' basic
// block to the 'To' basic block is currently feasible.
bool SCCPSolver::isEdgeFeasible(BasicBlock* From, BasicBlock* To)
{
    assert(BBExecutable.count(To) && "Dest should always be alive!");

    // Make sure the source BasicBlock is executable!!
    if(!BBExecutable.count(From)) return false;

    // Check to make sure this edge itself is actually feasible now.
    User* inst = From->back();
    auto UnCond = dynamic_cast<UnCondInst*>(inst);
    auto Cond = dynamic_cast<CondInst*>(inst);
    if(UnCond || Cond)
    {
        if(UnCond)
            return true;
        LatticeVal BCValue = getValueState(inst->Getuselist()[0]->usee);

        // Overdefined condition vairables mean the branch could go either way,
        // undef conditions mean that neither edge is feasible yet.
        ConstantData* C = BCValue.getConstantInt();
        if(!C)
            return !BCValue.isUnknown();
        
        // Constant condition variables mean the branch can only go a single way.
        auto val = dynamic_cast<ConstIRBoolean*>(Cond->Getuselist()[0]->usee);
        if(val->GetVal())
        {
            BasicBlock* TrueSucc = dynamic_cast<BasicBlock*>(Cond->Getuselist()[1]->usee);
            return TrueSucc == To;
        }
        else
        {
            BasicBlock* FalseSucc = dynamic_cast<BasicBlock*>(Cond->Getuselist()[2]->usee);
            return FalseSucc == To;
        }
    }
    #ifdef SYSY_ENABLE_MIDDLE_END
        dbgs() << "Unknown terminator instruction: " << inst->GetName() << '\n';
    #endif
}

// visit Implementations - Something changed in this instruction, either an
// operand made a transition, or the instruction is newly executable.  Change
// the value type of I to reflect these changes if appropriate.  This method
// makes sure to do the following actions:
//
// 1. If a phi node merges two constants in, and has conflicting value coming
//    from different branches, or if the PHI node merges in an overdefined
//    value, then the PHI node becomes overdefined.
// 2. If a phi node merges only constants in, and they all agree on value, the
//    PHI node becomes a constant value equal to that.
// 3. If V <- x (op) y && isConstant(x) && isConstant(y) V = Constant
// 4. If V <- x (op) y && (isOverdefined(x) || isOverdefined(y)) V = Overdefined
// 5. If V <- MEM or V <- CALL or V <- (unknown) then V = Overdefined
// 6. If a conditional branch has a value that is constant, make the selected
//    destination executable
// 7. If a conditional branch has a value that is overdefined, make all
//    successors executable.
void SCCPSolver::visitPHINode(PhiInst& inst)
{
    if(getValueState(&inst).isOverdefined())
        return;  // Quick exit
    
    // Super-extra-high-degree Phi are unlikely to ever be marked constant,
    // and slow us down a lot. Just mark them overdefined.
    if(inst.oprandNum > 64)
        return markOverdefined(&inst);
    
    // Look at all of the executable operands of the PHI node.  If any of them
    // are overdefined, the PHI becomes overdefined as well.  If they are all
    // constant, and they agree with each other, the PHI becomes the identical
    // constant.  If they are constant and don't agree, the PHI is overdefined.
    // If there are no executable operands, the PHI remains unknown.
    ConstantData* OperandVal = nullptr;
    
}

