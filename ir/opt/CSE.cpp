#include "CSE.hpp"
#include "HashScope.hpp"
#include "DCE.hpp"
#include "ConstantFold.hpp"

void CSE::Init()
{
    CurrGens = 0;
    Del_Calls.clear();
    AEB_Binary.clear();
    AEB.clear();
    AEB_Const_RHS.clear();
    AEB_Const_LHS.clear();
    Loads.clear();
    Geps.clear();
    HashMap.clear();
}
// 先写一下迭代计算最小不动点部分
void CSE::RunOnFunction()
{
    // 这里采用deque而非vector的原因是在元素个数较多的时候deque的效率更高
    std::deque<dominance::Node*> WorkList;
    // std::vector<dominance::Node*> DFS = DomTree->node;
    std::queue<dominance::Node*> DFS = DomTree->DFS_Dom();
    // 将DFS中元素压入WorkList中
    while(!DFS.empty())
    {
        WorkList.push_back(DFS.front());
        DFS.pop();
    }
    // WorkList.push_back(DFS.front());
    // for (auto it = DFS.begin() + 1; it != DFS.end(); ++it)
    //     WorkList.push_back(*it);

    while(!WorkList.empty())
    {
        dominance::Node* CurrNode = WorkList.front();
        if(!Processed.count(CurrNode))
        {
            RunOnNode(CurrNode);
            Processed.insert(CurrNode);
            WorkList.pop_front();
        }
    }
}

// bool CSE::RunOnFunc()
// {
//     bool modified = false;
//     CurrGens = 0;
//     // 这里采用deque而非vector的原因是在元素个数较多的时候deque的效率更高
//     std::deque<dominance::Node*> WorkList;
//     // std::vector<dominance::Node*> DFS = DomTree->node;
//     std::queue<dominance::Node*> DFS = DomTree->DFS_Dom();
//     // 将DFS中元素压入WorkList中
//     while(!DFS.empty())
//     {
//         WorkList.push_back(DFS.front());
//         DFS.pop();
//     }
//     // WorkList.push_back(DFS.front());
//     // for (auto it = DFS.begin() + 1; it != DFS.end(); ++it)
//     //     WorkList.push_back(*it);
//     while(!WorkList.empty())
//     {
//         dominance::Node* CurrNode = WorkList.front();
//         if(!Processed.count(CurrNode))
//         {
//             modified |= RunOnNode(CurrNode);
//             Processed.insert(CurrNode);
//             WorkList.pop_front();
//         }
//     }
//     return modified;
// }

bool CSE::RunOnNode(dominance::Node* node)
{
    bool modified = false;
    BasicBlock* CurrentBlock = node->thisBlock;
    for(User* inst : *CurrentBlock)
    {
        // Binary
        // if(dynamic_cast<BinaryInst*>(inst))
        // {
        //     Value* LHS = inst->GetOperand(0);
        //     Value* RHS = inst->GetOperand(0);

        //     ConstantData* ConstLHS = dynamic_cast<ConstantData*>(LHS);
        //     ConstantData* ConstRHS = dynamic_cast<ConstantData*>(RHS);
        //     if(LHS)
        //     {
        //         if(AEB_Const_LHS.find(std::make_tuple(ConstLHS, RHS, inst->GetInstId())) != AEB_Const_LHS.end())
        //         {
        //             std::pair<size_t, Value*>& iter = AEB_Const_LHS[std::make_tuple(ConstLHS, RHS, inst->GetInstId())];
        //             inst->RAUW(iter.second);
        //             wait_del.push_back(inst);
        //             modified = true;
        //         }
        //         else
        //         {
        //             AEB_Const_LHS[std::make_tuple(ConstLHS, RHS, inst->GetInstId())] = std::make_pair(CurrGens, inst);
        //         }
        //     }
        //     else if(RHS)
        //     {
        //         if(AEB_Const_RHS.find(std::make_tuple(LHS, ConstRHS, inst->GetInstId())) != AEB_Const_RHS.end())
        //         {
        //             std::pair<size_t, Value*>& iter = AEB_Const_RHS[std::make_tuple(LHS, ConstRHS, inst->GetInstId())];
        //             inst->RAUW(iter.second);
        //             wait_del.push_back(inst);
        //             modified = true;
        //         }
        //         else
        //         {
        //             AEB_Const_RHS[std::make_tuple(LHS, ConstRHS, inst->GetInstId())] = std::make_pair(CurrGens, inst);
        //         }
        //     }
        //     else
        //     {
        //         if(AEB_Binary.find(std::make_tuple(LHS, RHS, inst->GetInstId())) != AEB_Binary.end())
        //         {
        //             std::pair<size_t, Value*>& iter = AEB_Binary[std::make_tuple(LHS, RHS, inst->GetInstId())];
        //             inst->RAUW(iter.second);
        //             wait_del.push_back(inst);
        //             modified = true;
        //         }
        //         else
        //         {
        //             AEB_Binary[std::make_tuple(LHS, RHS, inst->GetInstId())] = std::make_pair(CurrGens, inst);
        //         }
        //     }
        // }
        // Gep
        if(dynamic_cast<GetElementPtrInst*>(inst))
        {
            Value* Base = inst->GetOperand(0);
            size_t Offset = HashTool::InstHash{}(inst);
            if(Geps.find(std::make_tuple(Base, Offset, inst->GetInstId())) != Geps.end())
            {
                Value* val = Geps[std::make_tuple(Base, Offset, inst->GetInstId())];
                if(User* gep = dynamic_cast<User*>(val))
                {
                    if(DomTree->dominates(CurrentBlock, gep->GetParent()))
                    {
                        inst->RAUW(Geps[std::make_tuple(Base, Offset, inst->GetInstId())]);
                        wait_del.push_back(inst);
                        modified = true;
                    }
                }
            }
            else
            {
                Geps[std::make_tuple(Base, Offset, inst->GetInstId())] = inst;
            }
        }
        // // Load
        // if(dynamic_cast<LoadInst*>(inst))
        // {
        //     Value* Val = inst->GetOperand(0);
        //     if(Loads.find(std::make_pair(inst, inst->GetInstId())) != Loads.end())
        //     {
        //         inst->RAUW(Loads[std::make_pair(inst, inst->GetInstId())]);
        //         wait_del.push_back(inst);
        //         modified = true;
        //     }
        //     else
        //     {
        //         Loads[std::make_pair(inst, inst->GetInstId())] = Val;
        //     }
        // }
        // // Store
        // if(dynamic_cast<StoreInst*>(inst))
        // {
        //     Value* src = inst->GetOperand(0);
        //     Value* dst = inst->GetOperand(1);

        //     for(auto& iter : Loads)
        //     {
        //         if(iter.first.first == dst)
        //         {
        //             // Loads[std::make_pair(dst, User::OpID::Load)] = src;
        //             Loads.erase(std::make_pair(dst, User::OpID::Load));
        //         }
        //     }
        // }
        ++CurrGens;
    }
    while(!wait_del.empty())
    {
        User* inst = wait_del.back();
        wait_del.pop_back();
        delete inst;
    }
    return modified;
}