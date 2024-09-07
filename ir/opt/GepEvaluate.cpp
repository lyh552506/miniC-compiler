#include "../../include/ir/opt/GepEvaluate.hpp"

bool GepEvaluate::Run()
{
    // auto test = gep->Getuselist()[0]->usee;
    // if (dynamic_cast<AllocaInst *>(test) && test->GetName() == ".101")
    // {
    //     auto test1 = dynamic_cast<HasSubType *>(test->GetType());
    //     auto test2 = test1->GetSubType()->GetTypeEnum();
    //     int a = 1;
    //     if (test1->GetSubType()->GetTypeEnum() == InnerDataType::IR_ARRAY)
    //     {
    //         auto test2 = dynamic_cast<ArrayType *>(test1->GetSubType());
    //         int b = 1;
    //         if (test2->GetNumEle() == 1)
    //         {
    //             int c = 1;
    //         }
    //     }
    // }

    DomTree = AM.get<dominance>(func);
    AM.get<SideEffect>(&Singleton<Module>());
    bool modified = false;

    Mapping.clear();
    std::deque<HandleNode *> WorkList;
    WorkList.push_back(new HandleNode(DomTree, &(DomTree->GetNode(0)), DomTree->GetNode(0).idom_child.begin(),
                                      DomTree->GetNode(0).idom_child.end(),
                                      std::unordered_map<Value *, std::unordered_map<size_t, Value *>>()));
    Mapping[DomTree->GetNode(0).thisBlock] = WorkList.back();
    while (!WorkList.empty())
    {
        GepEvaluate::HandleNode *cur = WorkList.back();
        if (!cur->isProcessed())
        {
            modified |= ProcessNode(cur);
            cur->Process();
        }
        else if (cur->Child() != cur->EndIter())
        {
            auto node = cur->NextChild();
            WorkList.push_back(new HandleNode(DomTree, &(DomTree->GetNode(*node)),
                                              DomTree->GetNode(*node).idom_child.begin(),
                                              DomTree->GetNode(*node).idom_child.end(), cur->ValueAddr));
            Mapping[DomTree->GetNode(*node).thisBlock] = WorkList.back();
        }
        else
            WorkList.pop_back();
    }
    while (!wait_del.empty())
    {
        User *inst = wait_del.back();
        wait_del.pop_back();
        inst->ClearRelation();
        inst->EraseFromParent();
    }
    return modified;
}

bool GepEvaluate::ProcessNode(HandleNode *node)
{
    bool modified = false;
    BasicBlock *block = node->GetBlock();
    HandleBlockIn(node->ValueAddr, node);
    for (User *inst : *block)
    {
        if (auto alloca = dynamic_cast<AllocaInst *>(inst))
        {
            allocas.insert(alloca);
            continue;
        }
        if (dynamic_cast<CallInst *>(inst))
        {
            if (inst->Getuselist()[0]->usee->GetName() == "llvm.memcpy.p0.p0.i32")
            {
                auto array = dynamic_cast<Variable *>(inst->Getuselist()[2]->usee);
                if (array && array->usage == Variable::Constant)
                {
                    if (auto alloca = dynamic_cast<AllocaInst *>(inst->Getuselist()[1]->usee))
                    {
                        if (array->Getuselist().size() != 0)
                        {
                            auto init = dynamic_cast<Initializer *>(array->Getuselist()[0]->usee);
                            AllocaInitMap[alloca] = init;
                            HandleMemcpy(alloca, init, node, std::vector<int>());
                        }
                    }
                }
                continue;
            }
            for (auto &use : inst->Getuselist())
            {
                if (use->usee->GetType()->GetTypeEnum() == InnerDataType::IR_PTR)
                {
                    if (auto gep = dynamic_cast<GetElementPtrInst *>(use->usee))
                    {
                        auto all_offset_zero = [&gep]() {
                            return std::all_of(gep->Getuselist().begin() + 1, gep->Getuselist().end(),
                                               [](User::UsePtr &use) {
                                                   if (auto val = dynamic_cast<ConstantData *>(use->usee))
                                                   {
                                                       return val->isConstZero();
                                                   }
                                                   return false;
                                               });
                        };
                        if (all_offset_zero() && dynamic_cast<AllocaInst *>(gep->Getuselist()[0]->usee))
                        {
                            auto alloca = dynamic_cast<AllocaInst *>(gep->Getuselist()[0]->usee);
                            node->ValueAddr[alloca].clear();
                            alloca->AllZero = false;
                            alloca->HasStored = true;
                        }
                    }
                    else if (auto alloca = dynamic_cast<AllocaInst *>(use->usee))
                    {
                        node->ValueAddr[alloca].clear();
                        alloca->AllZero = false;
                        alloca->HasStored = true;
                    }
                }
                else if (auto alloca = dynamic_cast<AllocaInst *>(use->usee))
                {
                    node->ValueAddr[alloca].clear();
                    alloca->AllZero = false;
                    alloca->HasStored = true;
                }
            }
            continue;
        }
        if (dynamic_cast<LoadInst *>(inst))
        {
            if (auto gep = dynamic_cast<GetElementPtrInst *>(inst->Getuselist()[0]->usee))
            {
                if (auto alloca = dynamic_cast<AllocaInst *>(gep->Getuselist()[0]->usee))
                {
                    size_t hash = GepHash{}(gep, &node->ValueAddr);
                    if (node->ValueAddr.find(alloca) != node->ValueAddr.end())
                    {
                        if (node->ValueAddr[alloca].find(hash) != node->ValueAddr[alloca].end())
                        {
                            inst->RAUW(node->ValueAddr[alloca][hash]);
                            wait_del.push_back(inst);
                            modified = true;
                        }
                    }
                    else if (!alloca->HasStored)
                    {
                        bool flag_all_const = true;
                        std::vector<int> index;
                        for (int i = 2; i < gep->Getuselist().size(); i++)
                        {
                            if (auto INT = dynamic_cast<ConstIRInt *>(gep->Getuselist()[i]->usee))
                                index.push_back(INT->GetVal());
                            else
                            {
                                flag_all_const = false;
                                break;
                            }
                        }
                        if (auto init = AllocaInitMap[alloca])
                        {
                            if (flag_all_const)
                            {
                                if (auto val = init->getInitVal(index))
                                {
                                    inst->RAUW(val);
                                    wait_del.push_back(inst);
                                    modified = true;
                                }
                            }
                        }
                    }
                }
            }
            continue;
        }
        if (dynamic_cast<StoreInst *>(inst))
        {
            if (auto gep = dynamic_cast<GetElementPtrInst *>(inst->Getuselist()[1]->usee))
            {
                if (auto alloca = dynamic_cast<AllocaInst *>(gep->Getuselist()[0]->usee))
                {
                    alloca->HasStored = true;
                    alloca->AllZero = false;
                    AllocaInitMap.erase(alloca);
                    auto all_offset_const = [&gep]() {
                        return std::all_of(gep->Getuselist().begin() + 1, gep->Getuselist().end(),
                                           [](User::UsePtr &use) {
                                               if (auto val = dynamic_cast<ConstantData *>(use->usee))
                                               {
                                                   return true;
                                               }
                                               return false;
                                           });
                    };
                    if (!all_offset_const())
                        node->ValueAddr[alloca].clear();
                    size_t hash = GepHash{}(gep, &node->ValueAddr);
                    node->ValueAddr[alloca][hash] = inst->Getuselist()[0]->usee;
                }
                else if (auto gep_base = dynamic_cast<GetElementPtrInst *>(gep->Getuselist()[0]->usee))
                {
                    assert(0 && "GepCombine has not been run");
                    if (auto alloca = dynamic_cast<AllocaInst *>(gep->Getuselist()[0]->usee))
                    {
                        size_t hash = GepHash{}(gep, &node->ValueAddr);
                        node->ValueAddr[alloca][hash] = inst->Getuselist()[0]->usee;
                    }
                }
                else if (gep->Getuselist()[0]->usee->isParam())
                {
                    auto base = gep->Getuselist()[0]->usee;
                    auto all_offset_const = [&gep]() {
                        return std::all_of(gep->Getuselist().begin() + 1, gep->Getuselist().end(),
                                           [](User::UsePtr &use) {
                                               if (auto val = dynamic_cast<ConstantData *>(use->usee))
                                               {
                                                   return true;
                                               }
                                               return false;
                                           });
                    };
                    if (!all_offset_const())
                        node->ValueAddr[base].clear();
                    size_t hash = GepHash{}(gep, &node->ValueAddr);
                    node->ValueAddr[base][hash] = inst->Getuselist()[0]->usee;
                }
            }
            continue;
        }
    }
    return modified;
}

void GepEvaluate::HandleMemcpy(AllocaInst *inst, Initializer *init, HandleNode *node, std::vector<int> index)
{
    if (init->size() == 0)
    {
        inst->AllZero = true;
        return;
    }
    int limi = dynamic_cast<ArrayType *>(init->GetType())->GetNumEle();
    for (int i = 0; i < limi; i++)
    {
        if (i < init->size())
        {
            index.push_back(i);
            if (auto inits = dynamic_cast<Initializer *>((*init)[i]))
            {
                HandleMemcpy(inst, inits, node, index);
                index.pop_back();
            }
            else // Handle Truly value
            {
                node->ValueAddr[inst][InitHash{}(inst, index)] = (*init)[i];
                index.pop_back();
            }
        }
        else // 这里就是zero
        {
            index.push_back(i);
            HandleZeroInitializer(inst, node, index);
            index.pop_back();
        }
    }
}

void GepEvaluate::HandleZeroInitializer(AllocaInst *inst, HandleNode *node, std::vector<int> index)
{
    return; // TODO
}

void GepEvaluate::HandleBlockIn(ValueAddr_Struct &addr, HandleNode *node)
{
    if (node->GetBlock()->GetUserlist().GetSize() < 2)
        return;
    std::vector<ValueAddr_Struct *> maps;

    for (auto user : node->GetBlock()->GetUserlist())
    {
        BasicBlock *userblock = user->GetUser()->GetParent();
        auto HandleNode = Mapping[userblock];
        if (HandleNode)
            maps.push_back(&(HandleNode->ValueAddr));
        else
        {
            for (auto alloca : allocas)
                alloca->HasStored = true;
            addr.clear();
            return;
        }
    }

    auto findCommonKeys = [](std::vector<ValueAddr_Struct *> &maps) {
        std::unordered_set<Value *> allKeys;
        std::unordered_set<Value *> commonKeys;

        for (auto &map : maps)
        {
            for (auto &[key, value] : *map)
            {
                if (key && allKeys.count(key))
                {
                    commonKeys.insert(key); // 发现重复的key
                }
                else
                {
                    allKeys.insert(key);
                }
            }
        }
        return commonKeys;
    };
    auto commonKeys = findCommonKeys(maps);
    if (!commonKeys.empty())
    {
        for (auto key : commonKeys)
        {
            if (addr.find(key) != addr.end())
                addr.erase(key);
        }
    }
}