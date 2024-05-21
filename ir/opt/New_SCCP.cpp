#include "New_SCCP.hpp"
#include "DCE.hpp"


int RemoveAllNonTerminatorInst(BasicBlock* block);

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
    Succs.resize(2);
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
    // Constant condition variables mean the branch can only go a single way.
    Succs[C->isZero()] = true;
    return;
    #ifdef SYSY_ENABLE_MIDDLE_END
        // dbgs() << "Unknown terminator instruction: " << inst->GetName() << '\n';
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
        // dbgs() << "Unknown terminator instruction: " << inst->GetName() << '\n';
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
void SCCPSolver::visitTerminatorInst(UnCondInst& inst)
{
    std::vector<bool> SuccFeasible;
    getFeasibleSuccessors(inst, SuccFeasible);

    BasicBlock* block = inst.GetParent();

    // Mark all feasible successors executable.
    for(int i = 0; i < SuccFeasible.size(); i++)
    {
        if(SuccFeasible[i])
            markEdgeExcutable(block, dynamic_cast<BasicBlock*>(inst.Getuselist()[i]->usee));
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
                // Could annihilate value.
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
        if(C)
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
    if(TrackedGlobals.empty() || !dynamic_cast<Variable*>(inst.Getuselist()[1]->usee))
        return;
    
    Variable* val = dynamic_cast<Variable*>(inst.Getuselist()[1]->usee);
    std::map<Variable*, LatticeVal>::iterator iter = TrackedGlobals.find(val);
    if(iter == TrackedGlobals.end() || iter->second.isOverdefined())
        return;
    
    // Get the value we are storing into the global, then merge it.
    mergeInValue(iter->second, Singleton<Module>().GetValueByName(val->get_name()), getValueState(inst.Getuselist()[0]->usee));
    if(iter->second.isOverdefined())
        TrackedGlobals.erase(iter); // No need to keep tracking this!
}

// Handle LoadInst. If the operand is a constant pointer to a constant global
// we can replace the load with the loaded constant value.
void SCCPSolver::visitLoadInst(LoadInst& inst)
{
    LatticeVal PtrVal = getValueState(inst.Getuselist()[0]->usee);
    if(PtrVal.isUnknown()) return;

    LatticeVal& LV = ValueState[&inst];
    if(LV.isOverdefined()) return;

    if(!PtrVal.isConstant())
        return markOverdefined(LV, &inst);
    
    ConstantData* Ptr = PtrVal.getConstantInt();

    // load null is undefined
    if(!dynamic_cast<ConstPtr*>(Ptr)) return;

    // Transform load (Constant Global) into the value loaded.
    // TODO
    // if(Variable* val = dynamic_cast<Variable*>(dynamic_cast<ConstPtr*>(Ptr)->GetVal()))
    // {
    //     if(!TrackedGlobals.empty())
    //     {
    //         // If we are tracking this global, merge in the known value for it.
    //         std::map<Variable*, LatticeVal>::iterator iter = TrackedGlobals.find(val);
    //         if(iter != TrackedGlobals.end())
    //         {
    //             mergeInValue(LV, &inst, iter->second);
    //             return;
    //         }
    //     }
    // }

    // TODO
    // Transform load from a constant into a constant if possible.
    // if(ConstantData* C = ConstantFolding::ConstantFoldLoadFromConstPtr(Ptr, Ptr->GetType()))
    // {
    //     if(dynamic_cast<UndefValue*>(C))
    //         return;
    //     return markConstant(LV, &inst, C);
    // }

    // otherwise we cannot say for certain what value this load will produce.
    // Bail out.
    markOverdefined(LV, &inst);
}

void SCCPSolver::visitCallSite(CallInst* inst)
{
    Function* func = dynamic_cast<Function*>(inst->Getuselist()[0]->usee);

    // If this is a local function that doesn't have its address taken, mark its
    // entry block executable and merge in the actual arguments to the call into
    // the formal arguments of the function.
    if(!TrackingIncomingArguments.empty() && TrackingIncomingArguments.count(func))
    {
        MarkBlockExecutabel(func->front());
        if(func->GetParams().size() != 0)
        {
            for(int i = 1, j = 0; i < inst->Getuselist().size(); i++, j++)  
            // i -> callinst arg ; j -> func param
            {
                Value* arg = inst->Getuselist()[i]->usee;
                Value* param = func->GetParams()[j].get();
                mergeInValue(arg, getValueState(param));
            }
        }
    }
    // If this is a single/zero retval case, see if we're tracking the function.
    std::map<Function*, LatticeVal>::iterator iter = TrackedRetVals.find(func);
    if(iter == TrackedRetVals.end())  // Not tracking this callee
    {
        // Void return and not tracking callee, just bail.
        if(inst->GetType()->GetTypeEnum() == InnerDataType::IR_Value_VOID)
            return;
        
        // Otherwise, if we have a single return value case, maybe we can constant fold it.
        // if(func)
        // TODO -> SCCP.cpp line 1041-1068
        return markAnythingOverdefined(inst);
    }

    mergeInValue(inst, iter->second);
}

void SCCPSolver::visit(User& inst)
{
    if(auto Phi = dynamic_cast<PhiInst*>(&inst))
        visitPHINode(*Phi);
    else if(auto Cond = dynamic_cast<CondInst*>(&inst))
        visitTerminatorInst(*Cond);
    else if(auto UnCond = dynamic_cast<UnCondInst*>(&inst))
        visitTerminatorInst(*UnCond);
    else if(auto Ret = dynamic_cast<RetInst*>(&inst))
        visitReturnInst(*Ret);
    else if(auto Binary = dynamic_cast<BinaryInst*>(&inst))
    {
        BinaryInst::Operation Op = Binary->getopration();
        if(Op == BinaryInst::Operation::Op_Add || Op == BinaryInst::Operation::Op_Sub ||
        Op == BinaryInst::Operation::Op_Mul || Op == BinaryInst::Operation::Op_Div ||
        Op == BinaryInst::Operation::Op_Mod || Op == BinaryInst::Operation::Op_And ||
        Op == BinaryInst::Operation::Op_Or)
            visitBinaryOperator(*Binary);
        else
            visitCmpInst(*Binary);
    }
    else if(auto Store = dynamic_cast<StoreInst*>(&inst))
        visitStoreInst(*Store);
    else if(auto Load = dynamic_cast<LoadInst*>(&inst))
        visitLoadInst(*Load);
    else if(auto GEP = dynamic_cast<GetElementPtrInst*>(&inst))
        visitGetElementPtrInst(*GEP);
    else if(auto Call = dynamic_cast<CallInst*>(&inst))
        visitCallInst(*Call);
    else if(auto Alloca = dynamic_cast<AllocaInst*>(&inst))
        visitAllocaInst(*Alloca);
    else
        visitInstruction(inst);
}

void SCCPSolver::visit_Block(BasicBlock* BB)
{
    for(User* inst : *BB)
        visit(*inst);
}

void SCCPSolver::Solve()
{
    // Process the work lists until they are empty!
    while(!BBWorkList.empty() || InstWorkList.empty() ||
    !OverdefinedInstWorkList.empty())
    {
        // Process the overdefined instruction's work list first, which drives other
        // things to overdefined more quickly.
        while(!OverdefinedInstWorkList.empty())
        {
            Value* inst = ::std::move(OverdefinedInstWorkList.back());
            OverdefinedInstWorkList.pop_back();
            // "inst" got into the work list because it either made the transition from
            // bottom to constant, or to overdefined.
            //
            // Anything on this worklist that is overdefined need not be visited
            // since all of its users will have already been marked as overdefined
            // Update all of the users of this instruction's value.
            for(Use* Use_ : inst->GetUserlist())
            {
                User* user = Use_->GetUser();
                OperandChangedState(user);
            }
        }

        // Process the instruction work list.
        while(!InstWorkList.empty())
        {
            Value* inst = ::std::move(InstWorkList.back());
            InstWorkList.pop_back();

            // "inst" got into the work list because it made the transition from undef to
            // constant.
            //
            // Anything on this worklist that is overdefined need not be visited
            // since all of its users will have already been marked as overdefined.
            // Update all of the users of this instruction's value.
            if(!getValueState(inst).isOverdefined())
            {
                for(Use* Use_ : inst->GetUserlist())
                {
                    User* user = Use_->GetUser();
                    OperandChangedState(user);
                }
            }
        }
            int a = 0;
        // Process the basic block work list.
        while(!BBWorkList.empty())
        {
            BasicBlock* Block = ::std::move(BBWorkList.back());
            BBWorkList.pop_back();

            // Notify all instructions in this BasicBlock that they 
            // are newly executable.
            visit_Block(Block);

            a++;
        }
        int b;
    }
}

/// ResolvedUndefsIn - While solving the dataflow for a function, we assume
/// that branches on undef values cannot reach any of their successors.
/// However, this is not a safe assumption.  After we solve dataflow, this
/// method should be use to handle this.  If this returns true, the solver
/// should be rerun.
///
/// This method handles this by finding an unresolved branch and marking it one
/// of the edges from the block as being feasible, even though the condition
/// doesn't say it would otherwise be.  This allows SCCP to find the rest of the
/// CFG and only slightly pessimizes the analysis results (by marking one,
/// potentially infeasible, edge feasible).  This cannot usefully modify the
/// constraints on the condition of the branch, as that would impact other users
/// of the value.
///
/// This scan also checks for values that use undefs, whose results are actually
/// defined.  For example, 'zext i8 undef to i32' should produce all zeros
/// conservatively, as "(zext i8 X -> i32) & 0xFF00" must always return zero,
/// even if X isn't defined.
bool SCCPSolver::ResolvedUndefsIn(Function& func)
{
    for(BasicBlock* block : func)
    {
        if(!BBExecutable.count(block)) continue;
        for(User* inst : *block)
        {
            // Look for instructions which produce undef values.
            if(inst->GetType()->GetTypeEnum() == InnerDataType::IR_Value_VOID)
                continue;
            
            LatticeVal& LV = getValueState(inst);
            if(!LV.isUnknown()) continue;

            // Compute the operand LatticeVals, for convenience below.

            LatticeVal Val1State = getValueState(inst->Getuselist()[0]->usee);
            LatticeVal Val2State;
            if(inst->Getuselist().size() == 2)
                Val2State = getValueState(inst->Getuselist()[1]->usee);

            // If this is an instructions whose result is defined even if the input is
            // not fully defined, propagate the information.
            InnerDataType tp = inst->GetType()->GetTypeEnum();
            if(auto Binary = dynamic_cast<BinaryInst*>(inst))
            {
                switch(Binary->getopration())
                {
                    case BinaryInst::Operation::Op_Add:
                        if(tp == InnerDataType::IR_Value_INT)
                            break;
                        // Floating-opint birany operation : be conservative
                        if(tp == InnerDataType::IR_Value_Float)
                        {
                            if(Val1State.isUnknown() && Val2State.isUnknown())
                                markForcedConstant(inst, ConstantData::getNullValue(inst->GetType()));
                            else
                                markOverdefined(inst);
                            return true;
                        }
                    case BinaryInst::Operation::Op_Sub:
                        if(tp == InnerDataType::IR_Value_INT)
                            break;
                        if(tp == InnerDataType::IR_Value_Float)
                        {
                            if(Val1State.isUnknown() && Val2State.isUnknown())
                                markForcedConstant(inst, ConstantData::getNullValue(inst->GetType()));
                            else
                                markOverdefined(inst);
                            return true;
                        }
                    case BinaryInst::Operation::Op_Mul:
                        if(tp == InnerDataType::IR_Value_Float)
                        {
                            if(Val1State.isUnknown() && Val2State.isUnknown())
                                markForcedConstant(inst, ConstantData::getNullValue(inst->GetType()));
                            else
                                markOverdefined(inst);
                            return true;
                        }
                        if(tp == InnerDataType::IR_Value_INT)
                        {
                            // Both operands undef -> undef
                            if(Val1State.isUnknown() && Val2State.isUnknown())
                                break;
                            // undef * X -> 0. X could be zero.
                            // undef & X -> 0. X could be zero.
                            if(Val1State.isUnknown() || Val2State.isUnknown())
                                markForcedConstant(inst, ConstantData::getNullValue(inst->GetType()));
                            return true;
                        }
                    case BinaryInst::Operation::Op_Div:
                        if(tp == InnerDataType::IR_Value_INT)
                        {
                            // X / undef -> undef. No change
                            if(Val1State.isUnknown())
                                break;
                            // X / 0 -> undef. No change
                            if(Val1State.isConstant() && dynamic_cast<ConstIRInt*>(Val1State.getConstantInt())->GetVal() == 0)
                                break;
                            // undef / X -> 0. X could be maxint.
                            if(Val1State.isUnknown() && !Val2State.isUnknown())
                                markForcedConstant(inst, ConstantData::getNullValue(inst->GetType()));
                            return true;
                        }
                        if(tp == InnerDataType::IR_Value_Float)
                        {
                            if(Val1State.isUnknown() && Val2State.isUnknown())
                                markForcedConstant(inst, ConstantData::getNullValue(inst->GetType()));
                            else
                                markOverdefined(inst);
                            return true;
                            /*
                            // X / undef -> undef
                            if(Val2State.isUnknown())
                                break;
                            // undef / X -> 0. X could be zero.
                            if(Val1State.isUnknown())
                                markForcedConstant(inst, ConstantData::getNullValue(inst->GetType()));
                            return true;
                            */
                        }
                    case BinaryInst::Operation::Op_Mod:
                        if(tp == InnerDataType::IR_Value_INT)
                        {
                            // X % undef -> undef. No change
                            if(Val1State.isUnknown())
                                break;
                            // X % 0 -> undef. No change
                            if(Val1State.isConstant() && dynamic_cast<ConstIRInt*>(Val1State.getConstantInt())->GetVal() == 0)
                                break;
                            // undef % X -> 0. X could be 1.
                            if(Val1State.isUnknown() && !Val2State.isUnknown())
                                markForcedConstant(inst, ConstantData::getNullValue(inst->GetType()));
                            return true;
                        }
                    case BinaryInst::Operation::Op_And:
                        // Both operands undef -> undef
                        if(Val1State.isUnknown() && Val2State.isUnknown())
                            break;
                        // undef & X -> 0. X could be zero.
                        if(Val1State.isUnknown() || Val2State.isUnknown())
                            markForcedConstant(inst, ConstantData::getNullValue(inst->GetType()));
                        return true;
                    case BinaryInst::Operation::Op_Or:
                        // Both operands undef -> undef
                        if(Val1State.isUnknown() && Val2State.isUnknown())
                            break;
                        // undef | X -> true.
                        markForcedConstant(inst, ConstIRBoolean::GetNewConstant(true));
                        return true;
                    case BinaryInst::Operation::Op_E:
                        // X == undef -> undef. Other comparisons get more compilcated.
                        if(Val1State.isUnknown() || Val2State.isUnknown())
                            break;
                        markOverdefined(inst);
                        return true;
                    case BinaryInst::Operation::Op_G:
                    case BinaryInst::Operation::Op_GE:
                    case BinaryInst::Operation::Op_L:
                    case BinaryInst::Operation::Op_LE:
                    case BinaryInst::Operation::Op_NE:
                        markOverdefined(inst);
                        return true;
                }
            }
            else if(auto zext = dynamic_cast<ZextInst*>(inst))
            {
                // undef -> 0; some outputs are impossible.
                markForcedConstant(inst, ConstantData::getNullValue(inst->GetType()));
                return true;
            }
            else if(auto fptsi = dynamic_cast<FPTSI*>(inst))
            {
                // undef -> 0; some outputs are impossible.
                markForcedConstant(inst, ConstantData::getNullValue(inst->GetType()));
                return true;
            }
            else if(auto sitfp = dynamic_cast<SITFP*>(inst))
            {
                // undef -> 0; some outputs are impossible.
                markForcedConstant(inst, ConstantData::getNullValue(inst->GetType()));
                return true;
            }
            else if(auto Call = dynamic_cast<CallInst*>(inst))
            {
                // There are two reasons a call can have an undef result
                // 1. It could be tracked.
                // 2. It could be constant-foldable.
                // Because of the way we solve return values, tracked calls must
                // never be marked overdefined in ResolvedUndefsIn.
                if(Function* func = dynamic_cast<Function*>(Call->Getuselist()[0]->usee))
                {
                    if(TrackedRetVals.count(func))
                        break;
                    // If the call is constant-foldable, we mark it overdefined because
                    // we do not know what return values are valid.
                    markOverdefined(inst);
                    return true;
                }
            }
            else
            {
                // If we don't know what should happen here, conservatively mark it
                // overdefined.
                markOverdefined(inst);
                return true;
            }
        }
        // Check to see if we have a branch on an undefined value.  If so
        // we force the branch to go one way or the other to make the successor
        // values live.  It doesn't really matter which way we force it.
        User* inst = block->back();
        if(dynamic_cast<CondInst*>(inst))
        {
            if(!getValueState(inst->Getuselist()[0]->usee).isUnknown())
                continue;
            // If the input to SCCP is actually branch on undef, fix the undef to
            // false.
            if(dynamic_cast<UndefValue*>(inst->Getuselist()[0]->usee))
            {
                inst->Getuselist()[0]->usee = ConstIRBoolean::GetNewConstant(false);
                markEdgeExcutable(block, dynamic_cast<BasicBlock*>(inst->Getuselist()[2]->usee));
                return true;
            }
            // Otherwise, it is a branch on a symbolic value which is currently
            // considered to be undef.  Handle this by forcing the input value to the
            // branch to false.
            markConstant(inst->Getuselist()[0]->usee, ConstIRBoolean::GetNewConstant(false));
            return true;
        }
    }
    return false;
}

static bool tryToReplaceWithConstant(SCCPSolver& Solver, Value* val)
{
    ConstantData* Const = nullptr;
    LatticeVal LV = Solver.getLatticeValueFor(val);
    if(LV.isOverdefined())
        return false;
    Const = LV.isConstant() ? LV.getConstantInt() : UndefValue::get(val->GetType());
    assert(Const && "Constant is nullptr here!");
    #ifdef SYSY_ENABLE_MIDDLE_END
        // DEBUG(dbgs() << "  Constant: " << *Const << " = " << *V << '\n');
    #endif
    // Replaces all of the uses of a variable with uses of the constant.
    val->RAUW(Const);
    return true;
}
/*
void SCCPSolver::OperandChangedState(User* inst)
{
    // If the instruction is overdefined, there is no need to do anything.
    if(getValueState(inst).isOverdefined())
        return;
    
    // If the instruction is not overdefined, we need to check if it is a constant
    // or not. If it is a constant, we need to update the value state of the instruction.
    if(inst->isConst())
    {
        if(tryToReplaceWithConstant(*this, inst))
            return;
    }
    // If the instruction is not a constant, we need to check if it is a user or not.
    // If it is a user, we need to update the value state of the instruction.
    if(dynamic_cast<User*>(inst))
    {
        if(tryToReplaceWithConstant(*this, inst))
            return;
    }
    // If the instruction is not a user, we need to check if it is a constant data or not.
    // If it is a constant data, we need to update the value state of the instruction.
    if(dynamic_cast<ConstantData*>(inst))
    {
        if(tryToReplaceWithConstant(*this, inst))
            return;
    }
}
*/

// runSCCP() - Run the Sparse Conditional Constant Propagation algorithm, 
// and return true if the program was modified.
bool SCCPSolver::runSCCP(Function& func)
{
    #ifdef SYSY_ENABLE_MIDDLE_END
    // DEBUG(dbgs() << "SCCP on function '" << func.GetName() << "'\n");
    #endif
    SCCPSolver Solver;
    int NumDeadBlocks = 0;
    int NumInstRemoved = 0;
    // Mark the first block of the function as being executable.
    Solver.MarkBlockExecutabel(func.front());

    // Mark all arguments to the function as being overdefined.
    for(auto& param_ : func.GetParams())
        Solver.markAnythingOverdefined(param_.get());
    
    //Solve for constants.
    bool ResolvedUndefs = true;
    while(ResolvedUndefs)
    {
        Solver.Solve();
        #ifdef SysY_ENABLE_MIDDLE_END
        DEBUG(dbgs() << "RESOLVING UNDEFs\n");
        #endif
        ResolvedUndefs = Solver.ResolvedUndefsIn(func);
    }
    
    bool MadeChanges = false;

    // If we decided that there are basic blocks that are dead in this function,
    // delete their contents now.  Note that we cannot actually delete the blocks,
    // as we cannot modify the CFG of the function.

    for(BasicBlock* block : func)
    {
        if(!Solver.isBlockExcutable(block))
        {
            #ifdef SysY_ENABLE_MIDDLE_END
            DEBUG(dbgs() << "  BasicBlock Dead:" << block->GetName());
            #endif

            ++NumDeadBlocks;

            NumInstRemoved += RemoveAllNonTerminatorInst(block);

            MadeChanges = true;
            continue;
        }

        // Iterate over all of the instructions in a function, replacing them with
        // constants if we have found them to be of constant values.
        for(User* inst : *block)
        {
            if(inst->GetType()->GetTypeEnum() == IR_Value_VOID || inst == block->back())
                continue;
            
            if(tryToReplaceWithConstant(Solver, inst))
            {
                if(DCE::isDeadInst(inst))
                {
                    inst->ClearRelation();
                    inst->EraseFromParent();

                    MadeChanges = true;
                    ++NumInstRemoved;
                }
            }
        }
    }
    return MadeChanges;
}


int RemoveAllNonTerminatorInst(BasicBlock* block)
{
    int NumDeadInst = 0;
    // Delete the instructions backwards, as it has a reduced likelihood of
    // having to update as many def-use and use-def chains.
    for(auto iter = block->rbegin(); iter != block->rend(); ++iter)
    {
        User* inst = *iter;
        if(!inst->GetUserlist().is_empty())
        {
            inst->RAUW(UndefValue::get(inst->GetType()));
            ++NumDeadInst;
            inst->ClearRelation();
            inst->EraseFromParent();
        }
    }
    return NumDeadInst;
}