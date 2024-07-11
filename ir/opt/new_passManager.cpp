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

bool _PassManager::Run() { return true; }

void _PassManager::RunOnLevel() {
  if (level == O0)
    return;
  if (level == O1) {
    _AnalysisManager AM;
    // DeadArgsElimination
    RunImpl<DeadArgsElimination>(module, AM);

    // StoreOnlyGlobalElimination
    RunImpl<StoreOnlyGlobalElimination>(module, AM);

    // global2local
    RunImpl<Global2Local>(module, AM);

    // mem2reg
    PassChangedBegin(curfunc)
    RunImpl<Mem2reg>(curfunc, AM);
    PassChangedEnd

    // inline TODO:Fix
    // RunImpl<Inliner>(module, AM);

    // mem2reg
    PassChangedBegin(curfunc)
    RunImpl<Mem2reg>(curfunc, AM);
    PassChangedEnd

    // constprop
    RunLevelPass(ConstantProp, curfunc);

    // simplifycfg
    RunLevelPass(cfgSimplify, curfunc);
    PassChangedBegin(curfunc) PassChangedEnd

    // ece pre
    // RunLevelPass(ElimitCriticalEdge, curfunc);
    // PassChangedBegin(curfunc) PassChangedEnd
    // RunLevelPass(PRE, curfunc);

    // cse
    RunLevelPass(CSE, curfunc);

    // constprop
    RunLevelPass(ConstantProp, curfunc);

    // simplifycfg
    RunLevelPass(cfgSimplify, curfunc);
    PassChangedBegin(curfunc) PassChangedEnd

    // reassociate
    RunLevelPass(Reassociate, curfunc);

    // loopsimplify
    RunLevelPass(LoopSimplify, curfunc);
    PassChangedBegin(curfunc) PassChangedEnd

    // // lcssa
    // RunLevelPass(LcSSA, curfunc);

    // // looprotate
    // RunLevelPass(LoopRotate, curfunc);
    // PassChangedBegin(curfunc) PassChangedEnd

    // licm
    // RunLevelPass(LICM, curfunc);
    // PassChangedBegin(curfunc) PassChangedEnd

    // cse
    RunLevelPass(CSE, curfunc);

    // constprop
    RunLevelPass(ConstantProp, curfunc);

    // simplifycfg
    RunLevelPass(cfgSimplify, curfunc);
    PassChangedBegin(curfunc) PassChangedEnd

    // loopsimplify
    RunLevelPass(LoopSimplify, curfunc);
    PassChangedBegin(curfunc) PassChangedEnd

    // lcssa
    // RunLevelPass(LcSSA, curfunc);
    // PassChangedBegin(curfunc) PassChangedEnd

    // loopdeletion
    // RunLevelPass(LoopDeletion, curfunc);
    // PassChangedBegin(curfunc) PassChangedEnd
    
    // loopsimplify
    RunLevelPass(LoopSimplify, curfunc);
    PassChangedBegin(curfunc) PassChangedEnd
  }
}

///@brief 执行Pass顺序会按照给定参数的顺序来
void _PassManager::RunOnTest() {
  _AnalysisManager AM;
  while (!EnablePass.empty()) {
    auto name = EnablePass.front();
    EnablePass.pop();
    for (auto &func : module->GetFuncTion()) {
      curfunc = func.get();
      //维护bbs关系
      curfunc->bb_num = 0;
      curfunc->GetBasicBlock().clear();
      for (auto bb : *curfunc) {
        bb->num = curfunc->bb_num++;
        curfunc->GetBasicBlock().push_back(bb);
      }
      switch (name) {
      case mem2reg: {
        curfunc = func.get();
        //维护bbs关系
        curfunc->bb_num = 0;
        curfunc->GetBasicBlock().clear();
        for (auto bb : *curfunc) {
          bb->num = curfunc->bb_num++;
          curfunc->GetBasicBlock().push_back(bb);
        }
        auto Mem2regRes = RunImpl<Mem2reg>(curfunc, AM);
        break;
      }
      case ece: {
        auto eliedg = RunImpl<ElimitCriticalEdge>(curfunc, AM);
        //维护bbs关系
        curfunc->bb_num = 0;
        curfunc->GetBasicBlock().clear();
        for (auto bb : *curfunc) {
          bb->num = curfunc->bb_num++;
          curfunc->GetBasicBlock().push_back(bb);
        }
        break;
      }
      case pre: {
        auto m_pre = RunImpl<PRE>(curfunc, AM);
        break;
      }
      case constprop: {
        auto m_constprop = RunImpl<ConstantProp>(curfunc, AM);
        break;
      }
      case dce: {
        auto m_dce = RunImpl<DCE>(curfunc, AM);
        break;
      }
      case simplifycfg: {
        auto m_cfgsimple = RunImpl<cfgSimplify>(curfunc, AM);
        //维护bbs关系
        curfunc->bb_num = 0;
        curfunc->GetBasicBlock().clear();
        for (auto bb : *curfunc) {
          bb->num = curfunc->bb_num++;
          curfunc->GetBasicBlock().push_back(bb);
        }
        break;
      }
      case reassociate: {
        auto m_reassociate = RunImpl<Reassociate>(curfunc, AM);
        break;
      }
      case loopsimplify: {
        //维护bbs关系
        auto m_loopsimple = RunImpl<LoopSimplify>(curfunc, AM);
        curfunc->bb_num = 0;
        curfunc->GetBasicBlock().clear();
        for (auto bb : *curfunc) {
          bb->num = curfunc->bb_num++;
          curfunc->GetBasicBlock().push_back(bb);
        }
        break;
      }
      case loopdeletion: {
        auto m_loopdeletion = RunImpl<LoopDeletion>(curfunc, AM);
        curfunc->bb_num = 0;
        curfunc->GetBasicBlock().clear();
        for (auto bb : *curfunc) {
          bb->num = curfunc->bb_num++;
          curfunc->GetBasicBlock().push_back(bb);
        }
        break;
      }
      case Inline: {
        auto m_inline = RunImpl<Inliner>(module, AM);
        curfunc->bb_num = 0;
        curfunc->GetBasicBlock().clear();
        for (auto bb : *curfunc) {
          bb->num = curfunc->bb_num++;
          curfunc->GetBasicBlock().push_back(bb);
        }
        break;
      }
      case cse: {
        auto m_cse = RunImpl<CSE>(curfunc, AM);
        break;
      }
      case deadargselimination: {
        auto m_deadargselimination = RunImpl<DeadArgsElimination>(module, AM);
        break;
      }
      case storeonlyglobalelimination: {
        auto m_storeonlyglobalelimination =
            RunImpl<StoreOnlyGlobalElimination>(module, AM);
        break;
      }
      case global2local: {
        auto m_global2local = RunImpl<Global2Local>(module, AM);
        break;
      }
      case lcssa: {
        auto m_lcssa = RunImpl<LcSSA>(curfunc, AM);
        break;
      }
      default: {
        assert(0);
      }
      }
    }
  }
}

void _PassManager::Init() { return; }