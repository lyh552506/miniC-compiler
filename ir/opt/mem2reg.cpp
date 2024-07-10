#include "CFG.hpp"
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"
#include "PromoteMemtoRegister.hpp"
#include "dominant.hpp"

/// @note 支配树的根节点通过entryblock返回
// mem2reg的开始函数
class Mem2reg: public _PassManagerBase<Mem2reg,Function> {
public:
  bool Run() {
    auto dom = AM.get<dominance>(func);
    return promoteMemoryToRegister(*func, *dom);
  }
  Mem2reg(Function *func_, _AnalysisManager &AM) : func(func_), AM(AM) {}
private:
  Function *func;
  _AnalysisManager &AM;
  bool promoteMemoryToRegister(Function &func, dominance &dom);
};

bool promoteMemoryToRegister(Function &func, dominance &dom) {
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
  PromoteMem2Reg(dom, Allocas, func).run();
  return false;
}