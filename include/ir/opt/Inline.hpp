#pragma once
#include "../../lib/CFG.hpp"
#include "../Analysis/LoopInfo.hpp"
#include "../Analysis/dominant.hpp"
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"
class _AnalysisManager;
class InlineHeuristic{
    public:
    virtual bool CanBeInlined(CallInst*)=0;
    //everytime we call get we'll reanalyze the whole module again to see which can be inlined
    static std::unique_ptr<InlineHeuristic> get(Module*);
};

class InlineHeuristicManager:public InlineHeuristic,public std::vector<std::unique_ptr<InlineHeuristic>>{
    public:
    virtual bool CanBeInlined(CallInst*)override;
    InlineHeuristicManager();
};

/// @note this should be placed at the end of the InlineHeuristic get
class SizeLimit:public InlineHeuristic{
    // if we use inline, we should consider some optimization effect, for maybe the size will shrink dramatically
    const size_t maxframesize=7864320;// 7.5MB
    const size_t maxsize=10000;
    size_t cost=0;
    public:
    bool CanBeInlined(CallInst*)override;
    SizeLimit();
};
class NoRecursive:public InlineHeuristic{
    Module* m;
    bool InlineRecursion = false;
    // std::unordered_set<Function*> recursive;
    public:
    bool CanBeInlined(CallInst*)override;
    NoRecursive(Module*);
};

class Inliner : public _PassManagerBase<Inliner, Module>
{
public:
    bool Run();
    std::pair<int, BinaryInst::Operation> MatchLib(Function* func);
    bool Inline(Module* m);
    Inliner(Module* m, _AnalysisManager &AM) : m(m), AM(AM) {}
private:
    std::vector<BasicBlock*> CopyBlocks(User* inst);
    void HandleVoidRet(BasicBlock* spiltBlock, std::vector<BasicBlock*>& blocks);
    void HandleRetPhi(BasicBlock* RetBlock, PhiInst* phi, std::vector<BasicBlock*>& blocks);
private:
    Module* m;
    _AnalysisManager &AM;
    // LoopAnalysis* loopAnalysis;
    void init(Module* m);
    std::vector<User*> NeedInlineCall;
};