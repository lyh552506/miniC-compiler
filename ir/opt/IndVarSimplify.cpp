#include "../../include/ir/opt/IndVarSimplify.hpp"
#include "../../include/ir/Analysis/LoopInfo.hpp"
#include "../../include/ir/Analysis/SideEffect.hpp"
#include "../../include/ir/Analysis/dominant.hpp"
#include "../../include/ir/opt/ConstantFold.hpp"
#include "../../include/ir/opt/PassManagerBase.hpp"
#include "../../include/lib/BaseCFG.hpp"
#include "../../include/lib/CFG.hpp"
#include "../../include/lib/Singleton.hpp"
#include "my_stl.hpp"
#include <cassert>
#include <cstdlib>
#include <iterator>
#include <unordered_set>
#include <vector>

void IndVarSimplify::init()
{
    DomTree = AM.get<dominance>(func);
    Loop = AM.get<LoopAnalysis>(func, DomTree, std::ref(DeleteLoop));
    AM.get<SideEffect>(&Singleton<Module>());
}

bool IndVarSimplify::Run()
{
    bool modified = false;
    return modified;
}