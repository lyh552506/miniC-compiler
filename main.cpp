#include "parser.hpp"
extern FILE* yyin;
int main(int argc,char** argv)
{
    yyin=fopen(argv[1],"r");
    yy::parser parse;
    parse();
    std::cout<<Singleton<CompUnit*>()<<'\n';
    Singleton<CompUnit*>()->codegen();
    std::cout<<"Program Terminated!\n";
    return 0;
}