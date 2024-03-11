#include "pass.hpp"

void ChangeBranch(MachineUnit* unit) {
  for (auto& func : unit->getMachineFunctions()) {
    for (auto& block : func->getMachineBasicBlocks()) {
        for (auto& inst : block->getMachineInsts()) {
            if (inst->GetOpcode() == "branch") {
                //inst is the branch instruction
                //icmpinst is the icmp instruction
                BinaryInst* icmpinst = dynamic_cast<BinaryInst*>((inst->getIR()->Getuselist())[0]->GetValue());
                Operand icmprs1 = (icmpinst->Getuselist())[0]->GetValue();
                Operand icmprs2 = (icmpinst->Getuselist())[1]->GetValue();

                //均为常数的情况，应在中端处理
                //situation1: one is constant, the other is not
                if ( icmprs1->isConst() || icmprs2->isConst() ) {

                }
                //situation2: both are not constant
                else {
                    
                }
                
            }
        }
    }
  }
}