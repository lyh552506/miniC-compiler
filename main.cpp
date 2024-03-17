#include "opt/GVN.hpp"
#include "opt/dominant.hpp"
#include "opt/passManager.hpp"
#include "parser.hpp"
#include "AsmPrinter.hpp"
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
                                       {"pre", no_argument, 0, 1},
                                       {"constantprop", no_argument, 0, 2},
                                       {"dce", no_argument, 0, 3},
                                       {"adce", no_argument, 0, 4}, 
                                       {"livenessanalysis", no_argument, 0, 5},
                                       {"help", no_argument, 0, 6},
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
  // output_path = argv[1];
  // output_path += ".a";
  // freopen(output_path.c_str(),"a",stdout);

  // freopen("/dev/tty", "a", stdout);  
  std::unique_ptr<PassManager>pass_manager(new PassManager);
  
  int optionIndex, option;

  while ((option = getopt_long(argc, argv, "", long_options, &optionIndex)) != -1) {
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
    }
  }
  pass_manager->Init_Pass();
  // auto f = Singleton<Module>().GetFuncTion()[0].get();
  // auto &Li = Singleton<Module>().GetFuncTion()[0]->GetBasicBlock();
  // for (auto bb = f->begin(); bb != f->end(); ++bb)
  //   f->push_bb(*bb);
  // for (int i = 0; i < Li.size(); ++i)
  //   Li[i]->num = i;

  // dominance dom(f, Li.size());

  // Gvn_Gcm test(&dom, f);
  // test.init_pass();
  Singleton<Module>().Test();
  PrintCodeToTxt(&Singleton<Module>());
  return 0;
}