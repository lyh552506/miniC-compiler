#include "CFG.hpp"
#include <set>

class LivenessAnalysis
{
    private:
    std::map<BasicBlock*, std::set<Value*>> BlockLivein;
    std::map<BasicBlock*, std::set<Value*>> BlockLiveout;
    void GetBlockLivein(BasicBlock* block);
    void GetBlockLiveout(BasicBlock* block);
    void iterate(Function* func);

    public:
    void pass(Function* func);

};