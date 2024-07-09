#pragma once
#include "CFG.hpp"
#include "PassManagerBase.hpp"
#include <any>
#include <cstdlib>
#include <getopt.h>
#include <iostream>
#include <memory>
#include <type_traits>
#include <utility>
#include <vector>
class FunctionPassManager;
class ModulePassManager;

enum OptLevel { O0, O1, O2, O3 };
enum PassName {
  mem2reg,
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
  looprotate
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
                                       {0, 0, 0, 0}};

class _AnalysisManager
    : public _AnalysisManagerBase<_AnalysisManager, Function> {
private:
  std::vector<std::unique_ptr<void, void (*)(void *)>> Contain;

public:
  _AnalysisManager() = default;

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
};

template <typename Scope>
class _PassManager : public _PassManagerBase<_PassManager<Scope>, Scope> {
public:
  _PassManager() = default;
  virtual ~_PassManager() = default;
  virtual bool Run(Scope *base) override { return true; }
  void DecodeArgs(int argc, char *argv[]);
  void RunOnLevel(OptLevel level);

private:
  std::unique_ptr<FunctionPassManager> FPM;
  std::unique_ptr<ModulePassManager> MPM;
};

class FunctionPassManager : public _PassManager<Function> {
public:
  FunctionPassManager(_AnalysisManager &_AM) : AM(_AM) {}
  virtual ~FunctionPassManager() = default;

  bool Run(Function *func) override { return true; }
  void AddPass(PassName pass) { _Pass.push_back(pass); }
  virtual bool RunOnFunction(Function *func, _AnalysisManager &AM) {
    return true;
  }

private:
  std::vector<PassName> _Pass;
  std::map<PassName,bool> EnablePass;
  _AnalysisManager &AM;
};

class ModulePassManager : public _PassManager<Module> {
public:
  ModulePassManager(_AnalysisManager &_AM) : AM(_AM) {}
  virtual ~ModulePassManager() = default;
  bool Run(Module *mod) override { return true; }
  void AddPass(PassName pass) { _Pass.push_back(pass); }
  virtual bool RunOnModule(Module *mod, _AnalysisManager &AM) { return true; }

private:
  std::vector<PassName> _Pass;
  _AnalysisManager &AM;
};
