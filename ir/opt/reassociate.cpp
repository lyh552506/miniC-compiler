#include "reassociate.hpp"
#include "BaseCFG.hpp"
#include "CFG.hpp"
#include "ConstantFold.hpp"
#include <algorithm>
#include <iostream>
#include <utility>

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

Value *Reassociate::ReassciateExp(BinaryInst *I) {
  std::vector<std::pair<Value *, int>> Leaf;
  std::vector<std::pair<Value *, int>> ValueToRank;
  //对表达式进行线性化分解
  LinearizeExp(I, Leaf);
  for (auto &[val, times] : Leaf)
    for (int i = 0; i < times; i++) {
      ValueToRank.push_back({val, GetRank(val)});
    }
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
  //通过rank的方式，常数/global会排在最右边，这样更有利于优化
  ConstantData *C = nullptr;
  while (!ValueToRank.empty() &&
         dynamic_cast<ConstantData *>(ValueToRank.back().first)) {
    ConstantData *temp = dynamic_cast<ConstantData *>(ValueToRank.back().first);
    ValueToRank.pop_back();
    if (C == nullptr)
      C = temp;
    else
      C = ConstantFolding::ConstFoldBinary(I->getopration(), C, temp);
  }
  //按理说做完常量折叠后，不会出现这种情况了
  if (ValueToRank.empty())
    return C;
  //判断C的特殊情况：
  // eg: x+0、x*0
  if (C != nullptr && !ShouldIgnoreConst(I->getopration(), C)) {
    if (AbsorbConst(I->getopration(), C))
      return C;
  }
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