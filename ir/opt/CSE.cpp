#include "CSE.hpp"
#include "ConstantFold.hpp"

bool CSE::RunOnFunction()
{
    if(m_func->GetName() == "main")
        int b =1;
    bool modified = false;
    bool Changed = false;
    update();
    for(BasicBlock* block : *m_func)
    {
        Changed = RunPass(block);
        modified |= Changed;
        if(Changed)
        {
            while(!wait_del.empty())
            {
                User* inst = wait_del.back();
                wait_del.pop_back();
                delete inst;
            }
            update();
        }

        
    }

    return modified;
}

void CSE::update()
{
    wait_del.clear();
    BlockLiveIn.clear();
    BlockLiveOut.clear();
    for(BasicBlock *block : *m_func)
    {
        GetBlockLiveOut(block);
        GetBlockLiveIn(block);
    }
    iterate(m_func);
    while (IsChanged)
        iterate(m_func);
}

void CSE::iterate(Function* func)
{
    RunOnFunc(func);
    bool isChanged = false;
    for(BasicBlock* block : *func)
    {
        if(!Unchanged[block])
        {
            isChanged = true;
            break;
        }
    }
}

void CSE::RunOnFunc(Function* func)
{
    for(BasicBlock* block : *func)
    {
        info Old_BlockLiveOut = BlockLiveOut[block];
        info Old_BlockLiveIn = BlockLiveIn[block];
        GetBlockLiveIn(block);
        BlockLiveOut[block] = BlockLiveIn[block];
        GetBlockLiveOut(block);
        if(BlockLiveOut[block] == Old_BlockLiveOut)
            Unchanged[block] = true;
        else
            Unchanged[block] = false;
    }
}

void CSE::GetBlockLiveOut(BasicBlock* block)
{
    for(User* inst : *block)
    {
        //Binary
        if(auto binary = dynamic_cast<BinaryInst*>(inst))
        {
            size_t hash = HashTool::BinaryInstHash{}(inst);
            if(BlockLiveOut[block].AEB_Binary.find(std::make_pair(hash, inst->GetInstId())) == BlockLiveOut[block].AEB_Binary.end())
            {
                BlockLiveOut[block].AEB_Binary[std::make_pair(hash, inst->GetInstId())] = inst;
            }
            continue;
        }

        // Gep
        if(dynamic_cast<GetElementPtrInst*>(inst))
        {
            size_t hash = HashTool::InstHash{}(inst);
            if(BlockLiveOut[block].Geps.find(hash) == BlockLiveOut[block].Geps.end())
                BlockLiveOut[block].Geps[hash] = inst;
            continue;
        }

        // load
        if(dynamic_cast<LoadInst*>(inst))
        {
            size_t hash = HashTool::InstHash{}(inst);
            if(BlockLiveOut[block].Loads.find(hash) == BlockLiveOut[block].Loads.end())
                BlockLiveOut[block].Loads[hash] = inst;
            continue;
        }

        // Store
        if(dynamic_cast<StoreInst*>(inst))
        {
            Value* Src = inst->GetOperand(0);
            Value* Dst = inst->GetOperand(1);
            size_t src_hash = HashTool::InstHash{}(Src);
            size_t dst_hash = HashTool::InstHash{}(Dst);
            {
                if(BlockLiveOut[block].Geps.find(dst_hash) != BlockLiveOut[block].Geps.end())
                {
                    BlockLiveOut[block].Geps.erase(dst_hash);
                    auto gep = dynamic_cast<GetElementPtrInst*>(Dst);
                    for(auto& Use_ : gep->Getuselist())
                    {
                        if(LoadInst* load = dynamic_cast<LoadInst*>(Use_->usee))
                        {
                            size_t load_hash = HashTool::InstHash{}(load);
                            if(BlockLiveOut[block].Loads.find(load_hash) != BlockLiveOut[block].Loads.end())
                                BlockLiveOut[block].Loads.erase(load_hash);
                        }
                    }
                }

                if(BlockLiveOut[block].Loads.find(dst_hash) != BlockLiveOut[block].Loads.end() && !Dst->isGlobVal())
                    BlockLiveOut[block].Loads.erase(dst_hash);
                else if(BlockLiveOut[block].Loads.find(dst_hash) != BlockLiveOut[block].Loads.end() && Dst->isGlobVal())
                    BlockLiveOut[block].Loads[dst_hash] = Dst;
                else if(BlockLiveOut[block].Loads.find(dst_hash) == BlockLiveOut[block].Loads.end() && Dst->isGlobVal())
                    BlockLiveOut[block].Loads[dst_hash] = Src;
            }
            continue;
        }

        // Call
        if(CallInst* Call = dynamic_cast<CallInst*>(inst))
        {
            Value* f = Call->Getuselist()[0]->usee;
            std::string name = f->GetName();
            if(Function* func = dynamic_cast<Function*>(Call->Getuselist()[0]->usee))
            {
                BlockLiveOut[block].Funcs.insert(func);
                // for(auto& Use_ : Call->Getuselist())
                // {
                //     if(LoadInst* load = dynamic_cast<LoadInst*>(Use_->usee))
                //     {
                //         size_t load_hash = HashTool::InstHash{}(load);
                //         if(BlockLiveIn[block].Loads.find(load_hash) != BlockLiveIn[block].Loads.end())
                //         {
                //             BlockLiveIn[block].Loads.erase(load_hash);
                //         }
                //     }
                // }
                for(Value* val : func->Change_Val)
                {
                    if(BlockLiveOut[block].Loads.find(HashTool::InstHash{}(val)) != BlockLiveOut[block].Loads.end())
                    {
                        auto iter = BlockLiveOut[block].Loads.find(HashTool::InstHash{}(val));
                        BlockLiveOut[block].Loads.erase(iter);
                    }
                }
            }
            else if(name == "getarray" || name == "getfarray")
            {
                auto Use_ = Call->Getuselist()[1]->usee;
                if(BlockLiveIn[block].Loads.find(HashTool::InstHash{}(Use_)) != BlockLiveIn[block].Loads.end())
                {
                    auto iter = BlockLiveIn[block].Loads.find(HashTool::InstHash{}(Use_));
                    BlockLiveIn[block].Loads.erase(iter);
                }
                if(BlockLiveIn[block].Geps.find(HashTool::InstHash{}(Use_)) != BlockLiveIn[block].Geps.end())
                {
                    auto iter = BlockLiveIn[block].Geps.find(HashTool::InstHash{}(Use_));
                    BlockLiveIn[block].Geps.erase(iter);
                }
            }
            // else if(name == "getint" || name == "getch" || name == "getfloat")
            // {
            //     auto Use_ = Call->Getuselist()[1]->usee;
            //     if(BlockLiveIn[block].Loads.find(HashTool::InstHash{}(Use_)) != BlockLiveIn[block].Loads.end())
            //     {
            //         auto iter = BlockLiveIn[block].Loads.find(HashTool::InstHash{}(Use_));
            //         BlockLiveIn[block].Loads.erase(iter);
            //     }
            // }
        }
    }
}

void CSE::GetBlockLiveIn(BasicBlock* block)
{
    bool flag = true;
    for(auto User_ : block->GetUserlist())
    {
        BasicBlock* pred;
        User* inst = User_->GetUser();
        if(dynamic_cast<CondInst*>(inst))
            pred = inst->GetParent();
        else if(dynamic_cast<UnCondInst*>(inst))
            pred = inst->GetParent();
        else
            continue;
        if(flag)
        {
            BlockLiveIn[block].AEB_Binary = BlockLiveOut[pred].AEB_Binary;
            BlockLiveIn[block].Loads = BlockLiveOut[pred].Loads;
            BlockLiveIn[block].Geps = BlockLiveOut[pred].Geps;
            BlockLiveIn[block].Funcs = BlockLiveOut[pred].Funcs;
            flag = false;
        }
        else
        {
            std::map<std::pair<size_t, User::OpID>, Value*> intersection_AEB_Binary;
            std::map<size_t, Value*> intersection_Loads;
            std::map<size_t, Value*> intersection_Geps;
            std::set<Function*> intersection_Funcs;
            for(const auto& item : BlockLiveOut[pred].AEB_Binary)
            {
                if(BlockLiveIn[block].AEB_Binary.find(item.first) != BlockLiveIn[block].AEB_Binary.end())
                {
                    if(item.second == BlockLiveIn[block].AEB_Binary[item.first])
                        intersection_AEB_Binary[item.first] = item.second;
                }
            }
            for(const auto& item : BlockLiveOut[pred].Loads)
            {
                if(BlockLiveOut[block].Loads.find(item.first) != BlockLiveOut[block].Loads.end())
                {
                    if(item.second == BlockLiveOut[block].Loads[item.first])
                        intersection_Loads[item.first] = item.second;
                }
            }
            for(const auto& item : BlockLiveOut[pred].Geps)
            {
                if(BlockLiveOut[block].Geps.find(item.first) != BlockLiveOut[block].Geps.end())
                {
                    if(item.second == BlockLiveOut[block].Geps[item.first])
                        intersection_Geps[item.first] = item.second;
                }
            }
            for(const auto& item : BlockLiveOut[pred].Funcs)
            {
                if(BlockLiveOut[block].Funcs.find(item) == BlockLiveOut[block].Funcs.end())
                    intersection_Funcs.insert(item);
            }
            BlockLiveIn[block].AEB_Binary = intersection_AEB_Binary;
            BlockLiveIn[block].Loads = intersection_Loads;
            BlockLiveIn[block].Geps = intersection_Geps;
            BlockLiveIn[block].Funcs = intersection_Funcs;
        }
    }
}

bool CSE::RunPass(BasicBlock* block)
{
    // std::vector<User*> wait_del;
    bool modified = false;
    for(User* inst : *block)
    {
        //Binary
        if(auto binary = dynamic_cast<BinaryInst*>(inst))
        {
            // auto opcode = binary->getopration();
            // auto LHS = dynamic_cast<ConstantData*>(binary->GetOperand(0));
            // auto RHS = dynamic_cast<ConstantData*>(binary->GetOperand(1));
            // if(LHS && RHS)
            // {
            //     auto C = ConstantFolding::ConstFoldBinary(opcode, LHS, RHS);
            //     if(C)
            //     {
            //     inst->RAUW(C);
            //     wait_del.push_back(inst);
            //     modified = true;
            //     }
            // }
            size_t hash = HashTool::BinaryInstHash{}(inst);
            // if(inst->GetInstId() <= User::OpID::G && inst->GetInstId() >= User::OpID::Ge)
            // {
            //     if(!BlockLiveIn[block].AEB_Binary.empty())
            //     {
            //         for(auto& iter : BlockLiveIn[block].AEB_Binary)
            //         {
            //             if(iter.first.second == User::OpID::Ge && inst->GetInstId() == User::OpID::L)
            //             {
            //                 if(HashTool::CmpSame{}(iter.second, inst))
            //                 {
            //                     inst->RAUW(iter.second);
            //                     wait_del.push_back(inst);
            //                     modified = true;
            //                 }
            //                 else
            //                     BlockLiveIn[block].AEB_Binary[std::make_pair(hash, inst->GetInstId())] = inst;
            //                 break;
            //             }
            //             if(iter.first.second == User::OpID::L && inst->GetInstId() == User::OpID::Ge)
            //             {
            //                 if(HashTool::CmpSame{}(iter.second, inst))
            //                 {
            //                     inst->RAUW(iter.second);
            //                     wait_del.push_back(inst);
            //                     modified = true;
            //                 }
            //                 else
            //                     BlockLiveIn[block].AEB_Binary[std::make_pair(hash, inst->GetInstId())] = inst;
            //                 break;
            //             }
            //             if(iter.first.second == User::OpID::G && inst->GetInstId() == User::OpID::Le)
            //             {
            //                 if(HashTool::CmpSame{}(iter.second, inst))
            //                 {
            //                     inst->RAUW(iter.second);
            //                     wait_del.push_back(inst);
            //                     modified = true;
            //                 }
            //                 else
            //                     BlockLiveIn[block].AEB_Binary[std::make_pair(hash, inst->GetInstId())] = inst;
            //                 break;
            //             }
            //             if(iter.first.second == User::OpID::Le && inst->GetInstId() == User::OpID::G)
            //             {
            //                 if(HashTool::CmpSame{}(iter.second, inst))
            //                 {
            //                     inst->RAUW(iter.second);
            //                     wait_del.push_back(inst);
            //                     modified = true;
            //                 }
            //                 else
            //                     BlockLiveIn[block].AEB_Binary[std::make_pair(hash, inst->GetInstId())] = inst;
            //                 break;
            //             }
            //         }
            //     }
            //     else
            //         BlockLiveIn[block].AEB_Binary[std::make_pair(hash, inst->GetInstId())] = inst;
            // }
            // else
            {
                if(BlockLiveIn[block].AEB_Binary.find(std::make_pair(hash, inst->GetInstId())) != BlockLiveIn[block].AEB_Binary.end())
                {
                    inst->RAUW(BlockLiveIn[block].AEB_Binary[std::make_pair(hash, inst->GetInstId())]);
                    wait_del.push_back(inst);
                    modified = true;
                }
                else
                    BlockLiveIn[block].AEB_Binary[std::make_pair(hash, inst->GetInstId())] = inst;
            }
            continue;
        }

        // Gep
        if(dynamic_cast<GetElementPtrInst*>(inst))
        {
            size_t key = HashTool::InstHash{}(inst);
            if(BlockLiveIn[block].Geps.find(key) != BlockLiveIn[block].Geps.end())
            {
                Value* val = BlockLiveIn[block].Geps[key];
                if(User* gep = dynamic_cast<User*>(val))
                {
                        inst->RAUW(BlockLiveIn[block].Geps[key]);
                        wait_del.push_back(inst);
                        modified = true;
                }
            }
            else
            {
                BlockLiveIn[block].Geps[key] = inst;
            }
            continue;
        }

        // Load
        if(dynamic_cast<LoadInst*>(inst))
        {
            size_t Val = HashTool::InstHash{}(inst->Getuselist()[0]->usee);
            if(BlockLiveIn[block].Loads.find(Val) != BlockLiveIn[block].Loads.end())
            {
                Value* val = BlockLiveIn[block].Loads[Val];
                Function* change_func = Find_Change(inst->Getuselist()[0]->usee, BlockLiveIn[block]);
                if(auto load = dynamic_cast<User*>(val))
                {
                    // if(DomTree->dominates(load->GetParent(), block))
                    // {
                        if(!change_func)
                        {
                            inst->RAUW(load);
                            wait_del.push_back(inst);
                            modified = true;
                        }
                        else
                        {
                            BlockLiveIn[block].Funcs.erase(change_func);
                            BlockLiveIn[block].Loads[Val] = inst;
                        }
                    // }
                }
                else if(dynamic_cast<ConstantData*>(val))
                {
                    inst->RAUW(val);
                    wait_del.push_back(inst);
                    modified = true;
                }
            }
            else
            {
                BlockLiveIn[block].Loads[Val] = inst;
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
                if(BlockLiveIn[block].Geps.find(dst_hash) != BlockLiveIn[block].Geps.end())
                {
                    BlockLiveIn[block].Geps.erase(dst_hash);
                    auto gep = dynamic_cast<GetElementPtrInst*>(Dst);
                    for(auto& Use_ : gep->Getuselist())
                    {
                        if(LoadInst* load = dynamic_cast<LoadInst*>(Use_->usee))
                        {
                            size_t load_hash = HashTool::InstHash{}(load);
                            if(BlockLiveIn[block].Loads.find(load_hash) != BlockLiveIn[block].Loads.end())
                            {
                                BlockLiveIn[block].Loads.erase(load_hash);
                            }
                        }
                    }
                }

                if(BlockLiveIn[block].Loads.find(dst_hash) != BlockLiveIn[block].Loads.end() && !Dst->isGlobVal())
                {
                    BlockLiveIn[block].Loads.erase(dst_hash);
                }
                else if(BlockLiveIn[block].Loads.find(dst_hash) != BlockLiveIn[block].Loads.end() && Dst->isGlobVal())
                {
                    BlockLiveIn[block].Loads[dst_hash] = Src;
                }
                else if(BlockLiveIn[block].Loads.find(dst_hash) == BlockLiveIn[block].Loads.end() && Dst->isGlobVal())
                {
                    BlockLiveIn[block].Loads[dst_hash] = Src;
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
            Value* f = Call->Getuselist()[0]->usee;
            std::string name = f->GetName();
            if(Function* func = dynamic_cast<Function*>(Call->Getuselist()[0]->usee))
            {
                BlockLiveIn[block].Funcs.insert(func);
                // for(auto& Use_ : Call->Getuselist())
                // {
                //     if(LoadInst* load = dynamic_cast<LoadInst*>(Use_->usee))
                //     {
                //         size_t load_hash = HashTool::InstHash{}(load);
                //         if(BlockLiveIn[block].Loads.find(load_hash) != BlockLiveIn[block].Loads.end())
                //         {
                //             BlockLiveIn[block].Loads.erase(load_hash);
                //         }
                //     }
                // }
                for(Value* val : func->Change_Val)
                {
                    if(BlockLiveIn[block].Loads.find(HashTool::InstHash{}(val)) != BlockLiveIn[block].Loads.end())
                    {
                        auto iter = BlockLiveIn[block].Loads.find(HashTool::InstHash{}(val));
                        BlockLiveIn[block].Loads.erase(iter);
                    }
                }
            }
            else if(name == "getarray" || name == "getfarray")
            {
                auto Use_ = Call->Getuselist()[1]->usee;
                if(BlockLiveIn[block].Loads.find(HashTool::InstHash{}(Use_)) != BlockLiveIn[block].Loads.end())
                {
                    auto iter = BlockLiveIn[block].Loads.find(HashTool::InstHash{}(Use_));
                    BlockLiveIn[block].Loads.erase(iter);
                }
                if(BlockLiveIn[block].Geps.find(HashTool::InstHash{}(Use_)) != BlockLiveIn[block].Geps.end())
                {
                    auto iter = BlockLiveIn[block].Geps.find(HashTool::InstHash{}(Use_));
                    BlockLiveIn[block].Geps.erase(iter);
                }
            }
            // else if(name == "getint" || name == "getch" || name == "getfloat")
            // {
            //     auto Use_ = Call->Getuselist()[1]->usee;
            //     if(BlockLiveIn[block].Loads.find(HashTool::InstHash{}(Use_)) != BlockLiveIn[block].Loads.end())
            //     {
            //         auto iter = BlockLiveIn[block].Loads.find(HashTool::InstHash{}(Use_));
            //         BlockLiveIn[block].Loads.erase(iter);
            //     }
            // }

        }

    }

    return modified;
}

Function* CSE::Find_Change(Value* val, info Info)
{
    for(Function* item : Info.Funcs)
    {
        if(val->Change_Funcs.find(item) != val->Change_Funcs.end())
            return item;
    }
    return nullptr;
}