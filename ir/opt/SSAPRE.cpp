#include "SSAPRE.hpp"

void PRE::init_pass() {
  //首先进行gvn，标注等价的表达式
  gvn_walk();
}

void PRE::gvn_walk() {
  BasicBlock *Entry = *(m_func->begin());
  caculateRPO(Entry);
  std::reverse(RPO.begin(), RPO.end());
  for (BasicBlock *BB : RPO) {
    For_inst_In(BB) {
      if (BinaryInst *Bin = dynamic_cast<BinaryInst *>(inst))
        Find_Equal(inst);
    }
  }
}

void PRE::caculateRPO(BasicBlock *bb) {
  if (visited.insert(bb).second) {
    auto &node = m_dom->GetNode(bb->num);
    for (auto child : node.des) {
      caculateRPO(m_dom->GetNode(child).thisBlock);
    }
    RPO.push_back(bb);
  }
}

Value *PRE::Find_Equal(Value *val) {
  auto iter = std::find_if(
      ValueNumber.begin(), ValueNumber.end(),
      [val](std::pair<Value *, Value *> &ele) { return ele.first == val; });
  if (iter != ValueNumber.end())
    return iter->second;

  int size = ValueNumber.size();
  ValueNumber.emplace_back(val, val);
  if (auto bin = dynamic_cast<BinaryInst *>(val))
    ValueNumber[size].second = Find_Equal(bin);

  return ValueNumber[size].second;
}

Value *PRE::Find_Equal(BinaryInst *inst) {
  auto op1 = inst->getopration();
  Value *l = inst->Getuselist()[0]->GetValue(),
        *r = inst->Getuselist()[1]->GetValue();
  Value *l1 = Find_Equal(l), *r1 = Find_Equal(r);

  for (int i = 0; i < ValueNumber.size(); i++) {
    auto [v1, v2] = ValueNumber[i];
    auto bin = dynamic_cast<BinaryInst *>(v1);
    if (bin && bin != inst) {
      int kind = bin->BelongsToExp;
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
      if (same1 || same2 || same3) {
        E_occurance[kind].push_back(inst);
        return v2;
      }
    }
  }
  //没有找到相同的表达式，则把他加入到E_occurance
  E_occurance[exp_nums++].push_back(inst);
  return inst;
}