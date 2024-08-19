#include "../../include/ir/opt/DSE.hpp"
#include "../../include/lib/CFG.hpp"

namespace PointerTool
{
auto all_offset_const = [](GetElementPtrInst *inst) {
    return std::all_of(inst->Getuselist().begin() + 1, inst->Getuselist().end(),
                       [](User::UsePtr &use) { return dynamic_cast<ConstantData *>(use->usee); });
};
} // namespace PointerTool

void DeadStoreElimination::init()
{
    wait_del.clear();
    DomTree = AM.get<dominance>(func);
    AM.get<SideEffect>(&Singleton<Module>());
    func->init_visited_block();
    OrderBlock(func->front());
    std::reverse(DFSOrder.begin(), DFSOrder.end());
}

void DeadStoreElimination::OrderBlock(BasicBlock *block)
{
    if (block->visited)
        return;
    block->visited = true;
    for (int dest : DomTree->GetNode(block->num).des)
        OrderBlock(DomTree->GetNode(dest).thisBlock);
    DFSOrder.push_back(block);
}

bool DeadStoreElimination::Run()
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

bool DeadStoreElimination::RunOnBlock(BasicBlock *block)
{
    for (User *inst : *block)
    {
        if (!dynamic_cast<StoreInst *>(inst))
            continue;
        StoreInst *store = dynamic_cast<StoreInst *>(inst);
        mylist<BasicBlock, User>::iterator pos(store);
        std::unordered_set<BasicBlock *> visited;
        if (Judge(store, block, store->GetOperand(1), block, visited, ++pos))
            wait_del.insert(store);
    }
    return false;
}

bool DeadStoreElimination::Judge(StoreInst *store, BasicBlock *block, Value *dst, BasicBlock *src_block,
                                 std::unordered_set<BasicBlock *> &visited, mylist<BasicBlock, User>::iterator pos)
{
    if(auto phi = dynamic_cast<PhiInst*>(dst))
    {
        for(auto&[key, val] : phi->PhiRecord)
        {
            if(auto gep = dynamic_cast<GetElementPtrInst*>(val.first))
            {
                dst = gep;
                break;
            }
        }
    }
    // 下一个block
    if (!store)
    {
        if (visited.count(block))
            return true;
        visited.insert(block);
        pos = block->begin();
    }
    for (; pos != block->end(); ++pos)
    {
        User *inst = *pos;
        if (dynamic_cast<StoreInst *>(inst))
        {
            Value *val = inst->Getuselist()[1]->usee;
            if (inst->GetOperand(1) == dst)
                return true;
            if (auto gep = dynamic_cast<GetElementPtrInst *>(val))
            {
                if (auto gep_dst = dynamic_cast<GetElementPtrInst *>(dst))
                {
                    if (!PointerTool::all_offset_const(gep) &&
                        gep->Getuselist()[0]->usee == gep_dst->Getuselist()[0]->usee)
                        return false;
                    else if (gep->Getuselist()[0]->usee == gep_dst->Getuselist()[0]->usee &&
                             AliasAnalysis::GetHash(gep) == AliasAnalysis::GetHash(gep_dst))
                        return true;
                }
            }
        }
        else if (dynamic_cast<CallInst *>(inst))
        {
            auto op1 = inst->Getuselist()[0]->usee;
            if (op1->GetName() == "putint" || op1->GetName() == "putfloat")
            {
                if (inst->Getuselist()[1]->usee == dst)
                    return false;
            }
            else if (dynamic_cast<GetElementPtrInst *>(dst) && inst->Getuselist().size() > 1)
            {
                auto base = dynamic_cast<GetElementPtrInst *>(dst)->GetOperand(0);
                if (op1->GetName() == "putarray" || op1->GetName() == "putfarray")
                {
                    if (auto put = dynamic_cast<GetElementPtrInst *>(inst->Getuselist()[2]->usee))
                    {
                        if (put->Getuselist()[0]->usee == base)
                            return false;
                    }
                }
                else if (op1->GetName() == "llvm.memcpy.p0.p0.i32")
                {
                    if (inst->Getuselist()[1]->usee == base)
                        return false;
                }
                if (base->isGlobal())
                {
                    Function *func = inst->Getuselist()[0]->usee->as<Function>();
                    if (func && base->ReadFunc.count(func))
                        return false;
                }
                else
                {
                    Function* parallel_body = inst->GetOperand(0)->as<Function>();
                    if(parallel_body && parallel_body->tag == Function::Tag::ParallelBody)
                    {
                        for(auto& use : inst->Getuselist())
                        {
                            Value* val = use->usee;
                            if(!dynamic_cast<GetElementPtrInst*>(val) && val == base)
                                return false;
                            else if(auto gep = dynamic_cast<GetElementPtrInst*>(val))
                            {
                                if(gep->GetOperand(0) == base)
                                    return false;
                            }
                        }
                    }
                    bool flag = false;
                    int distance = 0;
                    for (auto &use : inst->Getuselist())
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
                        Function *func_ = inst->Getuselist()[0]->usee->as<Function>();
                        if (func_->MemRead())
                            return false;
                    }
                }
            }
            else
            {
                Function *func = inst->Getuselist()[0]->usee->as<Function>();
                if (func)
                {
                    if (func->MemRead())
                        return false;
                }
            }
        }
        else if(auto binary = dynamic_cast<BinaryInst*>(inst))
        {
            if(binary->IsAtomic())
            {
                if(binary->GetOperand(0) == dst)
                    return false;
                else if(binary->GetOperand(1) == dst)
                    return false;
            }
        }
        else if (dynamic_cast<LoadInst *>(inst))
        {
            Value *val = inst->Getuselist()[0]->usee;
            if (val == dst)
                return false;
            if (auto gep = dynamic_cast<GetElementPtrInst *>(val))
            {
                if (auto gep_dst = dynamic_cast<GetElementPtrInst *>(dst))
                {
                    bool flag = PointerTool::all_offset_const(gep);
                    bool flag1 = PointerTool::all_offset_const(gep_dst);
                    if ((!flag || !flag1) && gep->Getuselist()[0]->usee == gep_dst->Getuselist()[0]->usee)
                        return false;
                    else if (gep->Getuselist()[0]->usee == gep_dst->Getuselist()[0]->usee &&
                             AliasAnalysis::GetHash(gep) == AliasAnalysis::GetHash(gep_dst))
                        return false;
                }
            }
        }
        else if (dynamic_cast<RetInst *>(inst))
        {
            if (dst->GetType()->GetTypeEnum() == IR_PTR && func->GetUserlist().GetSize() != 0)
                return false;
            if (inst->Getuselist()[0]->usee == dst)
                return false;
        }
        else if (dynamic_cast<CondInst *>(inst))
        {
            BasicBlock *true_block = inst->GetOperand(1)->as<BasicBlock>();
            BasicBlock *false_block = inst->GetOperand(2)->as<BasicBlock>();
            auto HandleSucc = [&](BasicBlock *succ) {
                if (src_block == succ)
                    return false;
                if (!DomTree->dominates(src_block, succ))
                    return false;
                return Judge(nullptr, succ, dst, src_block, visited, succ->begin());
            };
            bool Handle_failed = false;
            {
                if (!HandleSucc(true_block))
                    Handle_failed = true;
            }
            {
                if (Handle_failed)
                    return false;
                if (!HandleSucc(false_block))
                    Handle_failed = true;
            }
            if (Handle_failed)
                return false;
        }
        else if (dynamic_cast<UnCondInst *>(inst))
        {
            BasicBlock *succ_block = inst->GetOperand(0)->as<BasicBlock>();
            auto HandleSucc = [&](BasicBlock *succ) {
                if (src_block == succ)
                    return false;
                if (!DomTree->dominates(src_block, succ))
                    return false;
                return Judge(nullptr, succ, dst, src_block, visited, succ->begin());
            };
            if (!HandleSucc(succ_block))
                return false;
        }
    }
    return true;
}