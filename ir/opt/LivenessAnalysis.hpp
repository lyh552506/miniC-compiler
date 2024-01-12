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

}
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
// void LiveVariableAnalysis::iterate(MachineFunction *func) {
//   std::set<MachineBlock *> workList;
//   for (auto &block : func->getBlockList()) {
//     block->live_in.clear();
//     workList.insert(block);
//   }

//   while (!workList.empty()) {
//     auto block = *workList.begin();
//     workList.erase(workList.begin());
//     block->live_out.clear();
//     auto old = block->live_in;
//     for (auto &succ : block->getSuccs()) {
//       block->live_out.insert(succ->live_in.begin(), succ->live_in.end());
//     }
//     block->live_in = use[block];
//     set_difference(block->live_out.begin(), block->live_out.end(),
//                    def[block].begin(), def[block].end(),
//                    inserter(block->live_in, block->live_in.end()));
//     if (old != block->live_in) {
//       for (auto &pred : block->getPreds())
//         workList.insert(pred);
//     }
//   }
// }
// WorkList()
//     for i <- 1 to n do
//         y[i] <- { } //初始化随具体情况而定
//     w <- [ y[1] y[2] ... y[n] ] //将未知数放入worklist中
//     while(!is_empty(w)) do 
//         y[i] <- extract(w) //从worklist以某种方式抽出一个未知数
//         old <- y[i] //记录此未知数的值
//         y[i] <- f_i(y[1], y[2], ..., y[n]) //挑出以此未知数作为因变量的方程，并进行运算，结果赋给此未知数
//         if old != y[i] then //如果未知数的值在运算后发生变化
//             for y[k] <- dep(y[i]) do 
//             //将依赖它的那些未知数放入worklist中，a依赖b的含义是
//             //以a为因变量的方程使用b作为自变量，因此当b发生变化，a也就可能发生变化
//             //故把a放入worklist中
//                 w <- insert(w, y[k])