#pragma once
#include "../../yacc/parser.hpp"
#include <getopt.h>
#include "CFG.hpp"
#include "CSE.hpp"
#include "ConstantFold.hpp"
#include "ConstantProp.hpp"
#include "DCE.hpp"
#include "Global2Local.hpp"
#include "IDF.hpp"
#include "Inline.hpp"
#include "LoopInfo.hpp"
#include "LoopSimplify.hpp"
#include "PassManagerBase.hpp"
#include "PromoteMemtoRegister.hpp"
#include "SSAPRE.hpp"
#include "cfgSimplify.hpp"
#include "dominant.hpp"
#include "lcssa.hpp"
#include "reassociate.hpp"
#include <memory>
#include "licm.hpp"
#include "LoopRotate.hpp"
#include "mem2reg.hpp"
#include "DealCriticalEdges.hpp"
#include "StoreOnlyGlobalElimination.hpp"
#include "DeadArgsElimination.hpp"
#include "LoopDeletion.hpp"
class FunctionPassManager;
class ModulePassManager;
enum OptLevel { O0=0, O1=1, O2=2, O3=3 };
enum PassName {
  mem2reg=4,
  pre,
  constprop,
  dce,
  loopsimplify,
  simplifycfg,
  ece,
  Inline,
  global2local,
  reassociate,
  cse,
  lcssa,
  licm,
  looprotate,
  loopdeletion,
  deadargselimination,
  storeonlyglobalelimination
};

static struct option long_options[] = {{"mem2reg", no_argument, 0, 4},
                                       {"pre", no_argument, 0, 5},
                                       {"constprop", no_argument, 0, 6},
                                       {"dce", no_argument, 0, 7},
                                       {"loopsimplify", no_argument, 0, 8},
                                       {"simplifycfg", no_argument, 0, 9},
                                       {"ece", no_argument, 0, 10},
                                       {"inline", no_argument, 0, 11},
                                       {"global2local", no_argument, 0, 12},
                                       {"reassociate", no_argument, 0, 13},
                                       {"cse", no_argument, 0, 14},
                                       {"lcssa", no_argument, 0, 15},
                                       {"licm", no_argument, 0, 16},
                                       {"loop-rotate", no_argument, 0, 17},
                                       {0, 0, 0, 0}};

class _AnalysisManager
    : public _AnalysisManagerBase<_AnalysisManager, Function> {
private:
  std::vector<std::unique_ptr<void, void (*)(void *)>> Contain;

public:
  _AnalysisManager() = default;
  virtual ~_AnalysisManager() = default;
  template <typename Pass, typename... Args,
            typename name = std::enable_if_t<
                std::is_base_of_v<_AnalysisManagerBase<Pass, Function>, Pass>>>
  Pass *get(Function *func, Args &&...args) {
    std::unique_ptr<Pass> pass =
        std::make_unique<Pass>(func, std::forward<Args>(args)...);
    auto *result = pass->GetResult(func);
    Contain.emplace_back(pass.release(),
                         [](void *ptr) { delete static_cast<Pass *>(ptr); });
    return static_cast<Pass *>(result);
  }

  template <typename Pass, typename... Args,
            typename name = std::enable_if_t<
                std::is_base_of_v<_AnalysisManagerBase<Pass, Module>, Pass>>>
  Pass *get(Module *mod, Args &&...args) {
    std::unique_ptr<Pass> pass =
        std::make_unique<Pass>(mod, std::forward<Args>(args)...);
    auto *result = pass->GetResult(mod);
    Contain.emplace_back(pass.release(),
                         [](void *ptr) { delete static_cast<Pass *>(ptr); });
    return static_cast<Pass *>(result);
  }
};

class _PassManager : public _PassManagerBase<_PassManager, Function> {
public:
  _PassManager() = default;
  virtual ~_PassManager() = default;
  bool Run();
  void RunOnLevel(OptLevel level);
  void RunOnTest(int argc, char *argv[]);
  template <typename Pass, typename name = std::enable_if_t<std::is_base_of_v<
                               _PassManagerBase<Pass, Function>, Pass>>>
  bool RunImpl(Function *func, _AnalysisManager &AM) {
    auto pass = std::make_unique<Pass>(func, AM);
    return pass->Run();
  }
  template <typename Pass, typename name = std::enable_if_t<std::is_base_of_v<
                               _PassManagerBase<Pass, Module>, Pass>>>
  bool RunImpl(Module &mod, _AnalysisManager &AM) {
    auto pass = std::make_unique<Pass>(mod, AM);
    return pass->Run();
  }
  void DecodeArgs(int argc, char *argv[]);
private:
  void Init();
  OptLevel level;
  void AddPass(PassName pass) { EnablePass.push(pass); }
  std::queue<PassName> EnablePass;
  Module& module;
  Function* curfunc;
};
