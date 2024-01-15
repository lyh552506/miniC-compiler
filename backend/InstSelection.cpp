#include"InstSelection.hpp"

//指令选择
MachineInst* InstSelect(User& inst) {
    MachineInst* machineinst = nullptr;
    // if (auto Tempinst = dynamic_cast<AllocaInst*>(&inst)) {
    //     //将参数放进栈帧
        
    //     //MachineInst* machineinst = MatchAllocaInst(inst);
    //     //return machineinst;
    // }
    // else if (auto Tempinst = dynamic_cast<StoreInst*>(inst)) {
    //     MachineStoreInst* machineinst = dynamic_cast<MachineStoreInst*>(inst);
    //     return machineinst;
    // }
    // else if (auto Tempinst = dynamic_cast<LoadInst*>(inst)) {
    //     MachineInst* machineinst = MatchLoadInst(inst);
    //     return machineinst;
    // }
    // else if (auto Tempinst = dynamic_cast<FPTSI*>(inst)) {
    //     MachineInst* machineinst = MatchFPTSI(inst);
    //     return machineinst;
    // }
    // else if (auto Tempinst = dynamic_cast<SITFP*>(inst)) {
    //     MachineInst* machineinst = MatchSITFP(inst);
    //     return machineinst;
    // }
    // else if (auto Tempinst = dynamic_cast<UnCondInst*>(inst)) {
    //     MachineInst* machineinst = MatchUnCondInst(inst);
    //     return machineinst;
    // }  
    // else if (auto Tempinst = dynamic_cast<CondInst*>(inst)) {
    //     MachineInst* machineinst = MatchCondInst(inst);
    //     return machineinst;
    // }
    // else if (auto Tempinst = dynamic_cast<CallInst*>(inst)) {
    //     MachineInst* machineinst = MatchCallInst(inst);
    //     MachineInst* machineinst = MatchRetInst(inst);
    //     return machineinst;
    // }
    if (auto Tempinst = dynamic_cast<BinaryInst*>(&inst)) {
        machineinst = (MachineInst*)MatchBinaryInst(Tempinst);
    }
    // else if (auto Tempinst = dynamic_cast<RetInst*>(inst)) {
    //     MachineInst* machineinst = MatchRetInst(inst);
    //     return machineinst;
    // }
    else {
        std::cout << "InstSelect Error" << std::endl;
    }
    return machineinst;
} 

MachineBinaryInst* MatchBinaryInst(BinaryInst* inst) {
    std::string op = inst->GetOperation();
    Operand rd = inst->GetDef();
    //std::vector<std::unique_ptr<Use>> list = inst->Getuselist();
    Operand rs1 = (inst->Getuselist())[0]->GetValue();
    Operand rs2 = (inst->Getuselist())[0]->GetValue();
    if (op == "Op_Add") {
        MachineBinaryInst* inst = new MachineBinaryInst("add", rd, rs1, rs2);
        return inst;
    }
    else {
        std::cout << "error: no such machineinst!" << std::endl; 
        return 0;
    }
}




