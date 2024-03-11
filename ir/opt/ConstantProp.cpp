#include "ConstantProp.hpp"
#include <set>
#include <queue>


void ConstantProp::CalDomBlocks(BasicBlock* block)
{
    if(visited.insert(block).second)
    {
        auto& node = _dom->GetNode(block->num);
        for(int child : node.des)
            CalDomBlocks(_dom->GetNode(child).thisBlock);
        DomBlocks.push_back(block);
    }
}

void ConstantProp::Pass()
{
    // BFSTraversal(0, _dom);
    for(BasicBlock* block : *_func)
        RunOnBlock(block);
    // for(BasicBlock* block : *_func)
    //     Test(block);
}
void ConstantProp::RunOnBlock(BasicBlock* block)
{
    BlockInfo blockinfo;
    std::vector<User*> wait_del;
    // if(!wait_del.empty())
    for(User* inst : *block)
    {
        Value* C = ConstFold->ConstantFoldInst(inst);
        if(C && !dynamic_cast<UndefValue*>(C))
        {
            inst->RAUW(C);
            if(!dynamic_cast<CallInst*>(inst))
                wait_del.push_back(inst);
        }
        else if(dynamic_cast<UndefValue*>(C))
            inst->RAUW(C);
        blockinfo.GetinstIndex(inst);
    }
    for(auto inst : wait_del)
    {
        inst->ClearRelation();
        inst->EraseFromParent();
    }
    // for(User* inst : *block)
    // {
    //     if(auto AI_ = dynamic_cast<AllocaInst*>(inst)) 
    //         HandleMemInst(blockinfo, AI_);
    // }
    // for(User* inst : *block)
    // {
    //             if(auto LOadInst = dynamic_cast<LoadInst*>(inst))
    //     {
    //         auto Val = GetDefVal(LOadInst->Getuselist()[0]->usee);
    //         if(Val)
    //         {
    //             inst->RAUW(Val);
    //             wait_del.push_back(inst);
    //         }
    //     }
    //     if(auto SToreInst = dynamic_cast<StoreInst*>(inst))
    //     {
    //         Value* v1 = SToreInst->Getuselist()[0]->usee;
    //         Value* v2 = SToreInst->Getuselist()[1]->usee;
    //         auto V1 = GetConstVal(v1);
    //         if(V1)
    //             SetDefVal(V1, v2);
    //         else
    //         {
    //             if(ArrayDefVal.find(v2) != ArrayDefVal.end())
    //                 ArrayDefVal.erase(ArrayDefVal.find(v2));
    //             else if(Global_Def.find(v2) != Global_Def.end())
    //                 Global_Def.erase(Global_Def.find(v2));
    //         }
    //     }
    //     if(auto Gep = dynamic_cast<GetElementPtrInst*>(inst))
    //     {
    //         // ConstFold->ConstantFoldGetElementPtrInst(Gep);
    //         // auto test = GetDefVal(Gep);
    //         // if(test);
            
    //     }

    //     // }
    // }
}
void ConstantProp::HandleMemInst(BlockInfo& Blockinfo, AllocaInst* AI)
{
    ValMap.clear();
    std::vector<std::pair<int, StoreInst*>> StoreInstWithIndex;

    for(Use* use : AI->GetUserlist())
    {
        // use->GetValue();
        User* user = use->GetUser();
        if(auto Gep = dynamic_cast<GetElementPtrInst*>(user))
        {
            std::string GepKey = Blockinfo.CalGepKey(Gep);
            for(Use* use_ : Gep->GetUserlist())
            {
                User* user = use_->GetUser();
                if(StoreInst* SI = dynamic_cast<StoreInst*>(user))
                {
                    StoreInstWithIndex.push_back(std::make_pair(Blockinfo.GetinstIndex(SI), SI));
                    std::pair<std::string, Value*> StoreVal = {GepKey, SI->Getuselist()[0]->usee};
                    ValMap.insert({Blockinfo.GetinstIndex(SI), StoreVal});
                }
            }
        }
        
            // TODO:将store的值放入map
    }
    std::sort(StoreInstWithIndex.begin(), StoreInstWithIndex.end(),
            [](const std::pair<int, StoreInst *> &T1,
               const std::pair<int, StoreInst *> &T2) -> bool {
            return T1.first < T2.first;
            }); //方便进行后续的二分搜索
    for(Use* use : AI->GetUserlist())
    {
        User* user_ = use->GetUser();
        if(auto Gep = dynamic_cast<GetElementPtrInst*>(user_))
        {
        std::string GepKey = Blockinfo.CalGepKey(Gep);
        for(Use* use_ : Gep->GetUserlist())
        {
            User* user = use_->GetUser();
        if(LoadInst* LI = dynamic_cast<LoadInst*>(user))
        {
            int loadindex = Blockinfo.GetinstIndex(LI);
            // auto it = std::lower_bound(
            // StoreInstWithIndex.begin(), StoreInstWithIndex.end(),
            // std::make_pair(loadindex, static_cast<StoreInst *>(nullptr)),
            // [](const std::pair<int, StoreInst *> &T1,
            // const std::pair<int, StoreInst *> &T2) -> bool {
            // return T1.first < T2.first;
            // }); 
            auto it = std::lower_bound(StoreInstWithIndex.begin(), StoreInstWithIndex.end(),std::make_pair(loadindex, static_cast<StoreInst *>(nullptr)),[](const std::pair<int, StoreInst *> &T1,const std::pair<int, StoreInst *> &T2) -> bool {return T1.first < T2.first;}); 
            if(it == StoreInstWithIndex.end())
            {
                LI->RAUW(UndefValue::get(LI->GetType()));
            }
            else
            {
                // if(it->first == loadindex)
                // {
                //     LI->RAUW(it->second->Getuselist()[0]->usee);
                // }
                // else
                // {
                //     if(it == StoreInstWithIndex.begin())
                //         LI->RAUW(UndefValue::get(LI->GetType()));
                //     else
                //     {
                //         it--;
                //         LI->RAUW(it->second->Getuselist()[0]->usee);
                //     }
                // }
                if(ValMap[Blockinfo.GetinstIndex(it->second)].first == GepKey)
                {
                    Value* C = ValMap[Blockinfo.GetinstIndex(it->second)].second;
                    LI->RAUW(C);
                }
                // Value* C = ValMap[Blockinfo.GetinstIndex(it->second)].second;
                // LI->RAUW(C);
                //从 store的map中提取it的值 换到load中
            }
        // LI->ClearRelation();
        // LI->EraseFromParent();
        // Blockinfo.DelIndex(LI); 
        }
        }
    }
    }
    for(Use* use : AI->GetUserlist())
    {
    User* user_ = use->GetUser();
        if(auto Gep = dynamic_cast<GetElementPtrInst*>(user_))
        {
        for(Use* use_ : Gep->GetUserlist())
        {
        User* user = use_->GetUser();
        StoreInst* st = dynamic_cast<StoreInst*>(user);
        // st->ClearRelation();
        // st->EraseFromParent();
        // Blockinfo.DelIndex(st);
        }
        }
    }
    // AI->ClearRelation();
    // AI->EraseFromParent();
    // Blockinfo.DelIndex(AI);

}
// void ConstantProp::RunOnBlock(BasicBlock* block)
// {
//     For_inst_In(block)
//     {
//         if(auto GEtElementPtrInst = dynamic_cast<GetElementPtrInst*>(inst))
//         {
//             Value* C = ConstFold->ConstantFoldGetElementPtrInst(GEtElementPtrInst);
//             if(C)
//                 {
//                     inst->RAUW(C);
//                     inst->ClearRelation();
//                     inst->EraseFromParent();
//                 }
//             continue;
//         }
//         if(dynamic_cast<StoreInst*>(inst))
//             continue;
//         Value* C = ConstFold->ConstantFoldInst(inst);
//         if(C)
//         {
//             inst->RAUW(C);
//             inst->ClearRelation();
//             inst->EraseFromParent();
//         }
//     }
//     For_inst_In(block)
//     {
//     Value* C = ConstFold->ConstantFoldInst(inst);
//         if(C)
//         {
//             inst->RAUW(C);
//             inst->ClearRelation();
//             inst->EraseFromParent();
//         }
//     }
// }
void ConstantProp::Test(BasicBlock* block) 
{
  // Initialize the worklist to all of the instructions ready to process...
    std::set<User*> WorkList;
    for(User* inst:*block)
        WorkList.insert(inst);

    while (!WorkList.empty()) {
    User* I = *WorkList.begin();
    WorkList.erase(WorkList.begin());    // Get an element from the worklist...

    if (!I->Getuselist().empty())                 // Don't muck with dead instructions...
      if (Value *C = ConstFold->ConstantFoldInst(I)) {
        // Add all of the users of this instruction to the worklist, they might
        // be constant propagatable now...
        for (auto *U : I->GetUserlist())
        {
            if(dynamic_cast<Function*>(U->GetUser()))
                continue;
            else if(dynamic_cast<BasicBlock*>(U->GetUser()))
                continue;
            else
                WorkList.insert(U->GetUser());
        }
        I->RAUW(C);
        // Remove the dead instruction.
        WorkList.erase(I);
        I->ClearRelation();
        I->EraseFromParent();

      }
  }
}
ConstantData* ConstantProp::GetDefVal(Value* val)
{
    if(auto Gep = dynamic_cast<GetElementPtrInst*>(val))
    {
        if(ArrayDefVal.find(Gep->Getuselist()[0]->usee) != ArrayDefVal.end())
        {
            auto iter1 = ArrayDefVal.find(Gep->Getuselist()[0]->usee);
            std::vector<std::string> index;
            for (int i = 1; i < Gep->Getuselist().size(); i++) 
            {
                auto op = Gep->Getuselist()[i]->GetValue();
                if(dynamic_cast<ConstantData*>(op))
                    index.push_back(op->GetName());
                else
                    return nullptr;
            }
            std::string idx_key;
            for (auto idx : index) 
            {
                idx_key += idx;
                idx_key += "#";
            }
            if(iter1->second.find(idx_key) != iter1->second.end())
            {
                auto iter2 = iter1->second.find(idx_key);
                return iter2->second;
            }
            else
                return nullptr;
        }
        return nullptr;
    }
    else if(!dynamic_cast<User*>(val))
    {
        if(Global_Def.find(val) != Global_Def.end())
        {
            auto iter = Global_Def.find(val);
            return iter->second;
        }
        else
            return nullptr;
    }
    return nullptr;
}
ConstantData* ConstantProp::GetConstVal(Value* Val)
{
    if(auto iNt = dynamic_cast<ConstIRInt*>(Val))
        return ConstIRInt::GetNewConstant(iNt->GetVal());
    else if(auto fLoat = dynamic_cast<ConstIRFloat*>(Val))
        return ConstIRFloat::GetNewConstant(fLoat->GetVal());
    else if(auto BOol = dynamic_cast<ConstIRBoolean*>(Val))
        return ConstIRBoolean::GetNewConstant(BOol->GetVal());
    else
        return nullptr;
}
ConstantData* ConstantProp::SetDefVal(ConstantData* v1, Value* v2)
{
    Value* global_val;
    if(!dynamic_cast<User*>(v2))
        global_val = v2;
    else
        global_val = nullptr;
    if(global_val != nullptr)
    {
        if(Global_Def.find(global_val) != Global_Def.end())
        {
            auto iter = Global_Def.find(global_val);
            iter->second = v1;
            return iter->second;
        }
        else
        {
            Global_Def.insert({v2, v1});
            return Global_Def.find(v2)->second;
        }
    }
    else if(auto Gep = dynamic_cast<GetElementPtrInst*>(v2))
    {
        std::vector<std::string> index;
        for (int i = 1; i < Gep->Getuselist().size(); i++) 
        {
            auto op = Gep->Getuselist()[i]->GetValue();
            if(dynamic_cast<ConstantData*>(op))
                index.push_back(op->GetName());
            else
                return nullptr;
        }

        std::string idx_key;
        for (auto idx : index) 
        {
            idx_key += idx;
            idx_key += "#";
        }
        if(ArrayDefVal.find(Gep->Getuselist()[0]->usee) != ArrayDefVal.end())
        {
            auto iter1 = ArrayDefVal.find(Gep->Getuselist()[0]->usee);
            if(iter1->second.find(idx_key) != iter1->second.end())
            {
                auto iter2 = iter1->second.find(idx_key);
                iter2->second = v1;
            }
            else
            {
                iter1->second.insert({idx_key, v1});
                return iter1->second.find(idx_key)->second;
            }
        }
        else
        {
            std::map<std::string, ConstantData*> idx_map;
            idx_map.insert({idx_key, v1});
            ArrayDefVal.insert({Gep->Getuselist()[0]->usee, idx_map});
            return idx_map.find(idx_key)->second;
        }
    }
    else
        return nullptr;
    return nullptr;
}

int ConstantProp::BlockInfo::GetinstIndex(User *Inst) {
  auto It = IndexInfo.find(Inst);
  if (It != IndexInfo.end())
    return It->second;

  //目前user查找到当前的bb
  int num = 0;
  BasicBlock *BB = Inst->GetParent();
  for (auto inst = BB->begin(); inst != BB->end(); ++inst) {
    if (dynamic_cast<LoadInst *>(*inst) &&
            dynamic_cast<AllocaInst *>((*inst)->Getuselist()[0]->usee) ||
        dynamic_cast<StoreInst *>(*inst) &&
            dynamic_cast<AllocaInst *>((*inst)->Getuselist()[1]->usee)) {
      IndexInfo[*inst] = num++;
    }
  }
  return IndexInfo[Inst];
}

void ConstantProp::BlockInfo::DelIndex(User *Inst) { IndexInfo.erase(Inst); }
std::string ConstantProp::BlockInfo::CalGepKey(GetElementPtrInst *Gep)
{
    std::vector<std::string> index;
    for (int i = 1; i < Gep->Getuselist().size(); i++) 
    {
        auto op = Gep->Getuselist()[i]->GetValue();
        if(dynamic_cast<ConstantData*>(op))
            index.push_back(op->GetName());
        else
            return nullptr;
    }
    std::string idx_key;
    for (auto idx : index) 
    {
        idx_key += idx;
        idx_key += "#";
    }
    return idx_key;
}