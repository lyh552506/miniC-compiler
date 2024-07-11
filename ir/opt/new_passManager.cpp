#include "New_passManager.hpp"

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
    case storeonlyglobalelimination:
      AddPass(storeonlyglobalelimination);
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
  DecodeArgs(argc, argv);
  _AnalysisManager AM;
  while (!EnablePass.empty()) {
    auto name = EnablePass.front();
    EnablePass.pop();
    switch (name) {
    case mem2reg: {
      auto Mem2regRes = RunImpl<Mem2reg>(curfunc, AM);
    }
    case ece: {
      auto eliedg = RunImpl<ElimitCriticalEdge>(curfunc, AM);
    }
    // case pre: {
    //   dominance *d = new dominance(m_func, BList.size());
    //   d->update();
    //   m_pre = std::make_unique<PRE>(d, m_func);
    //   m_pre->RunOnFunction();
    //   // m_pre->PrintPass();
    // }
    case constprop: {
      auto m_constprop = RunImpl<ConstantProp>(curfunc, AM);
    }
    case dce: {
      auto m_dce = RunImpl<DCE>(curfunc, AM);
    }
    case simplifycfg: {
      auto m_cfgsimple = RunImpl<cfgSimplify>(curfunc, AM);
    }
    case reassociate: {
      auto m_reassociate = RunImpl<Reassociate>(curfunc, AM);
    }
    case loopsimplify: {
      auto m_loopsimple = RunImpl<LoopSimplify>(curfunc, AM);
    }
    case loopdeletion: {
      auto m_loopdeletion = RunImpl<LoopDeletion>(curfunc, AM);
    }
    case Inline: {
      auto m_inline = RunImpl<Inliner>(module, AM);
    }
    case cse: {
      auto m_cse = RunImpl<CSE>(curfunc, AM); 
    }
    case deadargselimination: {
      auto m_deadargselimination = RunImpl<DeadArgsElimination>(module, AM);
    }
    case storeonlyglobalelimination: {
      auto m_storeonlyglobalelimination = RunImpl<StoreOnlyGlobalElimination>(module, AM);
    }
    default: {
      assert(0);
    }
    }
  }
}

void _PassManager::Init() { return; }