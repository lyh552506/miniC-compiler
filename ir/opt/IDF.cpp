#include "../../include/ir/opt/IDF.hpp"

void IDF::SetDefBB(std::set<BasicBlock *> &DefBlock) { DefineBlock = &DefBlock; }

void IDF::SetLiveInBlock(std::set<BasicBlock *> &LiveInBlock) {
  LiveInBlocks = &LiveInBlock;
  uselivein = true;
}

void IDF::SetBBs(std::vector<BasicBlock*> &bbs) {
  this->bbs = &bbs;
}


void IDF::caculateIDF(std::vector<BasicBlock *> &IDFBlocks) {
  caculateDTlevel(&m_dom.GetNode(0), 0);

  std::function<bool(const NodePair &a1, const NodePair &a2)> Comp;

  std::priority_queue<NodePair, NodeContainer, decltype(Comp)> que(
      [](const NodePair &a1, const NodePair &a2) -> bool {
        return a1.second < a2.second;
      }); //装入处理好的DefinBlock

  for (BasicBlock *bb : *DefineBlock) {
    DTNode DomNode = &m_dom.GetNode(bb->num);
    que.push(std::make_pair(DomNode, Level[DomNode]));
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
        BasicBlock *succ = (*bbs)[succIndex];
        DTNode succNode = &m_dom.node[succIndex]; //方便找到J-Edge

        DTNode temp = &m_dom.node[succNode->idom];
        if (temp == root) //判断J-Edge
          continue;

        int SuccLevel = Level[succNode];
        if (SuccLevel > RootLevel) // ----------->key of paper
          continue;

        if (!VisitedQue.insert(succNode).second) //标记inPhi
          continue;

        if (uselivein && LiveInBlocks->find(succ) == LiveInBlocks->end())//不在live集合
          continue;

        IDFBlocks.push_back(succ);
        if (DefineBlock->find(succ) == DefineBlock->end())
          que.push(std::make_pair(succNode, SuccLevel));
      }

      for (auto Domchild : root->idom_child) {
        DTNode DC = &m_dom.node[Domchild];
        if (VisitedWorklists.insert(DC).second)
          Worklists.push_back(DC);
      }
    }
  }
}
//计算Dt上的Level
void IDF::caculateDTlevel(DTNode node, int depth) {
  Level[node] = depth;
  for (int i : node->idom_child) {
    DTNode child = &m_dom.GetNode(i);

    if (Level.find(child) == Level.end())
      caculateDTlevel(child, depth + 1);
  }
}