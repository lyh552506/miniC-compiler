#include "Necromancer.hpp"

void Necromancer::runOnBasicBlock(std::set<MOperand>& livein,std::set<MOperand>& liveout,RISCVBasicBlock* bb){
    storage[bb]=std::make_unique<RISCVSSABasicBlock>(bb);
    auto& ssabb=storage[bb];
    
    
    std::unordered_map<RISCVMOperand*,Value*> RegNamer;
    auto getRegVersion=[&](RISCVMOperand* mop){
        if(auto it=RegNamer.find(mop);it==RegNamer.end())
            RegNamer[mop]=ssabb->getSSAValue(mop);
        return RegNamer[mop];
    };

    auto updateRegVersion=[&RegNamer](RISCVMOperand* mop,Value* val){
        RegNamer[mop]=val;
        return RegNamer[mop];
    };

    auto normal_visiter=[&](RISCVMIR* inst){
        auto ssainst=ssabb->getSSAInstruction(inst->GetOpcode(),inst->GetDef());
        for(auto i=0,size=inst->GetOperandSize();i<size;i++){
            auto reg=inst->GetOperand(i);
            auto ssavalue=getRegVersion(reg);
            ssainst->add_use(ssavalue);
        }
        auto def=inst->GetDef();
        if(def!=nullptr){
            updateRegVersion(def,ssainst);
        }
    };


    for(auto inst:*bb){
        // 所有的 caller saved 都会被更新到 call 指令里
        if(inst->GetOpcode()==RISCVMIR::call){
            auto ssainst=ssabb->getSSAInstruction(inst->GetOpcode(),VoidType::NewVoidTypeGet());
            for(auto i=0,size=inst->GetOperandSize();i<size;i++){
                auto reg=inst->GetOperand(i);
                auto ssavalue=getRegVersion(reg);
                ssainst->add_use(ssavalue);
            }
            for(auto i=0;i<64;i++){
                auto phyreg=PhyRegMask::GetPhyReg(i);
                if(phyreg->isCallerSaved())
                    updateRegVersion(phyreg,ssainst);
            }         
        }
        else{
            normal_visiter(inst);
        }
    }

    // dealwith liveout here
    auto outside_placeholder=ssabb->getSSAInstruction(RISCVMIR::OUTSIDE_PLACEHOLDER,VoidType::NewVoidTypeGet());
    for(auto reg:liveout){
        auto ssavalue=getRegVersion(reg);
        outside_placeholder->add_use(ssavalue);
    }
}

bool Necromancer::run(RISCVFunction* func){
    // Clear the data structure, in case it's used multiple times.
    storage.clear();
    // Liveness analyze
    auto liveinfo=BlockLiveInfo(func);
    liveinfo.RunOnFunction();
    // Run on every basicblock
    for(auto mbb:*func){
        auto &livein=liveinfo.BlockLivein[mbb];
        auto &liveout=liveinfo.BlockLiveout[mbb];
        runOnBasicBlock(livein,liveout,mbb);
    }
}