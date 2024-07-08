#include <cstdlib>
#include <getopt.h>
#include <iostream>
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

template <typename DerivedT> class _AnalysisManager {};

template <typename DerivedT> class _PassManager {
public:
  virtual bool Run(DerivedT base, _AnalysisManager<DerivedT> &AM);
  void AddPass(PassName pass) { _Pass.push_back(pass); }
  void DecodeArgs(int argc, char *argv[]);
  void RunOnLevel();
private:
  std::vector<PassName> _Pass;
  OptLevel level;
};

template <typename DerivedT>
bool _PassManager<DerivedT>::Run(DerivedT base,
                                 _AnalysisManager<DerivedT> &AM) {
  return true;
}

template <typename DerivedT>
void _PassManager<DerivedT>::DecodeArgs(int argc, char *argv[]) {
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
    case simplifycfg:
      AddPass(simplifycfg);
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
    }
  }
}