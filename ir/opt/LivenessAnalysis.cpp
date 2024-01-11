#include "LivenessAnalysis.hpp"
#include <algorithm>
#include <iostream>

void LivenessAnalysis::pass(Function* func)
{
  for(auto &BB:func->getBlockList())
  {
    GetBlockLiveout(BB.get());
    GetBlockLivein(BB.get());
    iterate(BB.get());
  }
}

void LivenessAnalysis::GetBlockLivein(BasicBlock* block)
{
  std::set<Value*> _BlockLiveout = BlockLiveout[block];
  for(auto inst = block->getInstList().rbegin();inst != block->getInstList().rend(); ++inst)
  {
    for(auto &usePtr:(*inst)->Getuselist())
    {
      Value* useValue = usePtr->GetValue();
      _BlockLiveout.insert(useValue);
    }
    Value* DefValue = (*inst)->GetDef();
    _BlockLiveout.erase(DefValue);
  }
  BlockLivein[block] = _BlockLiveout;
}

void LivenessAnalysis::GetBlockLiveout(BasicBlock* block)
{
  std::set<Value*> _BlockLivein = BlockLivein[block];
  std::set<Value*> _BlockLiveout = BlockLiveout[block];
  auto inst = block->getInstList().back();
  if(auto _CondInst = dynamic_cast<CondInst *>(inst))
  {
    auto _Use = inst->Getuselist(); 
    BlockLivein[block].insert(_Use[1]->GetValue());
    auto _block_Pred1 = dynamic_cast<BasicBlock *>(_Use[1]->GetValue());
    auto _block_Pred2 = dynamic_cast<BasicBlock *>(_Use[2]->GetValue());
    BlockLiveout[block].insert(BlockLivein[_block_Pred1]);
  }
  if(auto _UnCondInst = dynamic_cast<UnCondInst *>(inst))
  {
    auto _Use = inst->Getuselist();
    auto _block_Pred = dynamic_cast<BasicBlock *>(_Use[0]->GetValue());
    
  }

}
// void LiveVariableAnalysis::pass(MachineUnit *unit) {
//   for (auto &func : unit->getFuncList()) {
//     BlockUseInstr(func);
//     BlockDefUse(func);
//     iterate(func);
//   } 
// }

// void LiveVariableAnalysis::pass(MachineFunction *func) {
//   BlockUseInstr(func);
//   BlockDefUse(func);
//   iterate(func);
// }

// void LiveVariableAnalysis::BlockDefUse(MachineFunction *func) {
//   for (auto &block : func->getBlockList()) {
//     for (auto inst = block->getInstList().begin();
//          inst != block->getInstList().end(); inst++) {
//       auto user = (*inst)->getUseList();
//       std::set<MachineOperand *> temp(user.begin(), user.end());
//       set_difference(temp.begin(), temp.end(), def[block].begin(),
//                      def[block].end(), inserter(use[block], use[block].end()));
//       auto defs = (*inst)->getDefList();
//       for (auto &Defs : defs)
//         def[block].insert(use_inst[*Defs].begin(), use_inst[*Defs].end());
//     }
//   }
// }

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

// void LiveVariableAnalysis::BlockUseInstr(MachineFunction *func) {
//   for (auto &block : func->getBlockList()) {
//     for (auto &inst : block->getInstList()) {
//       auto uses = inst->getUseList();
//       for (auto &use : uses) {
//         use_inst[*use].insert(use);
//       }
//     }
//   }
// }


