#include "Necromancer.hpp"


/*---RISCVSSABasicBlock---*/
RISCVSSABasicBlock* Necromancer::getSSABasicBlock(RISCVBasicBlock* bb){
    if(auto it=storage.find(bb);it!=storage.end()){
        return it->second.get();
    }
    assert(0&&"Could not be possible");
}

void RISCVSSABasicBlock::reEmit(){
    auto curbb=getAlias()->as<RISCVBasicBlock>();
    assert(curbb!=nullptr&&"Impossible");

    curbb->clear();

    for(auto inst:*this){
        auto minst=inst->reEmit();
        // 1. placeholder, 
        if(minst!=nullptr)
            curbb->push_back(minst);
    }

}

/*---Necromancer---*/
void Necromancer::runOnBasicBlock(std::set<MOperand>& livein,std::set<MOperand>& liveout,RISCVBasicBlock* bb){
    storage[bb]=std::make_unique<RISCVSSABasicBlock>(bb);
    auto& ssabb=storage[bb];
    
    std::unordered_map<RISCVMOperand*,Value*> RegNamer;
    auto getRegVersion=[&](RISCVMOperand* mop){
        if(auto it=RegNamer.find(mop);it==RegNamer.end())
            RegNamer[mop]=ssabb->getSSAValue(mop);
        return RegNamer[mop];
    };

    auto updateRegVersion=[&](RISCVMOperand* mop,Value* val){
        RegNamer[mop]=val;
        return RegNamer[mop];
    };

    auto updateStackRegister=[&](RISCVMOperand* reg) -> Value* {
        if(auto stackreg=reg->as<StackRegister>()){
            // 好像不需要把这个东西放到 RegNamer 里...
            auto stackreginst=ssabb->getSSAInstruction(RISCVMIR::STACKREG,stackreg);
            ssabb->push_back(stackreginst);
        }
        return nullptr;
    };

    auto normal_visiter=[&](RISCVMIR* inst){
        auto ssainst=ssabb->getSSAInstruction(inst->GetOpcode(),inst->GetDef());
        for(auto i=0,size=inst->GetOperandSize();i<size;i++){
            auto reg=inst->GetOperand(i);
            Value* ssavalue;
            if((ssavalue=updateStackRegister(reg))==nullptr)
                ssavalue=getRegVersion(reg);
            ssainst->add_use(ssavalue);
        }
        auto def=inst->GetDef();
        if(def!=nullptr)
            updateRegVersion(def,ssainst);
        ssabb->push_back(ssainst);
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