#include "parser.hpp"
#include "AsmPrinter.hpp"

extern FILE* yyin;
int main(int argc,char** argv)
{
    freopen("output.ll","w",stdout);
    yyin=fopen(argv[1],"r");
    yy::parser parse;
    parse();
    Singleton<CompUnit*>()->codegen();
    Singleton<Module>().Test();

    PrintCodeToTxt(&Singleton<Module>());
    return 0;
}