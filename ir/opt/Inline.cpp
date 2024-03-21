#include "Inline.hpp"

void Inline::PrintPass()
{
    std::cout << "--------Inline--------" << std::endl;
    Singleton<Module>().Test();
}

void Inline::RunOnFunction()
{
    
}