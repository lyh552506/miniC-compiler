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
        } else {
          if (auto val = Special_Opt(Bin->getopration(), LVal, RVal)) {
            Bin->RAUW(val);
            Bin->ClearRelation();
            Bin->EraseFromParent();
          } else {
            auto rpl = Find_Equal(Bin);
            if(rpl==Bin)
              continue;
            Bin->RAUW(rpl);
            Bin->ClearRelation();
            Bin->EraseFromParent();
          }
        }
      } else if (SITFP *sitfp = dynamic_cast<SITFP *>(inst)) {
        if (auto res = dynamic_cast<ConstIRInt *>(
                sitfp->Getuselist()[0]->GetValue())) {
          int x = res->GetVal();
          float val = (float)x;
          auto rpl = ConstIRFloat::GetNewConstant(val);
          sitfp->RAUW(rpl);
          sitfp->ClearRelation();
          sitfp->EraseFromParent();
        }
      } else if (FPTSI *fptsi = dynamic_cast<FPTSI *>(inst)) {
        if (auto res = dynamic_cast<ConstIRFloat *>(
                fptsi->Getuselist()[0]->GetValue())) {
          float x = res->GetVal();
          int val = (float)x;
          auto rpl = ConstIRInt::GetNewConstant(val);
          fptsi->RAUW(rpl);
          fptsi->ClearRelation();
          fptsi->EraseFromParent();
        }
      }
    }
  }
}

/*
确保传入的value都是const类型，然后进行常数折叠
*/
int Gvn_Gcm::OptConstBinary_INT(BinaryInst::Operation op, Value *a, Value *b) {
  assert(a->isConst() && b->isConst());
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

float Gvn_Gcm::OptConstBinary_Float(BinaryInst::Operation op, Value *a, Value *b) {
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
Value *Gvn_Gcm::Special_Opt(BinaryInst::Operation op, Value *a, Value *b) {
  auto Lval_int = dynamic_cast<ConstIRInt *>(a);
  auto Rval_int = dynamic_cast<ConstIRInt *>(b);
  auto Lval_float = dynamic_cast<ConstIRFloat *>(a);
  auto Rval_float = dynamic_cast<ConstIRFloat *>(b);
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
  } else if (Lval_float || Rval_float) {
    switch (op) {
    /// Add or Sub 0
    case BinaryInst::Op_Add:
    case BinaryInst::Op_Sub:
      if (Lval_float != nullptr)
        return Lval_float->GetVal() == 0 ? Rval_float : nullptr;
      else
        return Rval_float->GetVal() == 0 ? Lval_float : nullptr;
    /// mul 0 or mul 1
    case BinaryInst::Op_Mul:
      if (Lval_float != nullptr) {
        if (Lval_float->GetVal() == 0)
          return ConstIRFloat::GetNewConstant(0);
        else if (Lval_float->GetVal() == 1)
          return Rval_float;
      } else {
        if (Rval_float->GetVal() == 0)
          return ConstIRFloat::GetNewConstant(0);
        else if (Rval_float->GetVal() == 1)
          return Lval_float;
      }
    /// div 1
    case BinaryInst::Op_Div:
      if (Rval_float != nullptr)
        if (Rval_float->GetVal() == 1)
          return Lval_float;
      break;
    /// mod 1
    case BinaryInst::Op_Mod:
      if (Rval_float != nullptr)
        if (Rval_float->GetVal() == 1)
          return ConstIRFloat::GetNewConstant(0);
      break;
    /// AND 0 or AND 1
    case BinaryInst::Op_And:
      if (Lval_float != nullptr) {
        if (Lval_float->GetVal() == 1)
          return Rval_float;
        else if (Lval_float->GetVal() == 0)
          return ConstIRFloat::GetNewConstant(0);
      } else {
        if (Rval_float->GetVal() == 1)
          return Lval_float;
        else if (Rval_float->GetVal() == 0)
          return ConstIRFloat::GetNewConstant(0);
      }
    /// OR 1 or OR 0
    case BinaryInst::Op_Or:
      if (Lval_float != nullptr) {
        if (Lval_float->GetVal() == 1)
          return ConstIRFloat::GetNewConstant(1);
        else if (Lval_float->GetVal() == 0)
          return Rval_float;
      } else {
        if (Rval_float->GetVal() == 1)
          return ConstIRFloat::GetNewConstant(1);
        else if (Rval_float->GetVal() == 0)
          return Lval_float;
      }
    }
  }
  return nullptr;
}

Value *Gvn_Gcm::Find_Equal(Value *inst) {
  //首先直接查找指针看是否有直接等价的
  auto it = std::find_if(ValueNumer.begin(), ValueNumer.end(),
                         [inst](std::pair<Value *, Value *> k) -> bool {
                           return k.first == inst;
                         });
  if (it != ValueNumer.end())
    return it->second;

  //此时在VN中查找不到，但仍然不能否定没有等价
  int size = ValueNumer.size();
  ValueNumer.emplace_back(inst, inst);
  if (auto tmp = dynamic_cast<BinaryInst *>(inst))
    ValueNumer[size].second = Find_Equal(tmp);
  return ValueNumer[size].second;
}

Value *Gvn_Gcm::Find_Equal(BinaryInst *inst) {
  auto op1 = inst->getopration();
  Value *l = inst->Getuselist()[0]->GetValue(),
        *r = inst->Getuselist()[1]->GetValue();
  Value *l1 = Find_Equal(l), *r1 = Find_Equal(r);

  for (int i = 0; i < ValueNumer.size(); i++) {
    auto [v1, v2] = ValueNumer[i];
    auto bin = dynamic_cast<BinaryInst *>(v1);
    if (bin && bin != inst) {
      auto op2 = bin->getopration();
      Value *l2 = Find_Equal(bin->Getuselist()[0]->GetValue()),
            *r2 = Find_Equal(bin->Getuselist()[1]->GetValue());
      //a+b 和 b+a等价
      bool same1 =
          (op1 == op2 && ((l1 == l2 && r1 == r2) || (l1 == r2 && r1 == l2)) &&
           (op1 == BinaryInst::Op_Add || op1 == BinaryInst::Op_And ||
            op1 == BinaryInst::Op_E || op1 == BinaryInst::Op_NE ||
            op1 == BinaryInst::Op_Mul || op1 == BinaryInst::Op_Or));
      // a+b 和 a+b等价
      bool same2 = (op1 == op2 && l1 == l2 && r1 == r2);
      // a>b 和 b<a等价
      bool same3 = (l1 == r2 && r1 == l2 &&
                    ((op1 == BinaryInst::Op_G && op2 == BinaryInst::Op_L) ||
                     op1 == BinaryInst::Op_LE && op2 == BinaryInst::Op_GE));
      if(same1||same2||same3)
        return v2;
    }
  }
  return inst;
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