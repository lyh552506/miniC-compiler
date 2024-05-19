#include "SCCP.hpp"
#include "DCE.hpp"

bool Lattice::MarkOverDefined()
{
    if(isOverDefined())
        return false;
    
    Val.second = OverDefined;
    return true;
}

bool Lattice::MarkConstant(ConstantData* val)
{
        // Is already constant, return false;
        if(GetValueStatus() == Constant)
            return false;
        
        // ⊥ -> Constant
        if(isUnknown())
        {
            Val.second = Constant;
            Val.first = val;
        }
        else   // T -> Constant
        {
            assert(GetValueStatus() == ForcedConstant &&
            "Cannot move from OverDefined to Constant!");
        
            // Stay at ForcedConstant if the constant is the same.
            if(val == GetVal())
                return false;
            
            Val.second = OverDefined;
        }
        return true;
}

ConstantData* Lattice::GetConstData() const
{
    if(isConstant())
        return static_cast<ConstantData*>(GetVal());
    return nullptr;
}

void Lattice::MarkForcedConstant(ConstantData* val)
{
    assert(isUnknown() && "Cannot force a define value!");
    Val.first = val;
    Val.second = ForcedConstant;
}

bool SCCP::MarkBlockExecutable(BasicBlock* block)
{
    if(!ExecutableBlocks.insert(block).second)
        return false;
    BlockWorkList.push_back(block);  // 将基本块标记为可执行
    return true;
}

void SCCP::TrackGlobal(Variable* val)
{
    if(val->GetType()->GetTypeEnum() == InnerDataType::IR_Value_INT ||
    val->GetType()->GetTypeEnum() == InnerDataType::IR_Value_Float ||
    val->GetType()->GetTypeEnum() == InnerDataType::IR_PTR)
    {
        Lattice& L = GlobalTrack[val];
        if(val->GetInitializer())
        {
            if(auto Constant = dynamic_cast<ConstantData*>(val->GetInitializer()))
                L.MarkConstant(Constant);
        }
    }
}

Lattice SCCP::GetLattice(Value* val) const
{
    if(ValueStatusMap.find(val) != ValueStatusMap.end())
        return ValueStatusMap.at(val);
}

void SCCP::MarkConstant(Lattice& L, Value* val, ConstantData* C)
{
    if(!L.MarkConstant(C)) return;

    if(L.isOverDefined())
        OverDefinedWorkList.push_back(val);
    ValueWorkList.push_back(val);
}

void SCCP::MarkForcedConstant(Value* val, ConstantData* C)
{
    Lattice& L = ValueStatusMap[val];
    L.MarkForcedConstant(C);
    
    if(L.isOverDefined())
        OverDefinedWorkList.push_back(val);
    ValueWorkList.push_back(val);
}

void SCCP::MarkOverDefined(Lattice& L, Value* val)
{
    if(!L.MarkOverDefined()) return;

    OverDefinedWorkList.push_back(val);
}

void SCCP::MergeInValue(Lattice& L, Value* val, Lattice Merged)
{
    if(L.isOverDefined() || Merged.isUnknown()) return;

    if(Merged.isOverDefined())
        return MarkOverDefined(L, val);
    
    if(L.isUnknown())
        return MarkConstant(L, val, Merged.GetConstData());
    
    if(L.GetConstData() != Merged.GetConstData())
        return MarkOverDefined(L, val);
}

Lattice& SCCP::GetValueStatus(Value* val)
{
    std::pair<std::map<Value*, Lattice>::iterator, bool> iter
    = ValueStatusMap.insert(std::make_pair(val, Lattice()));
    Lattice& L = iter.first->second;
    if(!iter.second)
        return L;
    if(ConstantData* C = dynamic_cast<ConstantData*>(val))
    {
        if(!dynamic_cast<UndefValue*>(C))
            L.MarkConstant(C);
    }
    return L;
}

void SCCP::MarkEdgeExcutable(BasicBlock* Src, BasicBlock* Dst)
{
    // 已经是可以执行的边
    if(!KnownFeasibleEdges.insert(Edge(Src, Dst)).second)
        return;

    //如果 Dst 已经是可执行的，\
    那么我们只是让一条以前不可行的边变得可行了。\
    重新查看程序块中的 PHI 节点，因为它们可能有新的操作数。
    if(!MarkBlockExecutable(Dst))
    {
        PhiInst* Phi;
        for(auto iter = Dst->begin();
        (Phi = dynamic_cast<PhiInst*>(*iter)); ++iter)
            VisitPhiInst(Phi);
    }
}

void SCCP::GetExcutableSuccs(CondInst* inst, std::vector<bool>& Succs)
{
    Succs.resize(2);
    Lattice& L  = GetValueStatus(inst->GetOperand(0));
    ConstantData* C = L.GetConstData();
    
    // 如果是OverDefined, 则所有的分支都是可执行的
    if(!C)
    {
        if(!L.isUnknown())
        {
            Succs[0] = true;
            Succs[1] = true;
        }
        return;
    }

    // 如果是常量，则根据常量的值来确定哪个分支是可执行的
    if(C->isZero())
        Succs[1] = true;
    else
        Succs[0] = true;
    return;
}

void SCCP::GetExcutalbeSuccs(UnCondInst* inst, std::vector<bool>& Succs)
{
    Succs.resize(1);
    Succs[0] = true;
    return;
}


void SCCP::Solve()
{
    while(!BlockWorkList.empty() || !ValueWorkList.empty() ||
    !OverDefinedWorkList.empty())
    {
        while(!OverDefinedWorkList.empty())
        {
            Value* inst = std::move(OverDefinedWorkList.back());
            OverDefinedWorkList.pop_back();

            // inst 要么从 ⊥ 过渡到 Constant, \
            要么过渡到 T 。工作列表中任何 T 的内容都无需访问，\
            因为它的所有 User 都已被标记为 T , Update。
            for(Use* Use_ : inst->GetUserlist())
            {
                User* inst_ = Use_->GetUser();
                if(ExecutableBlocks.count(inst_->GetParent()))
                    Visit(inst_);
            }
        }

        while(!ValueWorkList.empty())
        {
            Value* inst = std::move(ValueWorkList.back());
            ValueWorkList.pop_back();

            if(!GetValueStatus(inst).isOverDefined())
            {
                for(Use* Use_ : inst->GetUserlist())
                {
                    User* inst_ = Use_->GetUser();
                    if(ExecutableBlocks.count(inst_->GetParent()))
                        Visit(inst_);
                }
            }
        }

        while(!BlockWorkList.empty())
        {
            BasicBlock* block = std::move(BlockWorkList.back());
            BlockWorkList.pop_back();

            // 这个block的user是可执行的
            for(User* inst : *block)
                Visit(inst);
        }
    }
}

bool SCCP::RunOnFunction(Function* func)
{
    int DeadBlocksNum = 0;
    int RemovedInstNum = 0;

    // 标志函数开始基本块为可执行
    MarkBlockExecutable(func->front());

    // 标志函数的所有参数为Overdefined
    for(auto& param_ : func->GetParams())
    {
        Value* val = param_.get();
        MarkOverDefined(ValueStatusMap[val], val);
    }

    bool Solved = true;
    while(Solved)
    {
        Solve();

        Solved = SolveUndefs(func);
    }

    bool Changed = false;

    //如果我们认为该函数中有一些基本模块已经死亡，\
    那么现在就删除它们的内容。
    for(BasicBlock* block : *func)
    {
        if(!isExcutableBlock(block))
        {
            for(auto iter = block->rbegin(); iter != block->rend(); ++iter)
            {
                User* inst = *iter;
                if(!inst->GetUserlist().is_empty())
                {
                    inst->RAUW(UndefValue::get(inst->GetType()));
                    inst->ClearRelation();
                    inst->EraseFromParent();
                }
                else
                    inst->EraseFromParent();
            }
            //TODO: 删除基本块
            ++DeadBlocksNum;
            Changed = true;
            continue;
        }

        for(User* inst : *block)
        {
            if(inst->GetType()->GetTypeEnum() == InnerDataType::IR_Value_VOID ||
            inst == block->back())
                continue;
            
            if(TryReplace(inst))
            {
                if(DCE::isDeadInst(inst))
                {
                    inst->ClearRelation();
                    inst->EraseFromParent();

                    Changed = true;
                    ++RemovedInstNum;
                }
            }
        }
    }
    return Changed;
}

bool SCCP::SolveUndefs(Function* func)
{
    bool Changed = false;
    for(BasicBlock* block : *func)
    {
        if(!ExecutableBlocks.count(block))
            continue;
        
        for(User* inst : *block)
        {
            Changed |= ReSolvedUndef(inst);
        }
    }
}

bool SCCP::ReSolvedUndef(User* inst)
{
    if(inst->GetType()->GetTypeEnum() == InnerDataType::IR_Value_VOID)
        return false;
    
    
}
// bool SCCPInstVisitor::resolvedUndef(Instruction &I) {
//   // Look for instructions which produce undef values.
//   if (I.getType()->isVoidTy())
//     return false;

//   if (auto *STy = dyn_cast<StructType>(I.getType())) {
//     // Only a few things that can be structs matter for undef.

//     // Tracked calls must never be marked overdefined in resolvedUndefsIn.
//     if (auto *CB = dyn_cast<CallBase>(&I))
//       if (Function *F = CB->getCalledFunction())
//         if (MRVFunctionsTracked.count(F))
//           return false;

//     // extractvalue and insertvalue don't need to be marked; they are
//     // tracked as precisely as their operands.
//     if (isa<ExtractValueInst>(I) || isa<InsertValueInst>(I))
//       return false;
//     // Send the results of everything else to overdefined.  We could be
//     // more precise than this but it isn't worth bothering.
//     for (unsigned i = 0, e = STy->getNumElements(); i != e; ++i) {
//       ValueLatticeElement &LV = getStructValueState(&I, i);
//       if (LV.isUnknown()) {
//         markOverdefined(LV, &I);
//         return true;
//       }
//     }
//     return false;
//   }

//   ValueLatticeElement &LV = getValueState(&I);
//   if (!LV.isUnknown())
//     return false;

//   // There are two reasons a call can have an undef result
//   // 1. It could be tracked.
//   // 2. It could be constant-foldable.
//   // Because of the way we solve return values, tracked calls must
//   // never be marked overdefined in resolvedUndefsIn.
//   if (auto *CB = dyn_cast<CallBase>(&I))
//     if (Function *F = CB->getCalledFunction())
//       if (TrackedRetVals.count(F))
//         return false;

//   if (isa<LoadInst>(I)) {
//     // A load here means one of two things: a load of undef from a global,
//     // a load from an unknown pointer.  Either way, having it return undef
//     // is okay.
//     return false;
//   }

//   markOverdefined(&I);
//   return true;
// }
// bool SCCPInstVisitor::resolvedUndefsIn(Function &F) {
//   bool MadeChange = false;
//   for (BasicBlock &BB : F) {
//     if (!BBExecutable.count(&BB))
//       continue;

//     for (Instruction &I : BB)
//       MadeChange |= resolvedUndef(I);
//   }

//   LLVM_DEBUG(if (MadeChange) dbgs()
//              << "\nResolved undefs in " << F.getName() << '\n');

//   return MadeChange;
// }
