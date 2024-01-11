#include "../backend/MachineCode.hpp"
#include "CFG.hpp"
#include <set>
// #include <map>
// #include <set>

// class MachineFunction;
// class MachineUnit;
// class MachineOperand;
// class MachineBlock;
// class LiveVariableAnalysis {
// private:
//   std::map<MachineOperand, std::set<MachineOperand *>> use_inst;
//   std::map<MachineBlock *, std::set<MachineOperand *>> def, use;
//   void BlockUseInstr(MachineFunction *);
//   void BlockDefUse(MachineFunction *);
//   void iterate(MachineFunction *);

// public:
//   void pass(MachineUnit *unit);
//   void pass(MachineFunction *func);
//   std::map<MachineOperand, std::set<MachineOperand *>> &getAllUses() {
//     return use_inst;
//   };
// };

// void LivenessAnalysis(Function *func);
// class RunOnBlock
// {
//   std::vector<Value*> GetLivein(BasicBlock *Block);
//   std::vector<Value*> GetLiveout(BasicBlock *Block);
//   std::list<BasicBlock *> GetPreds(Function *func);
// };
// class InstrInfo : public User
// {
//   std::vector<User*> GetInstLivein();
//   std::vector<User*> GetInstLiveout();
// };
class LivenessAnalysis
{
  private:
  std::map<BasicBlock*, std::set<Value*>> BlockLivein;
  std::map<BasicBlock*, std::set<Value*>> BlockLiveout;
  void GetBlockLivein(BasicBlock* block);
  void GetBlockLiveout(BasicBlock* block);
  void iterate(BasicBlock* block);
  
  public:
  void pass(Function* func);


}
