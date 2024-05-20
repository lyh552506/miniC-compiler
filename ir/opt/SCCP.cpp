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
        Value* Val = Singleton<Module>().GetValueByName(val->get_name());
        Lattice& L = GlobalTrack[Val];
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

bool SCCP::isEdgeExcutable(BasicBlock* Src, BasicBlock* Dst)
{
    // LLVM 18.1.6
    return KnownFeasibleEdges.count(Edge(Src, Dst));

    // LLVM 3.9.0
    // if(!isExcutableBlock(Src))
    //     return false;
    
    // User* inst = Src->back();
    // auto UnCond = dynamic_cast<UnCondInst*>(inst);
    // auto Cond = dynamic_cast<CondInst*>(inst);
    // if(UnCond || Cond)
    // {
    //     if(UnCond)
    //         return true;
    //     Lattice L = GetValueStatus(inst->Getuselist()[0]->usee);

    //     ConstantData* C = L.GetConstData();
    //     if(!C)
    //         return !L.isUnknown();
        
    //     auto val = dynamic_cast<ConstIRBoolean*>(Cond->GetOperand(0));
    //     if(val->GetVal())
    //     {
    //         BasicBlock* TrueSucc = dynamic_cast<BasicBlock*>(Cond->Getuselist()[1]->usee);
    //         return TrueSucc == Dst;
    //     }
    //     else
    //     {
    //         BasicBlock* FalseSucc = dynamic_cast<BasicBlock*>(Cond->Getuselist()[2]->usee);
    //         return FalseSucc == Dst;
    //     }
    // }
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

void SCCP::GetExcutableSuccs(UnCondInst* inst, std::vector<bool>& Succs)
{
    Succs.resize(1);
    Succs[0] = true;
    return;
}
// SolveUndefs - 在求解函数的数据流时，\
我们假定 undef 值上的分支无法到达其任何后继分支。\
然而，这种假设并不安全。在求解数据流后，应使用此方法来处理这个问题。\
如果返回 true, 则应重新运行求解器。
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
    return Changed;
}

bool SCCP::ReSolvedUndef(User* inst)
{
    if(inst->GetType()->GetTypeEnum() == InnerDataType::IR_Value_VOID)
        return false;

    Lattice& L = GetValueStatus(inst);
    if(!L.isUnknown())
        return false;
    
    if(auto Call = dynamic_cast<CallInst*>(inst))
    {
        if(auto F = dynamic_cast<Function*>(inst->Getuselist()[0]->usee))
        {
            if(RetValTrack.count(F))
                return false;
            for(auto iter = MultipleRetValsTrack.begin();
            iter != MultipleRetValsTrack.end(); ++iter)
            {
                if(((*iter).first).first == F)
                    return false;
            }
        }
    }
    
    if(dynamic_cast<LoadInst*>(inst))
        return false;
    
    MarkOverDefined(L, inst);
    return true;
}

void SCCP::Visit(User* inst)
{
    if(auto Phi = dynamic_cast<PhiInst*>(inst))
        VisitPhiInst(Phi);
    else if(auto Call = dynamic_cast<CallInst*>(inst))
        VisitCallInst(Call);
    else if(auto Cond = dynamic_cast<CondInst*>(inst))
        VisitCondInst(Cond);
    else if(auto UnCond = dynamic_cast<UnCondInst*>(inst))
        VisitUnCondInst(UnCond);
    else if(auto Store = dynamic_cast<StoreInst*>(inst))
        VisitStoreInst(Store);
    else if(auto Load = dynamic_cast<LoadInst*>(inst))
        VisitLoadInst(Load);
    else if(auto Ret = dynamic_cast<RetInst*>(inst))
        VisitReturnInst(Ret);
    else if(auto GEP = dynamic_cast<GetElementPtrInst*>(inst))
        VisitGetElementPtrInst(GEP);
    else if(auto Alloca = dynamic_cast<AllocaInst*>(inst))
        VisitAllocaInst(Alloca);
    else if(auto Binary = dynamic_cast<BinaryInst*>(inst))
    {
        BinaryInst::Operation Op = Binary->getopration();
        if(Op == BinaryInst::Operation::Op_Add || Op == BinaryInst::Operation::Op_Sub ||
        Op == BinaryInst::Operation::Op_Mul || Op == BinaryInst::Operation::Op_Div ||
        Op == BinaryInst::Operation::Op_Mod || Op == BinaryInst::Operation::Op_And ||
        Op == BinaryInst::Operation::Op_Or)
            VisitBinaryOperator(Binary);
        else
            VisitCmpInst(Binary);
    }
    else
        MarkOverDefined(GetValueStatus(inst), inst);
}

void SCCP::VisitPhiInst(PhiInst* inst)
{
    if(GetValueStatus(inst).isOverDefined())
        return;
    // 多个Operand不大可能是常量, 会大大降低速度, 直接标记为OverDefined
    if(inst->oprandNum > 64)
        return MarkOverDefined(GetValueStatus(inst), inst);
    
    ConstantData* C = nullptr;

    for(int i = 0; i < inst->oprandNum; i++)
    {
        Lattice& L = GetValueStatus(inst->GetVal(i));
        if(L.isUnknown())
            continue;
        
        if(!isEdgeExcutable(inst->GetBlock(i), inst->GetParent()))
            continue;
        
        if(L.isOverDefined())
            return MarkOverDefined(L, inst);
        
        if(!C)
        {
            C = L.GetConstData();
            continue;
        }

        if(L.GetConstData() != C)
            return MarkOverDefined(L, inst);
    }

    if(C)
        MarkConstant(GetValueStatus(inst), inst, C);
}

void SCCP::VisitReturnInst(RetInst* inst)
{
    if(inst->Getuselist().size() == 0)
        return;
    
    Function* func = inst->GetParent()->GetParent();
    Value* Result = inst->Getuselist()[0]->usee;

    if(!RetValTrack.empty())
    {
        if(RetValTrack.count(func))
        {
            MergeInValue(RetValTrack[func], func, GetValueStatus(Result));
            return;
        }
    }

    if(!MultipleRetValsTrack.empty())
    {
        std::vector<Value*> RetVals;
        for(BasicBlock* block : *(inst->GetParent()->GetParent()))
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
            MergeInValue(MultipleRetValsTrack[std::make_pair(func, i)],
            func, GetValueStatus(RetVals[i]));
        }
    }
}

void SCCP::VisitCondInst(CondInst* inst)
{
    std::vector<bool> SuccFeasible;
    GetExcutableSuccs(inst, SuccFeasible);

    BasicBlock* block = inst->GetParent();

    for(int i = 0; i < SuccFeasible.size(); i++)
    {
        if(SuccFeasible[i])
            MarkEdgeExcutable(block, dynamic_cast<BasicBlock*>
            (inst->Getuselist()[i + 1]->usee));
    }
}

void SCCP::VisitUnCondInst(UnCondInst* inst)
{
    std::vector<bool> SuccFeasible;
    GetExcutableSuccs(inst, SuccFeasible);

    BasicBlock* block = inst->GetParent();

    // Mark all feasible successors executable.
    for(int i = 0; i < SuccFeasible.size(); i++)
    {
        if(SuccFeasible[i])
            MarkEdgeExcutable(block, dynamic_cast<BasicBlock*>
            (inst->Getuselist()[i]->usee));
    }
}

void SCCP::VisitBinaryOperator(BinaryInst* inst)
{
    Lattice Val1Statu = GetValueStatus(inst->Getuselist()[0]->usee);
    Lattice Val2Statu = GetValueStatus(inst->Getuselist()[1]->usee);

    Lattice& L = ValueStatusMap[inst];
    if(L.isOverDefined()) return;

    if(Val1Statu.isConstant() && Val2Statu.isConstant())
    {
        ConstantData* C = ConstantFolding::ConstFoldBinary(inst->getopration(),
        Val1Statu.GetConstData(), Val2Statu.GetConstData()); 

        // X op Y -> undef
        if(dynamic_cast<UndefValue*>(C))
            return;
        return MarkConstant(L, inst, C);
    }
    
    if(!Val1Statu.isOverDefined() && !Val2Statu.isOverDefined())
        return;
    
    if(inst->getopration() == BinaryInst::Operation::Op_And
    || inst->getopration() == BinaryInst::Operation::Op_Or)
    {
        Lattice* NonOverdefVal = nullptr;
        if(!Val1Statu.isOverDefined())
            NonOverdefVal = &Val1Statu;
        else if(!Val2Statu.isOverDefined())
            NonOverdefVal = &Val2Statu;
        
        if(NonOverdefVal)
        {
            if(NonOverdefVal->isUnknown())
            {
                if(inst->getopration() == BinaryInst::Operation::Op_And)
                    MarkConstant(L, inst, ConstIRBoolean::GetNewConstant(false));
                else
                    MarkConstant(L, inst, ConstIRBoolean::GetNewConstant(true));
                return;
            }

            if(inst->getopration() == BinaryInst::Operation::Op_And)
            {
                // X and 0 = 0
                if(!dynamic_cast<ConstIRBoolean*>
                (NonOverdefVal->GetConstData())->GetVal())
                    return MarkConstant(L, inst, ConstIRBoolean::GetNewConstant(false));
            }
            else  // X or 1 = 1
            {
                if(dynamic_cast<ConstIRBoolean*>(NonOverdefVal->GetConstData())->GetVal())
                    return MarkConstant(L, inst, ConstIRBoolean::GetNewConstant(true));
            }
        }
    }

    MarkOverDefined(GetValueStatus(inst), inst);
}

void SCCP::VisitCmpInst(BinaryInst* inst)
{
    Lattice Val1Statu = GetValueStatus(inst->Getuselist()[0]->usee);
    Lattice Val2Statu = GetValueStatus(inst->Getuselist()[1]->usee);

    Lattice& L = ValueStatusMap[inst];
    if(L.isOverDefined()) return;

    if(Val1Statu.isConstant() && Val2Statu.isConstant())
    {
        ConstantData* C = ConstantFolding::ConstFoldBinary
        (inst->getopration(), Val1Statu.GetConstData(), Val2Statu.GetConstData()); 
        if(C)
            return MarkConstant(L, inst, C);
    }

    if(!Val1Statu.isOverDefined() && !Val2Statu.isOverDefined())
        return;
    
    MarkOverDefined(GetValueStatus(inst), inst);
}

void SCCP::VisitGetElementPtrInst(GetElementPtrInst* inst)
{
    if(GetValueStatus(inst).isOverDefined()) return;

    std::vector<Value*> Operands;
    Operands.reserve(inst->Getuselist().size());

    for(int i = 1; i < inst->Getuselist().size(); ++i)
    {
        Lattice Statu = GetValueStatus(inst->Getuselist()[i]->usee);
        if(Statu.isUnknown())
            return;
        
        if(Statu.isOverDefined())
            return MarkOverDefined(GetValueStatus(inst), inst);
        
        Operands.push_back(Statu.GetConstData());
    }

    // TODO : Support for GEP ConstantExpr
    // ConstantData* C = ConstantFolding::ConstantFoldInst(&inst);
    // if(dynamic_cast<UndefValue*>(C))
        // return;
    // markConstant(&inst, C);
    
}

void SCCP::VisitStoreInst(StoreInst* inst)
{
    if(GlobalTrack.empty() || !dynamic_cast<User*>(inst->Getuselist()[1]->usee))
        return;
    
    Value* val = inst->Getuselist()[1]->usee;

    if(!GlobalTrack.count(val))
        return;
    else
    {
        if(GlobalTrack[val].isOverDefined())
            return;
        
        MergeInValue(GlobalTrack[val], val, GetValueStatus(inst->Getuselist()[0]->usee));

        if(GlobalTrack[val].isOverDefined())
            GlobalTrack.erase(val);
    }

}

void SCCP::VisitLoadInst(LoadInst* inst)
{
    if(!GlobalTrack.empty() || !dynamic_cast<User*>(inst->Getuselist()[1]->usee))
    {
        Value* val = inst->Getuselist()[0]->usee;
        if(GlobalTrack.count(val))
        {
            if(GlobalTrack[val].isOverDefined())
                return MarkOverDefined(GetValueStatus(inst), inst);
            
            MergeInValue(GetValueStatus(inst), inst, GlobalTrack[val]);
            return;
        }
    }

    Lattice Val = GetValueStatus(inst->Getuselist()[0]->usee);
    if(Val.isUnknown()) return;

    Lattice& L = ValueStatusMap[inst];

    if(L.isOverDefined()) return;

    if(!Val.isConstant())
        return MarkOverDefined(L, inst);
    
    // ConstantData* Ptr = Val.GetConstData();

    // load null is undefined
    // if(!dynamic_cast<ConstPtr*>(Ptr)) return;

    // Transform load (Constant Global) into the value loaded.
    // TODO
    // if(!dynamic_cast<User*>(Ptr))
    // {
    //     if(!GlobalTrack.empty())
    //     {
    //         std::map<Value*, Lattice>::iterator iter = GlobalTrack.find(Ptr);
    //         if(iter != GlobalTrack.end())
    //         {
    //             MergeInValue(L, inst, iter->second);
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
    // MarkOverDefined(L, inst);
}

void SCCP::VisitCallInst(CallInst* inst)
{
    Function* func = dynamic_cast<Function*>(inst->Getuselist()[0]->usee);

    // If this is a local function that doesn't have its address taken, mark its
    // entry block executable and merge in the actual arguments to the call into
    // the formal arguments of the function.
    if(!IncomeArgsTrack.empty() && IncomeArgsTrack.count(func))
    {
        BasicBlock* EntryBlock = func->front();
        if(!ExecutableBlocks.count(EntryBlock))
            BlockWorkList.push_back(EntryBlock);
        if(func->GetParams().size() != 0)
        {
            for(int i = 1, j = 0; i < inst->Getuselist().size(); i++, j++)  
            // i -> callinst arg ; j -> func param
            {
                Value* arg = inst->Getuselist()[i]->usee;
                Value* param = func->GetParams()[j].get();
                MergeInValue(ValueStatusMap[arg], arg, GetValueStatus(param));
            }
        }
    }

    if(!RetValTrack.count(func))
    {
        if(inst->GetType()->GetTypeEnum() == InnerDataType::IR_Value_VOID)
            return;
        // TODO -> 查看所有testcases中的数学函数 比如 sin/cos/tan/abs
        // if(CanFoldCall)
        // {
        //     std::vector<ConstantData*> Operands;
        //     for(int i = 1; i < inst->Getuselist().size(); i++)
        //     {
        //         Lattice Statu = GetValueStatus(inst->Getuselist()[i]->usee);
        //         if(Statu.isUnknown())
        //             return;
                
        //         if(Statu.isOverDefined())
        //             return MarkOverDefined(GetValueStatus(inst), inst);
                
        //         Operands.push_back(Statu.GetConstData());
        //     }

        //     if(GetValueStatus(inst).isOverDefined())
        //         return;
            
        //     if(ConstantData* C = ConstantFolding::ConstFoldCall(func, Operands))
        //     {
        //         if(!dynamic_cast<UndefValue*>(C))
        //             return;
        //         return MarkConstant(GetValueStatus(inst), inst, C);
        //     }
        // }
        return MarkOverDefined(GetValueStatus(inst), inst);
    }

    MergeInValue(ValueStatusMap[inst], inst, RetValTrack[func]);
}

bool SCCP::TryReplace(Value* val)
{
    ConstantData* C = nullptr;
    Lattice L = GetLattice(val);
    if(L.isOverDefined())
        return false;
    C = L.isConstant() ? L.GetConstData() : UndefValue::get(val->GetType());

    val->RAUW(C);
    return true;
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

    // 标志函数的全局变量为Overdefined
    for(auto& global : Singleton<Module>().GetGlobalVariable())
    {
        Value* val = Singleton<Module>().GetValueByName(global->get_name());
        if(global->GetInitializer())
        {
            if(auto Constant = dynamic_cast<ConstantData*>(global->GetInitializer()))
                MarkConstant(GlobalTrack[val], val, Constant);
            else
                MarkOverDefined(GlobalTrack[val], val);
        }
        else
            MarkOverDefined(GlobalTrack[val], val);
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
                    continue;
                }
            }
            if(DCE::isDeadInst(inst))
            {
                inst->ClearRelation();
                inst->EraseFromParent();
                Changed = true;
                ++RemovedInstNum;
            }
        }
    }
    return Changed;
}
