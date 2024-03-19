#pragma once
#include "ConstantFold.hpp"
#include "ConstantProp.hpp"
#include "IDF.hpp"
#include "LivenessAnalysis.hpp"
#include "PromoteMemtoRegister.hpp"
#include "SSAPRE.hpp"
#include "dominant.hpp"
#include "DCE.hpp"
#include "ADCE.hpp"
#include "passManagerBase.hpp"
#include "../../yacc/parser.hpp"
#include "LoopInfo.hpp"
class PassManager:public PassManagerBase {
public:
  PassManager()=default;

  void IncludePass(int pass);
  void InitPass();
  void RunOnFunction();
  void Anlaysis();
  void PrintPass(){};
  void setAnalsis(bool choi){
    Analysis=choi;
  }
private:
  bool Analysis=false; 
  std::vector<int> InitpassRecorder{50};
  std::vector<Function*> FList;
  std::unique_ptr<LoopInfo> m_loopAnlay;
  std::unique_ptr<dominance> m_dom;
  std::unique_ptr<PRE> m_pre;
  std::unique_ptr<ConstantProp> m_constprop;
  std::unique_ptr<LivenessAnalysis> m_liveness;

};