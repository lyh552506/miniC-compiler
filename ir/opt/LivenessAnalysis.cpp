#include "LivenessAnalysis.hpp"
<<<<<<< Updated upstream

#include <algorithm>
#include <iostream>

/// @brief: BasicBlock constructor
/// @param: use
/// @param: def
BasicBlock::BasicBlock(const VariableSet& use, const VariableSet& def)
    : use(use)
    , def(def)
{}


void BasicBlock ::addSuccessor(BasicBlock* block)
{
    successors.push_back(block);
}

void liveVariableAnalysis(std::vector<BasicBlock*>& blocks)
{
    std::vector<BasicBlock*> worklist;
    for (auto block : blocks)
        worklist.push_back(block);
    while (!worklist.empty())
    {
        BasicBlock* block = worklist.back();
        worklist.pop_back();
        for (auto succ : block->successors)
        {
            if (succ->def.empty())
                succ->def = block->def;
            else
                succ->def.insert(block->def.begin(), block->def.end());
            worklist.push_back(succ);
=======
#include <iostream>
#include <algorithm>

void LiveVariableAnalysis::pass(MachineUnit *unit)
{
    for (auto &func : unit->getFuncList())
    {
        BlockUseInstr(func);
        BlockDefUse(func);
        iterate(func);
    }
}

void LiveVariableAnalysis::pass(MachineFunction *func)
{
    BlockUseInstr(func);
    BlockDefUse(func);
    iterate(func);
}

void LiveVariableAnalysis::BlockDefUse(MachineFunction *func)
{
    for (auto &block : func->getBlockList())
    {
        for (auto inst = block->getInstList().begin(); inst != block->getInstList().end(); inst++)
        {
            auto user = (*inst)->getUseList();
            std::set<MachineOperand *> temp(user.begin(), user.end());
            set_difference(temp.begin(), temp.end(),
                           def[block].begin(), def[block].end(), inserter(use[block], use[block].end()));
            auto defs = (*inst)->getDefList();
            for (auto &Defs : defs)
                def[block].insert(use_inst[*Defs].begin(), use_inst[*Defs].end());
>>>>>>> Stashed changes
        }
    }
}

<<<<<<< Updated upstream
void liveVariableAnalysisandPrintRanges(std ::vector<BasicBlock*>& blocks)
{
    // TODO;
    /// @brief: perform the live variable analysis
    liveVariableAnalysis(blocks);
    /// @brief: Map to store live ranges for each variable
    std ::map<Variable, std::vector<std::pair<int, int>>> liveRanges;

    /// @brief: determine live ranges
    for (int i = 0; i < blocks.size(); ++i) {
        for (const Variable& var : blocks[i]->out) {
            if (liveRanges[var].empty() || liveRanges[var].back().second != i)
                /// @brief: If the variable is not already live or was not live in the pervious, strat a new range
                liveRanges[var].push_back({i + 1, i + 1});
            else
                /// @brief :If the variable was live in the pervious block, extend the current range
                liveRanges[var].back().second = i + 1;
        }
    }

    /// @brief: print live ranges for each variable
    for (const auto& entry : liveRanges) {
        std ::cout << "Variable " << entry.first.name << "live range:{";
        for (const auto& range : entry.second)
            std ::cout << range.first << "->" << range.second << ",";
        std ::cout << "}\n";
    }
}

int main()
{
    // CFG

    liveVariableAnalysisandPrintRanges(blocks);
}
=======
void LiveVariableAnalysis::iterate(MachineFunction *func)
{
    std::set<MachineBlock *> workList;
    for (auto &block : func->getBlockList())
    {
        block->live_in.clear();
        workList.insert(block);
    }

    while (!workList.empty())
    {
        auto block = *workList.begin();
        workList.erase(workList.begin());
        block->live_out.clear();
        auto old = block->live_in;
        for (auto &succ : block->getSuccs())
        {
            block->live_out.insert(succ->live_in.begin(), succ->live_in.end());
        }
        block->live_in = use[block];
        set_difference(block->live_out.begin(), block->live_out.end(),
                       def[block].begin(), def[block].end(), inserter(block->live_in, block->live_in.end()));
        if (old != block->live_in)
        {
            for (auto &pred : block->getPreds())
                workList.insert(pred);
        }
    }
}

void LiveVariableAnalysis::BlockUseInstr(MachineFunction *func)
{
    for (auto &block : func->getBlockList())
    {
        for (auto &inst : block->getInstList())
        {
            auto uses = inst->getUseList();
            for (auto &use : uses)
            {
                use_inst[*use].insert(use);
            }
        }
    }
}
>>>>>>> Stashed changes
