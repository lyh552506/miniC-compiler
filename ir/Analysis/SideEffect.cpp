#include "../../include/ir/Analysis/SideEffect.hpp"
#include "../../include/lib/CFG.hpp"

bool SideEffect::RunOnModule(Module *module)
{
    for (auto &Func_Ptr : module->GetFuncTion())
    {
        Func_Ptr->Change_Val.clear();
        CreateCallMap(Func_Ptr.get());
    }
    DetectRecursive();
    CreateSideEffectFunc();
    return false;
}

void SideEffect::CreateCallMap(Function *func)
{
    for (Use *user_ : func->GetUserlist())
    {
        User *user = user_->GetUser();
        if (dynamic_cast<CallInst *>(user))
        {
            Function *CallFunc = user->GetParent()->GetParent();
            if (CallFunc)
                CalleeFuncs[func].insert(CallFunc);
        }
    }
    for (BasicBlock *block : *func)
    {
        for (User *inst : *block)
        {
            if (CallInst *call = dynamic_cast<CallInst *>(inst))
            {
                Function *Func = dynamic_cast<Function *>(call->Getuselist()[0]->usee);
                if (Func)
                    CallingFuncs[func].insert(Func);
            }
        }
    }
}

void SideEffect::DetectRecursive()
{
    std::set<Function *> visited;
    for (auto &Func_Ptr : module->GetFuncTion())
        VisitFunc(Func_Ptr.get(), visited);
}

void SideEffect::VisitFunc(Function *entry, std::set<Function *> &visited)
{
    visited.insert(entry);
    if (!CallingFuncs[entry].empty())
    {
        for (Function *Succ : CallingFuncs[entry])
        {
            if (visited.find(Succ) != visited.end())
                RecursiveFuncs.insert(Succ);
            else
                VisitFunc(Succ, visited);
        }
    }
    visited.erase(entry);
}

void SideEffect::CreateSideEffectFunc()
{
    for (auto &func_ : module->GetFuncTion())
    {
        auto &Params = func_->GetParams();
        for (auto &_param : Params)
        {
            if (_param->GetTypeEnum() == InnerDataType::IR_PTR)
            {
                for (Use *Use_ : _param->GetUserlist())
                {
                    if (dynamic_cast<StoreInst *>(Use_->GetUser()))
                        func_->Change_Val.insert(_param.get());

                    for (Use *Use__ : Use_->GetUser()->GetUserlist())
                    {
                        if (dynamic_cast<StoreInst *>(Use__->GetUser()))
                            func_->Change_Val.insert(_param.get());
                    }
                }
            }
        }
    }
    if (!Judge)
        for (auto &func_ : module->GetFuncTion())
        {
            func_->HasSideEffect = false;
        }
    for (auto &func_ : module->GetFuncTion())
    {
        if (FuncHasSideEffect(func_.get()))
            func_->HasSideEffect = true;
    }
}

bool SideEffect::FuncHasSideEffect(Function *func)
{
    bool flag = false;
    if (Judge && RecursiveFuncs.count(func))
        flag = true;
    if (func->tag == Function::ParallelBody || func->tag == Function::UnrollBody)
        flag = true;
    auto &Params = func->GetParams();
    for (auto &_param : Params)
    {
        if (_param->GetTypeEnum() == InnerDataType::IR_PTR)
        {
            for (Use *Use_ : _param->GetUserlist())
            {
                if (dynamic_cast<StoreInst *>(Use_->GetUser()))
                {
                    flag = true;
                    func->Change_Val.insert(_param.get());
                }

                for (Use *Use__ : Use_->GetUser()->GetUserlist())
                {
                    if (dynamic_cast<StoreInst *>(Use__->GetUser()))
                    {
                        flag = true;
                        func->Change_Val.insert(_param.get());
                    }
                }
            }
        }
    }
    for (BasicBlock *block : *func)
    {
        for (User *inst : *block)
        {
            if (dynamic_cast<CallInst *>(inst))
            {
                std::string name = inst->Getuselist()[0]->usee->GetName();
                if (name == "getint" || name == "getch" || name == "getfloat" || name == "getfarray" ||
                    name == "putint" || name == "putfloat" || name == "putarray" || name == "putfarray" ||
                    name == "putf" || name == "getarray" || name == "putch" || name == "_sysy_starttime" ||
                    name == "_sysy_stoptime" || name == "llvm.memcpy.p0.p0.i32")
                    flag = true;
                Function *Func = dynamic_cast<Function *>(inst->Getuselist()[0]->usee);
                if (Func && Func->HasSideEffect)
                    flag = true;
                if (Func)
                {
                    for (int i = 1; i < inst->Getuselist().size(); i++)
                    {
                        Value *param = Func->GetParams()[i - 1].get();
                        if (param && Func->Change_Val.count(param))
                        {
                            flag = true;
                            func->Change_Val.insert(inst->GetOperand(i));
                        }
                    }
                }
            }
            else if (dynamic_cast<StoreInst *>(inst))
            {
                if (inst->Getuselist()[1]->usee->isGlobal())
                {
                    flag = true;
                    func->Change_Val.insert(inst->Getuselist()[1]->usee);
                }
                if (auto gep = dynamic_cast<GetElementPtrInst *>(inst->Getuselist()[1]->usee))
                {
                    if (gep->Getuselist()[0]->usee->isGlobal())
                    {
                        flag = true;
                        func->Change_Val.insert(gep->Getuselist()[0]->usee);
                    }
                }
            }
            else if (dynamic_cast<LoadInst *>(inst))
            {
                Value *val = inst->Getuselist()[0]->usee;
                if (auto gep = dynamic_cast<GetElementPtrInst *>(val))
                {
                    auto base = gep->Getuselist()[0]->usee;
                    if (base->isGlobal())
                        base->ReadFunc.insert(func);
                    else if (base->isParam())
                        base->ReadFunc.insert(func);
                }
                else
                {
                    if (val->isGlobal())
                        val->ReadFunc.insert(func);
                    else if (val->isParam())
                        val->ReadFunc.insert(func);
                }
            }
            else if (func->tag == Function::Tag::ParallelBody && dynamic_cast<BinaryInst *>(inst))
            {
                auto binary = inst->as<BinaryInst>();
                if (binary->IsAtomic())
                {
                    for (auto &use : binary->Getuselist())
                    {
                        flag = true;
                        func->Change_Val.insert(use->usee);
                    }
                }
            }
        }
    }
    return flag;
}