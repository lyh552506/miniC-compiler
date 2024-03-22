#include "Inline.hpp"

void Inline::PrintPass()
{
    std::cout << "--------Inline--------" << std::endl;
    Singleton<Module>().Test();
}

void Inline::RunOnFunction()
{

}
/*
CallInst use: vector{Func, arges} for(int i = 1 ; i < vector.size() ; i++)
*/