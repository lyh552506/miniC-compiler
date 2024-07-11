#include "../../include/ir/opt/PromoteMemtoRegister.hpp"
#include "../../include/ir/Analysis/dominant.hpp"
#include "../../include/ir/opt/mem2reg.hpp"

bool Mem2reg::promoteMemoryToRegister(Function &func) {
  auto dom = AM.get<dominance>(&func);
  std::vector<AllocaInst *> Allocas;
  Allocas.clear();
  auto EntryBlock = func.front();
  For_inst_In(EntryBlock) {
    if (AllocaInst *allocaInst = dynamic_cast<AllocaInst *>(inst))
      if (IsAllocaPromotable(allocaInst))
        Allocas.push_back(allocaInst);
  }

  if (Allocas.empty()) //当前没有可以promote的alloca指令
    return false;
  PromoteMem2Reg(*dom, Allocas, func).run();
  return false;
}