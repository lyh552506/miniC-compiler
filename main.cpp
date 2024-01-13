//#include "parser.hpp"
#include "yacc/parser.hpp"
//#include "PromoteMemtoRegister.hpp"
//#include"dominant.hpp"
extern FILE* yyin;
int main(int argc,char** argv)
{
    freopen("output.ll","w",stdout);
    yyin=fopen(argv[1],"r");
    yy::parser parse;
    parse();
    std::cout<<Singleton<CompUnit*>()<<'\n';
    
    //dom_begin();
    Singleton<CompUnit*>()->codegen();
    Singleton<Module>().Test();

    
    return 0;
}