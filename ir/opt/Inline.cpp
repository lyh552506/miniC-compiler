#include "Inline.hpp"
#include "CFG.hpp"

void Inliner::Run()
{
    init();
    CreateCallMap();
    DetectRecursive();
    Inline();
    removeInlinedFunc();
}

void Inliner::init()
{
    if(func->GetBasicBlock().empty())
        NotInlineFunc.insert(func);
    if(Only_Inline_Small_Function)
    {
        if(func->GetBasicBlock().size() > Inline_Block_Num)
            NotInlineFunc.insert(func);
    }
    if(Not_Inline_Multilevel_Loop_Func)
    {
        for(BasicBlock* block : *func)
        {
            int nested = 0;
            LoopInfo* lf = loopAnalysis->LookUp(block);
            if(lf)
                nested = lf->GetLoopDepth();
            if(nested > Not_Inline_Multilevel_Loop_Nest)
            {
                if(NotInlineFunc.find(func) != NotInlineFunc.end())
                    break;
                NotInlineFunc.insert(func);
            }
        }
    }
    if(func->GetName() == "main")
        NotInlineFunc.insert(func);
    if(NotInlineFunc.find(func) == NotInlineFunc.end())
    {
        for(BasicBlock* block : *func)
        {
            for(User* inst : *block)
            {
                if(CanBeInlined(inst))
                    NeedInlineCall.push_back(inst);
            }
        }
    }
}

void Inliner::CreateCallMap()
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

void Inliner::DetectRecursive()
{
    std::set<Function*> visited;
    VisitFunc(func, visited);
}

void Inliner::VisitFunc(Function* entry, std::set<Function*>& visited)
{
    visited.insert(entry);
    if(!entry->CallingFuncs.empty()){
    for(Function* Succ : entry->CallingFuncs)
    {
        if(visited.find(Succ) != visited.end())
            RecursiveFunc.insert(Succ);
        else
            VisitFunc(Succ, visited);
    }}
    visited.erase(entry);
}
void Inliner::Inline()
{
    while(!NeedInlineCall.empty())
    {
        User* inst = NeedInlineCall.front();
        NeedInlineCall.erase(NeedInlineCall.begin());
        BasicBlock* block = inst->GetParent();

        BasicBlock* SplitBlock = block->SplitAt(inst);
        BasicBlock::mylist<Function,BasicBlock>::iterator Block_Pos(block);
        Block_Pos.insert_after(SplitBlock);
        ++Block_Pos;

        std::vector<BasicBlock*> blocks = CopyBlocks(inst);
        UnCondInst* Br = new UnCondInst(blocks[0]);
        block->push_back(Br);
        for(BasicBlock* block_ : blocks)
        {
            for(User* inst : *block_)
            {
                if(dynamic_cast<AllocaInst*>(inst))
                {
                    BasicBlock* front_block = func->front();
                    inst->EraseFromParent();
                    front_block->push_front(inst);
                }
            }
        }
        for(BasicBlock* block_ : blocks)
            Block_Pos.insert_before(block_);
        if(inst->GetTypeEnum() != InnerDataType::IR_Value_VOID)
        {
            // if(SSALevel)
            // {
            PhiInst* Phi = PhiInst::NewPhiNode(SplitBlock->front(), SplitBlock, inst->GetType());
            HandleRetPhi(SplitBlock, Phi, blocks);
            if(Phi->Getuselist().size() == 1)
            {
                Value* val = Phi->Getuselist()[0]->usee;
                inst->RAUW(val);
            }
            else
                inst->RAUW(Phi);
            // }
            // else
            // {
            // AllocaInst* Alloca = new AllocaInst(" ",inst->GetType());
            // entry->InsertAlloca(Alloca);
            // LoadInst* load = new LoadInst(Alloca);
            // for(Use* user_ : inst->GetUserlist())
            // {
            //     User* user = user_->GetUser();
            //     auto Inst_Pos = std::find(inst->GetParent()->begin(), inst->GetParent()->end(), user);
            //     Inst_Pos.insert_before(load);
            // }
            // inst->RAUW(load);
            // // NewBlock->push_front(load);
            // }
        }
        else
            HandleVoidRet(SplitBlock, blocks);
        m.inlinedFunc.insert(dynamic_cast<Function*>(inst->Getuselist()[0]->usee));
        m.hasInlinedFunc.insert(func);
        inst->ClearRelation();
        inst->EraseFromParent();
    }
}

std::vector<BasicBlock*> Inliner::CopyBlocks(User* inst)
{
    Function* Func = dynamic_cast<Function*>(inst->Getuselist()[0]->usee);
    std::unordered_map<Operand, Operand> OperandMapping;

    std::vector<BasicBlock*> copied_bbs;
    for(BasicBlock* block : *Func)
        copied_bbs.push_back(block->clone(OperandMapping));
    int num = 1;
    for(auto& param : Func->GetParams())
    {
        Value* Param = param.get();
        OperandMapping[Param]->RAUW(inst->Getuselist()[num]->usee);
    }
    return copied_bbs;
}

// void Inliner::InlineRecursive(Function* entry)
// {
//          TODO
// }

bool Inliner::CanBeInlined(User *inst)
{
    if(dynamic_cast<CallInst*>(inst))
    {    
        std::string name = inst->Getuselist()[0]->usee->GetName();
        if(name =="getint" || name == "getch" || name == "getfloat" \
        || name == "getfarray" || name == "putint" || name == "putfloat" \
        || name == "putarray" || name == "putfarray" || name == "putf" || name == "getarray" \
        || name == "putch" || name == "_sysy_starttime" || name == "_sysy_stoptime" \
        || name == "llvm.memcpy.p0.p0.i32")
            return false;
        Function* Func = dynamic_cast<Function*>(inst->Getuselist()[0]->usee);
        if(Func->GetUserlist().GetSize() > 2)
            return false;
        if(Only_Inline_Small_Function && !NotInline(Func))
        {
            if(Func->GetBasicBlock().size() <= Inline_Block_Num)
            {
                int Size = 0;
                for(BasicBlock* block : Func->GetBasicBlock())
                    Size += block->Size();
                if(Size <= 5)
                    return true;
                else
                    return false;
            }
            return false; 
        }
        else if(isRecursive(Func) && Inline_Recursive)
        {
            // int nest = CalRecursiveDepth(func); //TODO
            // if(nest < Nest_Max)
                // return true;
            return false;
        }
        else
            return false;
    }
    return false;
}

void Inliner::removeInlinedFunc()
{
    for(Function* func_ : m.inlinedFunc)
    {
        bool remove = true;
        for(Use* user_ : func_->GetUserlist())
        {
            User* user = user_->GetUser();
            if(dynamic_cast<CallInst*>(user))
            {
                Function* Func_use = user->GetParent()->GetParent();
                if(Func_use)
                {
                    if(m.hasInlinedFunc.find(Func_use) != m.hasInlinedFunc.end() \
                    && m.inlinedFunc.find(Func_use) == m.inlinedFunc.end())
                        remove = false;
                }
            }   
        }
        if(remove && func_->GetUserlist().is_empty())
        {
            m.inlinedFunc.erase(func_);
            m.EraseFunction(func_);
        }
    }
}

void Inliner::HandleVoidRet(BasicBlock* spiltBlock, std::vector<BasicBlock*>& blocks)
{
    for(BasicBlock* block : blocks)
    {
        User* inst = block->back();
        if(dynamic_cast<RetInst*>(inst))
        {
            UnCondInst* Br = new UnCondInst(spiltBlock);
            inst->ClearRelation();
            inst->EraseFromParent();
            block->push_back(Br);
        }
    }
}

void Inliner::HandleRetPhi(BasicBlock* RetBlock, PhiInst* Phi, std::vector<BasicBlock*>& blocks)
{
    for(BasicBlock* block : blocks)
    {
        User* inst = block->back();
        if(dynamic_cast<RetInst*>(inst))
        {
            Phi->updateIncoming(inst->Getuselist()[0]->usee, block);
            UnCondInst* Br = new UnCondInst(RetBlock);
            inst->ClearRelation();
            inst->EraseFromParent();
            block->push_back(Br);
        }
    }
}

void Inliner::PrintPass()
{
    #ifdef SYSY_MIDDLE_END_DEBUG
    std::cout << "--------Inline--------" << std::endl;
    Singleton<Module>().Test();
    #endif
}