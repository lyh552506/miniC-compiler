#include "parser.hpp"
#include "opt/dominant.hpp"
extern FILE* yyin;
int main(int argc,char** argv)
{
    yyin=fopen(argv[1],"r");
    yy::parser parse;
    parse();
    std::cout<<Singleton<CompUnit*>()<<'\n';
    Singleton<CompUnit*>()->codegen();
    Singleton<Module>().Test();
    std::cout<<"Program Terminated!\n";
    // auto& damn=Singleton<Module>().GetFunction();
    // //vector<Function*>
    // for(auto&i:damn)
    // {
    //     //i:unique_ptr<Function>
    //     auto& rnm=i->GetBasicBlocks();
    //     //vector<>
    //     for(auto&j:rnm)
    //     {
    //         //j 
    //         auto fuck=j->GetInsts();
    //         for(auto&k:fuck)
    //         {
    //             //k unique_ptr<User>
                
    //         }
    //     }
    // }
    return 0;
}