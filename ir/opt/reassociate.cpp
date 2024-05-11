#include"reassociate.hpp"
#include "CFG.hpp"


void Reassociate::RunOnFunction(){
    //first should caculate RPO
    BasicBlock* EntryBB=m_func->front();
    PostOrderCFG(EntryBB);
    //phase 1: build the rank map
    BuildRankMap();
}

void Reassociate::BuildRankMap(){
    int rank=2;
    for(auto &param:m_func->GetParams()){
        ValueRank[param.get()]=rank++;
    }
}

void Reassociate::OptimizeInst(Value* I){
  if(!dynamic_cast<BinaryInst*>(I))
    return;
}

void Reassociate::PostOrderCFG(BasicBlock *root) {
  if (root->visited) return;
  root->visited = true;
  for (int tmp : m_dom->GetNode(root->num).des) {
    PostOrderCFG(m_dom->GetNode(tmp).thisBlock);
  }
  PostOrder.push_back(root);
}