#pragma once
#include "../../lib/CFG.hpp"
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"
#include "PromoteMemtoRegister.hpp"
#include "../Analysis/dominant.hpp"
class _AnalysisManager;
/// @note 支配树的根节点通过entryblock返回
// mem2reg的开始函数
class Mem2reg : public _PassManagerBase<Mem2reg, Function> {
public:
  Mem2reg(Function *func, _AnalysisManager &_AM) : m_func(func), AM(_AM) {}
  bool Run() {
    return promoteMemoryToRegister(*m_func);
  }

private:
  bool promoteMemoryToRegister(Function &func);
  Function *m_func;
  _AnalysisManager &AM;
};