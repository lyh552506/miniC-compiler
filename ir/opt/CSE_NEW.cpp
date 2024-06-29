#include "CSE_New.hpp"
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
    std::deque<ProcessNode*> WorkList;
    // std::vector<dominance::Node*> DFS = DomTree->node;
    WorkList.push_back(new ProcessNode(&DomTree->GetNode(0)));
    _DEBUG(std::cerr<<WorkList.back()->node->thisBlock->num << " ";);    
    while(!WorkList.empty())
    {
        ProcessNode* CurrNode = WorkList.back();
        if(Processed.find(CurrNode) == Processed.end())
        {
            BlockIn[CurrNode->node->thisBlock] = new info;
            BlockOut[CurrNode->node->thisBlock] = new info;
            modified |= RunOnNode(CurrNode, *BlockIn[CurrNode->node->thisBlock], *BlockOut[CurrNode->node->thisBlock]);
            Processed.insert(CurrNode);
        }
        else if(CurrNode->iter != CurrNode->end)
        {
            WorkList.push_back(new ProcessNode(&DomTree->GetNode(CurrNode->nextChild())));   
            _DEBUG(std::cerr<<WorkList.back()->node->thisBlock->num << " ";);        
        }
            // WorkList.push_back(new ProcessNode(&DomTree->GetNode(CurrNode->nextChild())));
        else
        {
            delete CurrNode;
            WorkList.pop_back();
        }
    }
    
    // std::queue<dominance::Node*> DFS = DomTree->DFS_Dom();
    // while(!DFS.empty())
    // {
    //     _DEBUG(std::cerr<<DFS.front()->thisBlock->num << " ";);  
    //     DFS.pop();  
    // }
    // // 将DFS中元素压入WorkList中
    // while(!DFS.empty())
    // {
    //     WorkList.push_back(DFS.front());
    //     DFS.pop();
    // }
    // // WorkList.push_back(DFS.front());
    // // for (auto it = DFS.begin() + 1; it != DFS.end(); ++it)
    // //     WorkList.push_back(*it);
    // while(!WorkList.empty())
    // {
    //     dominance::Node* CurrNode = WorkList.front();
    //     if(!Processed.count(CurrNode))
    //     {
    //         BasicBlock* block = CurrNode->thisBlock;
    //         if(CurrNode->thisBlock->GetName() == ".275")
    //             int b  =1 ;
    //         if(CurrNode == &DomTree->GetNode(0))
    //         {
    //             BlockIn[CurrNode->thisBlock] = new info;
    //             BlockOut[CurrNode->thisBlock] = new info;
    //             modified |= RunOnNode(CurrNode, *BlockIn[CurrNode->thisBlock], *BlockOut[CurrNode->thisBlock]);
    //             Processed.insert(CurrNode);
    //         }
    //         // else
    //         // {
    //         //     BlockIn[CurrNode->thisBlock] = BlockOut[DomTree->GetNode(CurrNode->idom).thisBlock];
    //         //     BlockOut[CurrNode->thisBlock] = new info;
    //         //     modified |= RunOnNode(CurrNode, *BlockIn[CurrNode->thisBlock], *BlockOut[CurrNode->thisBlock]);
    //         //     Processed.insert(CurrNode);
    //         // }
    //         if(CurrNode->rev.begin() == CurrNode->rev.end() && !CurrNode->rev.empty())
    //         {
    //             BlockIn[block] = BlockOut[DomTree->GetNode(CurrNode->rev.front()).thisBlock];
    //             BlockOut[block] = new info;
    //             modified |= RunOnNode(CurrNode, *BlockIn[block], *BlockOut[block]);
    //             Processed_Blocks.insert(block);
    //         }
    //         else
    //         {
    //             std::vector<info*> args;
    //             for(int pred : CurrNode->rev)
    //             {
    //                 if(Processed_Blocks.find(DomTree->GetNode(pred).thisBlock) != Processed_Blocks.end())
    //                     args.push_back(BlockOut[DomTree->GetNode(pred).thisBlock]);
    //             }
    //             BlockIn[block] = new info;
    //             BlockOut[block] = new info;
    //             Process_Multiple_In(*BlockIn[block], args);
    //             modified |= RunOnNode(CurrNode, *BlockIn[block], *BlockOut[block]);
    //             Processed_Blocks.insert(block);
    //         }
    //         WorkList.pop_front();
    //     }
    // }
    return modified;
    //     bool modified = false;
    // for(BasicBlock* block : *func)
    // {
    //     if(block == func->front())
    //     {
    //         BlockIn[block] = new info;
    //         BlockOut[block] = new info;
    //         modified |= RunOnBlock(block, *BlockIn[block], *BlockOut[block]);
    //         Processed_Blocks.insert(block);
    //         continue;
    //     }
    //     if(DomTree->GetNode(block->num).rev.begin() == DomTree->GetNode(block->num).rev.end())
    //     {
    //         BlockIn[block] = BlockOut[DomTree->GetNode(DomTree->GetNode(block->num).rev.front()).thisBlock];
    //         BlockOut[block] = new info;
    //         modified |= RunOnBlock(block, *BlockIn[block], *BlockOut[block]);
    //         Processed_Blocks.insert(block);
    //     }
    //     else
    //     {
    //         std::vector<info*> args;
    //         for(int pred : DomTree->GetNode(block->num).rev)
    //         {
    //             if(Processed_Blocks.find(DomTree->GetNode(pred).thisBlock) != Processed_Blocks.end())
    //                 args.push_back(BlockOut[DomTree->GetNode(pred).thisBlock]);
    //         }
    //         BlockIn[block] = new info;
    //         BlockOut[block] = new info;
    //         Process_Multiple_In(*BlockIn[block], args);
    //         modified |= RunOnBlock(block, *BlockIn[block], *BlockOut[block]);
    //         Processed_Blocks.insert(block);
    //     }
    // }
    // return modified;
}
// bool CSE::RunOnFunc()
// {
//     bool modified = false;
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
//             BasicBlock* block = CurrNode->thisBlock;
//             if(CurrNode->thisBlock->GetName() == ".275")
//                 int b  =1 ;
//             if(CurrNode == &DomTree->GetNode(0))
//             {
//                 BlockIn[CurrNode->thisBlock] = new info;
//                 BlockOut[CurrNode->thisBlock] = new info;
//                 modified |= RunOnNode(CurrNode, *BlockIn[CurrNode->thisBlock], *BlockOut[CurrNode->thisBlock]);
//                 Processed.insert(CurrNode);
//             }
//             // else
//             // {
//             //     BlockIn[CurrNode->thisBlock] = BlockOut[DomTree->GetNode(CurrNode->idom).thisBlock];
//             //     BlockOut[CurrNode->thisBlock] = new info;
//             //     modified |= RunOnNode(CurrNode, *BlockIn[CurrNode->thisBlock], *BlockOut[CurrNode->thisBlock]);
//             //     Processed.insert(CurrNode);
//             // }
//             if(CurrNode->rev.begin() == CurrNode->rev.end() && !CurrNode->rev.empty())
//             {
//                 BlockIn[block] = BlockOut[DomTree->GetNode(CurrNode->rev.front()).thisBlock];
//                 BlockOut[block] = new info;
//                 modified |= RunOnNode(CurrNode, *BlockIn[block], *BlockOut[block]);
//                 Processed_Blocks.insert(block);
//             }
//             else
//             {
//                 std::vector<info*> args;
//                 for(int pred : CurrNode->rev)
//                 {
//                     if(Processed_Blocks.find(DomTree->GetNode(pred).thisBlock) != Processed_Blocks.end())
//                         args.push_back(BlockOut[DomTree->GetNode(pred).thisBlock]);
//                 }
//                 BlockIn[block] = new info;
//                 BlockOut[block] = new info;
//                 Process_Multiple_In(*BlockIn[block], args);
//                 modified |= RunOnNode(CurrNode, *BlockIn[block], *BlockOut[block]);
//                 Processed_Blocks.insert(block);
//             }
//             WorkList.pop_front();
//         }
//     }
//     return modified;
//     //     bool modified = false;
//     // for(BasicBlock* block : *func)
//     // {
//     //     if(block == func->front())
//     //     {
//     //         BlockIn[block] = new info;
//     //         BlockOut[block] = new info;
//     //         modified |= RunOnBlock(block, *BlockIn[block], *BlockOut[block]);
//     //         Processed_Blocks.insert(block);
//     //         continue;
//     //     }
//     //     if(DomTree->GetNode(block->num).rev.begin() == DomTree->GetNode(block->num).rev.end())
//     //     {
//     //         BlockIn[block] = BlockOut[DomTree->GetNode(DomTree->GetNode(block->num).rev.front()).thisBlock];
//     //         BlockOut[block] = new info;
//     //         modified |= RunOnBlock(block, *BlockIn[block], *BlockOut[block]);
//     //         Processed_Blocks.insert(block);
//     //     }
//     //     else
//     //     {
//     //         std::vector<info*> args;
//     //         for(int pred : DomTree->GetNode(block->num).rev)
//     //         {
//     //             if(Processed_Blocks.find(DomTree->GetNode(pred).thisBlock) != Processed_Blocks.end())
//     //                 args.push_back(BlockOut[DomTree->GetNode(pred).thisBlock]);
//     //         }
//     //         BlockIn[block] = new info;
//     //         BlockOut[block] = new info;
//     //         Process_Multiple_In(*BlockIn[block], args);
//     //         modified |= RunOnBlock(block, *BlockIn[block], *BlockOut[block]);
//     //         Processed_Blocks.insert(block);
//     //     }
//     // }
//     // return modified;
// }

bool CSE::RunOnNode(ProcessNode* node_, info& block_in, info& block_out)
{
    bool modified = false;
    BasicBlock* CurrentBlock = node_->node->thisBlock;
    for(User* inst : *CurrentBlock)
    {
        // //Binary
        // if(dynamic_cast<BinaryInst*>(inst))
        // {
        //     Value* LHS = inst->GetOperand(0);
        //     Value* RHS = inst->GetOperand(0);

        //     ConstantData* ConstLHS = dynamic_cast<ConstantData*>(LHS);
        //     ConstantData* ConstRHS = dynamic_cast<ConstantData*>(RHS);
        //     if(LHS)
        //     {
        //         if(AEB_Const_LHS.find(std::make_pair(ConstLHS, RHS)) != AEB_Const_LHS.end())
        //         {
        //             std::pair<size_t, Value*>& iter = AEB_Const_LHS[std::make_pair(ConstLHS, RHS)];
        //             inst->RAUW(iter.second);
        //             wait_del.push_back(inst);
        //             modified = true;
        //         }
        //         else
        //         {
        //             AEB_Const_LHS[std::make_pair(ConstLHS, RHS)] = std::make_pair(CurrGens, inst);
        //         }
        //     }
        //     else if(RHS)
        //     {
        //         if(AEB_Const_RHS.find(std::make_pair(LHS, ConstRHS)) != AEB_Const_RHS.end())
        //         {
        //             std::pair<size_t, Value*>& iter = AEB_Const_RHS[std::make_pair(LHS, ConstRHS)];
        //             inst->RAUW(iter.second);
        //             wait_del.push_back(inst);
        //             modified = true;
        //         }
        //         else
        //         {
        //             AEB_Const_RHS[std::make_pair(LHS, ConstRHS)] = std::make_pair(CurrGens, inst);
        //         }
        //     }
        //     else
        //     {
        //         if(AEB_Binary.find(std::make_pair(LHS, RHS)) != AEB_Binary.end())
        //         {
        //             std::pair<size_t, Value*>& iter = AEB_Binary[std::make_pair(LHS, RHS)];
        //             inst->RAUW(iter.second);
        //             wait_del.push_back(inst);
        //             modified = true;
        //         }
        //         else
        //         {
        //             AEB_Binary[std::make_pair(LHS, RHS)] = std::make_pair(CurrGens, inst);
        //         }
        //     }
        // }

        // Gep
        if(dynamic_cast<GetElementPtrInst*>(inst))
        {
            size_t key = HashTool::InstHash{}(inst);
            if(block_in.Geps.find(key) != block_in.Geps.end())
            {
                Value* val = block_in.Geps[key];
                if(User* gep = dynamic_cast<User*>(val))
                {
                    if(DomTree->dominates(gep->GetParent(), CurrentBlock))
                    {
                        inst->RAUW(block_in.Geps[key]);
                        wait_del.push_back(inst);
                        modified = true;
                    }
                }
            }
            else
            {
                block_in.Geps[key] = inst;
            }
        }

        // // Gep
        // if(dynamic_cast<GetElementPtrInst*>(inst))
        // {
        //     Value* Base = inst->GetOperand(0);
        //     size_t Offset = HashTool::InstHash{}(inst);
        //     if(block_in.Geps.find(std::make_pair(Base, Offset)) != block_in.Geps.end())
        //     {
        //         Value* val = block_in.Geps[std::make_pair(Base, Offset)];
        //         if(User* gep = dynamic_cast<User*>(val))
        //         {
        //             if(DomTree->dominates(gep->GetParent(), CurrentBlock))
        //             {
        //                 inst->RAUW(block_in.Geps[std::make_pair(Base, Offset)]);
        //                 wait_del.push_back(inst);
        //                 modified = true;
        //             }
        //         }
        //     }
        //     else
        //     {
        //         block_in.Geps[std::make_pair(Base, Offset)] = inst;
        //     }
        // }
        // Load
        if(dynamic_cast<LoadInst*>(inst))
        {
            if(inst->GetName() == ".216")
            int b = 1;
            size_t Val = HashTool::InstHash{}(inst);
            if(block_in.Loads.find(Val) != block_in.Loads.end())
            {
                Value* val = block_in.Loads[Val];
                Function* change_func = Find_Change(inst->Getuselist()[0]->usee, &block_in);
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

        // Store
        if(dynamic_cast<StoreInst*>(inst))
        {
            Value* Src = inst->GetOperand(0);
            Value* Dst = inst->GetOperand(1);
            size_t src_hash = HashTool::InstHash{}(Src);
            size_t dst_hash = HashTool::InstHash{}(Dst);

            //Handle Dst -> Kills
            {
                if(block_in.Geps.find(dst_hash) != block_in.Geps.end())
                {
                    block_in.Geps.erase(dst_hash);
                    auto gep = dynamic_cast<GetElementPtrInst*>(Dst);
                    for(auto& Use_ : gep->Getuselist())
                    {
                        if(LoadInst* load = dynamic_cast<LoadInst*>(Use_->usee))
                        {
                            size_t load_hash = HashTool::InstHash{}(load);
                            if(block_in.Loads.find(load_hash) != block_in.Loads.end())
                            {
                                block_in.Loads.erase(load_hash);
                            }
                        }
                    }
                }

                if(block_in.Loads.find(dst_hash) != block_in.Loads.end() && !Dst->isGlobVal())
                {
                    block_in.Loads.erase(dst_hash);
                }
                else if(block_in.Loads.find(dst_hash) != block_in.Loads.end() && Dst->isGlobVal())
                {
                    block_in.Loads[dst_hash] = Src;
                }
            }

            // // Handle Src -> Gens
            // {

            // }


        }

        // Call
        if(CallInst* Call = dynamic_cast<CallInst*>(inst))
        {
            if(Function* func = dynamic_cast<Function*>(Call->Getuselist()[0]->usee))
            {
                block_in.Funcs.insert(func);
                // for(auto& Use_ : Call->Getuselist())
                // {
                //     if(LoadInst* load = dynamic_cast<LoadInst*>(Use_->usee))
                //     {
                //         size_t load_hash = HashTool::InstHash{}(load);
                //         if(block_in.Loads.find(load_hash) != block_in.Loads.end())
                //         {
                //             block_in.Loads.erase(load_hash);
                //         }
                //     }
                // }
            }

        }

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
        // if(CallInst* call = dynamic_cast<CallInst*>(User_))
        // {
        //     auto& args = call->Getuselist();
        //     auto iter = std::find_if(args.begin(), args.end(),
        //     [inst](const User::UsePtr& usePtr){ return usePtr->usee == inst; });
        //     Function* func = dynamic_cast<Function*>(call->Getuselist()[0]->usee);
        //     if(iter != args.end() && func)
        //     {
        //         int index = std::distance(args.begin(), iter);
        //         Value* param = func->GetParams()[index - 1].get();
        //         for(Use* use : param->GetUserlist())
        //         {
        //             if(dynamic_cast<StoreInst*>(use->GetUser()))
        //                 return true;
        //         }
        //     }
        // }
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


// bool CSE::RunOnFunc()
// {
//     // bool modified = false;
//     // for(BasicBlock* block : *func)
//     // {
//     //     if(block == func->front())
//     //     {
//     //         BlockIn[block] = new info;
//     //         BlockOut[block] = new info;
//     //         modified |= RunOnBlock(block, *BlockIn[block], *BlockOut[block]);
//     //         Processed_Blocks.insert(block);
//     //         continue;
//     //     }
//     //     if(DomTree->GetNode(block->num).rev.begin() == DomTree->GetNode(block->num).rev.end())
//     //     {
//     //         BlockIn[block] = BlockOut[DomTree->GetNode(DomTree->GetNode(block->num).rev.front()).thisBlock];
//     //         BlockOut[block] = new info;
//     //         modified |= RunOnBlock(block, *BlockIn[block], *BlockOut[block]);
//     //         Processed_Blocks.insert(block);
//     //     }
//     //     else
//     //     {
//     //         std::vector<info*> args;
//     //         for(int pred : DomTree->GetNode(block->num).rev)
//     //         {
//     //             if(Processed_Blocks.find(DomTree->GetNode(pred).thisBlock) != Processed_Blocks.end())
//     //                 args.push_back(BlockOut[DomTree->GetNode(pred).thisBlock]);
//     //         }
//     //         BlockIn[block] = new info;
//     //         BlockOut[block] = new info;
//     //         Process_Multiple_In(*BlockIn[block], args);
//     //         modified |= RunOnBlock(block, *BlockIn[block], *BlockOut[block]);
//     //         Processed_Blocks.insert(block);
//     //     }
//     // }
//     // return modified;
//     // // 这里采用deque而非vector的原因是在元素个数较多的时候deque的效率更高
//     // std::deque<dominance::Node*> WorkList;
//     // // std::vector<dominance::Node*> DFS = DomTree->node;
//     // std::queue<dominance::Node*> DFS = DomTree->DFS_Dom();
//     // // 将DFS中元素压入WorkList中
//     // while(!DFS.empty())
//     // {
//     //     WorkList.push_back(DFS.front());
//     //     DFS.pop();
//     // }
//     // // WorkList.push_back(DFS.front());
//     // // for (auto it = DFS.begin() + 1; it != DFS.end(); ++it)
//     // //     WorkList.push_back(*it);
//     // while(!WorkList.empty())
//     // {
//     //     dominance::Node* CurrNode = WorkList.front();
//     //     if(!Processed.count(CurrNode))
//     //     {
//     //         if(CurrNode->thisBlock->GetName() == ".275")
//     //             int b  =1 ;
//     //         if(CurrNode == &DomTree->GetNode(0))
//     //         {
//     //             BlockIn[CurrNode->thisBlock] = new info;
//     //             BlockOut[CurrNode->thisBlock] = new info;
//     //             modified |= RunOnNode(CurrNode, *BlockIn[CurrNode->thisBlock], *BlockOut[CurrNode->thisBlock]);
//     //             Processed.insert(CurrNode);
//     //         }
//     //         else
//     //         {
//     //             BlockIn[CurrNode->thisBlock] = BlockOut[DomTree->GetNode(CurrNode->idom).thisBlock];
//     //             BlockOut[CurrNode->thisBlock] = new info;
//     //             modified |= RunOnNode(CurrNode, *BlockIn[CurrNode->thisBlock], *BlockOut[CurrNode->thisBlock]);
//     //             Processed.insert(CurrNode);
//     //         }
//     //         WorkList.pop_front();
//     //     }
//     // }
//     // return modified;
// }

// bool CSE::RunOnBlock(BasicBlock* CurrentBlock, info& block_in, info& block_out)
// {
    
//     bool modified = false;
//     for(User* inst : *CurrentBlock)
//     {
//         // // Binary
//         // if(dynamic_cast<BinaryInst*>(inst))
//         // {
//         //     Value* LHS = inst->GetOperand(0);
//         //     Value* RHS = inst->GetOperand(0);

//         //     ConstantData* ConstLHS = dynamic_cast<ConstantData*>(LHS);
//         //     ConstantData* ConstRHS = dynamic_cast<ConstantData*>(RHS);
//         //     if(LHS)
//         //     {
//         //         if(AEB_Const_LHS.find(std::make_pair(ConstLHS, RHS)) != AEB_Const_LHS.end())
//         //         {
//         //             std::pair<size_t, Value*>& iter = AEB_Const_LHS[std::make_pair(ConstLHS, RHS)];
//         //             inst->RAUW(iter.second);
//         //             wait_del.push_back(inst);
//         //             modified = true;
//         //         }
//         //         else
//         //         {
//         //             AEB_Const_LHS[std::make_pair(ConstLHS, RHS)] = std::make_pair(CurrGens, inst);
//         //         }
//         //     }
//         //     else if(RHS)
//         //     {
//         //         if(AEB_Const_RHS.find(std::make_pair(LHS, ConstRHS)) != AEB_Const_RHS.end())
//         //         {
//         //             std::pair<size_t, Value*>& iter = AEB_Const_RHS[std::make_pair(LHS, ConstRHS)];
//         //             inst->RAUW(iter.second);
//         //             wait_del.push_back(inst);
//         //             modified = true;
//         //         }
//         //         else
//         //         {
//         //             AEB_Const_RHS[std::make_pair(LHS, ConstRHS)] = std::make_pair(CurrGens, inst);
//         //         }
//         //     }
//         //     else
//         //     {
//         //         if(AEB_Binary.find(std::make_pair(LHS, RHS)) != AEB_Binary.end())
//         //         {
//         //             std::pair<size_t, Value*>& iter = AEB_Binary[std::make_pair(LHS, RHS)];
//         //             inst->RAUW(iter.second);
//         //             wait_del.push_back(inst);
//         //             modified = true;
//         //         }
//         //         else
//         //         {
//         //             AEB_Binary[std::make_pair(LHS, RHS)] = std::make_pair(CurrGens, inst);
//         //         }
//         //     }
//         // }

//         // Gep
//         if(dynamic_cast<GetElementPtrInst*>(inst))
//         {
//             Value* Base = inst->GetOperand(0);
//             size_t Offset = HashTool::InstHash{}(inst);
//             if(block_in.Geps.find(std::make_pair(Base, Offset)) != block_in.Geps.end() && !Is_Gep_Changed(inst, CurrentBlock))
//             {
//                 Value* val = block_in.Geps[std::make_pair(Base, Offset)];
//                 if(User* gep = dynamic_cast<User*>(val))
//                 {
//                     if(DomTree->dominates(gep->GetParent(), CurrentBlock))
//                     {
//                         inst->RAUW(block_in.Geps[std::make_pair(Base, Offset)]);
//                         if(inst->GetName() == ".194")
//                             int b =1;
//                         wait_del.push_back(inst);
//                         modified = true;
//                     }
//                 }
//             }
//             else
//             {
//                 block_in.Geps[std::make_pair(Base, Offset)] = inst;
//             }
//         }

//         // // Gep
//         // if(dynamic_cast<GetElementPtrInst*>(inst))
//         // {
//         //     Value* Base = inst->GetOperand(0);
//         //     size_t Offset = HashTool::InstHash{}(inst);
//         //     if(block_in.Geps.find(std::make_pair(Base, Offset)) != block_in.Geps.end())
//         //     {
//         //         Value* val = block_in.Geps[std::make_pair(Base, Offset)];
//         //         if(User* gep = dynamic_cast<User*>(val))
//         //         {
//         //             if(DomTree->dominates(gep->GetParent(), CurrentBlock))
//         //             {
//         //                 inst->RAUW(block_in.Geps[std::make_pair(Base, Offset)]);
//         //                 wait_del.push_back(inst);
//         //                 modified = true;
//         //             }
//         //         }
//         //     }
//         //     else
//         //     {
//         //         block_in.Geps[std::make_pair(Base, Offset)] = inst;
//         //     }
//         // }
//         // Load
//         if(dynamic_cast<LoadInst*>(inst))
//         {
//             Value* Val = inst->GetOperand(0);
//             if(block_in.Loads.find(Val) != block_in.Loads.end())
//             {
//                 Value* val = block_in.Loads[Val];
//                 Function* change_func = Find_Change(Val, &block_in);
//                 if(User* load = dynamic_cast<User*>(val))
//                 {
//                     if(DomTree->dominates(load->GetParent(), CurrentBlock))  // TODO: LLVM的处理是如果load跨了3个块，就重新load
//                     {
//                         if(!change_func)
//                         {
//                             if(inst->GetName() == ".192")
//                                 int b =3 ;
//                             inst->RAUW(block_in.Loads[Val]);
//                             wait_del.push_back(inst);
//                             modified = true;
//                         }
//                         else
//                         {
//                             block_in.Funcs.erase(change_func);
//                             block_in.Loads[Val] = inst;
//                         }
//                     }
//                 }
//             }
//             else
//             {
//                 block_in.Loads[Val] = inst;
//             }
//         }

//         // Store
//         if(dynamic_cast<StoreInst*>(inst))
//         {
//             Value* src = inst->GetOperand(0);
//             Value* dst = inst->GetOperand(1);
//             if(block_in.Loads.find(dst) != block_in.Loads.end())
//             {
//                 block_in.Loads.erase(dst);
//             }
//         }

//         // Call
//         if(CallInst* Call = dynamic_cast<CallInst*>(inst))
//                 if(Function* func = dynamic_cast<Function*>(Call->Getuselist()[0]->usee))
//                     block_in.Funcs.insert(func);
//     }
//     block_out = block_in;
//     while(!wait_del.empty())
//     {
//         User* inst = wait_del.back();
//         wait_del.pop_back();
//         delete inst;
//     }
//     return modified;
// }


void CSE::Process_Multiple_In(info& block_in, std::vector<info*> args)
{
    for(info* arg : args)
    {
        // if(arg == args[0])
        //     continue;
        for(auto&[key, val] : arg->AEB_Binary)
        {
            if(block_in.AEB_Binary.find(key) != block_in.AEB_Binary.end())
                block_in.AEB_Binary.erase(key);
            else
                block_in.AEB_Binary.insert(std::make_pair(key, val));
        }
        for(auto&[key, val] : arg->Loads)
        {
            if(block_in.Loads.find(key) != block_in.Loads.end())
                block_in.Loads.erase(key);
            else
                block_in.Loads.insert(std::make_pair(key, val));
        }
        for(auto&[key, val] : arg->Geps)
        {
            if(block_in.Geps.find(key) != block_in.Geps.end())
                block_in.Geps.erase(key);
            else
                block_in.Geps.insert(std::make_pair(key, val));
        }
        for(Function* F : arg->Funcs)
        {
            if(block_in.Funcs.find(F) != block_in.Funcs.end())
                block_in.Funcs.erase(F);
            else
                block_in.Funcs.insert(F);
        }
    }
}