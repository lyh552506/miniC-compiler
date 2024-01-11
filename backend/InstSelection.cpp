#include<iostream>
#include"MachineCode.hpp"
#include"InstSelection.hpp"
#include"../lib/CFG.hpp"

//指令选择
//new inst;
MachineInst* InstSelect(User* inst) {
    MachineInst* machineinst;
    //%def=%?1+%?2
    if (auto Tempinst = dynamic_cast<AllocaInst*>(inst)) {
        //将参数放进栈帧
        MachineInst* machineinst = MatchAllocaInst(inst);
        return machineinst;
    }
    else if (auto Tempinst = dynamic_cast<StoreInst*>(inst)) {
        MachineInst* machineinst = MatchStoreInst(inst);
        return machineinst;
    }
    else if (auto Tempinst = dynamic_cast<LoadInst*>(inst)) {
        MachineInst* machineinst = MatchLoadInst(inst);
        return machineinst;
    }
    else if (auto Tempinst = dynamic_cast<FPTSI*>(inst)) {
        MachineInst* machineinst = MatchFPTSI(inst);
        return machineinst;
    }
    else if (auto Tempinst = dynamic_cast<SITFP*>(inst)) {
        MachineInst* machineinst = MatchSITFP(inst);
        return machineinst;
    }
    else if (auto Tempinst = dynamic_cast<UnCondInst*>(inst)) {
        MachineInst* machineinst = MatchUnCondInst(inst);
        return machineinst;
    }  
    else if (auto Tempinst = dynamic_cast<CondInst*>(inst)) {
        MachineInst* machineinst = MatchCondInst(inst);
        return machineinst;
    }
    else if (auto Tempinst = dynamic_cast<CallInst*>(inst)) {
        MachineInst* machineinst = MatchCallInst(inst);
        MachineInst* machineinst = MatchRetInst(inst);
        return machineinst;
    }
    else if (auto Tempinst = dynamic_cast<BinaryInst*>(inst)) {
        MachineInst* machineinst = MatchBinaryInst(inst);
        return machineinst;
    }
    else if (auto Tempinst = dynamic_cast<RetInst*>(inst)) {
        MachineInst* machineinst = MatchRetInst(inst);
        return machineinst;
    }
    else {
        std::cout << "InstSelect Error" << std::endl;
    }
    return machineinst;
} 

MachineInst* MatchAllocaInst(User* inst) {
    //左操作数
    //auto rd = inst->GetDes();
    MachineOperand* offset ;

    //右操作数  std::list 遍历
    // for (auto rs : inst->getuselist()) {
        
    // }
    MachineOperand* rs2 ;
    MachineOperand* rs1 ;
    MachineInst* machineinst = new MachineStoreInst(MachineStoreInst::sw, rs2, rs1, offset);
    return machineinst;
}

MachineInst* MatchStoreInst(User* inst) {
    //左操作数
    //auto rd = inst->GetDes();
    MachineOperand* offset ;

    //右操作数  std::list 遍历
    // for (auto rs : inst->getuselist()) {
        
    // }
    MachineOperand* rs2 ;
    MachineOperand* rs1 ;
    MachineInst* machineinst = new MachineStoreInst(MachineStoreInst::sw, rs2, rs1, offset);
    return machineinst;
}

MachineInst* MatchFPTSI(User* inst) {
    //左操作数
    //auto rd = inst->GetDes();
    MachineOperand* offset ;

    //右操作数  std::list 遍历
    // for (auto rs : inst->getuselist()) {
        
    // }
    MachineOperand* rs2 ;
    MachineOperand* rs1 ;
    MachineInst* machineinst = new MachineStoreInst(MachineStoreInst::sw, rs2, rs1, offset);
    return machineinst;
}

MachineInst* MatchSITFP(User* inst) {
    //左操作数
    //auto rd = inst->GetDes();
    MachineOperand* offset ;

    //右操作数  std::list 遍历
    // for (auto rs : inst->getuselist()) {
        
    // }
    MachineOperand* rs2 ;
    MachineOperand* rs1 ;
    MachineInst* machineinst = new MachineStoreInst(MachineStoreInst::sw, rs2, rs1, offset);
    return machineinst;
}

MachineInst* MatchUnCondInst(User* inst) {
    //左操作数
    //auto rd = inst->GetDes();
    MachineOperand* offset ;

    //右操作数  std::list 遍历
    // for (auto rs : inst->getuselist()) {
        
    // }
    MachineOperand* rs2 ;
    MachineOperand* rs1 ;
    MachineInst* machineinst = new MachineStoreInst(MachineStoreInst::sw, rs2, rs1, offset);
    return machineinst;
}

MachineInst* MatchCallInst(User* inst) {
    //左操作数
    //auto rd = inst->GetDes();
    MachineOperand* offset ;

    //右操作数  std::list 遍历
    // for (auto rs : inst->getuselist()) {
        
    // }
    MachineOperand* rs2 ;
    MachineOperand* rs1 ;
    MachineInst* machineinst = new MachineStoreInst(MachineStoreInst::sw, rs2, rs1, offset);
    return machineinst;
}

MachineInst* MatchRetInst(User* inst) {
    //左操作数
    //auto rd = inst->GetDes();
    MachineOperand* offset ;

    //右操作数  std::list 遍历
    // for (auto rs : inst->getuselist()) {
        
    // }
    MachineOperand* rs2 ;
    MachineOperand* rs1 ;
    MachineInst* machineinst = new MachineStoreInst(MachineStoreInst::sw, rs2, rs1, offset);
    return machineinst;
}

MachineInst* MatchBinaryInst(User* inst) {
    //左操作数
    //auto rd = inst->GetDes();
    MachineOperand* offset ;

    //右操作数  std::list 遍历
    // for (auto rs : inst->getuselist()) {
        
    // }
    MachineOperand* rs2 ;
    MachineOperand* rs1 ;
    MachineInst* machineinst = new MachineStoreInst(MachineStoreInst::sw, rs2, rs1, offset);
    return machineinst;
}

MachineInst* MatchLoadInst(User* inst) {
    //左操作数
    //auto rd = inst->GetDes();
    MachineOperand* offset ;

    //右操作数  std::list 遍历
    // for (auto rs : inst->getuselist()) {
        
    // }
    MachineOperand* rs2 ;
    MachineOperand* rs1 ;
    MachineInst* machineinst = new MachineStoreInst(MachineStoreInst::sw, rs2, rs1, offset);
    return machineinst;
}


