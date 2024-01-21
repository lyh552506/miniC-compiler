#include "parser.hpp"
<<<<<<< HEAD
#include "AsmPrinter.hpp"
=======
//#include "AsmPrinter.hpp"
#include "opt/dominant.hpp"
// #include "AsmPrinter.hpp"
>>>>>>> dd20b13d74af45e50b8a060459bbf1d3a1136980
#include <fstream>
extern FILE *yyin;

void copyFile(const std::string &sourcePath,
              const std::string &destinationPath) {
  std::ifstream source(sourcePath, std::ios::binary);
  std::ofstream destination(destinationPath, std::ios::binary);
  destination << source.rdbuf();
}

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

<<<<<<< HEAD
    // output_path = argv[1];
    // output_path += ".a";
    // freopen(output_path.c_str(),"a",stdout);
    PrintCodeToTxt(&Singleton<Module>());
    // freopen("/dev/tty", "a", stdout);
    return 0;
=======
  auto f = Singleton<Module>().GetFuncTion()[0].get();
  auto &Li = Singleton<Module>().GetFuncTion()[0]->GetBasicBlock();

  for (int i = 0; i < Li.size(); ++i)
    Li[i].get()->num=i;

  int n = Li[0]->num;
  User *li = Li[0]->front();
  dominance dom(f, Li.size());

  Singleton<Module>().Test();
  return 0;
>>>>>>> dd20b13d74af45e50b8a060459bbf1d3a1136980
}