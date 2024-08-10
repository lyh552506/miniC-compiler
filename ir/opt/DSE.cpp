#include "../../include/ir/opt/DSE.hpp"

void DeadStoreElimination::init()
{
    Store_Map.clear();
    Array_Store_Map.clear();
    wait_del.clear();
    DomTree = AM.get<dominance>(func);
}

bool DeadStoreElimination::Run()
{
    bool modified = false;
    // WorkList.push_back(func->front());
    // while (!WorkList.empty())
    // {
        // BasicBlock *block = WorkList.back();
        // WorkList.pop_back();
        // if (HasHandleBlock.count(block))
            // continue;
        // HasHandleBlock.insert(block);
    for(auto block : *func)
        modified |= RunOnBlock(block);
    // }

    for (auto &[key, val] : Array_Store_Map)
    {
        for (auto &[key2, val2] : val)
        {
            wait_del.push_back(val2);
        }
    }
    for (auto &[key, val] : Global_Store_Map)
    {
        wait_del.push_back(val);
    }
    for (auto &[key, val] : Param_Store_Map)
    {
        wait_del.push_back(val);
    }
    for (auto &[key, val] : Store_Map)
    {
        wait_del.push_back(val);
    }
    while (!wait_del.empty())
    {
        modified = true;
        User *inst = wait_del.back();
        wait_del.pop_back();
        delete inst;
    }
    return modified;
}

bool DeadStoreElimination::RunOnBlock(BasicBlock *block)
{
    for (User *inst : *block)
    {
        if (auto store = dynamic_cast<StoreInst *>(inst))
        {
            Value *dst = inst->GetOperand(1);
            if(dst->GetName() == ".378")
                int c = 1;
            if (dst->isGlobal())
            {
                if (Global_Store_Map.count(dst))
                    wait_del.push_back(Global_Store_Map[dst]);
                Global_Store_Map[dst] = store;
            }
            else if (dst->isParam())
            {
                if (Param_Store_Map.count(dst))
                    wait_del.push_back(Param_Store_Map[dst]);
                Param_Store_Map[dst] = store;
            }
            else
            {
                if (auto gep_dst = dynamic_cast<GetElementPtrInst *>(dst))
                {
                    if (auto alloca = dynamic_cast<AllocaInst *>(gep_dst->Getuselist()[0]->usee))
                    {
                        if (Array_Store_Map.count(alloca) &&
                            Array_Store_Map[alloca].count(AliasAnalysis::GetHash(gep_dst)))
                            wait_del.push_back(Array_Store_Map[alloca][AliasAnalysis::GetHash(gep_dst)]);
                        Array_Store_Map[alloca][AliasAnalysis::GetHash(gep_dst)] = store;
                    }
                    else if (gep_dst->Getuselist()[0]->usee->isParam())
                    {
                        if (Array_Store_Map.count(gep_dst->Getuselist()[0]->usee) &&
                            Array_Store_Map[gep_dst->Getuselist()[0]->usee].count(AliasAnalysis::GetHash(gep_dst)))
                            wait_del.push_back(
                                Array_Store_Map[gep_dst->Getuselist()[0]->usee][AliasAnalysis::GetHash(gep_dst)]);
                        Array_Store_Map[gep_dst->Getuselist()[0]->usee][AliasAnalysis::GetHash(gep_dst)] = store;
                    }
                }
                else
                {
                    if (Store_Map.count(dst))
                        wait_del.push_back(Store_Map[dst]);
                    Store_Map[dst] = store;
                }
            }
            continue;
        }

        if (auto load = dynamic_cast<LoadInst *>(inst))
        {
            Value *val = load->GetOperand(0);
            if (auto gep = dynamic_cast<GetElementPtrInst *>(val))
            {
                if (auto alloca = dynamic_cast<AllocaInst *>(gep->Getuselist()[0]->usee))
                {
                    if (Array_Store_Map.count(alloca) && Array_Store_Map[alloca].count(AliasAnalysis::GetHash(gep)))
                    {
                        Array_Store_Map[alloca].erase(AliasAnalysis::GetHash(gep));
                    }
                    else if (Array_Store_Map.count(alloca))
                    {
                        Array_Store_Map[alloca] = {};
                    }
                }
                else if (gep->Getuselist()[0]->usee->isParam())
                {
                    if (Array_Store_Map.count(gep->Getuselist()[0]->usee) &&
                        Array_Store_Map[gep->Getuselist()[0]->usee].count(AliasAnalysis::GetHash(gep)))
                        Array_Store_Map[gep->Getuselist()[0]->usee].erase(AliasAnalysis::GetHash(gep));
                    else if (Array_Store_Map.count(gep->Getuselist()[0]->usee))
                        Array_Store_Map[gep->Getuselist()[0]->usee] = {};
                }
            }
            else
            {
                if (val->isGlobal())
                {
                    if (Global_Store_Map.count(val))
                        Global_Store_Map.erase(val);
                }
                else if (val->isParam())
                {
                    if (Param_Store_Map.count(val))
                        Param_Store_Map.erase(val);
                }
                else
                {
                    if (Store_Map.count(val))
                        Store_Map.erase(val);
                }
            }
            continue;
        }

        if (auto call = dynamic_cast<CallInst *>(inst))
        {
            std::string name = call->GetOperand(0)->GetName();
            if (name == "getint" || name == "getch" || name == "getfloat")
            {
                Value *val = inst->GetDef();
                if (val->isGlobal())
                {
                    if (Global_Store_Map.count(val))
                        Global_Store_Map.erase(val);
                }
                else if (val->isParam())
                {
                    if (Param_Store_Map.count(val))
                        Param_Store_Map.erase(val);
                }
                else
                {
                    if (Store_Map.count(val))
                        Store_Map.erase(val);
                }
            }
            else if (name == "getfarray" || name == "getarray")
            {
                Value *val = inst->GetDef();
                if (auto gep = dynamic_cast<GetElementPtrInst *>(val))
                {
                    if (auto alloca = dynamic_cast<AllocaInst *>(gep->Getuselist()[0]->usee))
                    {
                        if (Array_Store_Map.count(alloca))
                            Array_Store_Map[alloca] = {};
                    }
                    else if (gep->Getuselist()[0]->usee->isParam())
                    {
                        if (Array_Store_Map.count(gep->Getuselist()[0]->usee))
                            Array_Store_Map[gep->Getuselist()[0]->usee] = {};
                    }
                }
                else
                {
                    if (val->isGlobal())
                    {
                        if (Global_Store_Map.count(val))
                            Global_Store_Map.erase(val);
                    }
                    else if (val->isParam())
                    {
                        if (Param_Store_Map.count(val))
                            Param_Store_Map.erase(val);
                    }
                    else
                    {
                        if (Store_Map.count(val))
                            Store_Map.erase(val);
                    }
                }
            }
            else
            {
                for (auto &use : inst->Getuselist())
                {
                    Value *val = use->usee;
                    if (val->isGlobal())
                    {
                        if (Global_Store_Map.count(val))
                            Global_Store_Map.erase(val);
                    }
                    else if (val->isParam())
                    {
                        if (Param_Store_Map.count(val))
                            Param_Store_Map.erase(val);
                    }
                    else
                    {
                        if (auto gep = dynamic_cast<GetElementPtrInst *>(val))
                        {
                            if (auto alloca = dynamic_cast<AllocaInst *>(gep->Getuselist()[0]->usee))
                            {
                                if (Array_Store_Map.count(alloca) &&
                                    Array_Store_Map[alloca].count(AliasAnalysis::GetHash(gep)))
                                {
                                    Array_Store_Map[alloca].erase(AliasAnalysis::GetHash(gep));
                                }
                                else if (Array_Store_Map.count(alloca))
                                {
                                    Array_Store_Map[alloca] = {};
                                }
                            }
                            else if (gep->Getuselist()[0]->usee->isParam())
                            {
                                if (Array_Store_Map.count(gep->Getuselist()[0]->usee) &&
                                    Array_Store_Map[gep->Getuselist()[0]->usee].count(AliasAnalysis::GetHash(gep)))
                                    Array_Store_Map[gep->Getuselist()[0]->usee].erase(AliasAnalysis::GetHash(gep));
                                else if (Array_Store_Map.count(gep->Getuselist()[0]->usee))
                                    Array_Store_Map[gep->Getuselist()[0]->usee] = {};
                            }
                        }
                        else if (Store_Map.count(val))
                            Store_Map.erase(val);
                    }
                }
            }
        }
        if (dynamic_cast<CondInst *>(inst))
        {
            Value *val = inst->Getuselist()[0]->usee;
            if (val->isGlobal())
            {
                if (Global_Store_Map.count(val))
                    Global_Store_Map.erase(val);
            }
            else if (val->isParam())
            {
                if (Param_Store_Map.count(val))
                    Param_Store_Map.erase(val);
            }
            else
            {
                if (Store_Map.count(val))
                    Store_Map.erase(val);
            }
            WorkList.push_back(dynamic_cast<BasicBlock *>(inst->Getuselist()[1]->usee));
            WorkList.push_back(dynamic_cast<BasicBlock *>(inst->Getuselist()[2]->usee));
            continue;
        }
        if (dynamic_cast<UnCondInst *>(inst))
        {
            WorkList.push_back(dynamic_cast<BasicBlock *>(inst->Getuselist()[0]->usee));
            continue;
        }
        {
            for (auto &use : inst->Getuselist())
            {
                Value *val = use->usee;
                if (val->isGlobal())
                {
                    if (Global_Store_Map.count(val))
                        Global_Store_Map.erase(val);
                }
                else if (val->isParam())
                {
                    if (Param_Store_Map.count(val))
                        Param_Store_Map.erase(val);
                }
                else
                {
                    if (Store_Map.count(val))
                        Store_Map.erase(val);
                }
            }
            continue;
        }
    }
    return false;
}