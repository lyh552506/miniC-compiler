#include "ConstantProp.hpp"
#include "RISCVLowering.hpp"
#include "dominant.hpp"
#include "parser.hpp"
#include "passManager.hpp"
#include <fstream>
#include <getopt.h>
#include <iostream>

extern FILE *yyin;
extern int optind, opterr, optopt;
extern char *optargi;

void copyFile(const std::string &sourcePath,
              const std::string &destinationPath) {
  std::ifstream source(sourcePath, std::ios::binary);
  std::ofstream destination(destinationPath, std::ios::binary);
  destination << source.rdbuf();
}
enum PassName {
  mem2reg,
  pre,
  constprop,
  dce,
  adce,
  loops,
  help,
  simplifycfg,
  ece,
  Inline,
  global2local,
  sccp,
  reassociate,
  cse,
  lcssa,
  licm
};
static struct option long_options[] = {{"mem2reg", no_argument, 0, 0},
                                       {"pre", no_argument, 0, 1},
                                       {"constprop", no_argument, 0, 2},
                                       {"dce", no_argument, 0, 3},
                                       {"adce", no_argument, 0, 4},
                                       {"loops", no_argument, 0, 5},
                                       {"help", no_argument, 0, 6},
                                       {"simplifycfg", no_argument, 0, 7},
                                       {"ece", no_argument, 0, 8},
                                       {"inline", no_argument, 0, 9},
                                       {"global2local", no_argument, 0, 10},
                                       {"sccp", no_argument, 0, 12},
                                       {"reassociate", no_argument, 0, 11},
                                       {"cse", no_argument, 0, 13},
                                       {"lcssa", no_argument, 0, 14},
                                       {"licm", no_argument, 0, 15},
                                       {0, 0, 0, 0}};

int main(int argc, char **argv) {
  std::string output_path = argv[1];
  output_path += ".ll";

  std::string filename = argv[1];
  size_t lastSlashPos = filename.find_last_of("/\\") + 1;
  filename = filename.substr(lastSlashPos);

  std::string asmoutput_path = argv[1];
  size_t lastPointPos = asmoutput_path.find_last_of(".");
  asmoutput_path = asmoutput_path.substr(0, lastPointPos) + ".s";

  freopen(output_path.c_str(), "a", stdout);
  copyFile("runtime.ll", output_path);
  yyin = fopen(argv[1], "r");
  yy::parser parse;
  parse();
  Singleton<CompUnit *>()->codegen();
#ifdef SYSY_ENABLE_MIDDLE_END
  std::unique_ptr<PassManager> pass_manager(new PassManager);
  int optionIndex, option;
  // 目前处于调试阶段，最终会换成-O1 -O2 -O3
  while ((option = getopt_long(argc, argv, "", long_options, &optionIndex)) !=
         -1) {
    switch (option) {
    default:
      std::cerr << "No Such Opt!" << std::endl;
      exit(0);
    case mem2reg:
      pass_manager->IncludePass(0);
      break;
    case pre:
      pass_manager->IncludePass(1);
      break;
    case constprop:
      pass_manager->IncludePass(2);
      break;
    case dce:
      pass_manager->IncludePass(3);
      break;
    case adce:
      pass_manager->IncludePass(4);
      break;
    case loops:
      pass_manager->IncludePass(5);
      break;
    case help:
      std::cerr << "help" << std::endl;
      break;
    case simplifycfg:
      pass_manager->IncludePass(7);
      break;
    case ece:
      pass_manager->IncludePass(8);
      break;
    case Inline:
      pass_manager->IncludePass(9);
      break;
    case global2local:
      pass_manager->IncludePass(10);
      break;
    case sccp:
      pass_manager->IncludePass(11);
      break;
    case reassociate:
      pass_manager->IncludePass(12);
      break;
    case cse:
      pass_manager->IncludePass(13);
      break;
    case lcssa:
      pass_manager->IncludePass(14);
      break;
    case licm:
      pass_manager->IncludePass(licm);
      break;
    }
  }
  pass_manager->InitPass();

  Singleton<Module>().Test();
  fflush(stdout);
  fclose(stdout);
#endif
#ifdef SYSY_ENABLE_BACKEND
  freopen(asmoutput_path.c_str(), "w", stdout);
  RISCVModuleLowering RISCVAsm;
  RISCVAsm.run(&Singleton<Module>());
  fflush(stdout);
  fclose(stdout);
#endif
  // freopen("dev/tty", "w", stdout);

  return 0;
}