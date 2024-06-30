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
    _DEBUG(num = 0;)
    bool modified = false;
    // 这里采用deque而非vector的原因是在元素个数较多的时候deque的效率更高
    std::deque<ProcessNode*> WorkList;
    WorkList.push_back(new ProcessNode(&DomTree->GetNode(0)));
    BlockIn[DomTree->GetNode(0).thisBlock] = new info;
    BlockOut[DomTree->GetNode(0).thisBlock] = new info;
    while(!WorkList.empty())
    {
        ProcessNode* CurrNode = WorkList.back();
        if(CurrNode->node->thisBlock->GetName() == ".5")
            int b =1;
        if(Processed.find(CurrNode) == Processed.end())
        {
            modified |= RunOnNode(CurrNode, *BlockIn[CurrNode->node->thisBlock], *BlockOut[CurrNode->node->thisBlock]);
            Processed.insert(CurrNode);
        }
        else if(CurrNode->iter != CurrNode->end)
        {
            dominance::Node* Child = &DomTree->GetNode(CurrNode->nextChild());
            // if(Child->thisBlock->GetName() == ".5")
            //     int b =1;
            BlockIn[Child->thisBlock] = BlockOut[CurrNode->node->thisBlock];
            BlockOut[Child->thisBlock] = new info;
            WorkList.push_back(new ProcessNode(Child));
        }
        else
        {
            delete CurrNode;
            WorkList.pop_back();
        }
    }
    _DEBUG(std::cerr<<"Function: "<<func->GetName()<<" CSE: "<<num<<std::endl;)
    return modified;
}

bool CSE::RunOnNode(ProcessNode* node_, info& block_in, info& block_out)
{
    bool modified = false;
    BasicBlock* CurrentBlock = node_->node->thisBlock;
    if(CurrentBlock->GetName() == ".5")
        int b =1;
    // if(CurrentBlock->GetUserlist().GetSize() > 1)
    //     block_in = *(new info);
    // if(CurrentBlock->GetName() == ".5")
    // {
    //     auto test = DomTree->GetNode(node_->node->idom).thisBlock;
    //     int b =1;
    //     // auto test1 = DomTree->GetNode(node_->node->idom).idom_child;
    //     // for(auto& item : test1)
    //     // {
    //     //     auto test2 = DomTree->GetNode(item).thisBlock;
    //     // }
    // }
    for(User* inst : *CurrentBlock)
    {
        // if(dynamic_cast<CondInst*>(inst))
        // {
        //     if(auto boolean = dynamic_cast<ConstIRBoolean*>(inst->Getuselist()[0]->usee))
        //     {
        //         BasicBlock* TrueBlock = inst->Getuselist()[1]->usee->as<BasicBlock>();                
        //         BasicBlock* FalseBlock = inst->Getuselist()[2]->usee->as<BasicBlock>();                
        //         if(boolean->GetVal())
        //         {
        //             TrueBlock->reachable = true;
        //             FalseBlock->reachable = false;
        //         }
        //         else
        //         {
        //             TrueBlock->reachable = false;
        //             FalseBlock->reachable = true;
        //         }
        //     }
        //     else
        //     {
        //         BasicBlock* TrueBlock = inst->Getuselist()[1]->usee->as<BasicBlock>();                
        //         BasicBlock* FalseBlock = inst->Getuselist()[2]->usee->as<BasicBlock>();                
        //         TrueBlock->reachable = true;
        //         FalseBlock->reachable = true;
        //     }
        // }
        //Binary
        if(auto binary = dynamic_cast<BinaryInst*>(inst))
        {
            auto opcode = binary->getopration();
            auto LHS = dynamic_cast<ConstantData*>(binary->GetOperand(0));
            auto RHS = dynamic_cast<ConstantData*>(binary->GetOperand(1));
            if(LHS && RHS)
            {
                auto C = ConstantFolding::ConstFoldBinary(opcode, LHS, RHS);
                if(C)
                {
                inst->RAUW(C);
                wait_del.push_back(inst);
                modified = true;
                }
            }
            size_t hash = HashTool::BinaryInstHash{}(inst);
            for(auto& [key, val] : block_in.AEB_Binary)
            {
                if(key.second == User::OpID::Ge && inst->GetInstId() == User::OpID::L)
                {
                    if(HashTool::CmpSame{}(val, inst))
                    {
                        inst->RAUW(val);
                        wait_del.push_back(inst);
                        modified = true;
                    }
                    else
                        block_in.AEB_Binary[std::make_pair(hash, inst->GetInstId())] = inst;
                }
                if(key.second == User::OpID::L && inst->GetInstId() == User::OpID::Ge)
                {
                    if(HashTool::CmpSame{}(val, inst))
                    {
                        inst->RAUW(val);
                        wait_del.push_back(inst);
                        modified = true;
                    }
                    else
                        block_in.AEB_Binary[std::make_pair(hash, inst->GetInstId())] = inst;
                }
                if(key.second == User::OpID::G && inst->GetInstId() == User::OpID::Le)
                {
                    if(HashTool::CmpSame{}(val, inst))
                    {
                        inst->RAUW(val);
                        wait_del.push_back(inst);
                        modified = true;
                    }
                    else
                        block_in.AEB_Binary[std::make_pair(hash, inst->GetInstId())] = inst;
                }
                if(key.second == User::OpID::Le && inst->GetInstId() == User::OpID::G)
                {
                    if(HashTool::CmpSame{}(val, inst))
                    {
                        inst->RAUW(val);
                        wait_del.push_back(inst);
                        modified = true;
                    }
                    else
                        block_in.AEB_Binary[std::make_pair(hash, inst->GetInstId())] = inst;
                }
                if(block_in.AEB_Binary.find(std::make_pair(hash, inst->GetInstId())) != block_in.AEB_Binary.end())
                {
                        inst->RAUW(val);
                        wait_del.push_back(inst);
                        modified = true;
                }
                else
                    block_in.AEB_Binary[std::make_pair(hash, inst->GetInstId())] = inst;
            }
            continue;
        }

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
            continue;
        }

        // Load
        if(dynamic_cast<LoadInst*>(inst))
        {
            size_t Val = HashTool::InstHash{}(inst->Getuselist()[0]->usee);
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
                else if(dynamic_cast<ConstantData*>(val))
                {
                    inst->RAUW(block_in.Loads[Val]);
                    wait_del.push_back(inst);
                    modified = true;
                }
            }
            else
            {
                block_in.Loads[Val] = inst;
            }
            continue;
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
                else if(block_in.Loads.find(dst_hash) == block_in.Loads.end() && Dst->isGlobVal())
                {
                    block_in.Loads[dst_hash] = Src;
                }
            }
            // // Handle Src -> Gens
            // {

            // }

            continue;
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
        num++;
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