#include "reassociate.hpp"
#include "BaseCFG.hpp"
#include "CFG.hpp"
#include "Type.hpp"
#include "my_stl.hpp"
#include <algorithm>
#include <cassert>
#include <iostream>
#include <map>
#include <ostream>
#include <set>
#include <stdexcept>
#include <utility>
#include <variant>
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

void Reassociate::OptimizeInst(Value *I) {
  if (!dynamic_cast<BinaryInst *>(I))
    return;
  auto bin = dynamic_cast<BinaryInst *>(I);
  //如果是可交换（可重组）指令，尝试将含有const的操作数移动到右边
  if (IsCommutative(bin->getopration()))
    FormalBinaryInst(bin);

  // Float的代码重组有丢失精度的风险，暂时不对其进行处理
  if (IsBinaryFloatType(bin))
    return;
  if (bin->GetUserlist().GetSize() == 1) {
    if (auto bin_user = dynamic_cast<BinaryInst *>(
            bin->GetUserlist().Front()->GetValue())) {
      if (bin->GetOperation() == bin_user->GetOperation()) {
        RedoInst.push_back(bin);
      }
    }
  }
  ReassciateExp(bin);
}

void Reassociate::ReassciateExp(BinaryInst *I) {
  std::vector<std::pair<Value *, int>> Leaf;
  //对表达式进行线性化分解
  LinearizeExp(I, Leaf);
  _DEBUG(std::cerr << "Linear set befor reassociate "
                   << std::for_each(Leaf.begin(), Leaf.end(),
                                    [](std::pair<Value *, int> &ele) {
                                      std::cerr << "[" << ele.first->GetName()
                                                << " , " << ele.second << " ]";
                                    })
                   << std::endl;)
  
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
    auto &[target, Weight] = Worklist.back();
    Worklist.pop_back();
    for (int i = 0; i < 2; i++) {
      auto operand = GetOperand(target, i);
      _DEBUG(std::cerr << "OPERAND " << i << operand->GetName() << std::endl;)
      if (IsOperandAssociate(target, opcode)) {
        _DEBUG(std::cerr << "Find SubExp " << i << operand->GetName()
                         << std::endl;)
        Worklist.push_back(std::make_pair(target, Weight));
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
    assert(LeafToWeight.find(val) == LeafToWeight.end() &&
           "no way we only have this value in one set");
    Leaf.push_back(std::make_pair(val, LeafToWeight[val]));
  }
  assert(Leaf.size() == 0);
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

bool Reassociate::IsBinaryFloatType(BinaryInst *I) {
  if (I->GetType()->GetTypeEnum() == IR_Value_Float) {
    return false;
  }
  return true;
}