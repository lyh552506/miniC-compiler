#include "reassociate.hpp"
#include "BaseCFG.hpp"
#include "CFG.hpp"
#include "my_stl.hpp"
#include <algorithm>
#include <cassert>
#include <variant>

void Reassociate::RunOnFunction() {
  // first should caculate RPO
  BasicBlock *EntryBB = m_func->front();
  PostOrderCFG(EntryBB);
  std::reverse(RPO.begin(), RPO.end());
  BuildRankMap();
  // phase 1: build the rank map
  for (auto bb : RPO) {
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
  if (dynamic_cast<BinaryInst *>(I))
    return;
  auto bin = dynamic_cast<BinaryInst *>(I);
  //如果是可交换（可重组）指令，尝试将含有const的操作数移动到右边
  if (IsCommutative(bin->getopration()))
    FormalBinaryInst(bin);
  
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
  auto LHS = GetOperand(bin, 1);
  auto RHS = GetOperand(bin, 2);
  //TODO GetRank ，但是目前并不清楚这个对后续的作用
  if (dynamic_cast<ConstantData *>(RHS))
    return;
  if(dynamic_cast<ConstantData*>(LHS)){
    std::swap(LHS,RHS);
  }
}