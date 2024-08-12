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
        if (auto val = Judge(load, block, load->GetOperand(0), block, visited, --pos))
        {
            if (val != load)
            {
                load->RAUW(val);
                wait_del.insert(load);
            }
        }
    }
    return false;
}

Value *LoadElimination::Judge(User *inst, BasicBlock *block, Value *src, BasicBlock *pred_block,
                  std::unordered_set<BasicBlock *> &visited, mylist<BasicBlock, User>::iterator pos)
{
    bool Flag_CommonBlock = false;
    if (!inst && pred_block)
    {
        if (visited.count(pred_block))
            return nullptr;
        if (block == pred_block)
            Flag_CommonBlock = true;
        visited.insert(pred_block);
        pos = pred_block->rbegin();
    }

    for (;; --pos)
    {
        if (pos == pred_block->rend())
        {
            std::set<Value *> Pred_Value;
            for (auto pred_ : pred_block->GetUserlist())
            {
                User *br = pred_->GetUser();
                if (dynamic_cast<CondInst *>(br) || dynamic_cast<UnCondInst *>(br))
                {
                    BasicBlock *pred = br->GetParent();
                    // if (pred != block)
                    // {
                        auto val = Judge(nullptr, block, src, pred, visited, pred->rbegin());
                        if (val)
                            Pred_Value.insert(val);
                        else
                            return nullptr;
                    // }
                }
            }
            if (Pred_Value.size() == 1)
                return *Pred_Value.begin();
            return nullptr;
        }
        User *inst_ = *pos;
        if (!Flag_CommonBlock)
        {
            if (auto store = dynamic_cast<StoreInst *>(inst_))
            {
                if (auto src_gep = dynamic_cast<GetElementPtrInst *>(src))
                {
                    if (store->GetOperand(1) == src_gep)
                        return store->GetOperand(0);
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
                                    return store->GetOperand(0);
                            }
                            else if (!PointerTool_LoadElimination::all_offset_const(dst_gep))
                                return nullptr;
                        }
                    }
                }
                else if (store->GetOperand(1) == src)
                {
                    if (store->GetOperand(0) == src)
                        return nullptr;
                    return store->GetOperand(0);
                }
            }
            else if (auto load = dynamic_cast<LoadInst *>(inst_))
            {
                if (load->GetOperand(0) == src)
                    return load;
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
                        return nullptr;
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
                                    return val;
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
                            return nullptr;
                    }
                    else
                    {
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
                                return nullptr;
                        }
                    }
                }
                else if (src->isGlobal())
                {
                    Function *func_ = call->Getuselist()[0]->usee->as<Function>();
                    if (func_ && func_->Change_Val.count(src))
                        return nullptr;
                }
            }
            else if (auto binary = dynamic_cast<BinaryInst *>(inst_))
            {
                if (binary->IsAtomic())
                {
                    if (binary->GetOperand(0) == src || binary->GetOperand(1) == src)
                        return nullptr;
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
                        return nullptr;
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
                                    return nullptr;
                            }
                            else if (!PointerTool_LoadElimination::all_offset_const(dst_gep))
                                return nullptr;
                        }
                    }
                }
                else if (store->GetOperand(1) == src)
                {
                    if (store->GetOperand(0) == src)
                        return nullptr;
                    return nullptr;
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
                        return nullptr;
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
                                    return nullptr;
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
                            return nullptr;
                    }
                    else
                    {
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
                                return nullptr;
                        }
                    }
                }
                else if (src->isGlobal())
                {
                    Function *func_ = call->Getuselist()[0]->usee->as<Function>();
                    if (func_ && func_->Change_Val.count(src))
                        return nullptr;
                }
            }
            else if (auto binary = dynamic_cast<BinaryInst *>(inst_))
            {
                if (binary->IsAtomic())
                {
                    if (binary->GetOperand(0) == src || binary->GetOperand(1) == src)
                        return nullptr;
                }
            }
            else if (dynamic_cast<LoadInst *>(inst_))
            {
                if (inst_->GetOperand(0) == src)
                    return inst_;
            }
        }
    }
    return nullptr;
}