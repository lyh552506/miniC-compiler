#include "CFG.hpp"
#include "dominant.hpp"
#include "ConstantFold.hpp"
class LatticeVal
{
    enum LatticeValueTy
    {
        unknown,
        constant,
        forcedconstant,
        overdefined
    };
    std::pair<Value*, LatticeValueTy> Val;
    LatticeValueTy getLatticeValue() const { return Val.second; }

public:
    LatticeVal() : Val(nullptr, unknown) {}
    bool isUnknown() const { return getLatticeValue() == unknown; }
    bool isConstant() const
    {
        return getLatticeValue() == constant ||
        getLatticeValue() == forcedconstant;
    }
    bool isOverdefined() const { return getLatticeValue() == overdefined; }
    
    Value* Getval() const { return Val.first; }
    
    // markOverdefined - Return true if this is a change in status.
    bool markOverdefined()
    {
        if(isOverdefined())
            return false;
        
        Val.second = overdefined;
        return true;
    }

    // markConstant - Return true if this is a change in status.
    bool markConstant(ConstantData* val)
    {
        if(getLatticeValue() == constant){
            assert(Getval() == val && "Marking constant with different value");
            return false;
        }

        if(isUnknown())
        {
            Val.second = constant;
            assert(val && "Marking constant with nullptr");
            Val.first = val;
        }
        else
        {
            assert(getLatticeValue() == forcedconstant &&
            "Cannot move from overdefined to constant!");

            // Stay at forcedconstant if the constant is the same.
            if(val == Getval())
                return false;
            Val.second = overdefined;
        }
        return true;
    }

    // getConstantInt - If this is aconstant with a ConstantInt value
    // return it otherwise return nullptr.
    ConstantData* getConstantInt() const
    {
        if(isConstant())
            return static_cast<ConstantData*>(Getval());
        return nullptr;
    }

    void markForcedConstant(ConstantData* val)
    {
        assert(isUnknown() && "Cannot force a defined value");
        Val.first = val;
        Val.second = forcedconstant;
    }
}; 

class SCCPSolver
{
public:
    static bool runSCCP(Function& func);
private:
    std::set<BasicBlock*> BBExecutable;  // The BBs that are executable.
    std::map<Value*, LatticeVal> ValueState; // The state each value is in.
    
    /// GlobalValue - If we are tracking any values for the contents of a global
    /// variable, we keep a mapping from the constant accessor to the element of
    /// the global, to the currently known value.  If the value becomes
    /// overdefined, it's entry is simply removed from this map.
    std::map<Variable*, LatticeVal> TrackedGlobals;

    /// TrackedRetVals - If we are tracking arguments into and the return
    /// value out of a function, it will have an entry in this map, indicating
    /// what the known return value for the function is.
    std::map<Function*, LatticeVal> TrackedRetVals;

    /// TrackedMultipleRetVals - Same as TrackedRetVals, but used for functions
    /// that return multiple values.
    std::map<std::pair<Function*, unsigned>, LatticeVal> TrackedMultipleRetVals;

    /// TrackingIncomingArguments - This is the set of functions for whose
    /// arguments we make optimistic assumptions about and try to prove as
    /// constants. 
    std::set<Function*> TrackingIncomingArguments;

    /// The reason for two worklists is that overdefined is the lowest state
    /// on the lattice, and moving things to overdefined as fast as possible
    /// makes SCCP converge much faster.
    ///
    /// By having a separate worklist, we accomplish this because everything
    /// possibly overdefined will become overdefined at the soonest possible
    /// point.
    std::vector<Value*> OverdefinedInstWorkList;
    std::vector<Value*> InstWorkList;
    
    std::vector<BasicBlock*> BBWorkList; // The BasicBlock work list.

    /// KnownFeasibleEdges - Entries in this set are edges which have already had
    /// PHI nodes retriggered.
    typedef std::pair<BasicBlock*, BasicBlock*> Edge;
    std::set<Edge> KnownFeasibleEdges;

public:
    SCCPSolver() = default;
    /// MarkBlockExecutable - This method can be used by clients to mark all of
    /// the blocks that are known to be intrinsically live in the processed unit.
    ///
    /// This returns true if the block was not considered live before.
    bool MarkBlockExecutabel(BasicBlock* block)
    {
        if(!BBExecutable.insert(block).second)
            return false;
        #ifdef SYSY_ENABLE_MIDDLE_END
        // DEBUG(dbgs() << "Marking Block Executable: " << block->GetName() << '\n');
        #endif
        BBWorkList.push_back(block); // Add the block to the work list!
        return true;
    }

    /// TrackValueOfGlobalVariable - Clients can use this method to
    /// inform the SCCPSolver that it should track loads and stores to the
    /// specified global variable if it can.  This is only legal to call if
    /// performing Interprocedural SCCP.
    void TrackValueOfGlobalVariable(Variable* val)
    {
        // We only track the contents of scalar globals.
        if(val->GetType()->GetTypeEnum() == InnerDataType::IR_Value_INT ||
        val->GetType()->GetTypeEnum() == InnerDataType::IR_Value_Float ||
        val->GetType()->GetTypeEnum() == InnerDataType::IR_PTR)
        {
            LatticeVal& LV = TrackedGlobals[val];
            if(val->GetInitializer())
                LV.markConstant(dynamic_cast<ConstantData*>(val->GetInitializer()));
        }
    }

    /// AddTrackedFunction - If the SCCP solver is supposed to track calls into
    /// and out of the specified function (which cannot have its address taken),
    /// this method must be called.
    void AddTrackedFunction(Function* func)
    {
        // Add an entry, Func -> undef
        TrackedRetVals.insert(std::make_pair(func, LatticeVal()));
    }

    void AddArgumentTrackedFunction(Function* func)
    {
        TrackingIncomingArguments.insert(func);
    }

    /// Solve - Solve for constants and excutable blocks.
    void Solve();

    /// ResolvedUndefsIn - While solving the dataflow for a function, we assume
    /// that branches on undef values cannot reach any of their successors.
    /// However, this is not a safe assumption.  After we solve dataflow, this
    /// method should be use to handle this.  If this returns true, the solver
    /// should be rerun.
    bool ResolvedUndefsIn(Function& func);

    bool isBlockExcutable(BasicBlock* block) const
    {
        return BBExecutable.count(block);
    }

    LatticeVal getLatticeValueFor(Value* val) const
    {
        std::map<Value*, LatticeVal>::const_iterator iter = ValueState.find(val);
        assert(iter != ValueState.end() && "Val is not in valuemap!");
        return iter->second;
    }

    /// getTrackedRetVals - Get the inferred return value map.
    const std::map<Function*, LatticeVal>& getTrackedRetVals()
    {
        return TrackedRetVals;
    }
    /// getTrackedGlobals - Get and return the set of inferred initializers for
    /// global variables.
    const std::map<Variable*, LatticeVal>& getTrackedGlobals()
    {
        return TrackedGlobals;
    }
    
    void markOverdefined(Value* val)
    {
        markOverdefined(ValueState[val], val);
    }

    /// markAnythingOverdefined - Mark the specified value overdefined.  This
    /// works with both scalars and structs.
    void markAnythingOverdefined(Value* val)
    {
        markOverdefined(val);
    }
private:
    // pushToWorkList - Helper for markConstant/markForcedConstant
    void pushToWorkList(LatticeVal& LV, Value* val)\
    {
        if(LV.isOverdefined())
            return OverdefinedInstWorkList.push_back(val);
        InstWorkList.push_back(val);
    }
    // markConstant - Make a value be marked as "constant".  If the value
    // is not already a constant, add it to the instruction work list so that
    // the users of the instruction are updated later.
    void markConstant(LatticeVal& LV, Value* val, ConstantData* C)
    {
        if(!LV.markConstant(C)) return;
        #ifdef SYSY_ENABLE_MIDDLE_END
        // DEBUG(dbgs() << "markConstant: " << *C << ": " << *val << '\n');
        #endif
        pushToWorkList(LV, val); 
    }

    void markConstant(Value* val, ConstantData* C)
    {
        markConstant(ValueState[val], val, C);
    }

    void markForcedConstant(Value* val, ConstantData* C)
    {
        LatticeVal& LV = ValueState[val];
        LV.markForcedConstant(C);
        #ifdef SYSY_ENABLE_MIDDLE_END
        // DEBUG(dbgs() << "markForcedConstant: " << *C << ": " << *val << '\n');
        #endif
        pushToWorkList(LV, val);
    }

    // markOverdefined - Make a value be marked as "overdefined". If the
    // value is not already overdefined, add it to the overdefined instruction
    // work list so that the users of the instruction are updated later.
    void markOverdefined(LatticeVal& LV, Value* val)
    {
        if(!LV.markOverdefined())
            return;
        #ifdef SYSY_ENABLE_MIDDLE_END
        // DEBUG(dbgs() << "markOverdefined: ";
        //     if(Function* func = dynamic_cast<Function>(val))
        //         dbgs() << "Function '" << func->GetName() << "'\n";
        //     else
        //         dbgs() << *val << '\n');
        #endif
        OverdefinedInstWorkList.push_back(val);
    }

    void mergeInValue(LatticeVal& LV, Value* val, LatticeVal MergeWithVal)
    {
        if(LV.isOverdefined() || MergeWithVal.isUnknown())
            return; // Noop.
        if(MergeWithVal.isOverdefined())
            return markOverdefined(LV, val);
        if(LV.isUnknown())
            return markConstant(LV, val, MergeWithVal.getConstantInt());
        if(LV.getConstantInt() != MergeWithVal.getConstantInt())
            return markOverdefined(LV, val);
    }
    
    void mergeInValue(Value* val, LatticeVal MergeWithVal)
    {
        mergeInValue(ValueState[val], val, MergeWithVal);
    }
    /// getValueState - Return the LatticeVal object that corresponds to the
    /// value.  This function handles the case when the value hasn't been seen yet
    /// by properly seeding constants etc.
    LatticeVal& getValueState(Value* val)
    {
        std::pair<std::map<Value*,LatticeVal>::iterator, bool> iter =
            ValueState.insert(std::make_pair(val, LatticeVal()));
        LatticeVal& LV = iter.first->second;
        if(!iter.second)
            return LV; // Common case, already in the map.
        if(ConstantData* C = dynamic_cast<ConstantData*>(val))
        {
            // Undef Values remain unknown.
            if(!dynamic_cast<UndefValue*>(val))
                LV.markConstant(C); // Constants are constant.
        }
        return LV;
    }
    /// markEdgeExecutable - Mark a basic block as executable, adding it to the BB
    /// work list if it is not already executable.
    void markEdgeExcutable(BasicBlock* Source, BasicBlock* Dest)
    {
        if(!KnownFeasibleEdges.insert(Edge(Source, Dest)).second)
            return; // This edge is already known to be executable!
        if(!MarkBlockExecutabel(Dest))
        {
        // If the destination is already executable, we just made an *edge*
        // feasible that wasn't before.  Revisit the PHI nodes in the block
        // because they have potentially new operands.
            #ifdef SYSY_ENABLE_MIDDLE_END
            // DEBUG(dbgs() << "Marking Edge Executable: " << Source->GetName()
            //     << " -> " << Dest->GetName() << '\n');
            #endif
            PhiInst* PN;
            for(auto iter = Dest->begin();
                (PN = dynamic_cast<PhiInst*>(*iter)); ++iter)
                visitPHINode(*PN);
        }
    }

    // getFeasibleSuccessors - Return a vector of booleans to indicate which
    // successors are reachable from a given terminator instruction.
    void getFeasibleSuccessors(CondInst& inst, std::vector<bool>& Succs);
    void getFeasibleSuccessors(UnCondInst& inst, std::vector<bool>& Succs);
    void getFeasibleSuccessors(RetInst& inst, std::vector<bool>& Succs);

    // isEdgeFeasible - Return true if the control flow edge from the 'From' basic
    // block to the 'To' basic block is currently feasible.
    bool isEdgeFeasible(BasicBlock *From, BasicBlock *To);

    // OperandChangedState - This method is invoked on all of the users of an
    // instruction that was just changed state somehow.  Based on this
    // information, we need to update the specified user of this instruction.
    void OperandChangedState(User* inst) 
    {
    if (BBExecutable.count(inst->GetParent()))   // Inst is executable?
        visit(*inst);
    }
private:
    // visit implementations - Something changed in this instruction.  Either an
    // operand made a transition, or the instruction is newly executable.  Change
    // the value type of I to reflect these changes if appropriate.
    void visitPHINode(PhiInst& inst);
    
    //Terminators
    void visitTerminatorInst(CondInst& inst);
    void visitTerminatorInst(UnCondInst& inst);
    void visitReturnInst(RetInst& inst);

    void visitBinaryOperator(BinaryInst& inst);
    void visitCmpInst(BinaryInst& inst);

    // Instructions that cannot be folded away.
    void visitStoreInst(StoreInst& inst);
    void visitLoadInst(LoadInst& inst);
    void visitGetElementPtrInst(GetElementPtrInst& inst);
    void visitCallInst(CallInst& inst)
    {
        visitCallSite(&inst);
    } 
    void visitCallSite(CallInst* inst);
    void visitAllocaInst(AllocaInst& inst) { markOverdefined(&inst); }
    void visitInstruction(User &inst) 
    {
        // If a new instruction is added to LLVM that we don't handle.
        #ifdef SYSY_ENABLE_MIDDLE_END
        // dbgs() << "SCCP: Don't know how to handle: " << I << '\n';
        #endif
        markAnythingOverdefined(&inst);   // Just in case
    }
    void visit(User& inst);
    void visit_Block(BasicBlock* BB);
};
