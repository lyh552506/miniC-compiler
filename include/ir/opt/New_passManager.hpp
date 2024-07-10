#pragma once
#include "CFG.hpp"
#include "PassManagerBase.hpp"
#include <any>
#include <cstdlib>
#include <getopt.h>
#include <iostream>
#include <memory>
#include <queue>
#include <type_traits>
#include <utility>
#include <vector>
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
  deadstoreelimination
};

static struct option long_options[] = {{"mem2reg", no_argument, 0, 0},
                                       {"pre", no_argument, 0, 1},
                                       {"constprop", no_argument, 0, 2},
                                       {"dce", no_argument, 0, 3},
                                       {"loopsimplify", no_argument, 0, 4},
                                       {"simplifycfg", no_argument, 0, 5},
                                       {"ece", no_argument, 0, 6},
                                       {"inline", no_argument, 0, 7},
                                       {"global2local", no_argument, 0, 8},
                                       {"reassociate", no_argument, 0, 9},
                                       {"cse", no_argument, 0, 10},
                                       {"lcssa", no_argument, 0, 11},
                                       {"licm", no_argument, 0, 12},
                                       {"loop-rotate", no_argument, 0, 13},
                                       {"deadargselimination", no_argument, 0, 14},
                                       {"deadstoreelimination", no_argument, 0, 15},
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
};
