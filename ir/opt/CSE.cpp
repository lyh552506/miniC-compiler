#include "CSE.hpp"
#include "HashScope.hpp"
#include "DCE.hpp"
#include "ConstantFold.hpp"

void CSE::Init()
{
    BlockOut.clear();
    BlockIn.clear();
}

bool CSE::RunOnFunc()
{
    bool modified = false;
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
            if(CurrNode == &DomTree->GetNode(0))
            {
                BlockIn[CurrNode->thisBlock] = new info;
                BlockOut[CurrNode->thisBlock] = new info;
                modified |= RunOnNode(CurrNode, *BlockIn[CurrNode->thisBlock], *BlockOut[CurrNode->thisBlock]);
                Processed.insert(CurrNode);
            }
            else
            {
                BlockIn[CurrNode->thisBlock] = BlockOut[DomTree->GetNode(CurrNode->idom).thisBlock];
                BlockOut[CurrNode->thisBlock] = new info;
                modified |= RunOnNode(CurrNode, *BlockIn[CurrNode->thisBlock], *BlockOut[CurrNode->thisBlock]);
                Processed.insert(CurrNode);
            }
            WorkList.pop_front();
        }
    }
    return modified;
}

bool CSE::RunOnNode(dominance::Node* node, info& block_in, info& block_out)
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
            if(block_in.Geps.find(std::make_tuple(Base, Offset, inst->GetInstId())) != block_in.Geps.end() && !Is_Gep_Changed(inst, CurrentBlock))
            {
                Value* val = block_in.Geps[std::make_tuple(Base, Offset, inst->GetInstId())];
                if(User* gep = dynamic_cast<User*>(val))
                {
                    if(DomTree->dominates(gep->GetParent(), CurrentBlock))
                    {
                        inst->RAUW(block_in.Geps[std::make_tuple(Base, Offset, inst->GetInstId())]);
                        wait_del.push_back(inst);
                        modified = true;
                    }
                }
            }
            else
            {
                block_in.Geps[std::make_tuple(Base, Offset, inst->GetInstId())] = inst;
            }
        }

        // // Gep
        // if(dynamic_cast<GetElementPtrInst*>(inst))
        // {
        //     Value* Base = inst->GetOperand(0);
        //     size_t Offset = HashTool::InstHash{}(inst);
        //     if(block_in.Geps.find(std::make_tuple(Base, Offset, inst->GetInstId())) != block_in.Geps.end())
        //     {
        //         Value* val = block_in.Geps[std::make_tuple(Base, Offset, inst->GetInstId())];
        //         if(User* gep = dynamic_cast<User*>(val))
        //         {
        //             if(DomTree->dominates(gep->GetParent(), CurrentBlock))
        //             {
        //                 inst->RAUW(block_in.Geps[std::make_tuple(Base, Offset, inst->GetInstId())]);
        //                 wait_del.push_back(inst);
        //                 modified = true;
        //             }
        //         }
        //     }
        //     else
        //     {
        //         block_in.Geps[std::make_tuple(Base, Offset, inst->GetInstId())] = inst;
        //     }
        // }
        // Load
        if(dynamic_cast<LoadInst*>(inst))
        {
            Value* Val = inst->GetOperand(0);
            if(block_in.Loads.find(Val) != block_in.Loads.end())
            {
                Value* val = block_in.Loads[Val];
                Function* change_func = Find_Change(Val, &block_in);
                if(User* load = dynamic_cast<User*>(val))
                {
                    if(DomTree->dominates(load->GetParent(), CurrentBlock))
                    {
                        if(!change_func)
                        {
                            inst->RAUW(block_in.Loads[Val]);
                            wait_del.push_back(inst);
                            modified = true;
                        }
                        else
                        {
                            block_in.Funcs.erase(change_func);
                            block_in.Loads[Val] = inst;
                        }
                    }
                }
            }
            else
            {
                block_in.Loads[Val] = inst;
            }
        }

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

        // Call
        if(CallInst* Call = dynamic_cast<CallInst*>(inst))
                if(Function* func = dynamic_cast<Function*>(Call->Getuselist()[0]->usee))
                    block_in.Funcs.insert(func);
    }
    block_out = block_in;
    while(!wait_del.empty())
    {
        User* inst = wait_del.back();
        wait_del.pop_back();
        delete inst;
    }
    return modified;
}

Function* CSE::Find_Change(Value* val, info* Info)
{
    for(Function* item : Info->Funcs)
    {
        if(val->Change_Funcs.find(item) != val->Change_Funcs.end())
            return item;
    }
    return nullptr;
}

bool CSE::Is_Gep_Changed(User* inst, BasicBlock* Curr_Block)
{
    for(Use* Use_ : inst->GetUserlist())
    {
        User* User_ = Use_->GetUser();
        if(LoadInst* load = dynamic_cast<LoadInst*>(User_))
        {
            for(Use* Use_1 : User_->GetUserlist())
            {
                if(CallInst* call = dynamic_cast<CallInst*>(Use_1->GetUser()))
                {
                    auto& args = call->Getuselist();
                    auto iter = std::find_if(args.begin(), args.end(),
                    [load](const User::UsePtr& usePtr){ return usePtr->usee == load; });
                    Function* func = dynamic_cast<Function*>(call->Getuselist()[0]->usee);
                    if(iter != args.end() && func)
                    {
                        int index = std::distance(args.begin(), iter);
                        Value* param = func->GetParams()[index - 1].get();
                        for(Use* use : param->GetUserlist())
                        {
                            if(dynamic_cast<StoreInst*>(use->GetUser()))
                                return true;
                        }
                    }
                }
            }
        }
        if(dynamic_cast<StoreInst*>(User_) && (User_->GetParent() == Curr_Block))
            return true;
    }
}
// auto &args = item->Getuselist();
//             auto iter = std::find_if(args.begin(), args.end(), 
//             [val](const User::UsePtr& usePtr){ return usePtr->usee == val; });
//             int index = 0;
//             if(iter != args.end())
//             {
//                 index = std::distance(args.begin(), iter);
//                 Value* param = Call_Func->GetParams()[index - 1].get();
//                 if(param->Change_Funcs.find(Call_Func) != param->Change_Funcs.end())
//                     return item;
//             } 