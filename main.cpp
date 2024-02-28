#include "opt/dominant.hpp"
#include "opt/passManager.hpp"
#include "parser.hpp"
#include <fstream>
#include <getopt.h>
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
                                       {"gvn", no_argument, 0, 1},
                                       {"help", no_argument, 0, 2},
                                       {0, 0, 0, 0}};

int main(int argc, char **argv) {
  std::string output_path = argv[1];
  output_path += ".ll";
  copyFile("runtime.ll", output_path);
  freopen(output_path.c_str(), "a", stdout);
  yyin = fopen(argv[1], "r");
  yy::parser parse;
  parse();
  Singleton<CompUnit *>()->codegen();
  Singleton<Module>().Test();
  std::unique_ptr<PassManager> passmanager(new PassManager);
  int optionIndex, option;
  while ((option = getopt_long(argc, argv, "", long_options, &optionIndex))!=-1) {
    switch (option) {
    case 0:
      passmanager->IncludePass(0);
      break;
    case 1:
      passmanager->IncludePass(1);
      break;
    default:
      break;
    }
  }
  passmanager->Init_Pass();
  Singleton<Module>().Test();
  return 0;
}