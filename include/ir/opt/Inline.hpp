#include "CFG.hpp"
#include "LoopInfo.hpp"
#include "dominant.hpp"
class Inliner
{
public:
    const bool Only_Inline_Small_Function = true;
    const int Inline_Block_Num = 4;
    const bool Inline_Recursive = false;
    const bool Not_Inline_Multilevel_Loop_Func = true;
    const int Not_Inline_Multilevel_Loop_Nest = 5;
    const bool SSALevel = true;
public:
    Inliner(Function* f, LoopAnalysis* loopAnalysis_, Module& module) : func(f), m(module), loopAnalysis(loopAnalysis_) {}
    void Run();
    void PrintPass();
    void Inline();
private:
    // void InlineRecursive(Function* entry);
    bool NotInline(Function *f) { return NotInlineFunc.find(f) != NotInlineFunc.end(); }
    bool isRecursive(Function *f) { return RecursiveFunc.find(f) != RecursiveFunc.end(); }
    void CreateCallMap();
    void DetectRecursive();
    std::vector<BasicBlock*> CopyBlocks(User* inst);
    bool CanBeInlined(User* inst);
    void VisitFunc(Function* entry, std::set<Function*>& visited);
    void removeInlinedFunc();
    void HandleVoidRet(BasicBlock* spiltBlock, std::vector<BasicBlock*>& blocks);
    void HandleRetPhi(BasicBlock* RetBlock, PhiInst* phi, std::vector<BasicBlock*>& blocks);
private:
    Module& m;
    LoopAnalysis* loopAnalysis;
    void init();
    Function* func;
    std::vector<User*> NeedInlineCall;
    std::set<Function*> NotInlineFunc; // Func not inline
    std::set<Function*> RecursiveFunc;
};