#include "../../include/ir/Analysis/AliasAnalysis.hpp"
#include <cassert>
#include <functional>

// Gep  Load
void AliasAnalysis::run() {
  for (const auto bb : *m_func)
    for (const auto inst : *bb) {
      // Load i32 %1
      if (auto ld = dynamic_cast<LoadInst *>(inst)) {
        auto target = ld->GetOperand(0);
        auto hash = std::hash<Value *>()(target);
        hash = std::hash<int>()(Load) + hash;
        AliasTable[hash].insert(ld);
      } else if (auto gep = dynamic_cast<GetElementPtrInst *>(inst)) {
        auto hash = std::hash<int>()(Gep);
        for (int i = 0; i < gep->Getuselist().size(); i++) {
          hash += std::hash<Value *>()(gep->GetOperand(i));
        }
        AliasTable[hash].insert(gep);
      }
    }
}

size_t AliasAnalysis::GetHash(Value *val) {
  assert(dynamic_cast<GetElementPtrInst *>(val) ||
         dynamic_cast<LoadInst *>(val));
  if (auto ld = dynamic_cast<LoadInst *>(val)) {
    auto target = ld->GetOperand(0);
    auto hash = std::hash<Value *>()(target);
    hash = std::hash<int>()(Load) + hash;
    return hash;
  } else if (auto gep = dynamic_cast<GetElementPtrInst *>(val)) {
    auto hash = std::hash<int>()(Gep);
    for (int i = 0; i < gep->Getuselist().size(); i++) {
      hash += ((std::hash<Value *>()(gep->GetOperand(i)) << (i + 3)) * (i + 101));
    }
    return hash;
  }
  return 0;
}

void *AliasAnalysis::GetResult(Function *func) {
  AliasTable.clear();
  run();
  return this;
}

std::set<Value *> AliasAnalysis::FindHashVal(size_t hs) {
  if (AliasTable.find(hs) != AliasTable.end())
    return AliasTable[hs];
  return std::set<Value *>{};
}