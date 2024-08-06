#pragma once
#include "../../include/lib/CFG.hpp"
#include "../../include/ir/opt/CSE.hpp"
#include "../../include/ir/opt/ConstantFold.hpp"
#include "../../include/ir/opt/ConstantProp.hpp"
#include "../../include/ir/opt/DCE.hpp"
#include "../../include/ir/opt/DeadArgsElimination.hpp"
#include "../../include/ir/opt/DealCriticalEdges.hpp"
#include "../../include/ir/opt/Global2Local.hpp"
#include "../../include/ir/opt/TailRecurseElimination.hpp"
#include "../../include/ir/opt/Inline.hpp"
#include "../../include/ir/opt/Local2Global.hpp"
#include "../../include/ir/opt/LoopDeletion.hpp"
#include "../../include//ir/Analysis/LoopInfo.hpp"
#include "../../include/ir/opt/LoopParallel.hpp"
#include "../../include/ir/opt/LoopRotate.hpp"
#include "../../include/ir/opt/LoopSimplify.hpp"
#include "../../include/ir/opt/PassManagerBase.hpp"
#include "../../include/ir/opt/PromoteMemtoRegister.hpp"
#include "../../include/ir/opt/SSAPRE.hpp"
#include "../../include/lib/Singleton.hpp"
#include "../../include/ir/opt/StoreOnlyGlobalElimination.hpp"
#include "../../include/ir/opt/cfgSimplify.hpp"
#include "../../include/ir/Analysis/dominant.hpp"
#include "../../include/ir/opt/lcssa.hpp"
#include "../../include/ir/opt/licm.hpp"
#include "../../include/ir/opt/mem2reg.hpp"
#include "../../include/ir/opt/reassociate.hpp"
#include "../../include/ir/opt/LoopUnroll.hpp"
#include "../../include/ir/opt/GepCombine.hpp"
#include "../../include/ir/opt/CondMerge.hpp"
#include <getopt.h>
#include <any>
#include <memory>
#include <vector>
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
  storeonlyglobalelimination,
  local2global,
  parallel,
  loopUnroll,
  gepcombine,
  tailrecurseEliminator,
  condmerge
};

static struct option long_options[] = {
    {"mem2reg", no_argument, 0, 4},
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
    {"local2global", no_argument, 0, 21},
    {"parallel", no_argument, 0, 22},
    {"loopUnroll", no_argument, 0, 23},
    {"GepCombine", no_argument, 0, 24},
    {"TailRecurseEliminator", no_argument, 0, 25},
    {"CondMerge", no_argument, 0, 26},
    {"O0", no_argument, 0, 0},
    {"O1", no_argument, 0, 1},
    {"O2", no_argument, 0, 2},
    {"O3", no_argument, 0, 3},
    {0, 0, 0, 0}};

class _AnalysisManager
    : public _AnalysisManagerBase<_AnalysisManager, Function> {
private:
  std::vector<std::any> Contain;
  std::vector<LoopInfo*> loops;
public:
  _AnalysisManager() = default;
  virtual ~_AnalysisManager() = default;
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
  bool modified = true;
};
