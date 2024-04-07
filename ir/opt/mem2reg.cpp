#include "PromoteMemtoRegister.hpp"
#include "dominant.hpp"

/// @note 支配树的根节点通过entryblock返回
// mem2reg的开始函数
bool promoteMemoryToRegister(Function &func, dominance &dom) {
  std::vector<AllocaInst *> Allocas;
  // auto& BB = func.GetBasicBlock(); // BB是一个std::vector<BasicBlockPtr>

  Allocas.clear();
  // auto& EntryBlock=BB.front();
  auto EntryBlock = func.front();
  For_inst_In(EntryBlock) {
    if (AllocaInst *allocaInst = dynamic_cast<AllocaInst *>(inst))
      if (IsAllocaPromotable(allocaInst)) Allocas.push_back(allocaInst);
  }

  if (Allocas.empty())  //当前没有可以promote的alloca指令
    return false;
  RunPromoteMem2Reg(dom, Allocas, func);
  return false;
}

/// @brief 一个wrapper，在这里创建对象
void RunPromoteMem2Reg(dominance &dom, std::vector<AllocaInst *> Allocas,
                       Function &func) {
  PromoteMem2Reg(dom, Allocas, func).run();
}
