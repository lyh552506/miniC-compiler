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
    std::unordered_map<Value *, std::vector<StoreInst *>> info;
    Collect(info);
    CheckSelfStore(info);
    if (info.empty())
        return false;
    for (auto &[key, val] : info)
    {
        for (auto inst : val)
            wait_del.insert(inst);
    }
    return true;
}

void SelfStoreElimination::Collect(std::unordered_map<Value *, std::vector<StoreInst *>> &info)
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
                else
                    info[dst].push_back(store);
            }
        }
    }
}

void SelfStoreElimination::CheckSelfStore(std::unordered_map<Value *, std::vector<StoreInst *>> &info)
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