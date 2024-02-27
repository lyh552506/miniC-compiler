#include "ConstantProp.hpp"
#include <set>
#include <queue>
void ConstantProp::RunOnFunc(Function* func)
{
    for(BasicBlock* block:*func)
        RunOnBlock(block);
    for(BasicBlock* block:*func)
    {
        
        if(block->EndWithBranch())
        {
            if(auto COndInst = dynamic_cast<CondInst*>(block->back()))
            {
                BasicBlock* TrueBlock = dynamic_cast<BasicBlock*>(COndInst->Getuselist()[1].get()->GetValue());
                BasicBlock* FalseBlock = dynamic_cast<BasicBlock*>(COndInst->Getuselist()[2].get()->GetValue());
                if(Value* Cond = COndInst->Getuselist()[0].get()->GetValue())
                {
                    if(dynamic_cast<ConstIRInt*>(Cond)->GetVal() == 0)
                    {
                        COndInst->EraseFromParent();
                        COndInst->ClearRelation();
                        //ToDo: remove this block from its succblock's preblock
                        for(BasicBlock* Succ_Block:(COndInst->Succ_Block))
                        {
                            Succ_Block->Del_Pre();
                            if(Succ_Block != FalseBlock)
                            {
                                for(User* inst:*Succ_Block)
                                {
                                    if(auto PHiInst = dynamic_cast<PhiInst*>(inst))
                                    {
                                        for(int i = 0; i < PHiInst->PhiRecord.size(); i++)
                                        {
                                            auto test = PHiInst->PhiRecord[i].second();
                                        }
                                    }
                                }
                            }
                        
                        }
                    }
                }
            }   
        }
    }
}
// bool ConstantProp::RunOnBlock(BasicBlock &block) 
// {
//   // Initialize the worklist to all of the instructions ready to process...
//     std::set<User*> WorkList;
//     for(User* inst:block)
//         WorkList.insert(inst);
//     while(!WorkList.empty())
//     {
//         User* inst = *WorkList.begin();
//         WorkList.erase(WorkList.begin()); // Get an element from the worklist
//         if(!inst->Getuselist().empty())
//         {
//             ConstantFolding* ConstantFold;
//             if(Value *C = ConstantFold->ConstantFoldInst(inst))
//             {
//             // Add all of the users of this instruction to the worklist, they might
//             // be constant propagatable now...
//             for(Use* U:inst->GetUserlist())
//                 WorkList.insert(U->GetUser());
//             // Replace all of the uses of a variable with uses of the constant.
//             inst->RAUW(C);
//             // Remove the dead instruction.
//             WorkList.erase(inst);
//             if(isInstructionTriviallyDead(inst))
//                 inst->EraseFromParent();
//             // We made a change to the function.
//             changed = true;
//         }
//         return changed;
//     }
//     }
// }

void ConstantProp::Pass(Function* func, dominance& dom)
{
    bfsTraversal(func, dom);
}
void ConstantProp::bfsTraversal(Function* func, dominance& dom)
{
    std::queue<int> q;
    std::vector<bool> visited(sizeof(dominance::Node), false);

    //从根节点开始
    int rootIndex = 1;
    q.push(rootIndex);
    visited[rootIndex] = true;

    while(!q.empty())
    {
        int current = q.front();
        q.pop();
        dominance::Node* currentNode = &dom.node[current];

        //TODO
        RunOnBlock(currentNode->thisBlock);

        for(int childIndex : currentNode->idom_child)
        {
            if(!visited[childIndex])
            {
                q.push(childIndex);
                visited[childIndex] = true;
            }
        }
    }
}

bool isConstantAssignment(User* inst)
{
    // Check if the instruction is a constant assignment
    // Return true if it is, otherwise return false
    // TODO: Implement the logic to determine if the instruction is a constant assignment
    return false;
}
/*
    沿CFG对应的 dominant tree 从entry开始按BFS顺序遍历BasicBlock
    foreach block in blocks do:
        遍历每个inst
        foreach instr in block do:
            如果是常量赋值或者常量计算的结果
            if isConstantAssignment(instr):
                用常量值替换该变量的所有引用
                propConstToRef(instr)
            如果是常量值的分支条件
            elif isBranchAndConstPredicate(instr):
                替换为强制跳转，并标记另一个分支不可达
                changeCondBranchToAbsBranchAndMark(instr)
            如果是phi
            elif isPhi(instr):
                如果有一个基本块不可达，或者两个基本块的值相同
                if isOneBlockUnreachable(instr) || IsSameValPre(instr):
                    将可达块的值传播到对该指令的引用
                    propPhiToRef(instr)
    */

void ConstantProp::RunOnBlock(BasicBlock* block)
{
    for(User* inst:*block)
    {
        if(isConstantAssignment(inst))
            propConstToRef(inst);
        else if(isBranchAndConstPredicate(inst))
            changeCondBranchToAbsBranchAndMark(inst);
        else if(isPhi(inst))
            if(isOneBlockUnreachable(inst) || IsSameValPre(inst))
                propPhiToRef(inst);
    }
}