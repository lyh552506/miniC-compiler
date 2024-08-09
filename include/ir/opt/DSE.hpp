#include "../../../util/my_stl.hpp"
#include "../../lib/CFG.hpp"
#include "../Analysis/AliasAnalysis.hpp"
#include "../Analysis/LoopInfo.hpp"
#include "../Analysis/SideEffect.hpp"
#include "../Analysis/dominant.hpp"
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"

class _AnalysisManager;

class DSE : public _PassManagerBase<DSE, Function>
{
  private:
    dominance *DomTree;
    Function *func;
    _AnalysisManager &AM;
    std::vector<User *> wait_del;
    std::unordered_set<BasicBlock*> HasHandleBlock;
    std::unordered_map<Value*, StoreInst*> Store_Map;
    std::unordered_map<Value*, std::pair<size_t, StoreInst*>> Array_Store_Map;

    bool RunOnBlock(BasicBlock* block);
    void init();
    
  public:
    DSE(Function *f, _AnalysisManager &am) : func(f), AM(am)
    {
        init();
    }
    bool Run();
};