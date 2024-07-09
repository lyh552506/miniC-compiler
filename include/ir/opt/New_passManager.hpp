#pragma once
#include "CFG.hpp"
#include "PassManagerBase.hpp"
#include <cstdlib>
#include <getopt.h>
#include <iostream>
#include <type_traits>
#include <vector>

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
public:
  _AnalysisManager() = default;

  template <typename Pass, typename name = std::enable_if_t<std::is_base_of_v<
                               _AnalysisManagerBase<Pass, Function>, Pass>>>
  const Pass *get(Function *func) {
    std::unique_ptr<Pass> pass = std::make_unique<Pass>(func);
    const auto *result = pass->GetResult(func);
    return static_cast<const Pass *>(result);
  }
};

template <typename Scope>
class _PassManager : public _AnalysisManagerBase<_PassManager<Scope>, Scope> {
public:
  virtual bool Run(Scope base, _AnalysisManager &AM);
  void AddPass(PassName pass) { _Pass.push_back(pass); }
  void DecodeArgs(int argc, char *argv[]);
  void RunOnLevel();

private:
  std::vector<PassName> _Pass;
  OptLevel level;
};
