#include "../../include/ir/opt/GepCombine.hpp"
#include "../../include/ir/Analysis/SideEffect.hpp"
#include "../../include/ir/opt/ConstantFold.hpp"
#include "../../include/ir/opt/InstructionSimplify.hpp"
#include <deque>

bool GepCombine::Run()
{
    DomTree = AM.get<dominance>(func);
    AM.get<SideEffect>(&Singleton<Module>());
    bool modified = false;
    std::deque<HandleNode *> WorkList;
    WorkList.push_back(new HandleNode(DomTree, &(DomTree->GetNode(0)), DomTree->GetNode(0).idom_child.begin(),
                                      DomTree->GetNode(0).idom_child.end()));
    while (!WorkList.empty())
    {
        GepCombine::HandleNode *cur = WorkList.back();
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
                                              DomTree->GetNode(*node).idom_child.end()));
        }
        else
        {
            delete cur;
            WorkList.pop_back();
        }
    }
    return modified;
}