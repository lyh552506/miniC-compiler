#include "LivenessAnalysis.hpp"
#include <algorithm>
#include <iostream>

void LiveVariableAnalysis::pass(MachineUnit *unit) {
  for (auto &func : unit->getFuncList()) {
    BlockUseInstr(func);
    BlockDefUse(func);
    iterate(func);
  }
}

void LiveVariableAnalysis::pass(MachineFunction *func) {
  BlockUseInstr(func);
  BlockDefUse(func);
  iterate(func);
}

void LiveVariableAnalysis::BlockDefUse(MachineFunction *func) {
  for (auto &block : func->getBlockList()) {
    for (auto inst = block->getInstList().begin();
         inst != block->getInstList().end(); inst++) {
      auto user = (*inst)->getUseList();
      std::set<MachineOperand *> temp(user.begin(), user.end());
      set_difference(temp.begin(), temp.end(), def[block].begin(),
                     def[block].end(), inserter(use[block], use[block].end()));
      auto defs = (*inst)->getDefList();
      for (auto &Defs : defs)
        def[block].insert(use_inst[*Defs].begin(), use_inst[*Defs].end());
    }
  }
}

void LiveVariableAnalysis::iterate(MachineFunction *func) {
  std::set<MachineBlock *> workList;
  for (auto &block : func->getBlockList()) {
    block->live_in.clear();
    workList.insert(block);
  }

  while (!workList.empty()) {
    auto block = *workList.begin();
    workList.erase(workList.begin());
    block->live_out.clear();
    auto old = block->live_in;
    for (auto &succ : block->getSuccs()) {
      block->live_out.insert(succ->live_in.begin(), succ->live_in.end());
    }
    block->live_in = use[block];
    set_difference(block->live_out.begin(), block->live_out.end(),
                   def[block].begin(), def[block].end(),
                   inserter(block->live_in, block->live_in.end()));
    if (old != block->live_in) {
      for (auto &pred : block->getPreds())
        workList.insert(pred);
    }
  }
}

void LiveVariableAnalysis::BlockUseInstr(MachineFunction *func) {
  for (auto &block : func->getBlockList()) {
    for (auto &inst : block->getInstList()) {
      auto uses = inst->getUseList();
      for (auto &use : uses) {
        use_inst[*use].insert(use);
      }
    }
  }
}
