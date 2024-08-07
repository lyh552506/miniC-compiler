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
    std::deque<HandleNode *> WorkList;
    WorkList.push_back(new HandleNode(DomTree, &(DomTree->GetNode(0)), DomTree->GetNode(0).idom_child.begin(),
                                      DomTree->GetNode(0).idom_child.end(),
                                      std::unordered_map<Value *, std::unordered_map<size_t, Value *>>()));
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
        }
        else
        {
            delete cur;
            WorkList.pop_back();
        }
    }
    while (!wait_del.empty())
    {
        User *inst = wait_del.back();
        wait_del.pop_back();
        delete inst;
    }
    return modified;
}

bool GepEvaluate::ProcessNode(HandleNode *node)
{
    bool modified = false;
    BasicBlock *block = node->GetBlock();
    for (User *inst : *block)
    {
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
                            HandleMemcpy(alloca, init, node, std::vector<int>());
                        }
                    }
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
                    size_t hash = GepHash{}(gep);
                    if (node->ValueAddr[alloca].find(hash) != node->ValueAddr[alloca].end())
                    {
                        inst->RAUW(node->ValueAddr[alloca][hash]);
                        wait_del.push_back(gep);
                        wait_del.push_back(inst);
                        modified = true;
                    }
                }
            }
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
            Value *val = nullptr; // 选择直接不处理, 在map找不到就是0
        }
    }
}
