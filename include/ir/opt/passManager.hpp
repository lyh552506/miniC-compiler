#pragma once
#include <memory>
#include "../../yacc/parser.hpp"
#include "../Analysis/DealCriticalEdges.hpp"
#include "ADCE.hpp"
#include "CFG.hpp"
#include "ConstantFold.hpp"
#include "ConstantProp.hpp"
#include "DCE.hpp"
#include "IDF.hpp"
#include "LoopInfo.hpp"
#include "PassManagerBase.hpp"
#include "PromoteMemtoRegister.hpp"
#include "SSAPRE.hpp"
#include "dominant.hpp"
#include "cfgSimplify.hpp"
#include "Inline.hpp"
class PassManager : public PassManagerBase {
public:
  PassManager() : InitpassRecorder(50) {
  }
  void PreWork(int i);
  void IncludePass(int pass);
  void InitPass();
  void RunOnFunction();
  //void Anlaysis();
  void PrintPass(){};
  void setAnalsis(bool choi) { Analysis = choi; }
  ~PassManager() {

  }

private:
  bool Analysis = false;
  int func=0;
  std::vector<int> InitpassRecorder;
  std::vector<Function *> FList;
  std::vector<BasicBlock *> BList;
  Function *m_func;
  std::unique_ptr<LoopAnalysis> m_loopAnlay;
  std::unique_ptr<dominance> m_dom;
  std::unique_ptr<PRE> m_pre;
  std::unique_ptr<ConstantProp> m_constprop;
  std::unique_ptr<ADCE> m_adce;
  std::unique_ptr<DCE> m_dce;
  std::unique_ptr<ElimitCriticalEdge> m_eliedg;
  std::unique_ptr<cfgSimplify> m_cfgsimple;
  std::unique_ptr<Inliner> m_inline;
};