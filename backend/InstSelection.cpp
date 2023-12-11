#include<iostream>
#include"MachineCode.hpp"
#include"InstSelection.hpp"
#include"../lib/CFG.hpp"

MachineInst* MatchInstWithDef(User* inst) {
    auto def = inst->GetDef();
    
    //std::list 遍历
    for (auto rs : inst->getuselist()) {
        
    }
}


//指令选择
//new inst;
MachineInst* InstSelect(User* inst) {
    MachineInst* machineinst;
    //%def=%?1+%?2
    if (auto Tempinst = dynamic_cast<InstWithDef*>(inst)) {
        MatchInstWithDef(inst);
    }    
    else if (auto Tempinst = dynamic_cast<AllocaInst*>(inst)) {
        
    }
    else if (auto Tempinst = dynamic_cast<StoreInst*>(inst)) {
        
    }
    else if (auto Tempinst = dynamic_cast<LoadInst*>(inst)) {
        
    }
    else if (auto Tempinst = dynamic_cast<UnCondInst*>(inst)) {
        
    }  
    else if (auto Tempinst = dynamic_cast<CondInst*>(inst)) {
        
    }
    else if (auto Tempinst = dynamic_cast<CallInst*>(inst)) {
        
    }
    else if (auto Tempinst = dynamic_cast<RetInst*>(inst)) {
        
    }
    else if (auto Tempinst = dynamic_cast<BinaryInst*>(inst)) {
        
    }
    else 
        std::cout << "Invalid Instruction!" << std::endl;


    return machineinst;
} 