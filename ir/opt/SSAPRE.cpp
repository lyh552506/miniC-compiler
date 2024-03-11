#include "SSAPRE.hpp"

void PRE::init_pass() {
  // BuildSets();

  //
  // Insert();

  // Eliminate();
}

//论文的第一步：构建AnticOut/AnticIn/AvailIn/AvailOut
void PRE::BuildSets() {}

void PRE::DfsDT(int pos) {
  for (auto des : m_dom->node[pos].idom_child)
    if (m_dom->node[des].thisBlock->visited == false){
      m_dom->node[des].thisBlock->visited=true;
      DfsDT(des);
    }
  Dfs.emplace_back(m_dom->node[pos].thisBlock);
}