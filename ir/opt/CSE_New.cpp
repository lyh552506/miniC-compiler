#include "CSE_New.hpp"
#include "ConstantFold.hpp"

bool CSE::RunOnFunction()
{
    bool modified;
    for(BasicBlock *block : *m_func)
    {
        BlockLiveIn[block] = new info();
        BlockLiveOut[block] = new info();
        GetBlockLiveOut(block);
        GetBlockLiveIn(block);
    }
    iterate(m_func);
    while (IsChanged)
        iterate(m_func);
    for(BasicBlock* block : *m_func)
        modified = RunPass();
    return modified;
}

void CSE::GetBlockLiveOut(BasicBlock* block)
{
    for(User* inst : *block)
    {
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
                    delete inst;
                    continue;
                }
            }
            size_t hash = HashTool::BinaryInstHash{}(inst);
            for(auto& [key, val] : BlockLiveIn[block]->AEB_Binary)
            {
                if(key.second == User::OpID::Ge && inst->GetInstId() == User::OpID::L)
                {
                    if(HashTool::CmpSame{}(val, inst))
                    {
                        inst->RAUW(val);
                        delete inst;
                        break;
                    }
                    else
                        BlockLiveIn[block]->AEB_Binary[std::make_pair(hash, inst->GetInstId())] = inst;
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
    }
}