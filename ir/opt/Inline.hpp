#include "CFG.hpp"
#include "LoopInfo.hpp"
#include "dominant.hpp"
#define INT_MAX   __INT_MAX__
#define INT_MIN (-__INT_MAX__ -1)
class Inliner
{
public:
    const bool Only_Inline_Small_Function = false;
    const int Inline_Block_Num = 4;
    const bool Inline_Recursive = false;
    const bool Not_Inline_Multilevel_Loop_Func = true;

public:
    Inliner(Function* f, dominance* dom_, LoopAnalysis* loopAnalysis_, Module& module) : dom(dom_), func(f), m(module), loopAnalysis(loopAnalysis_) {}
    void Run();
    void Inline(Function* entry);
    void InlineRecursive(Function* entry);
    void PrintPass();

    void CreateCallMap();
    void DetectRecursive();
    void CopyBlocks(CallInst* inst, Function& func);
    bool CanBeInlined(User* inst);
    BasicBlock* SplitBlock(User* Calling, Function& func);
    void VisitFunc(Function* entry, std::set<Function*>& visited);
    void removeInlinedFunc();
    void HandleVoidRet();
private:
    Module& m;
    LoopAnalysis* loopAnalysis;
    void init();
    Function* func;
    dominance* dom;
    std::set<Function*> hasInlinedFunc;
    std::set<Function*> inlinedFunc;
    std::set<Function*> NotInlineFunc;
    std::set<Function*> RecursiveFunc;
    std::map<Function*, std::set<Function*>> CallMap;
    std::map<Function*, std::set<Function*>> CalledMap;
    std::set<std::pair<Value*, Value*>> ArgsMap;
    typedef struct ArgsMap argsmap;
    std::map<Value*, std::vector<std::pair<User*, argsmap*>>> RAUWArgsMap;
};