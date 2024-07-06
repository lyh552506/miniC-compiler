#include "passManager.hpp"
#include "CFG.hpp"
#include "PassManagerBase.hpp"
#include "Singleton.hpp"
#include "dominant.hpp"
#include "lcssa.hpp"
#include <memory>

void PassManager::InitPass() {
  for (int i = 0; i < Singleton<Module>().GetFuncTion().size(); i++) {
    func = i;
    PreWork(i);
    m_eliedg = std::make_unique<ElimitCriticalEdge>(m_func);
    m_dom = std::make_unique<dominance>(m_func, BList.size());
    // m_pre = std::make_unique<PRE>(m_dom.get(), m_func);
    // m_cfgsimple = std::make_unique<cfgSimplify>(m_func, m_dom.get());
    m_adce = std::make_unique<ADCE>(m_func);
    m_dce = std::make_unique<DCE>(m_func);
    m_constprop = std::make_unique<ConstantProp>(m_func);
    m_inline = std::make_unique<Inliner>(Singleton<Module>());
    m_reassociate = std::make_unique<Reassociate>(m_func, m_dom.get());
    m_cse = std::make_unique<CSE>(m_func, m_dom.get());
    // m_cse = std::make_unique<CSE>(m_func);
    RunOnFunction();
    // SCCPSolver::runSCCP(*m_func);
  }
  if (InitpassRecorder[global2local]) {
    m_g2l = std::make_unique<Global2Local>(Singleton<Module>());
    m_g2l->RunOnModule();
    for (int i = 0; i < Singleton<Module>().GetFuncTion().size(); i++) {
      func = i;
      PreWork(i);
      m_dom = std::make_unique<dominance>(m_func, BList.size());
      m_dom->RunOnFunction();
    }
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
  if (InitpassRecorder[mem2reg]) {
    m_dom->RunOnFunction();
    // m_dom->PrintPass();
    // if(m_func->GetName()=="main")
    //   Singleton<Module>().Test();
  }
  if (InitpassRecorder[ece]) {
    m_eliedg->RunOnFunction();
    PreWork(func);
    m_dom->update();
    // if(m_func->GetName()=="main")
    //   Singleton<Module>().Test();
  }
  if (InitpassRecorder[pre]) {
    dominance *d = new dominance(m_func, BList.size());
    d->update();
    m_pre = std::make_unique<PRE>(d, m_func);
    m_pre->RunOnFunction();
    // m_pre->PrintPass();
  }
  if (InitpassRecorder[constprop]) {
    m_constprop->RunOnFunction();
    // m_constprop->PrintPass();
  }
  if (InitpassRecorder[dce]) {
    m_dce->RunOnFunction();
    // m_dce->PrintPass();
  }
  if (InitpassRecorder[simplifycfg]) {
    PreWork(func);
    dominance *d = new dominance(m_func, BList.size());
    d->update();
    m_cfgsimple = new cfgSimplify(m_func, d);
    m_cfgsimple->RunOnFunction();
    PreWork(func);
    m_dom->update();
    // m_cfgsimple->PrintPass();
  }
  if (InitpassRecorder[adce]) {
    m_adce->RunOnFunction();
    // m_adce->PrintPass();
  }
  if (InitpassRecorder[reassociate]) {
    PreWork(func);
    m_reassociate->RunOnFunction();
    
  }
  if (InitpassRecorder[simplifycfg]) {
    PreWork(func);
    dominance *d = new dominance(m_func, BList.size());
    d->update();
    m_cfgsimple = new cfgSimplify(m_func, d);
    m_cfgsimple->RunOnFunction();
    PreWork(func);
    m_dom->update();
    // m_cfgsimple->PrintPass();
  }
  if (InitpassRecorder[loops]) {
    PreWork(func);
    dominance *d = new dominance(m_func, BList.size());
    d->RunOnFunction();
    m_loopsimple = std::make_unique<LoopSimplify>(m_func, d);
    m_loopsimple->RunOnFunction();
    m_loopsimple->PrintPass();
  }
  if (InitpassRecorder[Inline]) {
    m_inline->Run();
    // m_inline->PrintPass();
  }
  if (InitpassRecorder[3]) {
    m_dce->RunOnFunction();
    // m_dce->PrintPass();
  }
  if (InitpassRecorder[13]) {
    m_cse->RunOnFunction();
  }
  if (InitpassRecorder[11]) {
    PreWork(func);
    m_reassociate->RunOnFunction();
  }


  if (InitpassRecorder[14]) {
    PreWork(func);
    dominance *d = new dominance(m_func, BList.size());
    d->update();
    m_lcssa = std::make_unique<LcSSA>(m_func, d);
    m_lcssa->RunOnFunction();
    // m_eliedg->RunOnFunction();
  }
  if (InitpassRecorder[looprotate]) {
    PreWork(func);
    dominance *d = new dominance(m_func, BList.size());
    d->update();
    auto lr = new LoopRotate(m_func, d);
    lr->RunOnFunction();
  }
  if (InitpassRecorder[licm]) {
    // m_licm = std::make_unique<LICMPass>(m_dom.get(), m_func);
    PreWork(func);
    dominance *d = new dominance(m_func, BList.size());
    d->RunOnFunction();
    auto m_licm = new LICMPass(d, m_func);
    m_licm->RunOnFunction();
  }
  if(InitpassRecorder[loopdeletion])
  {
    PreWork(func);
    dominance *d = new dominance(m_func, BList.size());
    d->RunOnFunction();
    m_loopsimple = std::make_unique<LoopSimplify>(m_func, d);
    m_loopsimple->RunOnFunction();
    m_loopsimple->PrintPass();
    PreWork(func);
    dominance *d1 = new dominance(m_func, BList.size());
    d1->update();
    m_lcssa = std::make_unique<LcSSA>(m_func, d1);
    m_lcssa->RunOnFunction();
    bool flag = false;
    PreWork(func);
    dominance *d2 = new dominance(m_func, BList.size());
    d2->RunOnFunction();
    auto m_loopdeletion = new LoopDeletion(m_func, d2);
    flag = m_loopdeletion->RunOnFunc();
    if(flag)
    {
      PreWork(func);
      dominance *dom = new dominance(m_func, BList.size());
      dom->update();
      m_lcssa = std::make_unique<LcSSA>(m_func, dom);
      m_lcssa->RunOnFunction();
    }
  }
}

void PassManager::IncludePass(int pass) { InitpassRecorder[pass] = 1; }
