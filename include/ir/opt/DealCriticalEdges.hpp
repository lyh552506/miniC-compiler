#pragma once
#include "../yacc/parser.hpp"
#include "CFG.hpp"
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"
#include "dominant.hpp"
#include "my_stl.hpp"

// this pass is belongs to Analysis
class ElimitCriticalEdge
    : public _PassManagerBase<ElimitCriticalEdge, Function> {
public:
  void DealCriticalEdges();
  void AddNullBlock(User *inst, int succ);
  ElimitCriticalEdge(Function *func, _AnalysisManager &_AM)
      : m_func(func), AM(_AM) {}
  void Run();
  void PrintPass();

private:
  Function *m_func;
  _AnalysisManager &AM;
};
