#include "New_passManager.hpp"
#include <cassert>

void _PassManager::DecodeArgs(int argc, char *argv[]) {
  int optionIndex, option;
  while ((option = getopt_long(argc, argv, "", long_options, &optionIndex)) !=
         -1) {
    switch (option) {
    default:
      std::cerr << "No Such Opt!" << std::endl;
      exit(0);
    case mem2reg:
      AddPass(mem2reg);
      break;
    case pre:
      AddPass(pre);
      break;
    case constprop:
      AddPass(constprop);
      break;
    case dce:
      AddPass(dce);
      break;
    case loopsimplify:
      AddPass(loopsimplify);
      break;
    case simplifycfg:
      AddPass(simplifycfg);
      break;
    case ece:
      AddPass(ece);
      break;
    case Inline:
      AddPass(Inline);
      break;
    case global2local:
      AddPass(global2local);
      break;
    case reassociate:
      AddPass(reassociate);
      break;
    case cse:
      AddPass(cse);
      break;
    case lcssa:
      AddPass(lcssa);
      break;
    case licm:
      AddPass(licm);
      break;
    case looprotate:
      AddPass(looprotate);
      break;
    case loopdeletion:
      AddPass(loopdeletion);
      break;
    case deadargselimination:
      AddPass(deadargselimination);
      break;
    case deadstoreelimination:
      AddPass(deadstoreelimination);
      break;
    case O0:
      level = O0;
      break;
    case O1:
      level = O1;
      break;
    case O2:
      level = O2;
      break;
    case O3:
      level = O3;
      break;
    }
  }
}

bool _PassManager::Run() {
#ifdef TEST
  int a = 0;
#elif defined(LEVEL)
  int a = 1;
#else
  int a = 3;
#endif
}

void _PassManager::RunOnLevel(OptLevel level) {
  if (level == O0)
    return;
  if (level == O1) {
  }
}

///@brief 执行Pass顺序会按照给定参数的顺序来
void _PassManager::RunOnTest(int argc, char *argv[]) {
  Init();
  while (!EnablePass.empty()) {
    auto name = EnablePass.front();
    EnablePass.pop();
    switch (name) {
        // case mem2reg: {
        //   m_dom->RunOnFunction();
        //   // m_dom->PrintPass();
        //   // if(m_func->GetName()=="main")
        //   //   Singleton<Module>().Test();
        // }
        // case ece: {
        //   m_eliedg->RunOnFunction();
        //   PreWork(func);
        //   m_dom->update();
        //   // if(m_func->GetName()=="main")
        //   //   Singleton<Module>().Test();
        // }
        // case pre: {
        //   dominance *d = new dominance(m_func, BList.size());
        //   d->update();
        //   m_pre = std::make_unique<PRE>(d, m_func);
        //   m_pre->RunOnFunction();
        //   // m_pre->PrintPass();
        // }
        // case constprop: {
        //   m_constprop->RunOnFunction();
        //   // m_constprop->PrintPass();
        // }
        // case dce: {
        //   m_dce->RunOnFunction();
        //   // m_dce->PrintPass();
        // }
        // case simplifycfg: {
        //   PreWork(func);
        //   dominance *d = new dominance(m_func, BList.size());
        //   d->update();
        //   m_cfgsimple = new cfgSimplify(m_func, d);
        //   m_cfgsimple->RunOnFunction();
        //   PreWork(func);
        //   m_dom->update();
        //   // m_cfgsimple->PrintPass();
        // }
        // case reassociate: {
        //   PreWork(func);
        //   m_reassociate->RunOnFunction();
        // }
        // case simplifycfg: {
        //   PreWork(func);
        //   dominance *d = new dominance(m_func, BList.size());
        //   d->update();
        //   m_cfgsimple = new cfgSimplify(m_func, d);
        //   m_cfgsimple->RunOnFunction();
        //   PreWork(func);
        //   m_dom->update();
        //   // m_cfgsimple->PrintPass();
        // }
        // case loopsimplify: {
        //   PreWork(func);
        //   dominance *d = new dominance(m_func, BList.size());
        //   d->RunOnFunction();
        //   m_loopsimple = std::make_unique<LoopSimplify>(m_func, d);
        //   m_loopsimple->RunOnFunction();
        //   m_loopsimple->PrintPass();
        // }
        // case Inline: {
        //   m_inline->Run();
        //   // m_inline->PrintPass();
        // }
        // case:
        //   cse { m_cse->RunOnFunction(); }
        // default: {
        //   assert(0);
        // }
    }
  }
}

void _PassManager::Init() { return; }