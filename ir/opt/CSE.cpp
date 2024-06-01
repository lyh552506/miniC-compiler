#include "CSE.hpp"
#include "HashScope.hpp"


// 先写一下迭代计算最小不动点部分
void CSE::RunOnFunction()
{
    // 这里采用deque而非vector的原因是在元素个数较多的时候deque的效率更高
    std::deque<dominance::Node> WorkList;
    std::vector<dominance::Node> DFS = DomTree->node;

    // 将DFS中元素压入WorkList中
    WorkList.push_back(DFS.front());
    for (auto it = DFS.begin() + 1; it != DFS.end(); ++it)
        WorkList.push_back(*it);

    while(!WorkList.empty())
    {
        dominance::Node CurrBlock = WorkList.front();

        if(!Processed.count(CurrBlock))
        {
            RunOnNode(CurrBlock);
            Processed.insert(CurrBlock);
            WorkList.pop_front();
        }
    }
}

// bool CSE::RunOnNode(dominance::Node node)
// {
//     if(std::distance(node.rev.begin(), node.rev.end()) != 1)
//         // TODO: 可能不处理
//         return;

    
// }