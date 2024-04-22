#include "passManager.hpp"
#include "CFG.hpp"
#include "Singleton.hpp"
#include "dominant.hpp"

void PassManager::InitPass() {
  for (int i = 0; i < Singleton<Module>().GetFuncTion().size(); i++) {
    func = i;
    PreWork(i);
    m_eliedg = std::make_unique<ElimitCriticalEdge>(m_func);
    m_dom = std::make_unique<dominance>(m_func, BList.size());

    // m_pre = std::make_unique<PRE>(m_dom.get(), m_func);
    m_cfgsimple = std::make_unique<cfgSimplify>(m_func, m_dom.get());
    m_adce = std::make_unique<ADCE>(m_func);
    m_dce = std::make_unique<DCE>(m_func);
    m_constprop = std::make_unique<ConstantProp>(m_func);
    m_loopAnlay = std::make_unique<LoopAnalysis>(m_func, m_dom.get());
    m_inline = std::make_unique<Inliner>(m_func, m_loopAnlay.get(), Singleton<Module>());
    RunOnFunction();
  }
}

void PassManager::PreWork(int i) {
  FList.clear();
  BList.clear();
  Singleton<Module>().GetFuncTion()[i]->GetBasicBlock().clear();
  m_func = Singleton<Module>().GetFuncTion()[i].get();
  m_func->init_bbs();
  FList.push_back(m_func);
  for (auto bb = m_func->begin(); bb != m_func->end(); ++bb)
    m_func->push_bb(*bb);
  BList = Singleton<Module>().GetFuncTion()[i]->GetBasicBlock();
  for (m_func->bb_num = 0; m_func->bb_num < BList.size(); m_func->bb_num++)
    BList[m_func->bb_num]->num = m_func->bb_num;
}

void PassManager::RunOnFunction() {
  if (InitpassRecorder[0]) {
    m_dom->RunOnFunction();
    // m_dom->PrintPass();
    // if(m_func->GetName()=="main")
    //   Singleton<Module>().Test();
  }
  if (InitpassRecorder[8]) {
    m_eliedg->RunOnFunction();
    PreWork(func);
    m_dom->update();
    // if(m_func->GetName()=="main")
    //   Singleton<Module>().Test();
  }
  if (InitpassRecorder[1]) {
    dominance* d=new dominance(m_func, BList.size());
    d->RunOnFunction();
    m_pre = std::make_unique<PRE>(d, m_func);
    m_pre->RunOnFunction();
    // m_pre->PrintPass();
  }
  if (InitpassRecorder[2]) {
    m_constprop->RunOnFunction();
    m_constprop->PrintPass();
  }
  if (InitpassRecorder[7]) {
    m_cfgsimple->RunOnFunction();
    PreWork(func);
    m_dom->update();
    // m_cfgsimple->PrintPass();
  }
  if (InitpassRecorder[3]) {
    m_dce->RunOnFunction();
    m_dce->PrintPass();
  }
  if (InitpassRecorder[4]) {
    m_adce->RunOnFunction();
    m_adce->PrintPass();
  }
  if (InitpassRecorder[5]) {
    m_loopAnlay->RunOnFunction();
    m_loopAnlay->PrintPass();
  }
  if(InitpassRecorder[9]){
    m_inline->Run();
    // m_inline->PrintPass();
  }
}

void PassManager::IncludePass(int pass) { InitpassRecorder[pass] = 1; }
