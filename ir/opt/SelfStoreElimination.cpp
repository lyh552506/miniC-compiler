#include "../../include/ir/opt/SelfStoreElimination.hpp"

void SelfStoreElimination::init()
{
    wait_del.clear();
    DomTree = AM.get<dominance>(func);
    AM.get<SideEffect>(&Singleton<Module>());
    func->init_visited_block();
    OrderBlock(func->front());
    std::reverse(DFSOrder.begin(), DFSOrder.end());
}

void SelfStoreElimination::OrderBlock(BasicBlock *block)
{
    if (block->visited)
        return;
    block->visited = true;
    for (int dest : DomTree->GetNode(block->num).des)
        OrderBlock(DomTree->GetNode(dest).thisBlock);
    DFSOrder.push_back(block);
}

bool SelfStoreElimination::Run()
{
    std::unordered_map<Value *, std::vector<User *>> info;
    Collect(info);
    CheckSelfStore(info);
    if (info.empty())
        return false;
    for (auto &[key, val] : info)
    {
        for (auto inst : val)
            wait_del.insert(inst);
    }
    while (!wait_del.empty())
    {
        User *inst = *wait_del.begin();
        wait_del.erase(inst);
        delete inst;
    }
    return true;
}

void SelfStoreElimination::Collect(std::unordered_map<Value *, std::vector<User *>> &info)
{
    for (BasicBlock *block : DFSOrder)
    {
        for (User *inst : *block)
        {
            if (auto store = dynamic_cast<StoreInst *>(inst))
            {
                Value *dst = store->GetOperand(1);
                if (auto gep = dynamic_cast<GetElementPtrInst *>(dst))
                {
                    if (auto alloca = dynamic_cast<AllocaInst *>(gep->Getuselist()[0]->usee))
                        info[alloca].push_back(store);
                }
                else if (!dynamic_cast<PhiInst *>(dst) && !dst->isGlobal())
                    info[dst].push_back(store);
            }
            else if (dynamic_cast<CallInst *>(inst))
            {
                Value *call_func = inst->Getuselist()[0]->usee;
                std::string name = call_func->GetName();
                if (name == "llvm.memcpy.p0.p0.i32")
                {
                    Value *dst = inst->GetOperand(1);
                    if (auto gep = dynamic_cast<GetElementPtrInst *>(dst))
                    {
                        if (auto alloca = dynamic_cast<AllocaInst *>(gep->Getuselist()[0]->usee))
                            info[alloca].push_back(inst);
                    }
                    else if (auto alloca = dynamic_cast<AllocaInst *>(dst))
                        info[alloca].push_back(inst);
                }
            }
        }
    }
}

void SelfStoreElimination::CheckSelfStore(std::unordered_map<Value *, std::vector<User *>> &info)
{
    for (BasicBlock *block : *func)
    {
        for (User *inst : *block)
        {
            if (auto store = dynamic_cast<StoreInst *>(inst))
            {
                Value *src = store->GetOperand(0);
                if (auto load = dynamic_cast<LoadInst *>(src))
                {
                    if (auto gep = dynamic_cast<GetElementPtrInst *>(load->Getuselist()[0]->usee))
                    {
                        if (auto alloca = dynamic_cast<AllocaInst *>(gep->Getuselist()[0]->usee))
                            info.erase(alloca);
                    }
                }
                else
                    info.erase(src);
            }
            else if (dynamic_cast<GetElementPtrInst *>(inst))
            {
                if (auto alloca = dynamic_cast<AllocaInst *>(inst->Getuselist()[0]->usee))
                {
                    if (info.count(alloca))
                    {
                        for (auto user_ : inst->GetUserlist())
                        {
                            User *user = user_->GetUser();
                            if (!dynamic_cast<GetElementPtrInst *>(user) && !dynamic_cast<StoreInst *>(user))
                            {
                                info.erase(alloca);
                                break;
                            }
                        }
                    }
                }
            }
            else if (dynamic_cast<CallInst *>(inst))
            {
                Function *call_func = dynamic_cast<Function *>(inst->Getuselist()[0]->usee);
                if (call_func && call_func->tag != Function::Tag::ParallelBody)
                {
                    for (Value *val : call_func->Change_Val)
                        info.erase(val);
                }
                else if (call_func && call_func->tag == Function::Tag::ParallelBody)
                {
                    for (auto &use : inst->Getuselist())
                    {
                        Value *val = use->usee;
                        info.erase(val);
                    }
                }
            }
            else
            {
                for (auto &use : inst->Getuselist())
                {
                    Value *val = use->usee;
                    info.erase(val);
                }
            }
        }
    }
}