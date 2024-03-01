#include "GVN&GCM.hpp"

void Gvn_Gcm::init_pass() {
  BasicBlock *Entry = *(m_func->begin());
  caculateRPO(Entry);
  std::reverse(RPO.begin(), RPO.end());
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
        auto tmp1 = dynamic_cast<UndefValue *>(LVal),
             tmp2 = dynamic_cast<UndefValue *>(RVal);
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
          } else if (tmp1 || tmp2) {
            Bin->RAUW(UndefValue::get(LVal->GetType()));
            Bin->ClearRelation();
            Bin->EraseFromParent();
          } else {
            auto rpl = Find_Equal(
                dynamic_cast<Value *>(Bin)); //对于分支情况需要后续的gcm
            if (rpl == Bin)
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
      } else if (PhiInst *phi = dynamic_cast<PhiInst *>(inst)) {
        auto rpl = SimplifyPhiInst(phi);
        if (rpl != nullptr && phi->Getuselist().empty()) {
          phi->RAUW(rpl);
          phi->ClearRelation();
          phi->EraseFromParent();
        }
      } else if (GetElementPtrInst *gep =
                     dynamic_cast<GetElementPtrInst *>(inst)) {
        auto rpl = Find_Equal(dynamic_cast<Value *>(gep));
        if (rpl == gep)
          continue;
        gep->RAUW(rpl);
        gep->ClearRelation();
        gep->EraseFromParent();
      } else if (CallInst *call = dynamic_cast<CallInst *>(inst)) {
        Function *func =
            dynamic_cast<Function *>(call->Getuselist()[0]->GetValue());
        // assert(func);
        if (func == nullptr)
          continue;
        if (HaveSideEffect(func))
          continue;
        //没有副作用
        auto rpl = Find_Equal(dynamic_cast<Value *>(call));
        if (rpl == call)
          continue;
        call->RAUW(rpl);
        call->ClearRelation();
        call->EraseFromParent();
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

float Gvn_Gcm::OptConstBinary_Float(BinaryInst::Operation op, Value *a,
                                    Value *b) {
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
    ValueNumer[size].second = SimplifyBinaryInst(tmp);
  if (auto tmp = dynamic_cast<CallInst *>(inst))
    ValueNumer[size].second = SimplifyCall(tmp);
  if (auto tmp = dynamic_cast<GetElementPtrInst *>(inst))
    ValueNumer[size].second = SimplifyGEPInst(tmp);
  return ValueNumer[size].second;
}

Value *Gvn_Gcm::SimplifyBinaryInst(BinaryInst *inst) {
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
      // a+b 和 b+a等价
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
      if (same1 || same2 || same3)
        return v2;
    }
  }
  return inst;
}

//已经确保了传入进来的callinst一定没有副作用
Value *Gvn_Gcm::SimplifyCall(CallInst *inst) {
  for (int i = 0; i < ValueNumer.size(); i++) {
    auto [v1, v2] = ValueNumer[i];
    auto call = dynamic_cast<CallInst *>(v1);
    if (call && call != inst) {
      //跳转函数地址
      bool same = (call->Getuselist()[0]->GetValue() ==
                   inst->Getuselist()[0]->GetValue());
      //函数参数个数
      same = same && (inst->Getuselist().size() == call->Getuselist().size());
      if (!same)
        return inst;
      for (int i = 1; i < inst->Getuselist().size(); i++)
        same = same && (call->Getuselist()[i]->GetValue() ==
                        inst->Getuselist()[i]->GetValue());
      if (same)
        return call;
    }
  }
  return inst;
}

Value *Gvn_Gcm::SimplifyGEPInst(GetElementPtrInst *inst) {
  for (int i = 0; i < ValueNumer.size(); i++) {
    auto [v1, v2] = ValueNumer[i];
    auto gep = dynamic_cast<GetElementPtrInst *>(v1);
    if (gep && gep != inst) {
      bool same = inst->Getuselist().size() == gep->Getuselist().size();
      if (!same)
        return inst;
      for (int i = 1; i < inst->Getuselist().size(); i++)
        same = same && (gep->Getuselist()[i]->GetValue() ==
                        inst->Getuselist()[i]->GetValue());
      if (same)
        return gep;
    }
  }
  return inst;
}

Value *Gvn_Gcm::SimplifyPhiInst(PhiInst *inst) {
  HasUndefVal = false;
  Value *sameval = nullptr;
  BasicBlock *base = nullptr;
  auto phival = inst->GetAllPhiVal();
  for (int i = 0; i < phival.size(); i++) {
    Value *income = phival[i];
    base = inst->Blocks[i];
    // incoming值是phi本身，可以跳过
    if (income == inst)
      continue;
    if (dynamic_cast<UndefValue *>(income)) {
      HasUndefVal = true;
      continue;
    }
    if (sameval && income != sameval)
      return nullptr; //不能优化
    sameval = income;
  }
  //如果phi的所有incoming除了自己全是undef，那么化简为undef
  if (!sameval)
    return UndefValue::get(inst->GetType());
  //对形如phi(X,X,undef)的phiinst，
  if (HasUndefVal) {
    // args and const always dominate inst
    if (auto tmp = dynamic_cast<User *>(sameval))
      return m_dom->dominates(base, inst->GetParent()) ? sameval : nullptr;
    else
      return sameval;
  }
  //剩下的情况就是phi(X,X)
  return sameval;
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

//判断callinst的函数是否含有副作用，没有副作用可以进行优化
bool Gvn_Gcm::HaveSideEffect(Function *func) {
  auto &params = func->GetParams();
  for (auto &param : params) {
    if (param->GetTypeEnum() == InnerDataType::IR_PTR)
      return true;
  }
  for (auto it = func->begin(); it != func->end(); ++it) {
    BasicBlock *bb = *it;
    for (auto iter = bb->begin(); iter != bb->end(); ++iter) {
      User *inst = *iter;
      //如果在函数内又有call，此时含有副作用
      if (auto tmp = dynamic_cast<CallInst *>(inst))
        return true;
      //遍历每条指令的use关系，如果存在global value，此时含有副作用
      auto &vec = inst->Getuselist();
      for (auto &_val : vec)
        if (_val->GetValue()->isGlobVal()) // TODO isGlobVal() to be added
          return true;
    }
  }
  return false;
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