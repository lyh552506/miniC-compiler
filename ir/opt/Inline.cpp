#include "Inline.hpp"
#include "CFG.hpp"

void Inliner::Run()
{
    init();
    CreateCallMap();
    if(func->GetName() == "main")
        DetectRecursive();
    Inline(func);
    removeInlinedFunc();
}

void Inliner::init()
{
    auto &Params = func->GetParams();
    if(!Params.empty())
    {
        auto userList = func->GetUserlist();
        for(auto iter = userList.begin(); iter != userList.end();)
        {
            int i = 0;
            User* inst = (*iter)->GetUser();
            if(dynamic_cast<CallInst*>(inst))
            {
                for(auto iter1 = inst->Getuselist().begin(); iter1 != inst->Getuselist().end();)
                {
                    if(dynamic_cast<Function*>((*iter1)->usee))
                    {
                        ++iter1;
                        continue;
                    }
                    else
                    {
                        Value* arg = (*iter1)->usee;
                        Value* param = Params[i].get();
                        ArgsMap.insert(std::make_pair(arg, param));
                        i++;
                        ++iter1;
                    }
                }
                ++iter;
            }
            else
                ++iter;
        }
    }
    if(func->GetBasicBlock().empty())
        NotInlineFunc.insert(func);
    else if(Only_Inline_Small_Function)
    {
        if(func->GetBasicBlock().size() > Inline_Block_Num)
            NotInlineFunc.insert(func);
    }
    else if(Not_Inline_Multilevel_Loop_Func)
    {
        for(BasicBlock* block : *func)
        {
            int nested = 0;
            LoopInfo* lf = loopAnalysis->LookUp(block);
            if(lf)
                nested = lf->GetLoopDepth();
            if(nested > Not_Inline_Multilevel_Loop_Func)
            {
                if(NotInlineFunc.find(func) != NotInlineFunc.end())
                    break;
                NotInlineFunc.insert(func);
            }
        }
    }
    if(func->GetName() == "main")
        NotInlineFunc.erase(func);
}



void Inliner::CreateCallMap()
{
    for(BasicBlock* block : *func)
    {
        for(User* inst : *block)
        {
            if(CallInst* call = dynamic_cast<CallInst*>(inst))
            {
                Function* Func = dynamic_cast<Function*>(call->Getuselist()[0]->usee);
                if(Func)
                {
                    CallMap[func].insert(Func);
                    CalledMap[Func].insert(func);
                }
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
    for(Function* Succ : CallMap[entry])
    {
        if(visited.find(Succ) != visited.end())
            RecursiveFunc.insert(Succ);
        else
            VisitFunc(Succ, visited);
    }
    visited.erase(entry);
}
void Inliner::Inline(Function* entry)
{
    for(auto iter = entry->GetBasicBlock().begin(); iter != entry->GetBasicBlock().end(); ++iter)
    {
        BasicBlock* block = *iter;
        for(auto iter1 = block->begin(); iter1 != block->end(); ++iter1)
        {
            User* inst = *iter1;
            if(CanBeInlined(inst))
            {
                // 切分basicblock
                BasicBlock* NewBlock = SplitBlock(*iter1, *entry);
                // BasicBlock* NewBlock;
                UnCondInst* Br = new UnCondInst(NewBlock);
                block->push_back(Br);
                auto Block_Pos = std::find(entry->begin(), entry->end(), block);
                ++Block_Pos;
                BasicBlock* SuccBlock = *Block_Pos;
                Block_Pos.insert_before(NewBlock);
                Function* func = dynamic_cast<Function*>(inst->Getuselist()[0]->usee);
                std::list<BasicBlock*> blocks = CopyBlocks(inst, *func);
                for(BasicBlock* block_ : blocks)
                {
                    ++Block_Pos;
                    Block_Pos.insert_before(block_);
                }
                if(inst->GetTypeEnum() != InnerDataType::IR_Value_VOID)
                {
                    // if(SSALevel){
                    PhiInst* Phi = PhiInst::NewPhiNode(SuccBlock->front(), SuccBlock, inst->GetType());
                    HandleRetPhi(SuccBlock, Phi, blocks);
                    if(Phi->Getuselist().size() == 2)
                    {
                        Value* val = Phi->Getuselist()[0]->usee;
                        inst->RAUW(val);
                        inst->ClearRelation();
                        inst->EraseFromParent();
                    }
                    else
                        inst->RAUW(Phi);
                    // }
                    // else{
                    AllocaInst* Alloca = new AllocaInst(" ",inst->GetType());
                    entry->InsertAlloca(Alloca);
                    LoadInst* load = new LoadInst(Alloca);
                    inst->RAUW(load);
                    inst->ClearRelation();
                    inst->EraseFromParent();
                    NewBlock->push_front(load);
                    // }
                }
                else
                    HandleVoidRet(NewBlock, blocks);
                inlinedFunc.insert(func);
                hasInlinedFunc.insert(entry);
                // auto test = NewBlock->back();
                // for(auto &Args : inst->Getuselist())
                // {
                //     if(dynamic_cast<Function*>(Args->usee))
                //         continue;
                //     User* args = Args->GetUser();
                //     if(args && args->GetUserlist().is_empty())
                //         args->RAUW(Value *val)
                // }
                // 维护succ pred
                // 复制block
                // 设置新bb的父亲
                // 将新bb插入函数
                // 设置被split的块跳转到新的bb的entry
                // 给返回值alloca空间，并跳转到新的BB
                // 处理void返回值的情况，直接跳转到新的BB
            }
        }
    }
}


BasicBlock* Inliner::SplitBlock(User* Calling, Function& func)
{
    BasicBlock* NewBlock = new BasicBlock(func); 
    std::vector<User*> insts = Calling->GetSuccNodes();
    
    // auto test = *Calling;
    // BasicBlock* NewBlock = new BasicBlock(*Calling->GetParent());
    /*
    创建一个新block
    将Calling的后继节点全部移动到新block，并维护每个inst的parent关系
    如果calling的user是phi节点，需要将phi节点的前驱节点中的calling替换为新block
    */
}

std::list<BasicBlock*> Inliner::CopyBlocks(User* inst, Function& func)
{
    Function* Func = dynamic_cast<Function*>(inst->Getuselist()[0]->usee);
    std::list<BasicBlock*> blocks;
    std::map<Value*, Value*> Old2New;
    for(BasicBlock* block : func)
    {
        BasicBlock* NewBlock = new BasicBlock(func);
        Old2New[block] = NewBlock;
        blocks.push_back(NewBlock);
        /*
        复制block中的每个inst
        */
        for(User* inst : *block)
        {
            // auto test = inst->GetType();
            // User* NewInst = new User(test); 
            if(dynamic_cast<AllocaInst*>(inst))
            {
                NewBlock->push_alloca(inst->GetName(), inst->GetType());
            }
        }
        auto iter = std::find(Func->begin(), Func->end(), block);
        iter.insert_after(NewBlock);
    }
}

void Inliner::InlineRecursive(Function* entry)
{
    /*
    copy Blocks
    splitblocks 将这个基本块分割成两部分，然后将被调用的函数的基本块复制并插入到当前函数中
在复制基本块的过程中，它创建了一个新的基本块，并将旧的基本块和新的基本块的映射关系存储在一个map中。
复制基本块中的每个指令，并将旧的指令和新的指令的映射关系也存储在这个map中。
创建函数的形参和实参的映射关系。
在插入新的基本块的过程中，首先将新的基本块插入到当前函数的基本块列表中，设置新的基本块的父亲为当前函数。
然后，它处理函数的返回值。如果函数的返回值不是void，那么它将为返回值分配空间，并将返回值的加载指令插入到新的基本块的开始位置。
如果函数的返回值是void，那么它将直接创建一个跳转到新的基本块的跳转指令。
它将被内联的函数添加到`inlined_`集合中，表示这个函数已经被内联过，然后将当前函数添加到`has_inline_`集合中，表示这个函数包含了内联的函数
然后，删除了复制的基本块中的所有指令的操作数，以释放内存。
    */
}

bool Inliner::CanBeInlined(User *inst)
{
    if(dynamic_cast<CallInst*>(inst))
    {
        Function* func = dynamic_cast<Function*>(inst->Getuselist()[0]->usee);
        if(func->GetBasicBlock().size() == 1)
        {
            if(func->GetBasicBlock().back()->Size() <= 5)
                return true;
        }
        return false; //todo handle ignored and recursive
    }
    return false;
}
// bool FunctionInline::canBeInlined(Instruction *instr) {
//   if (instr->getInstrType() == Instruction::Call) {
//     auto call = static_cast<CallInst *>(instr);
//     auto func = call->getFunction();
//     if (m_->isMIRSSALevel()) {
//       if (func->getNumBasicBlocks() == 1) {
//         if (func->getBasicBlocks().back()->getInstructions().size() <= 5)
//           return true;
//       }
//       return false;
//     }
//     return !isIgnored(func) && !isRecursive(func);
//   }
//   return false;
// }

void Inliner::removeInlinedFunc()
{
    inlinedFunc.insert(func);
    for(Function* func_ : inlinedFunc)
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
                    if(hasInlinedFunc.find(Func_use) == hasInlinedFunc.end() \
                    && inlinedFunc.find(Func_use) == inlinedFunc.end())
                        // remove = false;
                        remove = true;
                }
            }
            if(remove)
                m.EraseFunction(func_);
        }
    }
}

void Inliner::HandleVoidRet(BasicBlock* spiltBlock, std::list<BasicBlock*>& blocks)
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

void Inliner::HandleRetPhi(BasicBlock* RetBlock, PhiInst* Phi, std::list<BasicBlock*>& blocks)
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

void Inliner::UpdateRAUWArgsMap(User* inst, Value* val)
{
    for(Use* user_ : inst->GetUserlist())
    {
        User* user = user_->GetUser();

    }
}
void Inliner::PrintPass()
{
    std::cout << "--------Inline--------" << std::endl;
    Singleton<Module>().Test();
}