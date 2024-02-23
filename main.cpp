#include "parser.hpp"
#include "opt/dominant.hpp"
#include <fstream>
#include "opt/GVN&GCM.hpp"
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

  auto f = Singleton<Module>().GetFuncTion()[0].get();
  auto &Li = Singleton<Module>().GetFuncTion()[0]->GetBasicBlock();

  for (int i = 0; i < Li.size(); ++i)
    Li[i].get()->num=i;

  int n = Li[0]->num;
  User *li = Li[0]->front();
  dominance dom(f, Li.size());
  
  // Gvn_Gcm test(&dom,f);
  // test.init_pass();
  Singleton<Module>().Test();
  return 0;
}