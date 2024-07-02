#include "DCE.hpp"
#include "my_stl.hpp"
#include <algorithm>
void DCE::PrintPass()
{
    std::cout << "--------DCE--------" << std::endl;
    Singleton<Module>().Test();
}

void DCE::RunOnFunction()
{
    CreateCallMap();
    DetectRecursive();
    CreateSideEffectFunc();
    bool flag = FuncHasSideEffect(func);
    // Value* C = RVACC(func);
    // if(dynamic_cast<UndefValue*>(C) && !flag)
    // {
    //     for(auto iter = func->rbegin(); iter != func->rend(); --iter)
    //     {
    //         bool NDelBlock = false;
    //         for(auto iter1 = (*iter)->rbegin(); iter1 != (*iter)->rend(); --iter1)
    //         {
    //             if(!dynamic_cast<RetInst*>(*iter1))
    //             {
    //                 (*iter1)->ClearRelation();
    //                 (*iter1)->EraseFromParent();
    //             }
    //             else
    //                 NDelBlock = true;
    //         }
    //         if(!NDelBlock)
    //         {
    //             auto remove_iter = std::find(func->GetBasicBlock().begin(), func->GetBasicBlock().end(), (*iter));
    //             func->GetBasicBlock().erase(remove_iter);
    //             (*iter)->EraseFromParent();
    //         }
    //     }
    //     return;
    // }
    // if(C && !flag)
    // {
    //     for(auto user : func->GetUserlist())
    //     {
    //         User* inst = user->GetUser();
    //         if(dynamic_cast<CallInst*>(inst))
    //         {
    //             inst->RAUW(C);
    //             _DEBUG(std::cerr<< "Delete Inst:" << inst->GetName() << "In Func:" << inst->GetParent()->GetParent()->GetName() <<std::endl;)
    //             delete inst;
    //         }
    //     }
    //     if(func->GetUserlist().is_empty())
    //     {
    //         // for(auto iter = func->rbegin(); iter != func->rend(); --iter)
    //         // {
    //         //     auto block = (*iter);
    //         //     delete block;
    //         // }
    //         func->clear();
    //         func->init_bbs();
    //         auto Block = new BasicBlock;
    //         auto ret = new RetInst(C);
    //         Block->push_back(ret);
    //         func->add_block(Block);
    //         func->GetBasicBlock().push_back(Block);
    //     }
    //     return;
    // }
    // std::vector<User*> WorkList;
    // for(BasicBlock* block : *func)
    // {
    //     for(auto inst = block->rbegin();inst != block->rend(); --inst)
    //     {
    //         if(std::find(WorkList.begin(), WorkList.end(), (*inst)) == WorkList.end())
    //             DCEInst((*inst), WorkList);
    //     }
    // }
    // while(!WorkList.empty())
    // {
    //     User* inst = WorkList.back();
    //     WorkList.pop_back();
    //     DCEInst(inst, WorkList);
    // }
}

void DCE::DCEInst(User* inst, std::vector<User*> &Worklist)
{
    if(isDeadInst(inst))
    {
        for(auto& use_ : inst->Getuselist())
        {
            Value* op = use_->usee;
            if(User* inst_ = dynamic_cast<User*>(op))
            {
                if(isDeadInst(inst_))
                    Worklist.push_back(inst_);
            }
        }
        inst->ClearRelation();
        inst->EraseFromParent();
    }
}

bool DCE::isDeadInst(User* inst)
{
    if(!inst->GetUserlist().is_empty() || inst->IsTerminateInst())
        return false;
    if(!inst->HasSideEffect())
        return true;
    return false;
}

Value* DCE::RVACC(Function* func)
{
    Value* RetVal = nullptr;
    for(BasicBlock* block : *func)
    {
        for(User* inst : *block)
        {
            if(auto PHiInst = dynamic_cast<PhiInst*>(inst))
            {
                Value* CommonValue = nullptr;
                for(Value* income : PHiInst->GetAllPhiVal())
                {
                    if(auto _UndefValue = dynamic_cast<UndefValue*>(income))
                        return nullptr;
                    if(CommonValue && income != CommonValue)
                        return nullptr;
                    CommonValue = income;
                }
                if(CommonValue)
                    inst->RAUW(CommonValue);
            }
        
            if(auto REtInst = dynamic_cast<RetInst*>(inst))
            {
                if(inst->Getuselist().size() == 0)
                    RetVal = nullptr;
                else
                {
                    Value* Val = inst->Getuselist()[0]->usee;
                    if(RetVal && RetVal != Val)
                        return nullptr;
                    RetVal = Val;
                }
            }

        }
    }
    if(RetVal && dynamic_cast<ConstantData*>(RetVal))
        return RetVal;
    return nullptr;
}

bool DCE::FuncHasSideEffect(Function* func)
{
    bool flag = false;
    if(Recursive_Funcs.count(func))
        flag = true;
    auto &Params = func->GetParams();
    for(auto &_param : Params)
    {
        if(_param->GetTypeEnum() == InnerDataType::IR_PTR)
        {
            for(Use* Use_ : _param->GetUserlist())
            {
                if(dynamic_cast<StoreInst*>(Use_->usee))
                {
                    _param->Change_Funcs.insert(func);
                    flag = true;
                }
            }
        }
    }
    for(BasicBlock* block : *func)
    {
        for(User* inst : *block)
        {
            if(dynamic_cast<CallInst*>(inst))
            {
                std::string name = inst->Getuselist()[0]->usee->GetName();
                if(name =="getint" || name == "getch" || name == "getfloat" \
                || name == "getfarray" || name == "putint" || name == "putfloat" \
                || name == "putarray" || name == "putfarray" || name == "putf" || name == "getarray" \
                || name == "putch" || name == "_sysy_starttime" || name == "_sysy_stoptime" \
                || name == "llvm.memcpy.p0.p0.i32")
                  flag = true;
                Function* Func = dynamic_cast<Function*>(inst->Getuselist()[0]->usee);
                if(Func && Singleton<Module>().Side_Effect_Funcs.count(Func))
                    flag = true;
            }
            if(dynamic_cast<StoreInst*>(inst))
            {
                if(inst->Getuselist()[1]->usee->isGlobVal())
                {
                    Value* val = inst->Getuselist()[1]->usee;
                    val->Change_Funcs.insert(func);
                    func->Change_Val.insert(val);
                    flag = true;
                }

                if(auto gep = dynamic_cast<GetElementPtrInst*>(inst->Getuselist()[1]->usee))
                {
                    if(gep->Getuselist()[0]->usee->isGlobVal())
                    {
                        Value* val = gep->Getuselist()[0]->usee;
                        val->Change_Funcs.insert(func);
                        flag = true;
                    }
                        // flag = true;
                }
            }
        }
    }
    return flag;
}

void DCE::DetectRecursive()
{
    std::set<Function*> visited;
    VisitFunc(func, visited);
}


void DCE::VisitFunc(Function* entry, std::set<Function*>& visited)
{
    visited.insert(entry);
    if(!entry->CallingFuncs.empty()){
    for(Function* Succ : entry->CallingFuncs)
    {
        if(visited.find(Succ) != visited.end())
            Recursive_Funcs.insert(Succ);
        else
            VisitFunc(Succ, visited);
    }}
    visited.erase(entry);
}

void DCE::CreateCallMap()
{
    for(Use* user_ : func->GetUserlist())
    {
        User* user = user_->GetUser();
        if(dynamic_cast<CallInst*>(user))
        {
            Function* CallFunc = user->GetParent()->GetParent();
            if(CallFunc)
                func->CalleeFuncs.insert(CallFunc);
        }
    }
    for(BasicBlock* block : *func)
    {
        for(User* inst : *block)
        {
            if(CallInst* call = dynamic_cast<CallInst*>(inst))
            {
                Function* Func = dynamic_cast<Function*>(call->Getuselist()[0]->usee);
                if(Func)
                    func->CallingFuncs.insert(Func);
            }
        }
    }
}

void DCE::CreateSideEffectFunc()
{
    for(auto& func_ : Singleton<Module>().GetFuncTion())
    {
        if(FuncHasSideEffect(func_.get()))
            Singleton<Module>().Side_Effect_Funcs.insert(func_.get());
    }
}