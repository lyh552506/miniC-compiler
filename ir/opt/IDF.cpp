#include "IDF.hpp"

void IDF::SetDefBB(std::set<BasicBlock *> DefBlock) { DefineBlock = &DefBlock; }

void IDF::SetLiveInBlock(std::set<BasicBlock *> LiveInBlock) {
  LiveInBlocks = &LiveInBlock;
  uselivein = true;
}

// 论文的关键函数
void IDF::caculateIDF(std::vector<BasicBlock *> &PhiBlocks) {
    //caculateDTlevel();
}
//计算Dt上的Level
/// @fix 
void IDF::caculateDTlevel(dominance::Node *node) {
  // dominance::Node& root=m_dom.GetNode(0);
    worklists.push(node);
    Level[node] = worklists.size() - 1;
    for(int i:node->idom_child){
        if(!WorklistVisited[&m_dom.node[i]]){
            caculateDTlevel(&m_dom.node[i]);
        }
  }
}