#include "../../include/ir/opt/reassociate.hpp"
#include "../../include/ir/opt/ConstantFold.hpp"
#include <algorithm>
#include <cassert>
#include <iostream>
#include <ostream>
#include <utility>
#include <vector>

bool Reassociate::Run() {
  // first should caculate RPO
  bool changed = false;
  BasicBlock *EntryBB = m_func->front();
  m_func->init_visited_block();
  auto m_dom = AM.get<dominance>(m_func);
  PostOrderCFG(EntryBB, m_dom);
  std::reverse(RPO.begin(), RPO.end());
  BuildRankMap();
  // phase 1: build the rank map
  for (auto bb : *m_func) {
    for (User *I : *bb)
      changed |= OptimizeInst(I);
  }
  if (!changed)
    return false;
  std::vector<User *> Kill{RedoInst.begin(), RedoInst.end()};
  while (!Kill.empty()) {
    auto val = PopBack(Kill);
    KillDeadInstTrival(val, Kill);
  }
  while (!RedoInst.empty()) {
    auto tar = PopBack(RedoInst);
    if (KillDeadInst(tar, RedoInst)) {
      continue;
    } else
      OptimizeInst(tar);
  }
  return changed;
}

void Reassociate::BuildRankMap() {
  int rank = 2;
  for (auto &param : m_func->GetParams()) {
    ValueRank[param.get()] = rank++;
  }
  for (auto bb : RPO) {
    for (auto inst : *bb) {
      if (dynamic_cast<PhiInst *>(inst) || dynamic_cast<CallInst *>(inst) ||
          dynamic_cast<LoadInst *>(inst) || dynamic_cast<StoreInst *>(inst) ||
          dynamic_cast<RetInst *>(inst))
        ValueRank[inst] = 99999;
    }
  }
}
int Reassociate::GetRank(Value *val) {
  if (!dynamic_cast<User *>(val)) {
    auto it =
        std::find_if(m_func->GetParams().begin(), m_func->GetParams().end(),
                     [val](const auto &ele) { return ele.get() == val; });
    // for (auto &x : m_func->GetParams()) {
    //   if (x.get() == val)
    //     return ValueRank[val];
    // }
    if (it != m_func->GetParams().end())
      return ValueRank[val];
    else //对于global和常量
      return 0;
  }
  if (ValueRank.find(val) != ValueRank.end())
    return ValueRank[val];
  //对于一个新的val，需要为它获取到一个rank
  int ra = 0;
  User *inst = dynamic_cast<User *>(val);
  for (auto &u : inst->Getuselist()) {
    if (ra > 10000)
      break;
    ra = std::max(ra, GetRank(u->GetValue()));
  }
  // assert(ra != 0 && "Rank cant be 0");
  ValueRank[val] = ++ra;
  return ra;
}

bool Reassociate::OptimizeInst(Value *I) {
  auto bin = dynamic_cast<BinaryInst *>(I);
  if (!bin || bin->IsCmpInst()||bin->IsAtomic())
    return false;
  //如果是可交换（可重组）指令，尝试将含有const的操作数移动到右边
  if (IsCommutative(bin->getopration()))
    FormalBinaryInst(bin);
  else
    return false;
  // Float的代码重组有丢失精度的风险，暂时不对其进行处理
  if (IsBinaryFloatType(bin))
    return false;

  if (bin->GetUserlist().GetSize() == 1) {
    if (auto bin_user =
            dynamic_cast<BinaryInst *>(bin->GetUserlist().Front()->GetUser())) {
      if (bin->GetOperation() == bin_user->GetOperation()) {
        PushVecSingleVal(RedoInst, dynamic_cast<User *>(bin_user));
        return false;
      }
    }
  }
  return ReassciateExp(bin);
}

bool Reassociate::ReassciateExp(BinaryInst *I) {
  std::vector<std::pair<Value *, int>> Leaf;
  std::vector<std::pair<Value *, int>> ValueToRank;
  //对表达式进行线性化分解
  LinearizeExp(I, Leaf);
  for (auto &[val, times] : Leaf)
    for (int i = 0; i < times; i++)
      ValueToRank.push_back({val, GetRank(val)});
  int Size = ValueToRank.size();
  _DEBUG(std::cerr << "Linear set befor reassociate ";
         std::for_each(ValueToRank.begin(), ValueToRank.end(),
                       [](std::pair<Value *, int> &ele) {
                         std::cerr << "[" << ele.first->GetName() << " , "
                                   << ele.second << " ]";
                       });
         std::cerr << std::endl;)
  std::stable_sort(
      ValueToRank.begin(), ValueToRank.end(),
      [](const auto &v1, const auto &v2) { return v1.second > v2.second; });
  if (Value *new_val = OptExp(I, ValueToRank)) {
    if (new_val != I) {
      I->RAUW(new_val);
      PushVecSingleVal(RedoInst, dynamic_cast<User *>(I));
      return true;
    }
    return false;
  }
  std::stable_sort(
      ValueToRank.begin(), ValueToRank.end(),
      [](const auto &v1, const auto &v2) { return v1.second > v2.second; });
  _DEBUG(std::cerr << "Linear set after reassociate ";
         std::for_each(ValueToRank.begin(), ValueToRank.end(),
                       [](std::pair<Value *, int> &ele) {
                         std::cerr << "[" << ele.first->GetName() << " , "
                                   << ele.second << " ]";
                       });
         std::cerr << std::endl;)
  if (ValueToRank.size() == 1) {
    if (ValueToRank[0].first == I)
      return false;
    I->RAUW(ValueToRank[0].first);
    PushVecSingleVal(RedoInst, dynamic_cast<User *>(I));
    return true;
  }
  if (Size == ValueToRank.size())
    return false;
  return ReWriteExp(I, ValueToRank);
}

bool Reassociate::ReWriteExp(
    BinaryInst *exp, std::vector<std::pair<Value *, int>> &LinerizedOp) {
  std::set<Value *> NotWritable;
  std::vector<Value *> ReWrite;
  BinaryInst *curr = exp;
  User *Changed = nullptr;
  std::for_each(LinerizedOp.begin(), LinerizedOp.end(),
                [&](auto &ele) { NotWritable.insert(ele.first); });
  _DEBUG(std::cerr << "Begin To Rewrite: " << exp->GetName() << std::endl;)
  for (int i = 0; i < LinerizedOp.size(); i++) {
    if (i + 2 == LinerizedOp.size()) {
      auto val_1 = LinerizedOp[i].first;
      auto val_2 = LinerizedOp[i + 1].first;
      auto old_val1 = GetOperand(curr, 0);
      auto old_val2 = GetOperand(curr, 1);
      if (val_1 == old_val1 && val_2 == old_val2)
        break;
      if (val_1 == old_val1 && val_2 == old_val2) {
        std::swap(curr->Getuselist()[0], curr->Getuselist()[1]);
        break;
      }
      if (val_1 != old_val1) {
        if (!NotWritable.count(old_val1) &&
            IsOperandAssociate(old_val1, curr->getopration())) {
          ReWrite.push_back(old_val1);
        }
        curr->SetOperand(0, val_1);
      }
      if (val_2 != old_val2) {
        if (!NotWritable.count(old_val2) &&
            IsOperandAssociate(old_val2, curr->getopration())) {
          ReWrite.push_back(old_val2);
        }
        curr->SetOperand(1, val_2);
      }
      Changed = curr;
      break;
    }
    auto val_1 = LinerizedOp[i].first;
    auto Old_val1 = GetOperand(curr, 1);
    if (val_1 != Old_val1) {
      if (val_1 == GetOperand(curr, 0)) {
        std::swap(curr->Getuselist()[0], curr->Getuselist()[1]);
      } else {
        if (IsOperandAssociate(Old_val1, exp->getopration()))
          ReWrite.push_back(Old_val1);
        curr->SetOperand(1, val_1);
      }
    }

    if (IsOperandAssociate(GetOperand(curr, 0), exp->getopration()) &&
        !NotWritable.count(GetOperand(curr, 0))) {
      _DEBUG(std::cerr << "Directly Have Two Rewritable Operand" << std::endl;)
      curr = dynamic_cast<BinaryInst *>(GetOperand(curr, 0));
      continue;
    }

    Value *new_val = nullptr;
    if (ReWrite.empty()) {
      assert("Why this happen??");
    } else {
      new_val = ReWrite.back();
      ReWrite.pop_back();
    }
    curr->SetOperand(0, new_val);
    curr = dynamic_cast<BinaryInst *>(new_val);
    Changed = curr;
  }
  if (Changed) {
    for (auto iter = exp->GetParent()->begin();
         iter != exp->GetParent()->end();) {
      if ((*iter) != exp) {
        ++iter;
        continue;
      }
      if (Changed == exp)
        break;
      Changed->EraseFromParent();
      iter.insert_before(Changed);
      Changed = Changed->GetUserlist().Front()->GetUser();
    }
  }
  for (auto redo : ReWrite) {
    auto tmp = dynamic_cast<User *>(redo);
    assert(tmp);
    PushVecSingleVal(RedoInst, dynamic_cast<User *>(tmp));
  }
  PushVecSingleVal(RedoInst, dynamic_cast<User *>(exp));
  return true;
}

Value *Reassociate::OptExp(BinaryInst *exp,
                           std::vector<std::pair<Value *, int>> &LinerizedOp) {
  //通过rank的方式，常数/global会排在最右边，这样更有利于优化
  ConstantData *C = nullptr;
  while (!LinerizedOp.empty() &&
         dynamic_cast<ConstantData *>(LinerizedOp.back().first)) {
    ConstantData *temp = dynamic_cast<ConstantData *>(LinerizedOp.back().first);
    LinerizedOp.pop_back();
    if (C == nullptr)
      C = temp;
    else
      C = ConstantFolding::ConstFoldBinary(exp, exp->getopration(), C, temp);
  }
  //按理说做完常量折叠后，不会出现这种情况了
  if (LinerizedOp.empty()) {
    return C;
  }
  //判断C的特殊情况,正常情况下常量折叠应该做完了
  // eg: x+0、x*0
  if (C != nullptr && !ShouldIgnoreConst(exp->getopration(), C)) {
    if (AbsorbConst(exp->getopration(), C))
      exp->RAUW(C);
    LinerizedOp.push_back(std::make_pair(C, 0));
  }
  if (LinerizedOp.size() == 1)
    return LinerizedOp[0].first;
  // if (LinerizedOp.size() == 1)
  //   exp->RAUW(LinerizedOp[0].first);
  int size = LinerizedOp.size();
  switch (exp->getopration()) {
  case BinaryInst::Op_Add: {
    auto ret = OptAdd(exp, LinerizedOp);
    if (ret != nullptr)
      return ret;
    break;
  }
  case BinaryInst::Op_Mul:
    OptMul(exp, LinerizedOp);
    break;
  default:
    break;
  }
  if (size != LinerizedOp.size())
    return OptExp(exp, LinerizedOp);
  return nullptr;
}

Value *Reassociate::OptMul(BinaryInst *MulInst,
                           std::vector<std::pair<Value *, int>> &LinerizedOp) {
  return nullptr;
}

bool Reassociate::IsOperandAssociate(Value *op, BinaryInst::Operation opcode) {
  auto bin = dynamic_cast<BinaryInst *>(op);
  if (bin && bin->getopration() == opcode && bin->GetUserListSize() == 1) {
    if (bin->Getuselist()[0]->GetValue()->GetTypeEnum() != IR_Value_Float)
      return true;
  }
  return false;
}

void Reassociate::LinearizeExp(BinaryInst *I,
                               std::vector<std::pair<Value *, int>> &Leaf) {
  std::map<Value *, int> LeafToWeight;
  std::set<Value *> Leafs;
  _DEBUG(std::cerr << "LINEAR :" << I->GetName() << std::endl;)
  std::vector<std::pair<Value *, int>> Worklist{std::make_pair(I, 1)};
  auto opcode = I->getopration();
  while (!Worklist.empty()) {
    auto &back_val = Worklist.back();
    auto target = back_val.first;
    auto Weight = back_val.second;
    Worklist.pop_back();
    for (int i = 0; i < 2; i++) {
      auto operand = GetOperand(target, i);
      _DEBUG(std::cerr << "OPERAND " << i << "  " << operand->GetName()
                       << std::endl;)
      if (IsOperandAssociate(operand, opcode)) {
        _DEBUG(std::cerr << "Find SubExp " << operand->GetName() << std::endl;)
        Worklist.push_back(std::make_pair(operand, Weight));
        continue;
      }
      //不满足第一种情况
      if (Leafs.find(operand) == Leafs.end()) {
        //找到了一个实际存在的leaf，并且之前没有添加过
        _DEBUG(std::cerr << "Find a Leaf " << operand->GetName() << std::endl;)
        Leafs.insert(operand);
        LeafToWeight[operand] = Weight;
        // }
      } else {
        //找到一个添加过的Leaf，更新他的Weight
        _DEBUG(std::cerr << "Find a Used Leaf " << operand->GetName()
                         << std::endl;)
        int &w = LeafToWeight[operand];
        w = w + Weight;
      }
    }
  }
  for (auto val : Leafs) {
    assert(LeafToWeight.find(val) != LeafToWeight.end() &&
           "no way we only have this value in one set");
    Leaf.push_back(std::make_pair(val, LeafToWeight[val]));
  }
  assert(Leaf.size() != 0);
  return;
}

void Reassociate::PostOrderCFG(BasicBlock *root, dominance *m_dom) {
  if (root->visited)
    return;
  root->visited = true;
  for (int tmp : m_dom->GetNode(root->num).des) {
    PostOrderCFG(m_dom->GetNode(tmp).thisBlock, m_dom);
  }
  RPO.push_back(root);
}

bool Reassociate::IsCommutative(BinaryInst::Operation opcode) {
  switch (opcode) {
  default:
    return false;
  case BinaryInst::Op_Add:
  case BinaryInst::Op_E:
  case BinaryInst::Op_Mul:
  case BinaryInst::Op_And:
  case BinaryInst::Op_Or:
    return true;
  }
}

void Reassociate::FormalBinaryInst(User *I) {
  auto bin = dynamic_cast<BinaryInst *>(I);
  assert(bin && "must be a binaryinst");
  auto LHS = GetOperand(bin, 0);
  auto RHS = GetOperand(bin, 1);
  auto LHSRank = GetRank(LHS);
  auto RHSRank = GetRank(RHS);
  if (dynamic_cast<ConstantData *>(RHS))
    return;
  if (dynamic_cast<ConstantData *>(LHS) || LHSRank > RHSRank) {
    std::swap(bin->Getuselist()[0], bin->Getuselist()[1]);
  }
}

bool Reassociate::ShouldIgnoreConst(BinaryInst::Operation Op,
                                    ConstantData *constdata) {
  switch (Op) {
  case BinaryInst::Op_Add:
  case BinaryInst::Op_And:
    if (auto I = dynamic_cast<ConstIRInt *>(constdata)) {
      if (I->GetVal() == 0)
        return true;
    }
    if (auto F = dynamic_cast<ConstIRFloat *>(constdata)) {
      if (F->GetVal() == 0)
        return true;
    }
    break;
  case BinaryInst::Op_Mul:
    if (auto I = dynamic_cast<ConstIRInt *>(constdata))
      if (I->GetVal() == 1)
        return true;
    if (auto F = dynamic_cast<ConstIRFloat *>(constdata))
      if (F->GetVal() == 1)
        return true;
    break;
  default:
    break;
  }
  return false;
}

bool Reassociate::AbsorbConst(BinaryInst::Operation Op,
                              ConstantData *constdata) {
  switch (Op) {
  case BinaryInst::Op_Mul:
    if (auto I = dynamic_cast<ConstIRInt *>(constdata)) {
      if (I->GetVal() == 0)
        return true;
    }
    if (auto F = dynamic_cast<ConstIRFloat *>(constdata)) {
      if (F->GetVal() == 0)
        return true;
    }
    break;
  default:
    return false;
  }
  return false;
}

bool Reassociate::IsBinaryFloatType(BinaryInst *I) {
  if (I->GetType()->GetTypeEnum() == IR_Value_Float) {
    return true;
  }
  return false;
}

Value *Reassociate::OptAdd(BinaryInst *AddInst,
                           std::vector<std::pair<Value *, int>> &LinerizedOp) {
  for (int i = 0; i < LinerizedOp.size(); i++) {
    if (i + 1 < LinerizedOp.size() && LinerizedOp[i + 1] == LinerizedOp[i]) {
      int same = 1;
      int index = i;
      Value *src = LinerizedOp[i].first;
      while (LinerizedOp[index + 1] == LinerizedOp[index]) {
        same++;
        index++;
      }
      if (same < 3)
        return nullptr;
      BinaryInst *Mul = nullptr;
      if (AddInst->Getuselist()[0]->GetValue()->GetTypeEnum() ==
          IR_Value_Float) {
        Mul = BinaryInst::CreateInst(src, BinaryInst::Op_Mul,
                                     ConstIRFloat::GetNewConstant((float)same));
      } else if (AddInst->Getuselist()[0]->GetValue()->GetTypeEnum() ==
                 IR_Value_INT) {
        Mul = BinaryInst::CreateInst(src, BinaryInst::Op_Mul,
                                     ConstIRInt::GetNewConstant(same));
      } else {
        assert(0);
      }
      LinerizedOp.emplace_back(Mul, GetRank(Mul));
      for (auto it = AddInst->GetParent()->begin();
           it != AddInst->GetParent()->end(); ++it) {
        if ((*it) != AddInst)
          continue;
        it.insert_before(Mul);
        break;
      }
      LinerizedOp.erase(LinerizedOp.begin() + i,
                        LinerizedOp.begin() + i + same);
      i--;
      PushVecSingleVal(RedoInst, dynamic_cast<User *>(Mul));
      if (LinerizedOp.size() == 0) {
        return Mul;
      }
    }
  }

  //尝试进行分配率
  int Max = 0;
  Value *Maxval = nullptr;
  std::map<Value *, int> RecordAccurance;
  for (int i = 0; i < LinerizedOp.size(); i++) {
    if (IsOperandAssociate(LinerizedOp[i].first, BinaryInst::Op_Mul)) {
      std::vector<Value *> op;
      RecursionSplitOp(LinerizedOp[i].first, op);
      std::set<Value *> visited;
      for (auto _val : op) {
        if (visited.insert(_val).second) {
          int occ = ++RecordAccurance[_val];
          if (occ > Max) {
            Max = occ;
            Maxval = _val;
          }
        }
      }
    }
  }
  if (Max > 1) {
    //获得公因式val
    bool HaveDiv = false;
    std::vector<Value *> AddOperands;
    for (int i = 0; i < LinerizedOp.size(); i++) {
      if (!IsOperandAssociate(LinerizedOp[i].first, BinaryInst::Op_Mul))
        continue;
      std::vector<std::pair<Value *, int>> Leaf;
      std::vector<std::pair<Value *, int>> divisor;
      auto bin = dynamic_cast<BinaryInst *>(LinerizedOp[i].first);
      assert(bin);
      LinearizeExp(bin, Leaf);
      for (auto &[_val, times] : Leaf) {
        for (int i = 0; i < times; i++)
          divisor.emplace_back(_val, GetRank(_val));
      }
      for (int i = 0; i < divisor.size(); i++) {
        HaveDiv = false;
        auto target = divisor[i];
        if (target.first == Maxval) {
          vec_pop(divisor, i);
          HaveDiv = true;
          break;
        }
      }
      if (!HaveDiv)
        continue;
      vec_pop(LinerizedOp, i);
      if (divisor.size() == 1) {
        AddOperands.push_back(divisor[0].first);
      } else {
        ReWriteExp(bin, divisor);
        AddOperands.push_back(bin);
      }
    }
    _DEBUG(std::cerr << "Create ADD Inst: ( ";
           std::for_each(AddOperands.begin(), AddOperands.end(),
                         [](auto ele) { std::cerr << ele->GetName() << ", "; });
           std::cerr << ")" << std::endl;)
    auto add = CreatAddExp(AddInst, AddOperands);
    auto add2mul =
        BinaryInst::CreateInst(add, BinaryInst::Op_Mul, Maxval, AddInst);
    PushVecSingleVal(RedoInst, dynamic_cast<User *>(add));
    PushVecSingleVal(RedoInst, dynamic_cast<User *>(add2mul));
    if (LinerizedOp.size() == 0)
      return add2mul;
    LinerizedOp.emplace_back(add2mul, GetRank(add2mul));
  }
  return nullptr;
}

Value *Reassociate::CreatAddExp(User *Inst, std::vector<Value *> &AddOperands) {
  if (AddOperands.size() == 1)
    return AddOperands[0];
  auto lhs = PopBack(AddOperands);
  auto rhs = CreatAddExp(Inst, AddOperands);
  return BinaryInst::CreateInst(lhs, BinaryInst::Op_Add, rhs, Inst);
}

void Reassociate::RecursionSplitOp(Value *I, std::vector<Value *> &ops) {
  if (!IsOperandAssociate(I, BinaryInst::Op_Mul)) {
    ops.push_back(I);
    return;
  }
  RecursionSplitOp(GetOperand(I, 0), ops);
  RecursionSplitOp(GetOperand(I, 1), ops);
}

bool Reassociate::KillDeadInst(User *I, int i) {
  if (I->GetUserListSize() == 0) {
    _DEBUG(std::cerr << "Killing Inst: " << I->GetName() << std::endl;)
    vec_pop(RedoInst, i);
    delete I;
    return true;
  }
  return false;
}

bool Reassociate::KillDeadInst(User *I, std::vector<User *> &kill) {
  if (I->GetUserListSize() == 0) {
    _DEBUG(std::cerr << "Killing Inst: " << I->GetName() << std::endl;)
    for (auto &op : I->Getuselist()) {
      if (auto tmp = dynamic_cast<User *>(op->GetValue()))
        PushVecSingleVal(kill, tmp);
    }
    delete I;
    return true;
  }
  return false;
}

bool Reassociate::KillDeadInstTrival(User *I, std::vector<User *> &kill) {
  if (I->GetUserListSize() == 0) {
    _DEBUG(std::cerr << "Killing Inst: " << I->GetName() << std::endl;)
    auto it = std::find(RedoInst.begin(), RedoInst.end(), I);
    auto iter = std::find(kill.begin(), kill.end(), I);
    if (it != RedoInst.end()) {
      RedoInst.erase(it);
    }
    // kill.erase(iter);
    for (auto &op : I->Getuselist()) {
      if (auto tmp = dynamic_cast<User *>(op->GetValue()))
        PushVecSingleVal(kill, tmp);
    }
    delete I;
    return true;
  }
  return false;
}