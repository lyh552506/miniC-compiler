#include "parser.hpp"
#include <fstream>
extern FILE* yyin;

void copyFile(const std::string& sourcePath, const std::string& destinationPath) {
    std::ifstream source(sourcePath, std::ios::binary);
    std::ofstream destination(destinationPath, std::ios::binary);
    destination << source.rdbuf();
}

int main(int argc,char** argv)
{
    copyFile("runtime.ll", "output.ll");
    freopen("output.ll","a",stdout);
    yyin=fopen(argv[1],"r");
    yy::parser parse;
    parse();
    Singleton<CompUnit*>()->codegen();
    Singleton<Module>().Test();
    return 0;
}