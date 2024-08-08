#include "../../include/ir/opt/DSE.hpp"

void DSE::init()
{
    wait_del.clear();
}

bool DSE::Run()
{
    DomTree = AM.get<dominance>(func);
}