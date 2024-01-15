#include"InstSelection.hpp"

bool is_int(Operand op) {
    if (op->GetType()->GetTypeEnum() == InnerDataType::IR_Value_INT) 
        return true;
    else return false;
}
bool is_float(Operand op) {
    if (op->GetType()->GetTypeEnum() == InnerDataType::IR_Value_Float) 
        return true;
    else return false;
}
//指令选择
MachineInst* InstSelect(User& inst) {
    MachineInst* machineinst = nullptr;
     if (auto Tempinst = dynamic_cast<AllocaInst*>(&inst)) {
        //To Do
        std::cout << "This is an alloca inst." << std::endl;
    }
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
    // else if (auto Tempinst = dynamic_cast<GetElementPtrInst*>(inst)) {
    //     MachineInst* machineinst = MatchCallInst(inst);
    //     MachineInst* machineinst = MatchRetInst(inst);
    //     return machineinst;
    // }
    else if (auto Tempinst = dynamic_cast<BinaryInst*>(&inst)) {
        machineinst = MatchBinaryInst(Tempinst);
    }
    // else if (auto Tempinst = dynamic_cast<RetInst*>(inst)) {
    //     MachineInst* machineinst = MatchRetInst(inst);
    //     return machineinst;
    // }
    else {
        std::cout << "Error: No Such Instruction." << std::endl;
    }
    return machineinst;
} 

// MachineInst* ConvertToMachineInst (std::variant<MachineBinaryInst*, MachineCmpInst*>& variant) {
//     return std::visit([](auto&& arg) -> MachineInst* {
//         using T = std::decay_t<decltype(arg)>;
//         if constexpr (std::is_same_v<T, MachineBinaryInst*>) {
//             return static_cast<MachineInst*>(arg);
//         } else if constexpr (std::is_same_v<T, MachineCmpInst*>) {
//             return static_cast<MachineInst*>(arg);
//         } else {
//             return nullptr;
//         }
//     }, variant);    
// }
MachineInst* MatchBinaryInst(BinaryInst* inst) {
    std::string op = inst->GetOperation();
    Operand rd = inst->GetDef();
    //std::vector<std::unique_ptr<Use>> list = inst->Getuselist();
    Operand rs1 = (inst->Getuselist())[0]->GetValue();
    Operand rs2 = (inst->Getuselist())[0]->GetValue();
    if (op == "Op_Add") {
        if (is_int(rs1) && is_int(rs2)) {
            MachineInst* inst = new MachineInst("addw", rd, rs1, rs2);
            return inst;
        }
        else if (0) {
            //To Do
            //imm
        }
    }
    else if (op == "Op_Sub") {
        if (is_int(rs1) && is_int(rs2)) {
            MachineInst* inst = new MachineInst("subw", rd, rs1, rs2);
            return inst;
        }
        else if (0) {
            //To Do
            //imm
        }
    }
    else if (op == "Op_Mul") {
        if (is_int(rs1) && is_int(rs2)) {
            MachineInst* inst = new MachineInst("mulw", rd, rs1, rs2);
            return inst;
        }
        else if (0) {
            //To Do
            //imm
        }
    }    
    else if (op == "Op_Div") {
        if (is_int(rs1) && is_int(rs2)) {
            MachineInst* inst = new MachineInst("divw", rd, rs1, rs2);
            return inst;
        }
        else if (0) {
            //To Do
            //imm
        }
    }      
    else if (op == "Op_Mod") {
        if (is_int(rs1) && is_int(rs2)) {
            MachineInst* inst = new MachineInst("remw", rd, rs1, rs2);
            return inst;
        }
        else if (0) {
            //To Do
            //imm
        }
    }
    else if (op == "Op_And") {
        if (is_int(rs1) && is_int(rs2)) {
            MachineInst* inst = new MachineInst("and", rd, rs1, rs2);
            return inst;
        }
        else if (0) {
            //To Do
            //imm
        }
    }
    else if (op == "Op_Or") {
        if (is_int(rs1) && is_int(rs2)) {
            MachineInst* inst = new MachineInst("or", rd, rs1, rs2);
            return inst;
        }
        else if (0) {
            //To Do
            //imm
        }
    }
    //To Do 
    else if (op == "Op_E") {
        if (is_int(rs1) && is_int(rs2)) {
            MachineInst* inst = new MachineInst("eq", rd, rs1, rs2);
            return inst;
        }
        else if (0) {
            //To Do
            //imm
        }
    }
    //...
    else {
        std::cout << "error: no such machineinst!" << std::endl; 
        //return 0;
    }
    
}




