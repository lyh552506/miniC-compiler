#include "./include/lib/CFG.hpp"
#include "./include/ir/opt/New_passManager.hpp"
#include "./include/backend/RISCVLowering.hpp"
#include "./include/yacc/parser.hpp"
#include <fstream>
#include <getopt.h>
#include <iostream>
#include <memory>

extern FILE *yyin;
extern int optind, opterr, optopt;
extern char *optargi;
std::string asmoutput_path;
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

  asmoutput_path = argv[1];
  size_t lastPointPos = asmoutput_path.find_last_of(".");
  asmoutput_path = asmoutput_path.substr(0, lastPointPos) + ".s";

  copyFile("runtime.ll", output_path);
  freopen(output_path.c_str(), "a", stdout);
  yyin = fopen(argv[1], "r");
  yy::parser parse;
  parse();
  Singleton<CompUnit *>()->codegen();
// #ifdef SYSY_ENABLE_MIDDLE_END
  auto PM = std::make_unique<_PassManager>();
  PM->DecodeArgs(argc, argv);
// #ifdef TEST
  PM->RunOnTest();
// #elif defined(LEVEL)
  // PM->RunOnLevel();
// #else
  // assert(0);
// #endif
  Singleton<Module>().Test();
  fflush(stdout);
  fclose(stdout);
// #endif
// #ifdef SYSY_ENABLE_BACKEND
  freopen(asmoutput_path.c_str(), "w", stdout);
  RISCVModuleLowering RISCVAsm;
  RISCVAsm.run(&Singleton<Module>());
  fflush(stdout);
  fclose(stdout);
// #endif
  // freopen("dev/tty", "w", stdout);

  return 0;
}