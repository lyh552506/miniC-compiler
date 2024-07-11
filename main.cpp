#include "CFG.hpp"
#include "ConstantProp.hpp"
#include "LoopInfo.hpp"
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"
#include "RISCVLowering.hpp"
#include "dominant.hpp"
#include "parser.hpp"
// #include "passManager.hpp"
#include "AliasAnalysis.hpp"
#include <fstream>
#include <getopt.h>
#include <iostream>
#include <memory>

extern FILE *yyin;
extern int optind, opterr, optopt;
extern char *optargi;

void copyFile(const std::string &sourcePath,
              const std::string &destinationPath) {
  std::ifstream source(sourcePath, std::ios::binary);
  std::ofstream destination(destinationPath, std::ios::binary);
  destination << source.rdbuf();
}

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
  Function *func = Singleton<Module>().GetFuncTion()[0].get();
  Singleton<Module>().Test();

#ifdef SYSY_ENABLE_MIDDLE_END
  auto PM = std::make_unique<_PassManager>();
  PM->RunOnTest(argc,argv);
  PM->Run();
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