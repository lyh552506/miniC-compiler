#include "passManager.hpp"

void PassManager::InitPass() {
  for (int i = 0; i < Singleton<Module>().GetFuncTion().size(); i++) {
    PreWork(i);
    m_eliedg = std::make_unique<ElimitCriticalEdge>(m_func);
    Anlaysis();
    m_dom = std::make_unique<dominance>(m_func, BList->size());
    m_liveness = std::make_unique<LivenessAnalysis>(m_func);
    m_loopAnlay = std::make_unique<LoopAnalysis>(m_func, m_dom.get());
    m_eliedg=std::make_unique<ElimitCriticalEdge>(m_func);
    m_pre = std::make_unique<PRE>(m_dom.get(), m_func);
    m_constprop = std::make_unique<ConstantProp>(m_func);
    RunOnFunction();
  }
}

void PassManager::PreWork(int i) {
  m_func = Singleton<Module>().GetFuncTion()[i].get();
  FList->push_back(m_func);
  BList = &(Singleton<Module>().GetFuncTion()[i]->GetBasicBlock());
  for (auto bb = m_func->begin(); bb != m_func->end(); ++bb)
    m_func->push_bb(*bb);
  for (int i = 0; i < BList->size(); ++i)
    (*BList)[i]->num = i;
}

void PassManager::RunOnFunction() {
  m_eliedg->RunOnFunction();
  if (InitpassRecorder[0]) {
    m_dom->RunOnFunction();
    m_dom->PrintPass();
  }
  if (InitpassRecorder[1]) {
    m_pre->RunOnFunction();
    m_pre->PrintPass();
  }
  if(InitpassRecorder[2]) {
    m_constprop->RunOnFunction();
    m_constprop->PrintPass();
  }
  // if(InitpassRecorder[3])
  // if(InitpassRecorder[4])
  if(InitpassRecorder[5]){
    m_loopAnlay->RunOnFunction();
    m_loopAnlay->PrintPass();
  }
}

void PassManager::IncludePass(int pass) { InitpassRecorder[pass] = 1; }

void PassManager::Anlaysis() {
  // m_liveness
  m_eliedg->RunOnFunction();
  //
}