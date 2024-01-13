#include "IDF.hpp"

void IDF::SetDefBB(std::set<BasicBlock *> DefBlock) { DefineBlock = &DefBlock; }

void IDF::SetLiveInBlock(std::set<BasicBlock *> LiveInBlock) {
  LiveInBlocks = &LiveInBlock;
  uselivein = true;
}

// 论文的关键函数
void IDF::caculateIDF(std::vector<BasicBlock *> &IDFBlocks) {
  caculateDTlevel(&m_dom.GetNode(0));

  using NodePair = std::pair<dominance::Node *, int>;
  using NodeContainer = std::vector<NodePair>;

  std::function<bool(const NodePair &a1, const NodePair &a2)> Comp;
  
  std::priority_queue<NodePair, NodeContainer, decltype(Comp)> que(
      [](const NodePair &a1, const NodePair &a2) -> bool {
        return a1.second < a2.second;
      });//装入处理好的DefinBlock
  
  for(BasicBlock* bb:*DefineBlock){
      auto DomNode=m_dom.GetNode(bb->dfs);
      que.push(std::make_pair(&DomNode,Level[&DomNode]));                                         
  }//装入初始Nα集合

  //工作表创建
  std::vector<dominance::Node*> Worklists;
  std::set<dominance::Node*> VisitedWorklists;
  std::set<dominance::Node*> VisitedQue;

  while(!que.empty()){
    NodePair Pair=que.top();
    que.pop();
    dominance::Node* nod=Pair.first;
    int lev=Pair.second;

    Worklists.clear();//initial clear
    Worklists.push_back(nod);
    VisitedWorklists.insert(nod);

    while(!Worklists.empty()){
      auto root=Worklists.back();
      Worklists.pop_back();
      VisitedQue.insert(root);
      
      
      
    }
  }
}
//计算Dt上的Level
/// @fix
void IDF::caculateDTlevel(dominance::Node *node) {
  // dominance::Node& root=m_dom.GetNode(0);
  worklists.push(node);
  Level[node] = worklists.size() - 1;
  for (int i : node->idom_child) {
    if (!WorklistVisited[&m_dom.node[i]]) {
      caculateDTlevel(&m_dom.node[i]);
    }
  }
}