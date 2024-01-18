#include "parser.hpp"
#include "AsmPrinter.hpp"
#include <fstream>
extern FILE* yyin;

void copyFile(const std::string& sourcePath, const std::string& destinationPath) {
    std::ifstream source(sourcePath, std::ios::binary);
    std::ofstream destination(destinationPath, std::ios::binary);
    destination << source.rdbuf();
}

int main(int argc,char** argv)
{
    std::string output_path=argv[1];    
    output_path+=".ll";
    copyFile("runtime.ll", output_path);
    freopen(output_path.c_str(),"a",stdout);
    yyin=fopen(argv[1],"r");

    yy::parser parse;
    parse();
    Singleton<CompUnit*>()->codegen();
    Singleton<Module>().Test();

    // output_path = argv[1];
    // output_path += ".a";
    // freopen(output_path.c_str(),"a",stdout);
    PrintCodeToTxt(&Singleton<Module>());
    // freopen("/dev/tty", "a", stdout);
    return 0;
}