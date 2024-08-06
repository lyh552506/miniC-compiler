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
            cur->SetChildValueAddr(cur->GetValueAddr());
        }
        else if (cur->Child() != cur->EndIter())
        {
            auto node = cur->NextChild();
            WorkList.push_back(new HandleNode(DomTree, &(DomTree->GetNode(*node)),
                                              DomTree->GetNode(*node).idom_child.begin(),
                                              DomTree->GetNode(*node).idom_child.end(), cur->GetChildValueAddr()));
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

bool GepEvaluate::ProcessNode(HandleNode* node)
{
    
}