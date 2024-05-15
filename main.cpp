// #include "AsmPrinter.hpp"
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

static struct option long_options[] = {{"mem2reg", no_argument, 0, 0},
                                       {"pre", no_argument, 0, 1},
                                       {"constprop", no_argument, 0, 2},
                                       {"dce", no_argument, 0, 3},
                                       {"adce", no_argument, 0, 4},
                                       {"loopinfo", no_argument, 0, 5},
                                       {"help", no_argument, 0, 6},
                                       {"simplifycfg", no_argument, 0, 7},
                                       {"ece", no_argument, 0, 8},
                                       {"inline", no_argument, 0, 9},
                                       {"global2local", no_argument, 0, 10},
                                       {"reassociate", no_argument, 0, 11},
                                       {0, 0, 0, 0}};

int main(int argc, char **argv) {
  std::string output_path = argv[1];
  output_path += ".ll";

  std::string filename = argv[1];
  size_t lastSlashPos = filename.find_last_of("/\\") + 1;
  filename = filename.substr(lastSlashPos);

  std::string asmoutput_path = argv[1];
  asmoutput_path = asmoutput_path.substr(0, asmoutput_path.length() - 2) + ".s";
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
    case 0:
      pass_manager->IncludePass(0);
      break;
    case 1:
      pass_manager->IncludePass(1);
      break;
    case 2:
      pass_manager->IncludePass(2);
      break;
    case 3:
      pass_manager->IncludePass(3);
      break;
    case 4:
      pass_manager->IncludePass(4);
      break;
    case 5:
      pass_manager->IncludePass(5);
      break;
    case 6:
      std::cerr << "help" << std::endl;
      break;
    case 7:
      pass_manager->IncludePass(7);
      break;
    case 8:
      pass_manager->IncludePass(8);
      break;
    case 9:
      pass_manager->IncludePass(9);
      break;
    case 10:
      pass_manager->IncludePass(10);
      break;
    case 11:
      pass_manager->IncludePass(11);
    }
  }
  pass_manager->InitPass();
  Singleton<Module>().Test();
  fflush(stdout);
  fclose(stdout);
#endif
// #ifdef SYSY_ENABLE_BACKEND
  freopen(asmoutput_path.c_str(), "w", stdout);
  RISCVModuleLowering RISCVASm;
  RISCVASm.run(&Singleton<Module>());
  fflush(stdout);
  fclose(stdout);

  freopen("dev/tty", "w", stdout);
// #endif
  return 0;
}