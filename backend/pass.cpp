#include "pass.hpp"

void ChangeBranch(MachineUnit* unit) {
  for (auto& func : unit->getMachineFunctions()) {
    for (auto& block : func->getMachineBasicBlocks()) {
        for (auto& inst : block->getMachineInsts()) {
            if (inst->GetOpcode() == "branch") {
                std::cout << "Here is a br instruction" << std::endl;
                
                BinaryInst* tempinst = dynamic_cast<BinaryInst*>((inst->getIR()->Getuselist())[0]->GetValue());
                tempinst->print();
                (tempinst->Getuselist())[0]->GetValue()->print();

                
            }
        }
    }
  }
}