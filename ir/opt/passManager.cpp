#include "passManager.hpp"

void PassManager::InitPass() {
  for (int i = 0; i < Singleton<Module>().GetFuncTion().size(); i++) {
    auto f = Singleton<Module>().GetFuncTion()[i].get();
    FList.push_back(f);
    auto &Li = Singleton<Module>().GetFuncTion()[i]->GetBasicBlock();
    for (auto bb = f->begin(); bb != f->end(); ++bb)
      f->push_bb(*bb);
    for (int i = 0; i < Li.size(); ++i)
      Li[i]->num = i;

    m_dom = std::make_unique<dominance>(f, Li.size());
    m_pre = std::make_unique<PRE>(m_dom.get(), f);
    m_loopAnlay = std::make_unique<LoopInfo>(f, m_dom.get());
    m_liveness = std::make_unique<LivenessAnalysis>();
    m_constprop = std::make_unique<ConstantProp>(f);
    RunOnFunction();
  }
}
void PassManager::RunOnFunction() {
  if (InitpassRecorder[0]) {
    m_dom->RunOnFunction();
    m_dom->PrintPass();
  }
  if (InitpassRecorder[1]) {
    m_pre->RunOnFunction();
    m_pre->PrintPass();
  }
  // if(InitpassRecorder[2])
  // if(InitpassRecorder[3])
  // if(InitpassRecorder[4])
  if (Analysis == true) {
    Anlaysis();
    m_loopAnlay->PrintPass();
  }
}

void PassManager::IncludePass(int pass) { InitpassRecorder[pass] = 1; }

void PassManager::Anlaysis() {
  //m_liveness
  m_loopAnlay->RunOnFunction();
}