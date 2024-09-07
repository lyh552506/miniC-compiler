#pragma once
#include "../Analysis/LoopInfo.hpp"
#include "../Analysis/dominant.hpp"
#include "BlockMerge.hpp"
#include "CSE.hpp"
#include "Cache.hpp"
#include "CondMerge.hpp"
#include "ConstantFold.hpp"
#include "ConstantProp.hpp"
#include "DCE.hpp"
#include "DSE.hpp"
#include "DeadArgsElimination.hpp"
#include "DealCriticalEdges.hpp"
#include "GepCombine.hpp"
#include "GepEvaluate.hpp"
#include "Global2Local.hpp"
#include "Inline.hpp"
#include "InstructionSimplify.hpp"
#include "LoadElimination.hpp"
#include "Local2Global.hpp"
#include "LoopDeletion.hpp"
#include "LoopParallel.hpp"
#include "LoopRotate.hpp"
#include "LoopSimplify.hpp"
#include "LoopUnroll.hpp"
#include "PassManagerBase.hpp"
#include "PromoteMemtoRegister.hpp"
#include "SSAPRE.hpp"
#include "SelfStoreElimination.hpp"
#include "StoreOnlyGlobalElimination.hpp"
#include "TailRecurseElimination.hpp"
#include "cfgSimplify.hpp"
#include "lcssa.hpp"
#include "licm.hpp"
#include "mem2reg.hpp"
#include "reassociate.hpp"
#include "DSE.hpp"
#include "LoadElimination.hpp"
#include "SelfStoreElimination.hpp"
#include "ScalarStrengthReduce.hpp"
#include "ConstantHoist.hpp"
#include "ControlFlowOpt.hpp"
#include "Select2Branch.hpp"
#include "CodeMove.hpp"
#include <any>
#include <getopt.h>
#include <memory>
#include <unordered_map>
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
  condmerge,
  gepevaluate,
  blockmerge,
  Dse,
  loadeliminaion,
  selfstoreelimination,
  cachelookup,
  scalarstrengthreduce,
  consthoist,
  select2branch
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
    {"GepEvaluate", no_argument, 0, 27},
    {"BlockMerge", no_argument, 0, 28},
    {"dse", no_argument, 0, 29},
    {"LoadElimination", no_argument, 0, 30},
    {"SelfStoreElimination", no_argument, 0, 31},
    {"CacheLookUp", no_argument, 0, 32},
    {"ScalarStrengthReduce", no_argument, 0, 33},
    {"consthoist", no_argument, 0, 34},
    {"select2branch", no_argument, 0, 35},
    {"O0", no_argument, 0, 0},
    {"O1", no_argument, 0, 1},
    {"O2", no_argument, 0, 2},
    {"O3", no_argument, 0, 3},
    {0, 0, 0, 0}};

enum LoopAttr {
  Normal,
  Simplified,
  Lcssa,
  Rotate,
};

class _AnalysisManager
    : public _AnalysisManagerBase<_AnalysisManager, Function> {
private:
  std::vector<std::any> Contain;
  std::vector<LoopInfo *> loops;
  std::unordered_map<BasicBlock *, std::set<LoopAttr>> LoopForm;
  std::unordered_set<BasicBlock *> UnrollRecord;

public:
  _AnalysisManager() = default;
  virtual ~_AnalysisManager() = default;
  template <typename Pass, typename... Args,
            typename name = std::enable_if_t<
                std::is_base_of_v<_AnalysisManagerBase<Pass, Function>, Pass>>>
  Pass *get(Function *func, Args &&...args) {
    auto it =
        std::find_if(Contain.begin(), Contain.end(), [&](const std::any &ele) {
          return ele.type() == typeid(Pass *);
        });
    if (it != Contain.end()) {
      delete std::any_cast<Pass *>(*it);
      Contain.erase(it);
    }
    auto pass = new Pass(func, std::forward<Args>(args)...);
    auto *result = pass->GetResult(func);
    Contain.emplace_back(pass);
    return static_cast<Pass *>(result);
  }

  void AddAttr(BasicBlock *LoopHeader, LoopAttr attr) {
    LoopForm[LoopHeader].insert(attr);
  }

  void Unrolled(BasicBlock *LoopHeader) { UnrollRecord.insert(LoopHeader); }

  bool IsUnrolled(BasicBlock *LoopHeader) {
    return UnrollRecord.find(LoopHeader) != UnrollRecord.end();
  }
  bool FindAttr(BasicBlock *bb, LoopAttr attr) {
    if (LoopForm.find(bb) != LoopForm.end()) {
      if (LoopForm[bb].find(attr) != LoopForm[bb].end())
        return true;
    }
    return false;
  }

  void ChangeLoopHeader(BasicBlock *Old, BasicBlock *New) {
    if (LoopForm.find(Old) == LoopForm.end())
      return;
    LoopForm[New] = std::move(LoopForm[Old]);
    LoopForm.erase(Old);
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

  bool CommonPass(_AnalysisManager &AM);

private:
  void Init();
  OptLevel level;
  void AddPass(PassName pass) { EnablePass.push(pass); }
  std::queue<PassName> EnablePass;
  Module *module;
  Function *curfunc;
  bool modified = true;
  bool other = false;
  bool HasRunCondMerge = false;
};