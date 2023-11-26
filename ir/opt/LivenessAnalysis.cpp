#include "LivenessAnalysis.hpp"

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
    // TODO;
}

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
                // If the variable is not already live or was not live in the pervious, strat a new
                // range
                liveRanges[var].push_back({i + 1, i + 1});
            else
                // If the variable was live in the pervious block, extend the current range
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
