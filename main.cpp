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
    // using Type=std::unique_ptr<Variable>;
    // std::vector<Type> arr;
    // Singleton<InnerDataType>()=IR_Value_INT;
    // auto tmp=new Variable("fuck");
    // arr.push_back(Type(tmp));
    return 0;
}