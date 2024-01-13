#include "IDF.hpp"

void IDF::SetDefBB(std::set<BasicBlock *> DefBlock) { DefineBlock = &DefBlock; }

void IDF::SetLiveInBlock(std::set<BasicBlock *> LiveInBlock) {
  LiveInBlocks = &LiveInBlock;
  uselivein = true;
}

void IDF::SetBBs(std::vector<std::unique_ptr<BasicBlock>> &bbs) {
  this->bbs = bbs;
}

// 论文的关键函数
void IDF::caculateIDF(std::vector<BasicBlock *> &IDFBlocks) {
  caculateDTlevel(&m_dom.GetNode(0));

  std::function<bool(const NodePair &a1, const NodePair &a2)> Comp;

  std::priority_queue<NodePair, NodeContainer, decltype(Comp)> que(
      [](const NodePair &a1, const NodePair &a2) -> bool {
        return a1.second < a2.second;
      }); //装入处理好的DefinBlock

  for (BasicBlock *bb : *DefineBlock) {
    auto DomNode = m_dom.GetNode(bb->dfs);
    que.push(std::make_pair(&DomNode, Level[&DomNode]));
  } //装入初始Nα集合

  //工作表创建
  std::vector<DTNode> Worklists;
  std::set<DTNode> VisitedWorklists;
  std::set<DTNode> VisitedQue;

  while (!que.empty()) {
    NodePair Pair = que.top();
    que.pop();
    DTNode nod = Pair.first;
    int RootLevel = Pair.second;

    Worklists.clear(); // initial clear
    Worklists.push_back(nod);
    VisitedWorklists.insert(nod);

    while (!Worklists.empty()) {
      DTNode root = Worklists.back(); //获取domtree上的结点
      Worklists.pop_back();
      BasicBlock *bb = root->thisBlock; //获取对应与CFG上的结点

      for (auto succIndex : m_dom.node[bb->num].des) {
        BasicBlock *succ = bbs[succIndex].get();
        DTNode succNode = &m_dom.node[succIndex]; //方便找到J-Edge

        DTNode temp = &m_dom.node[succNode->idom];
        if (temp == root) //判断J-Edge
          continue;

        int SuccLevel = Level[succNode];
        if (SuccLevel > RootLevel) // ----------->key of paper
          continue;

        if (!VisitedQue.insert(succNode).second) //标记inPhi
          continue;

        if (uselivein && LiveInBlocks->find(succ) != LiveInBlocks->end())
          continue;

        IDFBlocks.push_back(succ);
        if (DefineBlock->find(succ) == DefineBlock->end())
          que.push(std::make_pair(succNode, SuccLevel));
      }
      
      for(auto Domchild:root->idom_child){
        DTNode DC=&m_dom.node[Domchild];
        if(VisitedWorklists.insert(DC).second)
          Worklists.push_back(DC);
      }
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