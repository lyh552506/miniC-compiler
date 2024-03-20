#include "passManager.hpp"

void PassManager::InitPass() {
  for (int i = 0; i < Singleton<Module>().GetFuncTion().size(); i++) {
    auto f = Singleton<Module>().GetFuncTion()[i].get();
    auto &Li = Singleton<Module>().GetFuncTion()[i]->GetBasicBlock();
    for (auto bb = f->begin(); bb != f->end(); ++bb)
      f->push_bb(*bb);
    for (int i = 0; i < Li.size(); ++i)
      Li[i]->num = i;

    m_dom = std::make_unique<dominance>(f, Li.size());
    m_pre = std::make_unique<PRE>(m_dom.get(), f);
    m_loopAnlay = std::make_unique<LoopInfo>(f, m_dom.get());
    m_liveness = std::make_unique<LivenessAnalysis>(f);
    m_constprop = std::make_unique<ConstantProp>(f);
    m_adce = std::make_unique<ADCE>(f);
    m_eliedg=std::make_unique<ElimitCriticalEdge>(f);
    RunOnFunction();
  }
}
void PassManager::RunOnFunction() {
  if (Analysis == true) {
    Anlaysis();
    m_loopAnlay->PrintPass();
    m_eliedg->PrintPass();
    m_liveness->PrintPass();
  }
  if (InitpassRecorder[0]) {
    m_dom->RunOnFunction();
    m_dom->PrintPass();
  }
  if (InitpassRecorder[1]) {
    m_pre->RunOnFunction();
    m_pre->PrintPass();
  }
  if(InitpassRecorder[2])
  {
    m_constprop->RunOnFunction();
    m_constprop->PrintPass();
  }
  if(InitpassRecorder[3])
  {
    m_adce->RunOnFunction();
    m_adce->PrintPass();
  }
  // if(InitpassRecorder[4])
  
}

void PassManager::IncludePass(int pass) { InitpassRecorder[pass] = 1; }

void PassManager::Anlaysis() {
  m_liveness->RunOnFunction();
  m_eliedg->RunOnFunction();
  m_loopAnlay->RunOnFunction();
}