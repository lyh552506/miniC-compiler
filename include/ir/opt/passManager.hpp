#pragma once
#include "../../yacc/parser.hpp"
#include "../Analysis/DealCriticalEdges.hpp"
#include "ADCE.hpp"
#include "CFG.hpp"
#include "CSE_Tmp.hpp"
#include "ConstantFold.hpp"
#include "ConstantProp.hpp"
#include "DCE.hpp"
#include "Global2Local.hpp"
#include "IDF.hpp"
#include "Inline.hpp"
#include "LoopInfo.hpp"
#include "LoopSimplify.hpp"
#include "PassManagerBase.hpp"
#include "PromoteMemtoRegister.hpp"
#include "SCCP.hpp"
#include "SSAPRE.hpp"
#include "cfgSimplify.hpp"
#include "dominant.hpp"
#include "lcssa.hpp"
#include "reassociate.hpp"
#include <memory>
#include "licm.hpp"
#include "LoopRotate.hpp"
class PassManager : public PassManagerBase {
public:
  PassManager() : InitpassRecorder(50) {}
  void PreWork(int i);
  void IncludePass(int pass);
  void InitPass();
  void RunOnFunction();
  // void Anlaysis();
  void PrintPass(){};
  void setAnalsis(bool choi) { Analysis = choi; }
  ~PassManager() {}

private:
  bool Analysis = false;
  int func = 0;
  std::vector<int> InitpassRecorder;
  std::vector<Function *> FList;
  std::vector<BasicBlock *> BList;
  Function *m_func;
  std::unique_ptr<LoopAnalysis> m_loopAnlay;
  std::unique_ptr<LoopSimplify> m_loopsimple;
  std::unique_ptr<dominance> m_dom;
  std::unique_ptr<PRE> m_pre;
  std::unique_ptr<ConstantProp> m_constprop;
  std::unique_ptr<ADCE> m_adce;
  std::unique_ptr<DCE> m_dce;
  std::unique_ptr<ElimitCriticalEdge> m_eliedg;
  cfgSimplify* m_cfgsimple;
  std::unique_ptr<Inliner> m_inline;
  std::unique_ptr<Global2Local> m_g2l;
  std::unique_ptr<SCCP> m_sccp;
  std::unique_ptr<Reassociate> m_reassociate;
  std::unique_ptr<CSE> m_cse;
  std::unique_ptr<LcSSA> m_lcssa;
  //std::unique_ptr<LICMPass> m_licm;
};