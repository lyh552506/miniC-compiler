#include"reassociate.hpp"


void Reassociate::RunOnFunction(){
    //phase 1: build the rank map
    BuildRankMap();
}

void Reassociate::BuildRankMap(){
    int rank=2;
    for(auto &param:m_func->GetParams()){
        ValueRank[param.get()]=rank++;
    }
}

void Reassociate::PostOrderCFG(BasicBlock *root) {
  if (root->visited) return;
  root->visited = true;
  for (int tmp : m_dom->GetNode(root->num).des) {
    PostOrderCFG(m_dom->GetNode(tmp).thisBlock);
  }
  PostOrder.push_back(root);
}