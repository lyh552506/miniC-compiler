#include "InstSelection.hpp"

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
bool need_load(User* inst) { // icmp
    Operand rd = inst->GetDef();
    Operand rs1 = (inst->Getuselist())[0]->GetValue();
    Operand rs2 = (inst->Getuselist())[1]->GetValue();
    if (rs1->isConst() && rs2->isConst()) {
        return false;
    }
    else if (rs1->isConst() && rs2->isConst() == false) {
        return true;
    }
    else if (rs1->isConst() == false && rs2->isConst()) {
        return true;
    }
    else {
        return false;
    }
}
void add_inst(MachineInst* inst, MachineBasicBlock* parent, mylist<BasicBlock, User>::iterator& it) {
    std::string opcode = inst->GetOpcode();
    if (opcode.find("icmp") != std::string::npos) {
        std::string head = "i_";
        std::string mid1 = "slt";
        std::string mid2 = "xor_";
        std::string tail = "xori";
        std::string le = "le";
        std::string gt = "gt";
        if (opcode.find(head) != std::string::npos) {
            LiInst* liInst = nullptr;
            MachineInst* MliInst = nullptr;
            if (opcode.find(le) != std::string::npos || opcode.find(gt) != std::string::npos) {
                liInst = new LiInst(inst->GetRs1());
                inst->getIR()->RSUW(0, liInst->GetDef());
                inst->SetRs1(liInst->GetDef());
                MliInst = new MachineInst(liInst, parent, "li", liInst->GetDef(), GetOperand(liInst, 0));
            }
            else {
                liInst = new LiInst(inst->GetRs2());
                inst->getIR()->RSUW(1, liInst->GetDef());
                inst->SetRs2(liInst->GetDef());
                MliInst = new MachineInst(liInst, parent, "li", liInst->GetDef(), GetOperand(liInst, 0));
            }
            it.insert_before(liInst);
            parent->addMachineInst(MliInst);
        }

        if (opcode.find(mid1) != std::string::npos) {
            inst->SetOpcode("slt");
        }
        else if (opcode.find(mid2) != std::string::npos) {
            inst->SetOpcode("xor");
        }
        parent->addMachineInst(inst);

        if (opcode.find(tail) != std::string::npos) {
            Operand rs2 = ConstIRInt::GetNewConstant(1); //issue：常数 1
            XorInst* xorInst = new XorInst(inst->GetRd(), "xori", rs2);
            MachineInst* MxorInst = new MachineInst(xorInst, parent, "xori", xorInst->GetDef(), GetOperand(xorInst, 0), GetOperand(xorInst, 1));
            
            //std::cout << "insert xorInst:"  << xorInst->GetName() << " after icmp:" << inst->getIR()->GetName() << std::endl;
            it.insert_after(xorInst);
            ++it;
            
            parent->addMachineInst(MxorInst);
        }
    }

    else if (opcode.find("beqz") != std::string::npos) {
        parent->addMachineInst(inst);
        UnCondInst* uncondInst = new UnCondInst(dynamic_cast<BasicBlock*>((inst->getIR()->Getuselist())[1]->GetValue()));

        // 不再对中端IR进行维护
        // --it;
        // User* last = *it;
        // inst->getIR()->RSUW(0, last->GetDef());
        // inst->SetRd(last->GetDef());
        // ++it;
        // it.insert_after(uncondInst);
        // ++it;
        MachineInst* jInst = MatchUnCondInst(parent, uncondInst);
        parent->addMachineInst(jInst);
    }
    
    else parent->addMachineInst(inst);
}

//指令选择
MachineInst* InstSelect(MachineBasicBlock* parent, User& inst) {
    MachineInst* machineinst = nullptr;
     if (auto Tempinst = dynamic_cast<AllocaInst*>(&inst)) {
        machineinst = new MachineInst(&inst, parent, "alloca");
    }
    else if (auto Tempinst = dynamic_cast<StoreInst*>(&inst)) {
        machineinst = MatchStoreInst(parent,Tempinst);
    }
    else if (auto Tempinst = dynamic_cast<LoadInst*>(&inst)) {
        machineinst = MatchLoadInst(parent, Tempinst);
    }
    else if (auto Tempinst = dynamic_cast<FPTSI*>(&inst)) {
        machineinst = MatchFPTSI(parent, Tempinst);
    }
    else if (auto Tempinst = dynamic_cast<SITFP*>(&inst)) {
        machineinst = MatchSITFP(parent, Tempinst);
    }
    else if (auto Tempinst = dynamic_cast<UnCondInst*>(&inst)) {
        parent->set_succNum(1);
        machineinst = MatchUnCondInst(parent, Tempinst);
    }
    else if (auto Tempinst = dynamic_cast<CondInst*>(&inst)) {
        parent->set_succNum(0);
        machineinst = MatchCondInst(parent, Tempinst);
    }
    else if (auto Tempinst = dynamic_cast<CallInst*>(&inst)) {
        machineinst = MatchCallInst(parent, Tempinst);
    }
    // else if (auto Tempinst = dynamic_cast<GetElementPtrInst*>(inst)) {
    //     machineinst = MatchCallInst(inst);
    // }
    else if (auto Tempinst = dynamic_cast<BinaryInst*>(&inst)) {
        machineinst = MatchBinaryInst(parent, Tempinst);
    }
    else if (auto Tempinst = dynamic_cast<RetInst*>(&inst)) {
        machineinst = MatchRetInst(parent, Tempinst);
    }
    else {
        machineinst = new MachineInst(&inst, parent, "white");
    }
    return machineinst;
}
MachineInst* MatchStoreInst(MachineBasicBlock* parent, StoreInst* inst) {
    std::string op = "sw";
    Operand rd = (inst->Getuselist())[0]->GetValue();
    Operand rs1 = (inst->Getuselist())[1]->GetValue();
    MachineInst* machineinst = new MachineInst(inst, parent, op, rd, rs1);
    machineinst->SetDefs(rs1);
    machineinst->GetUses().push_back(rd);
    return machineinst;
}
MachineInst* MatchLoadInst(MachineBasicBlock* parent, LoadInst* inst) {
    std::string op = "lw";
    Operand rd = inst->GetDef();
    Operand rs1 = (inst->Getuselist())[0]->GetValue();
    MachineInst* machineinst = new MachineInst(inst, parent, op, rd, rs1);
    machineinst->SetDefs(rd);
    machineinst->GetUses().push_back(rs1);
    return machineinst;
}
MachineInst* MatchFPTSI(MachineBasicBlock* parent,FPTSI* inst) {
    std::string op = "fcvt.s.w";
    Operand rd = inst->GetDef();
    Operand rs1 = (inst->Getuselist())[0]->GetValue();
    MachineInst* machineinst = new MachineInst(inst, parent, op, rd, rs1);
    machineinst->SetDefs(rd);
    machineinst->GetUses().push_back(rs1);
    return machineinst;
}
MachineInst* MatchSITFP(MachineBasicBlock* parent,SITFP* inst) {
    std::string op = "fcvt.w.s";
    Operand rd = inst->GetDef();
    Operand rs1 = (inst->Getuselist())[0]->GetValue();
    MachineInst* machineinst = new MachineInst(inst, parent, op, rd, rs1);
    machineinst->SetDefs(rd);
    machineinst->GetUses().push_back(rs1);
    return machineinst;
}
MachineInst* MatchUnCondInst(MachineBasicBlock* parent, UnCondInst* inst) {
    std::string op = "j";
    Operand rd = inst->Getuselist()[0]->GetValue();
    MachineInst* machineinst = new MachineInst(inst, parent, op, rd);
    // 特殊
    machineinst->GetUses().push_back(rd);  
    return machineinst;
}
MachineInst* MatchCondInst(MachineBasicBlock* parent, CondInst* inst) {
    std::string op = "beqz";
    Operand rd =  inst->Getuselist()[0]->GetValue();
    std::string condi = dynamic_cast<BinaryInst*>(rd)->GetOperation();
    Operand rs1 = inst->Getuselist()[1]->GetValue();
    Operand rs2 = inst->Getuselist()[2]->GetValue();
    if (condi == "Op_E") { // beqz rs lable1 
        Operand rs1 = (inst->Getuselist())[2]->GetValue();
        Operand rs2 = (inst->Getuselist())[1]->GetValue();
    } else {} // beqz rs label2
    MachineInst* machineinst = new MachineInst(inst, parent, op, rd, rs1, rs2);
    machineinst->GetUses().push_back(rd);    
    machineinst->GetUses().push_back(rs1);    
    machineinst->GetUses().push_back(rs2);
    return machineinst;
}
MachineInst* MatchCallInst(MachineBasicBlock* parent, CallInst* inst) {
    Operand rd = inst->Getuselist()[0]->GetValue();
    MachineInst* machineinst = new MachineInst(inst, parent, "call", rd);
    int i=1;
    // 
    while (Value* rs =dynamic_cast<Value*>(inst->Getuselist()[i]->GetValue())) {
        machineinst->GetUses().push_back(rs);
        i++;
    }
    return machineinst;
}
MachineInst* MatchRetInst(MachineBasicBlock* parent, RetInst* inst) {
    MachineInst* machineinst = nullptr;
    if(inst->Getuselist().empty()) {
        machineinst = new MachineInst(inst, parent, "ret");
        return machineinst;
    }
    Operand rd = inst->Getuselist()[0]->GetValue(); 
    machineinst = new MachineInst(inst, parent, "ret", rd);
    return machineinst;
}
MachineInst* MatchBinaryInst(MachineBasicBlock* parent, BinaryInst* inst) {
    MachineInst* machineinst = nullptr;
    std::string op = inst->GetOperation();
    std::string opcode;
    Operand rd = inst->GetDef();
    Operand rs1 = GetOperand(inst, 0);
    Operand rs2 = GetOperand(inst, 1);
    if (op == "Op_Add") {
        if (is_int(rs1) && is_int(rs2)) 
            opcode = "addw";
        else if (is_float(rs1) && is_float(rs2)) 
            opcode = "fadd.s";
        else if (rs1->isConst()) {
            opcode = "addi";
            Operand temp = rs1;
            rs1 = rs2;
            rs2 = temp;
        }
        else if (rs2->isConst()) {
            opcode = "addi";
        }
        else opcode = "white";
    }
    else if (op == "Op_Sub") {
        if (is_int(rs1) && is_int(rs2)) 
            opcode = "subw";
        else if (is_float(rs1) && is_float(rs2)) 
            opcode = "fsub.s";
        else opcode = "white";
    }
    else if (op == "Op_Mul") {
        if (is_int(rs1) && is_int(rs2)) 
            opcode = "mulw";
        else if (is_float(rs1) && is_float(rs2)) 
            opcode = "fmul.s";
        else opcode = "white";
    }
    else if (op == "Op_Div") {
        if (is_int(rs1) && is_int(rs2)) 
            opcode = "divw";
        else if (is_float(rs1) && is_float(rs2)) 
            opcode = "fdiv.s";
        else opcode = "white";
    }  
    else if (op == "Op_Mod") {
        if (is_int(rs1) && is_int(rs2)) 
            opcode = "remw";
        // %符号只能用于整型
        else opcode = "white";
    }  
    else if (op == "Op_And") {
        if (is_int(rs1) && is_int(rs2)) 
            opcode = "and";
        else if (rs1->isConst()) {
            opcode = "andi";
            Operand temp = rs1;
            rs1 = rs2;
            rs2 = temp;
        }
        else if (rs2->isConst()) {
            opcode = "andi";
        }
        else opcode = "white";
    }  
    else if (op == "Op_Or") {
        if (is_int(rs1) && is_int(rs2)) 
            opcode = "or";
        else if (rs1->isConst()) {
            opcode = "ori";
            Operand temp = rs1;
            rs1 = rs2;
            rs2 = temp;
        }
        else if (rs2->isConst()) {
            opcode = "ori";
        }
        else opcode = "white";
    }
    else if (op == "Op_E" || op == "Op_NE" || op == "Op_G" || op == "Op_GE" || op == "Op_L" || op == "Op_LE") {
        // need li inst
        opcode = "icmp_"; // head "icmp_"
        if ( need_load(inst) ) {
            Operand rs = rs1->isConst() ? rs1 : rs2;
            if (rs1 == rs) {
                rs1 = rs2;
                rs2 = rs;
            }
            opcode += "i_"; // head "i_"
        }
        // without li inst
        if (op == "Op_E") {
            opcode += "xor_eq_"; // middle "xor_"
        }
        else if (op == "Op_NE") {
            opcode += "xor_ne_";
        }
        else if (op == "Op_GE" ) {
            opcode += "slt_xori"; // tail "_xori"
        }
        else if (op == "Op_LE") {
            // slt rd, rs2, rs1
            // xori r, rd, 1
            opcode += "le_"; // special "le_"
            opcode += "slt_xori"; // tail "_xori"
            machineinst = new MachineInst(inst, parent, opcode, rd, rs2, rs1);
            return machineinst;
        }
        else if (op == "Op_G" ) {
            // slt rd, rs2, rs1
            opcode += "gt_"; // special "gt_"
            opcode += "slt_"; 
            machineinst = new MachineInst(inst, parent, opcode, rd, rs2, rs1);
            return machineinst;
        }
        else {
            opcode += "slt" ; // middle "slt"
        }
    }
    else {
        std::cout << "Error: No Such Binaryinst!" << std::endl;
        machineinst = new MachineInst(inst, parent, "white");
        return machineinst; 
    }
    machineinst = new MachineInst(inst, parent, opcode, rd, rs1, rs2);
    machineinst->SetDefs(rd);
    machineinst->GetUses().push_back(rs1);
    machineinst->GetUses().push_back(rs2);
    return machineinst;
}