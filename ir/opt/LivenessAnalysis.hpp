#ifndef LIVENESSANALYSIS_HPP
#define LIVENESSANALYSIS_HPP
#include <iostream>
#include <map>
#include <set>
#include <vector>

/// @brief:Forward declarations
class BasicBlock;

struct Variable
{
    std ::string name;
    Variable(const std ::string name);
    bool operator<(const Variable& other) const {return name < other.name; }
};

using VariableSet = std ::set<Variable>;

/// @brief: BasicBlock represents a node in the control flow graph
class BasicBlock
{
public:
    Variable                  use;          // Variables of use in this block
    Variable                  def;          // Variables of def in this block
    Variable                  in;           // Variables of in
    Variable                  out;          // Variables of out
    std ::vector<BasicBlock*> successors;   // Successors in the CFG

    BasicBlock(const VariableSet& use, const VariableSet& def);
    void addSuccessor(BasicBlock* block);
};

/// @brief: Function to perform the live variable analysis
/// @param: blocks
void liveVariableAnalysis(std ::vector<BasicBlock*>& blocks);

/// @brief: Function to perform the live variavle analysis and print live range
/// @param: blocks
void liveVariavleAnalysisandPrintRanges(std ::vector<BasicBlock*>& blocks);

#endif   // LIVENESSANALYSIS_HPP
