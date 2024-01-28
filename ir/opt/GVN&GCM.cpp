#include "GVN&GCM.hpp"

void Gvn_Gcm::init_pass() {
  BasicBlock* Entry=m_func->front_block();
  caculateRPO(Entry);
  /*start to Gvn*/
}

void Gvn_Gcm::GVN() {}


void Gvn_Gcm::caculateRPO(BasicBlock* bb){
    if(visited.insert(bb).second){
      auto& node=m_dom->GetNode(bb->num);
      for(auto child:node.des){
        caculateRPO(m_dom->GetNode(child).thisBlock);
      }
      RPO.push_back(bb);
    }
}


void Gvn_Gcm::GCM() {}

void Gvn_Gcm::Schedule_Early(User *inst) {}

void Gvn_Gcm::Schedule_Late(User *inst) {}

bool Gvn_Gcm::IsPinned(User *inst) {
  if (dynamic_cast<PhiInst *>(inst) || dynamic_cast<CondInst *>(inst) ||
      dynamic_cast<UnCondInst *>(inst) || dynamic_cast<RetInst *>(inst))
      return true;
  return false;
}