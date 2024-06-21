#include "CSE.hpp"
#include "HashScope.hpp"
#include "DCE.hpp"

// 先写一下迭代计算最小不动点部分
void CSE::RunOnFunction()
{
    // 这里采用deque而非vector的原因是在元素个数较多的时候deque的效率更高
    std::deque<dominance::Node*> WorkList;
    // std::vector<dominance::Node*> DFS = DomTree->node;
    std::queue<dominance::Node*> DFS = DomTree->DFS_Dom();
    // 将DFS中元素压入WorkList中
    while(!DFS.empty())
    {
        WorkList.push_back(DFS.front());
        DFS.pop();
    }
    // WorkList.push_back(DFS.front());
    // for (auto it = DFS.begin() + 1; it != DFS.end(); ++it)
    //     WorkList.push_back(*it);

    while(!WorkList.empty())
    {
        dominance::Node* CurrBlock = WorkList.front();
        if(!Processed.count(CurrBlock))
        {
            RunOnNode(CurrBlock);
            Processed.insert(CurrBlock);
            WorkList.pop_front();
        }
    }
}

bool CSE::RunOnNode(dominance::Node* node)
{
    BasicBlock* CurrBlock = node->thisBlock;
    if(std::distance(node->rev.begin(), node->rev.end()) != 1)
        // TODO: 可能不处理
        // return;
        ++CurrGens;
    if(!node->rev.empty())
        if(BasicBlock* block = DomTree->GetNode(node->rev.front()).thisBlock)
            if(auto inst = dynamic_cast<CondInst*>(block->back()))
                if(auto cond = dynamic_cast<User*>(inst->Getuselist()[0]->usee))
                if(CanHandle(cond))
                {
                    auto Condition = (dynamic_cast<BasicBlock*>(inst->Getuselist()[1]->usee) == block) ? 
                    ConstIRBoolean::GetNewConstant(true) : ConstIRBoolean::GetNewConstant(false);
                    AvailableValues.Insert(cond, Condition);
                    _DEBUG(std::cerr << "Add Condition Value for '"<< cond->GetName() <<
                    << "' as" << Condition << " in " << block->GetName() << std::endl;)
                }

    User* LoadStore = nullptr;
    for(auto iter = CurrBlock->begin(); iter != CurrBlock->end();)
    {
        User* inst = *++iter;
        if(DCE::isDeadInst(inst))
        {
            delete inst;
        }
    }
    

}