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
  // compiler -S -o testcase.s testcase.sy
  asmoutput_path = argv[3];
  yyin = fopen(argv[4], "r");
  yy::parser parse;
  parse();
  Singleton<CompUnit *>()->codegen();
  auto PM = std::make_unique<_PassManager>();
  // PM->DecodeArgs(argc-4,argv+4);
  PM->RunOnLevel();
  freopen(asmoutput_path.c_str(), "w", stdout);
  RISCVModuleLowering RISCVAsm;
  RISCVAsm.run(&Singleton<Module>());
  fflush(stdout);
  fclose(stdout);
  return 0;
}