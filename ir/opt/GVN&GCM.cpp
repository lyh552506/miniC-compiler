#include "GVN&GCM.hpp"

void Gvn_Gcm::init_pass() {
  BasicBlock *Entry = *(m_func->begin());
  caculateRPO(Entry);
  /*start to Gvn*/
  GVN();
}

/*hashing the instructions and do some basic optimizations*/
void Gvn_Gcm::GVN() {
  for (BasicBlock *BB : RPO) {
    For_inst_In(BB) {
      //如果是二元操作指令，检查是否可以进行折叠
      if (BinaryInst *Bin = dynamic_cast<BinaryInst *>(inst)) {
        auto &uselist = Bin->Getuselist();
        Value *LVal = uselist[0]->usee;
        Value *RVal = uselist[1]->usee;
        auto type = Bin->GetTypeEnum();
        /*both Lval/Rval are const*/
        if (LVal->isConst() && RVal->isConst()) {
          if (type == InnerDataType::IR_Value_INT) {
            int res = OptConstBinary_INT(Bin->getopration(), LVal, RVal);
            ConstIRInt *const_int = ConstIRInt::GetNewConstant(res);
            Bin->RAUW(const_int);
            Bin->ClearRelation();
            Bin->EraseFromParent();
          } else if (type == InnerDataType::IR_Value_Float) {
            float res = OptConstBinary_Float(Bin->getopration(), LVal, RVal);
            ConstIRFloat *const_float = ConstIRFloat::GetNewConstant(res);
            Bin->RAUW(const_float);
            Bin->ClearRelation();
            Bin->EraseFromParent();
          }
        } else{
          if(auto val=Special_Opt(Bin->getopration(),LVal,RVal)){
            Bin->RAUW(val);
            Bin->ClearRelation();
            Bin->EraseFromParent();
          }else{
            auto rpl=Find_Equal(Bin);
            Bin->RAUW(rpl);
            Bin->ClearRelation();
            Bin->EraseFromParent();
          }
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
  //右边的操作数是int类型
  if (auto L = dynamic_cast<ConstIRInt *>(a)) {
    int LVal = dynamic_cast<ConstIRInt *>(a)->GetVal();
    int RVal = dynamic_cast<ConstIRInt *>(b)->GetVal();
    switch (op) {
    case BinaryInst::Op_Add:
      return LVal + RVal;
    case BinaryInst::Op_Div:
      return LVal / RVal;
    case BinaryInst::Op_Sub:
      return LVal - RVal;
    case BinaryInst::Op_Mul:
      return LVal * RVal;
    case BinaryInst::Op_E:
      return LVal == RVal;
    case BinaryInst::Op_G:
      return LVal > RVal;
    case BinaryInst::Op_GE:
      return LVal >= RVal;
    case BinaryInst::Op_L:
      return LVal < RVal;
    case BinaryInst::Op_Mod:
      return LVal % RVal;
    case BinaryInst::Op_LE:
      return LVal <= RVal;
    case BinaryInst::Op_NE:
      return LVal != RVal;
    case BinaryInst::Op_Or:
      return LVal || RVal;
    case BinaryInst::Op_And:
      return LVal && RVal;
    default:
      assert(0);
    }
  }
}

float Gvn_Gcm::OptConstBinary_Float(int op, Value *a, Value *b) {
  if (auto L = dynamic_cast<ConstIRFloat *>(a)) {
    float LVal = dynamic_cast<ConstIRFloat *>(a)->GetVal();
    float RVal = dynamic_cast<ConstIRFloat *>(b)->GetVal();
    switch (op) {
    case BinaryInst::Op_Add:
      return (LVal + RVal);
    case BinaryInst::Op_Div:
      return (LVal / RVal);
    case BinaryInst::Op_Sub:
      return (LVal - RVal);
    case BinaryInst::Op_Mul:
      return (LVal * RVal);
    case BinaryInst::Op_E:
      return (LVal == RVal);
    case BinaryInst::Op_G:
      return (LVal > RVal);
    case BinaryInst::Op_GE:
      return (LVal >= RVal);
    case BinaryInst::Op_L:
      return (LVal < RVal);
    case BinaryInst::Op_LE:
      return (LVal <= RVal);
    case BinaryInst::Op_NE:
      return (LVal != RVal);
    case BinaryInst::Op_Or:
      return (LVal || RVal);
    case BinaryInst::Op_And:
      return (LVal && RVal);
    default:
      assert(0);
    }
  }
}

/// @brief 检查binaryinst的特殊优化(目前只考虑int)
Value *Gvn_Gcm::Special_Opt(int op, Value *a, Value *b) {
  auto Lval_int = dynamic_cast<ConstIRInt *>(a);
  auto Rval_int = dynamic_cast<ConstIRInt *>(b);
  if (Lval_int || Rval_int) {
    switch (op) {
    /// Add or Sub 0
    case BinaryInst::Op_Add:
    case BinaryInst::Op_Sub:
      if (Lval_int != nullptr)
        return Lval_int->GetVal() == 0 ? Rval_int : nullptr;
      else
        return Rval_int->GetVal() == 0 ? Lval_int : nullptr;
    /// mul 0 or mul 1
    case BinaryInst::Op_Mul:
      if (Lval_int != nullptr) {
        if (Lval_int->GetVal() == 0)
          return ConstIRInt::GetNewConstant(0);
        else if (Lval_int->GetVal() == 1)
          return Rval_int;
      } else {
        if (Rval_int->GetVal() == 0)
          return ConstIRInt::GetNewConstant(0);
        else if (Rval_int->GetVal() == 1)
          return Lval_int;
      }
    /// div 1
    case BinaryInst::Op_Div:
      if (Rval_int != nullptr)
        if (Rval_int->GetVal() == 1)
          return Lval_int;
      break;
    /// mod 1
    case BinaryInst::Op_Mod:
      if (Rval_int != nullptr)
        if (Rval_int->GetVal() == 1)
          return ConstIRInt::GetNewConstant(0);
      break;
    /// AND 0 or AND 1
    case BinaryInst::Op_And:
      if (Lval_int != nullptr) {
        if (Lval_int->GetVal() == 1)
          return Rval_int;
        else if (Lval_int->GetVal() == 0)
          return ConstIRInt::GetNewConstant(0);
      } else {
        if (Rval_int->GetVal() == 1)
          return Lval_int;
        else if (Rval_int->GetVal() == 0)
          return ConstIRInt::GetNewConstant(0);
      }
    /// OR 1 or OR 0
    case BinaryInst::Op_Or:
      if (Lval_int != nullptr) {
        if (Lval_int->GetVal() == 1)
          return ConstIRInt::GetNewConstant(1);
        else if (Lval_int->GetVal() == 0)
          return Rval_int;
      } else {
        if (Rval_int->GetVal() == 1)
          return ConstIRInt::GetNewConstant(1);
        else if (Rval_int->GetVal() == 0)
          return Lval_int;
      }
    }
  }
  return nullptr;
}

Value *Gvn_Gcm::Find_Equal(Value* inst){

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