#pragma once
#include "../../yacc/parser.hpp"
#include "CFG.hpp"
#include "CSE.hpp"
#include "ConstantFold.hpp"
#include "ConstantProp.hpp"
#include "DCE.hpp"
#include "DeadArgsElimination.hpp"
#include "DealCriticalEdges.hpp"
#include "Global2Local.hpp"
#include "IDF.hpp"
#include "Inline.hpp"
#include "LoopDeletion.hpp"
#include "LoopInfo.hpp"
#include "LoopRotate.hpp"
#include "LoopSimplify.hpp"
#include "PassManagerBase.hpp"
#include "PromoteMemtoRegister.hpp"
#include "SSAPRE.hpp"
#include "Singleton.hpp"
#include "StoreOnlyGlobalElimination.hpp"
#include "any"
#include "cfgSimplify.hpp"
#include "dominant.hpp"
#include "lcssa.hpp"
#include "licm.hpp"
#include "mem2reg.hpp"
#include "reassociate.hpp"
#include <getopt.h>
#include <memory>
class FunctionPassManager;
class ModulePassManager;
enum OptLevel { O0 = 0, O1 = 1, O2 = 2, O3 = 3 };
enum PassName {
  mem2reg = 4,
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
                                       {"loop-deletion", no_argument, 0, 18},
                                       {"deadargselimination", no_argument, 0, 19},
                                       {"storeonlyglobalelimination", no_argument, 0, 20},
                                       {"O0", no_argument, 0, 21},
                                       {"O1", no_argument, 0, 22},
                                       {"O2", no_argument, 0, 23},
                                       {"O3", no_argument, 0, 24},
                                       {0, 0, 0, 0}};

class _AnalysisManager
    : public _AnalysisManagerBase<_AnalysisManager, Function> {
private:
  std::vector<std::any> Contain;

public:
  _AnalysisManager() = default;
  virtual ~_AnalysisManager()=default;
  template <typename Pass, typename... Args,
            typename name = std::enable_if_t<
                std::is_base_of_v<_AnalysisManagerBase<Pass, Function>, Pass>>>
  Pass *get(Function *func, Args &&...args) {
    auto pass = new Pass(func, std::forward<Args>(args)...);
    auto *result = pass->GetResult(func);
    Contain.emplace_back(pass);
    return static_cast<Pass *>(result);
  }

  template <typename Pass, typename... Args,
            typename name = std::enable_if_t<
                std::is_base_of_v<_AnalysisManagerBase<Pass, Module>, Pass>>>
  Pass *get(Module *mod, Args &&...args) {
    auto pass = new Pass(mod, std::forward<Args>(args)...);
    auto *result = pass->GetResult();
    Contain.emplace_back(pass);
    return static_cast<Pass *>(result);
  }
};

class _PassManager : public _PassManagerBase<_PassManager, Function> {
public:
  _PassManager() { module = &Singleton<Module>(); }
  virtual ~_PassManager() = default;
  bool Run();
  void RunOnLevel();
  void RunOnTest();
  template <typename Pass, typename name = std::enable_if_t<std::is_base_of_v<
                               _PassManagerBase<Pass, Function>, Pass>>>
  bool RunImpl(Function *func, _AnalysisManager &AM) {
    auto pass = std::make_unique<Pass>(func, AM);
    return pass->Run();
  }
  template <typename Pass, typename name = std::enable_if_t<std::is_base_of_v<
                               _PassManagerBase<Pass, Module>, Pass>>>
  bool RunImpl(Module *mod, _AnalysisManager &AM) {
    auto pass = std::make_unique<Pass>(mod, AM);
    return pass->Run();
  }
  void DecodeArgs(int argc, char *argv[]);

private:
  void Init();
  OptLevel level;
  void AddPass(PassName pass) { EnablePass.push(pass); }
  std::queue<PassName> EnablePass;
  Module *module;
  Function *curfunc;
};
