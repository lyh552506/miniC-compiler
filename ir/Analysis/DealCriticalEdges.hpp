#pragma once
#include "../yacc/parser.hpp"
#include "CFG.hpp"
#include "my_stl.hpp"
#include "PassManagerBase.hpp"

// this pass is belongs to Analysis
class ElimitCriticalEdge : public PassManagerBase {
public:
  void DealCriticalEdges();
  void AddNullBlock(User *inst, int succ);
  ElimitCriticalEdge(Function *func) : m_func(func) {}
  void RunOnFunction();
  void PrintPass();

private:
  Function *m_func;
};
