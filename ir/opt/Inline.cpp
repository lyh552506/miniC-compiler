#include "Inline.hpp"
#include "CFG.hpp"

// CallGraphNode* CallGraphNode::operator[](unsigned i) const
// {   
//     assert(i < CalledFunctions.size() && "Invalid index");
//     return CalledFunctions[i].second; 
// }

// void CallGraphNode::removeAllCalledFunctions()
// {
//     while(!CalledFunctions.empty())
//     {
//         // TODO 计数器
//         CalledFunctions.pop_back();
//     }
// }

// void CallGraphNode::MoveCallFuncFrom(CallGraphNode *Node)
// {
//     assert(CalledFunctions.empty() && "Cannot Move");
//     std::swap(CalledFunctions, Node->CalledFunctions);
// }

// // void CallGraphNode::AddCallFunc(CallInst* inst)
// // {
// //     CalledFunctions.emplace_back( \
// //         std::make_pair(inst, CallGraphNode \
// //         (dynamic_cast<Function*>(inst->Getuselist()[0]->usee))));
// // }

// void CallGraphNode::DelCallEdge(iterator iter)
// {

// }

// CallGraphNode* CallGraph::operator[](Function* func)
// {
//     const_iterator iter = FunctionMap.find(func);
//     assert(iter != FunctionMap.end() && "Function not in CallGraph!");
//     return iter->second.get();
// }

// Function* CallGraph::EraseFromModule(CallGraphNode* node)
// {
//     assert(node->is_empty() && "Cannot erase function from module!");
//     Function* F = node->getFunc();
//     FunctionMap.erase(F);
//     M.EraseFunction(F);
//     return F;
// }

// void CallGraphSCC::ReplaceNode(CallGraphNode* Old, CallGraphNode* New)
// {
//     assert(Old != New && "Should not replace node with self!");
//     for(unsigned i = 0 ; ; ++i)
//     {
//         assert(i != Nodes.size() && "Node not in SCC!");
//         if(Nodes[i] != Old)
//             continue;
//         Nodes[i] = New;
//         break;
//     }
//     //todo update
// }

// InlineCost InlineCost::getCost(Function* func) 
// {
//     int COst = 0;
//     if(!func)
//         return InlineCost::GetNever();
//     if(func->AlwaysInline)
//     {
//         if(isVariable()) //tode fix func
//             return InlineCost::GetAlways();
//         return InlineCost::GetNever();
//     }

//     if(func->NeverInline)
//         return InlineCost::GetNever();
    
    
//     for(BasicBlock* block : *func)
//     {
//         for(User* inst : *block)
//         {
//             if(dynamic_cast<CallInst*>(inst))
//                 COst += CallCost;
//             else
//                 COst += InstrCost;
//         }
        

//     }
//     return InlineCost(COst, 0);
// }

// void Inline::PrintPass()
// {
//     std::cout << "--------Inline--------" << std::endl;
//     Singleton<Module>().Test();
// }

// void Inline::RunOnFunction()
// {

// }
// /*
// CallInst use: vector{Func, arges} for(int i = 1 ; i < vector.size() ; i++)
// */

// void Inliner::PrintPass()
// {
//     std::cout << "--------Inline--------" << std::endl;
//     Singleton<Module>().Test();
// }

void Inliner::Run()
{
    init();
    CreateCallMap();
    if(func->GetName() == "main")
        DetectRecursive();
    Inline(func);
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
            User* inst = *iter1;
            if(CanBeInlined(inst))
            {
                // 切分basicblock
                // BasicBlock* NewBlock = SplitBlock(*iter1, *entry);
                BasicBlock* NewBlock;
                UnCondInst* Br = new UnCondInst(NewBlock);
                block->push_back(Br);
                auto Block_Pos = std::find(entry->begin(), entry->end(), block);
                ++Block_Pos;
                Block_Pos.insert_before(NewBlock);
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

// void FunctionInline::inlining(Function *entry_func) {
//   auto &entry_func_bbs = entry_func->getBasicBlocks();
//   for (auto bbs_iter = entry_func_bbs.begin(); bbs_iter != entry_func_bbs.end();
//        ++bbs_iter) {
//     BasicBlock *cur_bb = *bbs_iter;
//     auto &instrs = cur_bb->getInstructions();
//     for (auto instr_iter = instrs.begin(); instr_iter != instrs.end();
//          ++instr_iter) {
//       auto cur_inst = *instr_iter;
//       if (canBeInlined(cur_inst)) {
//         // 切分BB
//         auto split_bb = splitBasicBlock(instr_iter, instrs);
//         ++bbs_iter;
//         auto next_bb_iter = entry_func_bbs.insert(bbs_iter, split_bb);
//         split_bb->setParent(entry_func);
//         // 维护前驱和后继
//         for (auto bb : cur_bb->getSuccBasicBlocks()) {
//           bb->removePreBasicBlock(cur_bb);
//           bb->addPreBasicBlock(split_bb);
//           split_bb->addSuccBasicBlock(bb);
//         }
//         cur_bb->clearSuccBasicBlock();

//         // 复制函数的bbs
//         CallInst *call_inst = static_cast<CallInst *>(cur_inst);
//         exit_ifnot(_NotCallInst_inlining_FunctionInline, call_inst);
//         Function *func = call_inst->getFunction();
//         std::list<BasicBlock *> inlined_bbs = copyBasicBlocks(call_inst, func);
//         // 设置新bb的父亲
//         for (auto bb : inlined_bbs) {
//           bb->setParent(entry_func);
//         }
//         // 将新的bb插入函数
//         next_bb_iter = entry_func_bbs.insert(next_bb_iter, inlined_bbs.begin(),
//                                              inlined_bbs.end());

//         // 设置被split的块跳转到新的bb的entry，注意这个指令会自动添加Br到cur_bb
//         BranchInst *br = BranchInst::createBr(*(inlined_bbs.begin()), cur_bb);

//         // 给返回值alloca空间，并跳转到新的BB
//         if (!call_inst->isVoid()) {
//           // 生成PHI指令
//           if (m_->isMIRSSALevel()) {
//             auto phi = PhiInst::createPhi(call_inst->getType(), nullptr);
//             handlePHIReturns(split_bb, phi, inlined_bbs);
//             if (phi->getNumOperand() == 2)
//               call_inst->replaceAllUseWith(phi->getOperand(0));
//             else {
//               call_inst->replaceAllUseWith(phi);
//               split_bb->addInstrBegin(phi);
//             }
//           } else {
//             auto alloca = AllocaInst::createAlloca(call_inst->getType());
//             handleReturns(split_bb, alloca, inlined_bbs);
//             auto inlined_entry_bb = *(inlined_bbs.begin());
//             inlined_entry_bb->addInstrBegin(alloca);
//             // alloca->setParent(inlined_entry_bb);
//             auto load = LoadInst::createLoad(call_inst->getType(), alloca);
//             call_inst->replaceAllUseWith(load);
//             split_bb->addInstrBegin(load);
//           }
//         }
//         // 处理void返回值的情况，直接跳转到新的BB
//         else {
//           handleVoidReturn(split_bb, inlined_bbs);
//         }

//         inlined_.insert(func);
//         has_inline_.insert(entry_func);

//         bbs_iter = --next_bb_iter;
//         break;
//       }
//     }
//   }
// }

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

// BasicBlock* Inliner::SplitBlock(User* Calling, Function& func)
// {
//     BasicBlock* NewBlock = new BasicBlock(func); 
//     std::vector<User*> insts = Calling->GetSuccNodes();
    
//     // auto test = *Calling;
//     // BasicBlock* NewBlock = new BasicBlock(*Calling->GetParent());
//     /*
//     创建一个新block
//     将Calling的后继节点全部移动到新block，并维护每个inst的parent关系
//     如果calling的user是phi节点，需要将phi节点的前驱节点中的calling替换为新block
//     */
// }

// void Inliner::CopyBlocks(CallInst* inst, Function& func)
// {
//     Function* Func = dynamic_cast<Function*>(inst->Getuselist()[0]->usee);
//     std::list<BasicBlock*> blocks;
//     std::map<Value*, Value*> Old2New;
//     for(BasicBlock* block : func)
//     {
//         BasicBlock* NewBlock = new BasicBlock(func);
//         Old2New[block] = NewBlock;
//         blocks.push_back(NewBlock);
//         /*
//         复制block中的每个inst
//         */
//         for(User* inst : *block)
//         {
//             // auto test = inst->GetType();
//             // User* NewInst = new User(test); 
//             if(dynamic_cast<AllocaInst*>(inst))
//             {
//                 NewBlock->push_alloca(inst->GetName(), inst->GetType());
//             }
//         }
//         auto iter = std::find(Func->begin(), Func->end(), block);
//         iter.insert_after(NewBlock);
//     }
// }

// // 进行了形参和实参的替换，新bb内的前驱和后继也有维护，bb没有设置parent
// std::list<BasicBlock *> FunctionInline::copyBasicBlocks(CallInst *call_inst,
//                                                         Function *old_func) {
//   std::list<BasicBlock *> bbs;
//   std::map<Value *, Value *> old2new;
//   // 创建新的BB和instr，并建立旧的Value和新的Value的map（old2new）
//   for (auto bb : old_func->getBasicBlocks()) {
//     BasicBlock *new_bb = BasicBlock::create(m_, "");
//     old2new[bb] = new_bb;
//     bbs.push_back(new_bb);
//     for (auto instr : bb->getInstructions()) {
//       Instruction *new_inst = instr->copy(new_bb);
//       exit_ifnot(_copyhasWrong_copyBasicBlocks_FunctionInline,
//                  new_inst->getInstrType() == instr->getInstrType());
//       old2new[instr] = new_inst;
//     }
//   }
//   // 创建形参和实参的映射
//   // 注意实参的ops是从1开始，0是函数func
//   int i = 1;
//   for (auto arg : old_func->getArgs()) {
//     old2new[arg] = call_inst->getOperand(i);
//     i++;
//   }

//   for (auto bb : old_func->getBasicBlocks()) {
//     BasicBlock *new_bb = dynamic_cast<BasicBlock *>(old2new[bb]);
//     exit_ifnot(_NewBBEmpty_copyBasicBlocks_FunctionInline, new_bb);
//     for (auto instr : bb->getInstructions()) {
//       Instruction *new_inst = dynamic_cast<Instruction *>(old2new[instr]);
//       exit_ifnot(_NewInsEmpty_copyBasicBlocks_FunctionInline, new_inst);
//       int i = 0;
//       for (auto op : instr->getOperands()) {
//         Value *new_op;
//         if (dynamic_cast<Constant *>(op) ||
//             dynamic_cast<GlobalVariable *>(op) ||
//             dynamic_cast<Function *>(op)) {
//           new_op = op;
//         } else {
//           new_op = old2new[op];
//         }
//         new_inst->setOperand(i, new_op);
//         i++;
//       }
//     }
//   }
//   for (auto bb : old_func->getBasicBlocks()) {
//     BasicBlock *new_bb = dynamic_cast<BasicBlock *>(old2new[bb]);
//     exit_ifnot(_NewBBEmpty_copyBasicBlocks_FunctionInline, new_bb);
//     for (auto succ : bb->getSuccBasicBlocks()) {
//       BasicBlock *new_succ = dynamic_cast<BasicBlock *>(old2new[succ]);
//       exit_ifnot(_NewBBEmpty_copyBasicBlocks_FunctionInline, new_succ);
//       new_bb->addSuccBasicBlock(new_succ);
//       new_succ->addPreBasicBlock(new_bb);
//     }
//   }
//   return bbs;
// }
void Inliner::InlineRecursive(Function* entry)
{

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
