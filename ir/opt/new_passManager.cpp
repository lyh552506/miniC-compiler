#include "../../include/ir/opt/New_passManager.hpp"
#include "Singleton.hpp"
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
    case local2global:
      AddPass(local2global);
      break;
    case parallel:
      AddPass(parallel);
      break;
    case loopUnroll:
      AddPass(loopUnroll);
      break;
    case gepcombine:
      AddPass(gepcombine);
      break;
    case tailrecurseEliminator:
      AddPass(tailrecurseEliminator);
      break;
    case condmerge:
      AddPass(condmerge);
      break;
    case gepevaluate:
      AddPass(gepevaluate);
      break;
    case blockmerge:
      AddPass(blockmerge);
      break;
    case Dse:
      AddPass(Dse);
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
    auto AM = Singleton<_AnalysisManager>();

    // DeadArgsElimination
    RunImpl<DeadArgsElimination>(module, AM);

    // StoreOnlyGlobalElimination
    RunImpl<StoreOnlyGlobalElimination>(module, AM);

    // global2local
    RunImpl<Global2Local>(module, AM);
    CommonPass(AM);

    while (RunImpl<Inliner>(module, AM)) {
      RunLevelPass(cfgSimplify, curfunc, modified)
          RunImpl<DeadArgsElimination>(module, AM);
      RunImpl<StoreOnlyGlobalElimination>(module, AM);
      RunImpl<Global2Local>(module, AM);
      CommonPass(AM);
    }

    RunLevelPass(TailRecurseEliminator, curfunc,
                 modified) while (RunImpl<Inliner>(module, AM)) {
      RunLevelPass(cfgSimplify, curfunc, modified)
          RunImpl<DeadArgsElimination>(module, AM);
      RunImpl<StoreOnlyGlobalElimination>(module, AM);
      RunImpl<Global2Local>(module, AM);
      CommonPass(AM);
    }

    RunLevelPass(TailRecurseEliminator, curfunc, modified)

                 while (RunImpl<Inliner>(module, AM)) {
      RunLevelPass(cfgSimplify, curfunc, modified)
          RunImpl<DeadArgsElimination>(module, AM);
      RunImpl<StoreOnlyGlobalElimination>(module, AM);
      RunImpl<Global2Local>(module, AM);
      CommonPass(AM);
    }

    // Loops
    {
      modified = true;
      while (modified) {
        modified = false;
        PassChangedBegin(curfunc)

            PassChangedEnd RunLevelPass(LoopSimplify, curfunc, other);
        PassChangedBegin(curfunc) PassChangedEnd

            RunLevelPass(LcSSA, curfunc, other);
        PassChangedBegin(curfunc) PassChangedEnd

            // loop-rotate
            RunLevelPass(LoopRotate, curfunc, other) PassChangedBegin(curfunc)
                PassChangedEnd // licm

                    RunLevelPass(LICMPass, curfunc, modified);
        PassChangedBegin(curfunc) PassChangedEnd

            // loopdeletion
            RunLevelPass(LoopDeletion, curfunc, modified);
        PassChangedBegin(curfunc) PassChangedEnd

            // RunLevelPass(LoopParallel, curfunc, modified)
            //     PassChangedBegin(curfunc)
            //         PassChangedEnd

            RunLevelPass(LoopUnroll, curfunc,
                         modified) PassChangedBegin(curfunc)
                PassChangedEnd RunLevelPass(ConstantProp, curfunc, modified);

        RunLevelPass(DCE, curfunc, other);
        PassChangedBegin(curfunc) PassChangedEnd

            RunLevelPass(BlockMerge, curfunc, other);
        PassChangedBegin(curfunc) PassChangedEnd
      }
    }

    CommonPass(AM);

        RunLevelPass(DeadStoreElimination, curfunc, modified);

        RunLevelPass(LoadElimination, curfunc, modified)
        RunLevelPass(DCE, curfunc, modified)
        // RunLevelPass(DeadStoreElimination, curfunc, modified);
        // RunLevelPass(SelfStoreElimination, curfunc, modified)
        // RunLevelPass(DeadStoreElimination, curfunc, modified);
        // RunLevelPass(DCE, curfunc, modified);
        // RunLevelPass(DCE, curfunc, modified)
    {
      // tail
      // RunLevelPass(TailRecurseEliminator, curfunc,
      //              modified) while (RunImpl<Inliner>(module, AM)) {
      //   RunLevelPass(cfgSimplify, curfunc, modified)
      //       RunImpl<DeadArgsElimination>(module, AM);
      //   RunImpl<StoreOnlyGlobalElimination>(module, AM);
      //   RunImpl<Global2Local>(module, AM);
      //   while (1) {
      //     if (!CommonPass(AM))
      //       break;
      //   }
      // }
    }
  }
}

bool _PassManager::CommonPass(_AnalysisManager &AM) {
  bool mody = true;
  while (mody) {
    static int a = 0;
    a++;
    mody = false;
    RunLevelPass(cfgSimplify, curfunc, mody);
    PassChangedBegin(curfunc) PassChangedEnd PassChangedBegin(curfunc)
        RunImpl<Mem2reg>(curfunc, AM);
    PassChangedEnd if (!HasRunCondMerge) {
      PassChangedBegin(curfunc)
          PassChangedEnd RunLevelPass(CondMerge, curfunc, modified);
      PassChangedBegin(curfunc) PassChangedEnd HasRunCondMerge = true;
    }
    // Local2Global
    RunImpl<Local2Global>(module, AM);
    // simplifycfg
    RunLevelPass(ConstantProp, curfunc, mody);
    RunLevelPass(DCE, curfunc, mody);
    PassChangedBegin(curfunc) PassChangedEnd

        RunLevelPass(cfgSimplify, curfunc, mody);
    PassChangedBegin(curfunc) PassChangedEnd
        // cse
        RunLevelPass(CSE, curfunc, mody);
    RunLevelPass(GepCombine, curfunc, mody);
    RunLevelPass(GepEvaluate, curfunc, mody);
 RunLevelPass(DeadStoreElimination, curfunc, modified);
    RunLevelPass(LoadElimination, curfunc, mody)

    RunLevelPass(DCE, curfunc, mody)
    // constprop
    RunLevelPass(ConstantProp, curfunc, mody);

    // reassociate
    RunLevelPass(Reassociate, curfunc, mody);


    // cse
    RunLevelPass(CSE, curfunc, mody);
    // RunLevelPass(GepCombine, curfunc, mody);
        RunLevelPass(BlockMerge, curfunc, mody);

    RunLevelPass(DCE, curfunc, mody);

    PassChangedBegin(curfunc)
        PassChangedEnd RunLevelPass(cfgSimplify, curfunc, mody);
    // TRE
    // RunLevelPass(TailRecurseEliminator, curfunc, mody) return mody;
  }
  return mody;
}

///@brief 执行Pass顺序会按照给定参数的顺序来
void _PassManager::RunOnTest() {
  _AnalysisManager AM;
  while (!EnablePass.empty()) {
    auto name = EnablePass.front();
    EnablePass.pop();
    switch (name) {
    case deadargselimination: {
      auto m_deadargselimination = RunImpl<DeadArgsElimination>(module, AM);
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
    case local2global: {
      auto m_local2global = RunImpl<Local2Global>(module, AM);
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
    default: {
      for (int i = 0; i < module->GetFuncTion().size(); i++) {
        auto &func = module->GetFuncTion()[i];
        if (func->tag == Function::UnrollBody ||
            func->tag == Function::ParallelBody)
          continue;
        curfunc = func.get();
        // 维护bbs关系
        curfunc->bb_num = 0;
        curfunc->GetBasicBlock().clear();
        for (auto bb : *curfunc) {
          bb->num = curfunc->bb_num++;
          curfunc->GetBasicBlock().push_back(bb);
        }
        switch (name) {
        case mem2reg: {
          curfunc = func.get();
          // 维护bbs关系
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
          // 维护bbs关系
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
          ContinueRunPassOnTest(DCE, curfunc) break;
        }
        case simplifycfg: {
          auto m_cfgsimple = RunImpl<cfgSimplify>(curfunc, AM);
          // 维护bbs关系
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
          // 维护bbs关系
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
        case cse: {
          auto m_cse = RunImpl<CSE>(curfunc, AM);
          break;
        }
        case lcssa: {
          auto m_lcssa = RunImpl<LcSSA>(curfunc, AM);
          break;
        }
        case looprotate: {
          auto m_looprotate = RunImpl<LoopRotate>(curfunc, AM);
          break;
        }
        case parallel: {
          auto parallel = RunImpl<LoopParallel>(curfunc, AM);
          break;
        }
        case licm: {
          auto m_licm = RunImpl<LICMPass>(curfunc, AM);
          break;
        }
        case loopUnroll: {
          auto m_LoopUnroll = RunImpl<LoopUnroll>(curfunc, AM);
          break;
        }
        case gepcombine: {
          auto m_gepcombine = RunImpl<GepCombine>(curfunc, AM);
          break;
        }
        case tailrecurseEliminator: {
          auto m_TRE = RunImpl<TailRecurseEliminator>(curfunc, AM);
          break;
        }
        case condmerge: {
          auto m_CondMerge = RunImpl<CondMerge>(curfunc, AM);
          break;
        }
        case gepevaluate: {
          auto m_gepevaluate = RunImpl<GepEvaluate>(curfunc, AM);
          break;
        }
        case Dse:
        {
          auto m_Dse = RunImpl<DeadStoreElimination>(curfunc, AM);
          break;
        }
        case loadeliminaion:
        {
          auto m_loadeliminaion = RunImpl<LoadElimination>(curfunc, AM);
          break;
        }
        case selfstoreelimination:
        {
          auto m_selfstoreelimination = RunImpl<SelfStoreElimination>(curfunc, AM);
          break;
        }
        default: {
          assert(0);
        }
        }
      }
    }
    }
  }
}

void _PassManager::Init() { return; }