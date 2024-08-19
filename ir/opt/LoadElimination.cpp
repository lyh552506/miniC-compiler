#include "../../include/ir/opt/LoadElimination.hpp"

namespace PointerTool_LoadElimination
{
auto all_offset_const = [](GetElementPtrInst *inst) {
    return std::all_of(inst->Getuselist().begin() + 1, inst->Getuselist().end(),
                       [](User::UsePtr &use) { return dynamic_cast<ConstantData *>(use->usee); });
};
} // namespace PointerTool_LoadElimination

void LoadElimination::init()
{
    wait_del.clear();
    DomTree = AM.get<dominance>(func);
    AM.get<SideEffect>(&Singleton<Module>());
    func->init_visited_block();
    OrderBlock(func->front());
}

void LoadElimination::OrderBlock(BasicBlock *block)
{
    if (block->visited)
        return;
    block->visited = true;
    for (int dest : DomTree->GetNode(block->num).des)
        OrderBlock(DomTree->GetNode(dest).thisBlock);
    DFSOrder.push_back(block);
}

bool LoadElimination::Run()
{
    init();
    bool modified = false;
    for (auto block : DFSOrder)
        modified |= RunOnBlock(block);
    while (!wait_del.empty())
    {
        modified = true;
        User *inst = *wait_del.begin();
        wait_del.erase(wait_del.begin());
        inst->ClearRelation();
        inst->EraseFromParent();
    }
    return modified;
}

bool LoadElimination::RunOnBlock(BasicBlock *block)
{
    for (auto iter = block->rbegin(); iter != block->rend(); --iter)
    {
        User *inst = *iter;
        if (!dynamic_cast<LoadInst *>(inst))
            continue;
        LoadInst *load = dynamic_cast<LoadInst *>(inst);
        mylist<BasicBlock, User>::iterator pos(load);
        std::unordered_set<BasicBlock *> visited;
        load->Change = false;
        std::pair<Value *, BasicBlock *> val = Judge(load, load, block, load->GetOperand(0), block, visited, --pos, 0);
        if (val.first && val.first != load)
        {
            load->RAUW(val.first);
            wait_del.insert(load);
        }
    }
    return false;
}

std::pair<Value *, BasicBlock *> LoadElimination::Judge(User *inst, User *origin, BasicBlock *block, Value *src,
                                                        BasicBlock *pred_block,
                                                        std::unordered_set<BasicBlock *> &visited,
                                                        mylist<BasicBlock, User>::iterator pos, size_t depth)
{
    bool Flag_CommonBlock = false;
    if (!inst && pred_block)
    {
        if (visited.count(pred_block))
            return std::pair{nullptr, nullptr};
        if (block == pred_block)
            Flag_CommonBlock = true;
        visited.insert(pred_block);
        pos = pred_block->rbegin();
    }

    for (;; --pos)
    {
        if (pos == pred_block->rend())
        {
            std::map<Value *, BasicBlock *> Pred_Value;
            for (auto pred_ : pred_block->GetUserlist())
            {
                User *br = pred_->GetUser();
                if (dynamic_cast<CondInst *>(br) || dynamic_cast<UnCondInst *>(br))
                {
                    BasicBlock *pred = br->GetParent();
                    // if (pred != block)
                    // {
                    auto val = Judge(nullptr, origin, block, src, pred, visited, pred->rbegin(), depth + 1);
                    if (val.second == pred_block && val.first != nullptr)
                        Pred_Value[val.first] = val.second;
                    else if (val.first && val.second != pred_block)
                        Pred_Value[val.first] = val.second;
                    // }
                }
            }
            if (Pred_Value.size() == 1 && depth != 0 && Pred_Value.begin()->second != pred_block)
                return *Pred_Value.begin();
            else if (Pred_Value.size() == 1 && depth == 0 &&
                     DomTree->dominates(Pred_Value.begin()->second, pred_block) &&
                     Pred_Value.begin()->second != pred_block && !origin->Change)
                return *Pred_Value.begin();
            return std::pair{nullptr, nullptr};
        }
        User *inst_ = *pos;
        if (!Flag_CommonBlock)
        {
            if (auto store = dynamic_cast<StoreInst *>(inst_))
            {
                if (auto src_gep = dynamic_cast<GetElementPtrInst *>(src))
                {
                    if (store->GetOperand(1) == src_gep)
                        return std::pair{store->GetOperand(0), inst_->GetParent()};
                    Value *Src_base = src_gep->Getuselist()[0]->usee;
                    if (auto dst_gep = dynamic_cast<GetElementPtrInst *>(store->GetOperand(1)))
                    {
                        Value *Dst_base = dst_gep->Getuselist()[0]->usee;
                        if (Src_base == Dst_base)
                        {
                            if (PointerTool_LoadElimination::all_offset_const(src_gep) &&
                                PointerTool_LoadElimination::all_offset_const(dst_gep))
                            {
                                if (AliasAnalysis::GetHash(src_gep) == AliasAnalysis::GetHash(dst_gep))
                                    return std::pair{store->GetOperand(0), inst_->GetParent()};
                            }
                            else if (!PointerTool_LoadElimination::all_offset_const(dst_gep))
                            {
                                origin->Change = true;
                                return std::pair{nullptr, nullptr};
                            }
                        }
                    }
                }
                else if (store->GetOperand(1) == src)
                {
                    if (store->GetOperand(0) == src)
                        return std::pair{nullptr, nullptr};
                    return std::pair{store->GetOperand(0), inst_->GetParent()};
                }
            }
            else if (auto load = dynamic_cast<LoadInst *>(inst_))
            {
                if (load->GetOperand(0) == src)
                    return std::pair{load, inst_->GetParent()};
            }
            else if (auto call = dynamic_cast<CallInst *>(inst_))
            {
                Value *call_base = call->GetOperand(0);
                std::string call_name = call_base->GetName();
                if ((call_name == "getarray" || call_name == "getfarray") && dynamic_cast<GetElementPtrInst *>(src))
                {
                    Value *call_gep_base = dynamic_cast<GetElementPtrInst *>(call->GetOperand(1))->GetOperand(0);
                    Value *src_base = dynamic_cast<GetElementPtrInst *>(src)->GetOperand(0);
                    if (call_gep_base == src_base)
                    {
                        origin->Change = true;
                        return std::pair{nullptr, nullptr};
                    }
                }
                else if (call_name == "llvm.memcpy.p0.p0.i32" && dynamic_cast<GetElementPtrInst *>(src))
                {
                    GetElementPtrInst *src_gep = dynamic_cast<GetElementPtrInst *>(src);
                    Value *src_base = src_gep->GetOperand(0);
                    auto array = dynamic_cast<Variable *>(call->Getuselist()[2]->usee);
                    if (array && array->usage == Variable::Constant)
                    {
                        if (auto alloca = dynamic_cast<AllocaInst *>(call->Getuselist()[1]->usee))
                        {
                            if (alloca == src_base && array->Getuselist().size() != 0 &&
                                PointerTool_LoadElimination::all_offset_const(src_gep))
                            {
                                auto init = dynamic_cast<Initializer *>(array->Getuselist()[0]->usee);
                                std::vector<int> index;
                                for (int i = 2; i < src_gep->Getuselist().size(); i++)
                                {
                                    if (auto INT = dynamic_cast<ConstIRInt *>(src_gep->Getuselist()[i]->usee))
                                        index.push_back(INT->GetVal());
                                }
                                if (auto val = init->getInitVal(index))
                                    return std::pair{val, call->GetParent()};
                            }
                        }
                    }
                }
                else if (dynamic_cast<GetElementPtrInst *>(src) && inst_->Getuselist().size() > 1)
                {
                    Value *base = dynamic_cast<GetElementPtrInst *>(src)->GetOperand(0);
                    if (base->isGlobal())
                    {
                        Function *func_ = inst_->Getuselist()[0]->usee->as<Function>();
                        if (func_ && func_->Change_Val.count(base))
                        {
                            origin->Change = true;
                            return std::pair{nullptr, nullptr};
                        }
                    }
                    else
                    {
                        Function *func_ = call->Getuselist()[0]->usee->as<Function>();
                        if (func_ && func_->tag == Function::Tag::ParallelBody)
                        {
                            for (auto &use : call->Getuselist())
                            {
                                if (base == use->usee)
                                {
                                    origin->Change = true;
                                    return std::pair{nullptr, nullptr};
                                }
                            }
                        }
                        bool flag = false;
                        int distance = 0;
                        for (auto &use : call->Getuselist())
                        {
                            if (auto call_gep = dynamic_cast<GetElementPtrInst *>(use->usee))
                            {
                                if (call_gep->GetOperand(0) == base)
                                {
                                    flag = true;
                                    break;
                                }
                            }
                            distance++;
                        }
                        if (flag)
                        {
                            Function *func_ = call->Getuselist()[0]->usee->as<Function>();
                            if (func_ && func_->Change_Val.count(func_->GetParams()[distance - 1].get()))
                            {
                                origin->Change = true;
                                return std::pair{nullptr, nullptr};
                            }
                        }
                    }
                }
                else if (src->isGlobal())
                {
                    Function *func_ = call->Getuselist()[0]->usee->as<Function>();
                    if (func_ && func_->Change_Val.count(src))
                    {
                        origin->Change = true;
                        return std::pair{nullptr, nullptr};
                    }
                }
            }
            else if (auto binary = dynamic_cast<BinaryInst *>(inst_))
            {
                if (binary->IsAtomic())
                {
                    if (binary->GetOperand(0) == src || binary->GetOperand(1) == src)
                    {
                        origin->Change = true;
                        return std::pair{nullptr, nullptr};
                    }
                }
            }
        }
        else
        {
            if (auto store = dynamic_cast<StoreInst *>(inst_))
            {
                if (auto src_gep = dynamic_cast<GetElementPtrInst *>(src))
                {
                    if (store->GetOperand(1) == src_gep)
                        return std::pair{store->GetOperand(0), inst_->GetParent()};
                    Value *Src_base = src_gep->Getuselist()[0]->usee;
                    if (auto dst_gep = dynamic_cast<GetElementPtrInst *>(store->GetOperand(1)))
                    {
                        Value *Dst_base = dst_gep->Getuselist()[0]->usee;
                        if (Src_base == Dst_base)
                        {
                            if (PointerTool_LoadElimination::all_offset_const(src_gep) &&
                                PointerTool_LoadElimination::all_offset_const(dst_gep))
                            {
                                if (AliasAnalysis::GetHash(src_gep) == AliasAnalysis::GetHash(dst_gep))
                                    return std::pair{store->GetOperand(0), inst_->GetParent()};
                            }
                            else if (!PointerTool_LoadElimination::all_offset_const(dst_gep))
                                return std::pair{store->GetOperand(0), inst_->GetParent()};
                        }
                    }
                }
                else if (store->GetOperand(1) == src)
                {
                    if (store->GetOperand(0) == src)
                        return std::pair{nullptr, nullptr};
                    return std::pair{store->GetOperand(0), inst_->GetParent()};
                }
            }
            else if (auto call = dynamic_cast<CallInst *>(inst_))
            {
                Value *call_base = call->GetOperand(0);
                std::string call_name = call_base->GetName();
                if ((call_name == "getarray" || call_name == "getfarray") && dynamic_cast<GetElementPtrInst *>(src))
                {
                    Value *call_gep_base = dynamic_cast<GetElementPtrInst *>(call->GetOperand(1))->GetOperand(0);
                    Value *src_base = dynamic_cast<GetElementPtrInst *>(src)->GetOperand(0);
                    if (call_gep_base == src_base)
                        return std::pair{call, inst_->GetParent()};
                }
                else if (call_name == "llvm.memcpy.p0.p0.i32" && dynamic_cast<GetElementPtrInst *>(src))
                {
                    GetElementPtrInst *src_gep = dynamic_cast<GetElementPtrInst *>(src);
                    Value *src_base = src_gep->GetOperand(0);
                    auto array = dynamic_cast<Variable *>(call->Getuselist()[2]->usee);
                    if (array && array->usage == Variable::Constant)
                    {
                        if (auto alloca = dynamic_cast<AllocaInst *>(call->Getuselist()[1]->usee))
                        {
                            if (alloca == src_base && array->Getuselist().size() != 0 &&
                                PointerTool_LoadElimination::all_offset_const(src_gep))
                            {
                                auto init = dynamic_cast<Initializer *>(array->Getuselist()[0]->usee);
                                std::vector<int> index;
                                for (int i = 2; i < src_gep->Getuselist().size(); i++)
                                {
                                    if (auto INT = dynamic_cast<ConstIRInt *>(src_gep->Getuselist()[i]->usee))
                                        index.push_back(INT->GetVal());
                                }
                                if (auto val = init->getInitVal(index))
                                    return std::pair{val, inst_->GetParent()};
                            }
                        }
                    }
                }
                else if (dynamic_cast<GetElementPtrInst *>(src) && inst_->Getuselist().size() > 1)
                {
                    Value *base = dynamic_cast<GetElementPtrInst *>(src)->GetOperand(0);
                    if (base->isGlobal())
                    {
                        Function *func_ = inst_->Getuselist()[0]->usee->as<Function>();
                        if (func_ && func_->Change_Val.count(base))
                            return std::pair{call, inst_->GetParent()};
                    }
                    else
                    {
                        Function *func_ = call->Getuselist()[0]->usee->as<Function>();
                        if (func_ && func_->tag == Function::Tag::ParallelBody)
                        {
                            for (auto &use : call->Getuselist())
                            {
                                if (base == use->usee)
                                    return std::pair{nullptr, nullptr};
                            }
                        }
                        bool flag = false;
                        int distance = 0;
                        for (auto &use : call->Getuselist())
                        {
                            if (auto call_gep = dynamic_cast<GetElementPtrInst *>(use->usee))
                            {
                                if (call_gep->GetOperand(0) == base)
                                {
                                    flag = true;
                                    break;
                                }
                            }
                            distance++;
                        }
                        if (flag)
                        {
                            Function *func_ = call->Getuselist()[0]->usee->as<Function>();
                            if (func_ && func_->Change_Val.count(func_->GetParams()[distance - 1].get()))
                                return std::pair{call, inst_->GetParent()};
                        }
                    }
                }
                else if (src->isGlobal())
                {
                    Function *func_ = call->Getuselist()[0]->usee->as<Function>();
                    if (func_ && func_->Change_Val.count(src))
                        return std::pair{call, inst_->GetParent()};
                }
            }
            else if (auto binary = dynamic_cast<BinaryInst *>(inst_))
            {
                if (binary->IsAtomic())
                {
                    if (binary->GetOperand(0) == src || binary->GetOperand(1) == src)
                        return std::pair{binary, inst_->GetParent()};
                }
            }
            else if (dynamic_cast<LoadInst *>(inst_))
            {
                if (inst_ == origin)
                    return std::pair{nullptr, inst_->GetParent()};
            }
        }
    }
    return std::pair{nullptr, nullptr};
}