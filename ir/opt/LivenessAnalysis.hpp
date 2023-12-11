#include "../backend/MachineCode.hpp"
#include "../lib/CFG.hpp"
#include <map>
#include <set>

class MachineFunction;
class MachineUnit;
class MachineOperand;
class MachineBlock;
class LiveVariableAnalysis {
private:
  std::map<MachineOperand, std::set<MachineOperand *>> use_inst;
  std::map<MachineBlock *, std::set<MachineOperand *>> def, use;
  void BlockUseInstr(MachineFunction *);
  void BlockDefUse(MachineFunction *);
  void iterate(MachineFunction *);

public:
  void pass(MachineUnit *unit);
  void pass(MachineFunction *func);
  std::map<MachineOperand, std::set<MachineOperand *>> &getAllUses() {
    return use_inst;
  };
};
