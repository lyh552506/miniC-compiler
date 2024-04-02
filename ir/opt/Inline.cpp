#include "Inline.hpp"

CallGraphNode* CallGraphNode::operator[](unsigned i) const
{   
    assert(i < CalledFunctions.size() && "Invalid index");
    return CalledFunctions[i].second; 
}

void CallGraphNode::removeAllCalledFunctions()
{
    while(!CalledFunctions.empty())
    {
        // TODO 计数器
        CalledFunctions.pop_back();
    }
}

void CallGraphNode::MoveCallFuncFrom(CallGraphNode *Node)
{
    assert(CalledFunctions.empty() && "Cannot Move");
    std::swap(CalledFunctions, Node->CalledFunctions);
}

// void CallGraphNode::AddCallFunc(CallInst* inst)
// {
//     CalledFunctions.emplace_back( \
//         std::make_pair(inst, CallGraphNode \
//         (dynamic_cast<Function*>(inst->Getuselist()[0]->usee))));
// }

void CallGraphNode::DelCallEdge(iterator iter)
{

}

CallGraphNode* CallGraph::operator[](Function* func)
{
    const_iterator iter = FunctionMap.find(func);
    assert(iter != FunctionMap.end() && "Function not in CallGraph!");
    return iter->second.get();
}

Function* CallGraph::EraseFromModule(CallGraphNode* node)
{
    assert(node->is_empty() && "Cannot erase function from module!");
    Function* F = node->getFunc();
    FunctionMap.erase(F);
    M.EraseFunction(F);
    return F;
}

void CallGraphSCC::ReplaceNode(CallGraphNode* Old, CallGraphNode* New)
{
    assert(Old != New && "Should not replace node with self!");
    for(unsigned i = 0 ; ; ++i)
    {
        assert(i != Nodes.size() && "Node not in SCC!");
        if(Nodes[i] != Old)
            continue;
        Nodes[i] = New;
        break;
    }
    //todo update
}

InlineCost InlineCost::getCost(Function* func) 
{
    int COst = 0;
    if(!func)
        return InlineCost::GetNever();
    if(func->AlwaysInline)
    {
        if(isVariable()) //tode fix func
            return InlineCost::GetAlways();
        return InlineCost::GetNever();
    }

    if(func->NeverInline)
        return InlineCost::GetNever();
    
    
    for(BasicBlock* block : *func)
    {
        for(User* inst : *block)
        {
            if(dynamic_cast<CallInst*>(inst))
                COst += CallCost;
            else
                COst += InstrCost;
        }
        

    }
    return InlineCost(COst, 0);
}

void Inline::PrintPass()
{
    std::cout << "--------Inline--------" << std::endl;
    Singleton<Module>().Test();
}

void Inline::RunOnFunction()
{

}
/*
CallInst use: vector{Func, arges} for(int i = 1 ; i < vector.size() ; i++)
*/

void Inliner::PrintPass()
{
    std::cout << "--------Inline--------" << std::endl;
    Singleton<Module>().Test();
}

void Inliner::Run()
{
    init();
    CreateCallMap();
    DetectRecursive();
}

void Inliner::init()
{
    for(auto &func_ : m->GetFuncTion())
    {
        Function* func = func_.get();
        LoopAnalysis loopAnalysis(func, dom);
        loopAnalysis.RunOnFunction();
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
                LoopInfo* lf = loopAnalysis.LookUp(block);
                nested = lf->GetLoopDepth();
                if(nested > Not_Inline_Multilevel_Loop_Func)
                {
                    if(NotInlineFunc.find(func) != NotInlineFunc.end())
                        break;
                    NotInlineFunc.insert(func);
                }
            }
        }
    }
    for(auto& func_ : m->GetFuncTion())
    {
        Function* func = func_.get();
        if(func->GetName() == "main")
            NotInlineFunc.erase(func);
    }
}

void Inliner::CreateCallMap()
{
    for(auto& func_ : m->GetFuncTion())
    {
        Function* func = func_.get();
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
}

void Inliner::DetectRecursive()
{
    Function* entry = m->GetMainFunc();
    std::set<Function*> visited;
    VisitFunc(entry, visited);
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
    // if(inlinedFunc.find(entry) != inlinedFunc.end())
    //     return;
    // inlinedFunc.insert(entry);
    // for(auto& func_ : m->GetFuncTion())
    // {
    //     Function* func = func_.get();
    //     if(func->GetName() == entry->GetName())
    //         continue;
    //     if(NotInlineFunc.find(func) != NotInlineFunc.end())
    //         continue;
    //     if(CallMap.find(func) == CallMap.end())
    //         continue;
    //     for(auto& call : CallMap[func])
    //     {
    //         if(call->GetName() == entry->GetName())
    //         {
    //             InlineCost cost = Cost.getCost(func);
    //             if(cost.isNever())
    //                 continue;
    //             if(cost.isAlways())
    //             {
    //                 Inline(call);
    //                 break;
    //             }
    //             if(cost.Cost < Inline_Block_Num)
    //             {
    //                 Inline(call);
    //                 break;
    //             }
    //         }
    //     }
    // }
    for(auto iter = entry->GetBasicBlock().begin(); iter != entry->GetBasicBlock().end(); ++iter)
    {
        BasicBlock* block = *iter;
        for(auto iter1 = block->begin(); iter1 != block->end(); ++iter1)
        {
            if(CanBeInlined(*iter1))
            {
                // 切分basicblock
                // SplitBlock(iter1);
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

// void Inliner::Inline(Function* entry)
// {
//     if(inlinedFunc.find(entry) != inlinedFunc.end())
//         return;
//     inlinedFunc.insert(entry);
//     for(auto& func_ : m->GetFuncTion())
//     {
//         Function* func = func_.get();
//         if(func->GetName() == entry->GetName())
//             continue;
//         if(NotInlineFunc.find(func) != NotInlineFunc.end())
//             continue;
//         if(CallMap.find(func) == CallMap.end())
//             continue;
//         for(auto& call : CallMap[func])
//         {
//             if(call->GetName() == entry->GetName())
//             {
//                 InlineCost cost = Cost.getCost(func);
//                 if(cost.isNever())
//                     continue;
//                 if(cost.isAlways())
//                 {
//                     Inline(call);
//                     break;
//                 }
//                 if(cost.Cost < Inline_Block_Num)
//                 {
//                     Inline(call);
//                     break;
//                 }
//             }
//         }
//     }
// }

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

void Inliner::CopyBlocks(CallInst* inst, Function& func)
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
        
        auto iter = std::find(Func->begin(), Func->end(), block);
        iter.insert_after(NewBlock);
    }
}

void Inliner::InlineRecursive(Function* entry)
{

}