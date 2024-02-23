#include "GVN&GCM.hpp"

void Gvn_Gcm::init_pass() {
  BasicBlock *Entry = m_func->front_block();
  caculateRPO(Entry);
  /*start to Gvn*/
  GVN();
}

/*hashing the instructions and do some basic optimizations*/
void Gvn_Gcm::GVN() {
  for (BasicBlock *BB : RPO) {
    For_inst_In(BB) {
      if (BinaryInst *Bin = dynamic_cast<BinaryInst *>(inst)) {
        auto &uselist = Bin->Getuselist();
        Value *LVal = uselist[0]->usee;
        Value *RVal = uselist[1]->usee;
        auto type = Bin->GetTypeEnum();
        /*both Lval/Rval are const*/
        if (LVal->isConst() && RVal->isConst()) {
          if (type == InnerDataType::IR_Value_INT)
            int res=OptConstBinary_INT(Bin->getopration(), LVal, RVal);
        }
      }
    }
  }
}

/*
确保传入的value都是const类型，然后进行常数折叠
*/
int Gvn_Gcm::OptConstBinary_INT(int op, Value *a, Value *b) {
  assert(a->isConst() && b->isConst());
  if(dynamic_cast<cons>)
  // switch(op){
  //   case BinaryInst::Op_Add:
  //   case BinaryInst::Op_Div:
  //   case BinaryInst::Op_G:

  // }
}

void Gvn_Gcm::caculateRPO(BasicBlock *bb) {
  if (visited.insert(bb).second) {
    auto &node = m_dom->GetNode(bb->num);
    for (auto child : node.des) {
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