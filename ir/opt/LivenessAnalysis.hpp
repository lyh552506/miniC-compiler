<<<<<<< Updated upstream
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
=======
#include "../lib/CFG.hpp"
#include "../backend/MachineCode.hpp"
#include <set>
#include <map>

class MachineFunction;
class MachineUnit;
class MachineOperand;
class MachineBlock;
class LiveVariableAnalysis
{
private:
    std::map<MachineOperand, std::set<MachineOperand *>> use_inst;
    std::map<MachineBlock *, std::set<MachineOperand *>> def, use;
    void BlockUseInstr(MachineFunction *);
    void BlockDefUse(MachineFunction *);
    void iterate(MachineFunction *);

public:
    void pass(MachineUnit *unit);
    void pass(MachineFunction *func);
    std::map<MachineOperand, std::set<MachineOperand *>> &getAllUses()
    {
        return use_inst;
    };
};
>>>>>>> Stashed changes
