#include "../../include/ir/opt/CodeMove.hpp"

void CodeMove::init()
{
    // Loop = AM.get<LoopAnalysis>(func);
    DomTree = AM.get<dominance>(func);
    AM.get<SideEffect>(&Singleton<Module>());
    Loops = Loop->GetLoops();
}

bool CodeMove::Run()
{
    bool Changed = false;

    return Changed;
}