#include "reassociate.hpp"
#include "AST_NODE.hpp"
#include "BaseCFG.hpp"
#include "CFG.hpp"
#include "ConstantFold.hpp"
#include "my_stl.hpp"
#include <algorithm>
#include <cassert>
#include <iostream>
#include <ostream>
#include <utility>
#include <vector>

void Reassociate::RunOnFunction() {
  // first should caculate RPO
  BasicBlock *EntryBB = m_func->front();
  PostOrderCFG(EntryBB);
  std::reverse(RPO.begin(), RPO.end());
  BuildRankMap();
  // phase 1: build the rank map
  for (auto bb : *m_func) {
    for (User *I : *bb)
      OptimizeInst(I);
  }
}

void Reassociate::BuildRankMap() {
  int rank = 2;
  for (auto &param : m_func->GetParams()) {
    ValueRank[param.get()] = rank++;
  }
}

int Reassociate::GetRank(Value *val) {
  if (!dynamic_cast<User *>(val)) {
    auto it =
        std::find_if(m_func->GetParams().begin(), m_func->GetParams().end(),
                     [val](auto &ele) { return ele.get() == val; });
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
    ra = std::max(ra, GetRank(u->GetValue()));
  }
  assert(ra == 0 && "Rank cant be 0");
  ValueRank[val] = ra;
  return ra;
}

void Reassociate::OptimizeInst(Value *I) {
  auto bin = dynamic_cast<BinaryInst *>(I);
  if (!bin || bin->IsCmpInst())
    return;
  //如果是可交换（可重组）指令，尝试将含有const的操作数移动到右边
  if (IsCommutative(bin->getopration()))
    FormalBinaryInst(bin);

  // Float的代码重组有丢失精度的风险，暂时不对其进行处理
  if (IsBinaryFloatType(bin))
    return;
  if (bin->GetUserlist().GetSize() == 1) {
    if (auto bin_user =
            dynamic_cast<BinaryInst *>(bin->GetUserlist().Front()->GetUser())) {
      if (bin->GetOperation() == bin_user->GetOperation()) {
        RedoInst.push_back(bin);
        return;
      }
    }
  }
  ReassciateExp(bin);
}

void Reassociate::ReassciateExp(BinaryInst *I) {
  std::vector<std::pair<Value *, int>> Leaf;
  std::vector<std::pair<Value *, int>> ValueToRank;
  //对表达式进行线性化分解
  LinearizeExp(I, Leaf);
  for (auto &[val, times] : Leaf)
    for (int i = 0; i < times; i++)
      ValueToRank.push_back({val, GetRank(val)});

  std::stable_sort(
      ValueToRank.begin(), ValueToRank.end(),
      [](const auto &v1, const auto &v2) { return v1.second > v2.second; });

  _DEBUG(std::cerr << "Linear set befor reassociate ";
         std::for_each(ValueToRank.begin(), ValueToRank.end(),
                       [](std::pair<Value *, int> &ele) {
                         std::cerr << "[" << ele.first->GetName() << " , "
                                   << ele.second << " ]";
                       });
         std::cerr << std::endl;)
  if (Value *new_val = OptExp(I, ValueToRank)) {
    // TODO
  }
  _DEBUG(std::cerr << "Linear set after reassociate ";
         std::for_each(ValueToRank.begin(), ValueToRank.end(),
                       [](std::pair<Value *, int> &ele) {
                         std::cerr << "[" << ele.first->GetName() << " , "
                                   << ele.second << " ]";
                       });
         std::cerr << std::endl;)
  ReWriteExp(I, ValueToRank);
}

void Reassociate::ReWriteExp(
    BinaryInst *exp, std::vector<std::pair<Value *, int>> &LinerizedOp) {
  std::set<Value *> NotWritable;
  std::vector<Value *> ReWrite;
  BinaryInst *curr = exp;
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
      break;
    }
    auto val_1 = LinerizedOp[i].first;
    auto Old_val1 = GetOperand(curr, 0);
    if (val_1 != Old_val1) {
      if (val_1 == GetOperand(curr, 1)) {
        std::swap(curr->Getuselist()[0], curr->Getuselist()[1]);
      } else {
        if (IsOperandAssociate(Old_val1, exp->getopration()))
          ReWrite.push_back(Old_val1);
        curr->SetOperand(0, val_1);
      }
    }

    if (IsOperandAssociate(GetOperand(curr, 1), exp->getopration()) &&
        !NotWritable.count(GetOperand(curr, 1))) {
      _DEBUG(std::cerr << "Directly Have Two Rewritable Operand" << std::endl;)
      curr = dynamic_cast<BinaryInst *>(GetOperand(curr, 1));
      continue;
    }

    Value *new_val = nullptr;
    if (ReWrite.empty()) {
      assert("Why this happen??");
    } else {
      new_val = ReWrite.back();
      ReWrite.pop_back();
    }
    curr->SetOperand(1, new_val);
    curr = dynamic_cast<BinaryInst *>(new_val);
  }
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
      C = ConstantFolding::ConstFoldBinary(exp->getopration(), C, temp);
  }
  //按理说做完常量折叠后，不会出现这种情况了
  if (LinerizedOp.empty())
    exp->RAUW(C);

  //判断C的特殊情况,正常情况下常量折叠应该做完了
  // eg: x+0、x*0
  if (C != nullptr && !ShouldIgnoreConst(exp->getopration(), C)) {
    if (AbsorbConst(exp->getopration(), C))
      exp->RAUW(C);
    LinerizedOp.push_back(std::make_pair(C, 0));
  }
  if (LinerizedOp.size() == 1)
    exp->RAUW(LinerizedOp[0].first);
  int size = LinerizedOp.size();
  switch (exp->getopration()) {
  case BinaryInst::Op_Add:
    OptAdd(exp, LinerizedOp);
  case BinaryInst::Op_Mul:
    OptMul(exp, LinerizedOp);
  default:
    break;
  }
  if (size != LinerizedOp.size())
    return OptExp(exp, LinerizedOp);
  return nullptr;
}

Value *Reassociate::OptMul(BinaryInst *MulInst,
                           std::vector<std::pair<Value *, int>> &LinerizedOp) {}

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

void Reassociate::PostOrderCFG(BasicBlock *root) {
  if (root->visited)
    return;
  root->visited = true;
  for (int tmp : m_dom->GetNode(root->num).des) {
    PostOrderCFG(m_dom->GetNode(tmp).thisBlock);
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
  // TODO GetRank ，但是目前并不清楚这个对后续的作用
  if (dynamic_cast<ConstantData *>(RHS))
    return;
  if (dynamic_cast<ConstantData *>(LHS)) {
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
}

bool Reassociate::IsBinaryFloatType(BinaryInst *I) {
  if (I->GetType()->GetTypeEnum() == IR_Value_Float) {
    return true;
  }
  return false;
}

Value *Reassociate::OptAdd(BinaryInst *AddInst,
                           std::vector<std::pair<Value *, int>> &LinerizedOp) {
  // 对于X+X+X+Y，尝试优化成3*X+Y
  for (int i = 0; i < LinerizedOp.size(); i++) {
    if (i + 1 < LinerizedOp.size() && LinerizedOp[i + 1] == LinerizedOp[i]) {
      int same = 2;
      if (LinerizedOp[same] == LinerizedOp[i])
        same++;
      // TODO
    }
  }
}

void Reassociate::KillDeadInst(User* I){
  if(I->GetUserListSize()==0){}
    //TODO
}