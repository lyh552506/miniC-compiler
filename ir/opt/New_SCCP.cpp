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
    for(unsigned i = 0, e = inst.oprandNum; i != e; ++i)
    {
        LatticeVal LV = getValueState(inst.GetVal(i));
        if(LV.isUnknown()) continue; // Doesn't influence PhiNode.

        if(!isEdgeFeasible(inst.GetBlock(i), inst.GetParent()))
            continue;

        if(LV.isOverdefined()) // PhiNode becomes overdefined !
            return markOverdefined(&inst);
        
        if(!OperandVal) // Grab the first value.
        {
            OperandVal = LV.getConstantInt();
            continue;
        }
        // There is already a reachable operand.  If we conflict with it,
        // then the PHI node becomes overdefined.  If we agree with it, we
        // can continue on.

        // Check to see if there are two different constants merging, if so, the PHI
        // node is overdefined.
        if(LV.getConstantInt() != OperandVal)
            return markOverdefined(&inst);
    }

    // If we exited the loop, this means that the PHI node only has constant
    // arguments that agree with each other(and OperandVal is the constant) or
    // OperandVal is null because there are no defined incoming arguments.  If
    // this is the case, the PHI remains unknown.
    if(OperandVal)
        markConstant(&inst, OperandVal);  // Acquire operand value
}

void SCCPSolver::visitReturnInst(RetInst& inst)
{
    if(inst.Getuselist().size() == 0)  // return void
        return;
    
    Function* func = inst.GetParent()->GetParent();
    Value* ResultOp = inst.Getuselist()[0]->usee;

    // If we tracking the return value of this function, merge it in.
    if(!TrackedRetVals.empty())
    {
        std::map<Function*, LatticeVal>::iterator iter = TrackedRetVals.find(func);
        if(iter != TrackedRetVals.end())
        {
            mergeInValue(iter->second, func, getValueState(ResultOp));
            return;
        }
    }

    // Handle functions that return multiple values.
    if(!TrackedMultipleRetVals.empty())
    {
        std::vector<Value*> RetVals;
        for(BasicBlock* block : *(inst.GetParent()->GetParent()))
        {
            User* inst_ = block->back();
            if(dynamic_cast<RetInst*>(inst_))
            {
                if(!inst_->Getuselist().empty())
                    RetVals.push_back(inst_->Getuselist()[0]->usee);
            }
        }
        for(int i = 0; i < RetVals.size(); i++)
        {
            mergeInValue(TrackedMultipleRetVals[std::make_pair(func, i)], 
            func, getValueState(RetVals[i]));
        }
    }
}

void SCCPSolver::visitTerminatorInst(CondInst& inst)
{
    std::vector<bool> SuccFeasible;
    getFeasibleSuccessors(inst, SuccFeasible);

    BasicBlock* block = inst.GetParent();

    // Mark all feasible successors executable.
    for(int i = 0; i < SuccFeasible.size(); i++)
    {
        if(SuccFeasible[i])
            markEdgeExcutable(block, dynamic_cast<BasicBlock*>(inst.Getuselist()[i + 1]->usee));
    }
}

void SCCPSolver::visitBinaryOperator(BinaryInst& inst)
{
    LatticeVal Val1State = getValueState(inst.Getuselist()[0]->usee);
    LatticeVal Val2State = getValueState(inst.Getuselist()[1]->usee);

    LatticeVal& LV = ValueState[&inst];
    if(LV.isOverdefined()) return;

    if(Val1State.isConstant() && Val2State.isConstant())
    {
        ConstantData* C = ConstantFolding::ConstFoldBinary(inst.getopration(), Val1State.getConstantInt(), Val2State.getConstantInt()); 

        // X op Y -> undef
        if(dynamic_cast<UndefValue*>(C))
            return;
        return markConstant(LV, &inst, C);
    }
    
    // If something is undef, wait for it to resolve.
    if(!Val1State.isOverdefined() && !Val2State.isOverdefined())
        return;
    
    // Otherwise, one of our operands is overdefined.  Try to produce something
    // better than overdefined with some tricks.

    // If this is an AND or OR with 0 or -1, it doesn't matter that the other
    // operand is overdefined.
    // may be to delete, because no such operation in sysy
    if(inst.getopration() == BinaryInst::Operation::Op_And
    || inst.getopration() == BinaryInst::Operation::Op_Or)
    {
        LatticeVal* NonOverdefVal = nullptr;
        if(!Val1State.isOverdefined())
            NonOverdefVal = &Val1State;
        else if(!Val2State.isOverdefined())
            NonOverdefVal = &Val2State;
        
        if(NonOverdefVal)
        {
            if(NonOverdefVal->isUnknown())
            {
                // Counld annihilate value.
                if(inst.getopration() == BinaryInst::Operation::Op_And)
                    markConstant(LV, &inst, ConstIRBoolean::GetNewConstant(false));
                else
                    markConstant(LV, &inst, ConstIRBoolean::GetNewConstant(true));
                return;
            }

            if(inst.getopration() == BinaryInst::Operation::Op_And)
            {
                // X and 0 = 0
                if(!dynamic_cast<ConstIRBoolean*>(NonOverdefVal->getConstantInt())->GetVal())
                    return markConstant(LV, &inst, ConstIRBoolean::GetNewConstant(false));
            }
            else  // X or 1 = 1
            {
                if(dynamic_cast<ConstIRBoolean*>(NonOverdefVal->getConstantInt())->GetVal())
                    return markConstant(LV, &inst, ConstIRBoolean::GetNewConstant(true));
            }
        }
    }

    markOverdefined(&inst);
}

// Handle CmpInst 
void SCCPSolver::visitCmpInst(BinaryInst& inst)
{
    LatticeVal Val1State = getValueState(inst.Getuselist()[0]->usee);
    LatticeVal Val2State = getValueState(inst.Getuselist()[1]->usee);

    LatticeVal& LV = ValueState[&inst];
    if(LV.isOverdefined()) return;

    if(Val1State.isConstant() && Val2State.isConstant())
    {
        ConstantData* C = ConstantFolding::ConstFoldBinary(inst.getopration(), Val1State.getConstantInt(), Val2State.getConstantInt()); 

        // X op Y -> undef
        if(dynamic_cast<UndefValue*>(C))
            return;
        return markConstant(LV, &inst, C);
    }

    // If operands are still unknown, wait for it to resolve.
    if(!Val1State.isOverdefined() && !Val2State.isOverdefined())
        return;
    
    markOverdefined(&inst);
}

// Handle getelementptr instructions.  If all operands are constants then we
// can turn this into a getelementptr ConstantExpr.

void SCCPSolver::visitGetElementPtrInst(GetElementPtrInst& inst)
{
    if(ValueState[&inst].isOverdefined()) return;

    std::vector<Value*> Operands;
    Operands.reserve(inst.Getuselist().size());

    for(int i = 0; i < inst.Getuselist().size(); ++i)
    {
        LatticeVal State = getValueState(inst.Getuselist()[i + 1]->usee);
        if(State.isUnknown())
            return;  // Operands are not resolved yet.
        
        if(State.isOverdefined())
            return markOverdefined(&inst);
        
        assert(State.isConstant() && "Unknown state!");
        Operands.push_back(State.getConstantInt());
    }

    // TODO : Support for GEP ConstantExpr
    // ConstantData* C = ConstantFolding::ConstantFoldInst(&inst);
    // if(dynamic_cast<UndefValue*>(C))
        // return;
    // markConstant(&inst, C);
    
}

void SCCPSolver::visitStoreInst(StoreInst& inst)
{

}


