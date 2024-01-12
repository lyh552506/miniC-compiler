#include "parser.hpp"
extern FILE* yyin;
int main(int argc,char** argv)
{
    freopen("output","w",stdout);
    yyin=fopen(argv[1],"r");
    yy::parser parse;
    parse();
    Singleton<CompUnit*>()->codegen();
    Singleton<Module>().Test();
    return 0;
}