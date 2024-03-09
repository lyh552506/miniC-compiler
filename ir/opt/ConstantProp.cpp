#include "ConstantProp.hpp"
#include <set>
#include <queue>

std::vector<BasicBlock*> ConstantProp::BFSTraversal(int rootIndex, dominance* dom) {
    std::vector<dominance::Node> node = dom->node;
    if (node.empty()) return bfsOrder;

    std::queue<int> q;
    q.push(rootIndex);

    while (!q.empty()) {
        int nodeIndex = q.front();
        q.pop();

        // 访问当前节点并将其添加到bfsOrder中
        bfsOrder.push_back(node[nodeIndex].thisBlock);

        // 将当前节点的所有孩子添加到队列中
        for (int childIndex : node[nodeIndex].idom_child) {
            q.push(childIndex);
        }
    }

    return bfsOrder;
}
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
    For_inst_In(block)
    {
        if(auto GEtElementPtrInst = dynamic_cast<GetElementPtrInst*>(inst))
        {
            Value* C = ConstFold->ConstantFoldGetElementPtrInst(GEtElementPtrInst);
            if(C)
                {
                    inst->RAUW(C);
                    inst->ClearRelation();
                    inst->EraseFromParent();
                }
            continue;
        }
        if(dynamic_cast<StoreInst*>(inst))
            continue;
        Value* C = ConstFold->ConstantFoldInst(inst);
        if(C)
        {
            inst->RAUW(C);
            inst->ClearRelation();
            inst->EraseFromParent();
        }
    }
    For_inst_In(block)
    {
    Value* C = ConstFold->ConstantFoldInst(inst);
        if(C)
        {
            inst->RAUW(C);
            inst->ClearRelation();
            inst->EraseFromParent();
        }
    }
}
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