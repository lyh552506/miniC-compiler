#include "Necromancer.hpp"

static RISCVMOperand* getRISCVSSAValueAlias(Value* val){
    if(auto ssaval=val->as<RISCVSSAValue>()){
        return ssaval->getAlias();
    }
    else if(auto ssainstr=val->as<RISCVSSAInstruction>()){
        return ssainstr->getAlias();
    }
    else assert(0);
}

static Type* RISCVType2TypePtr(RISCVType tp){
    switch (tp)
    {
    case riscv_i32:
        return IntType::NewIntTypeGet();
    case riscv_float32:
        return FloatType::NewFloatTypeGet();
    case riscv_ptr:
        return VoidType::NewVoidTypeGet();
    default:
        assert(0&&"Impossible");
    }

}

void RISCVSSAAlias::setAlias(RISCVMOperand* _realname){
    realname=_realname;
}

RISCVMOperand* RISCVSSAAlias::getAlias(){
    return realname;
}

/*---RISCVSSAValue---*/

RISCVSSAValue::RISCVSSAValue(RISCVMOperand* _realname):Value(RISCVType2TypePtr(_realname->GetType())){
    setAlias(_realname);
}

/*---RISCVSSAInstruction---*/
RISCVMOperand* RISCVSSAInstruction::getAlias(){
    if(opcode==RISCVMIR::STACKREG){
        /// @todo 从 use 里重新创建 stackreg
            assert(0&&"Not Impl");
    }
    return RISCVSSAAlias::getAlias();
}

RISCVSSAInstruction::RISCVSSAInstruction(Type* _tp):User(_tp){}

void RISCVSSAInstruction::print(){
    assert(0**"Not Impl");
}

void RISCVSSAInstruction::setOpcode(RISCVMIR::RISCVISA opcode){
    this->opcode=opcode;
}

RISCVMIR::RISCVISA RISCVSSAInstruction::getOpcode(){
    return opcode;
}

RISCVMIR* RISCVSSAInstruction::reEmit(){
    if(opcode==RISCVMIR::OUTSIDE_PLACEHOLDER||opcode==RISCVMIR::STACKREG){
        return nullptr;
    }
    
    auto newinst=new RISCVMIR(opcode);
    newinst->SetDef(getAlias());
    for(int i=0,size=Getuselist().size();i<size;i++){
        auto op=GetOperand(i);
        auto aliasuse=getRISCVSSAValueAlias(op);
        newinst->AddOperand(aliasuse);
    }
    return newinst;
}

/*---RISCVSSABasicBlock---*/

RISCVSSAValue* RISCVSSABasicBlock::getSSAValue(RISCVMOperand* op){
    auto newval=new RISCVSSAValue(op);
    MemoryManager.push_back(std::make_unique<Value*>(newval));
    return newval;
}

RISCVSSAInstruction* RISCVSSABasicBlock::getSSAInstruction(RISCVMIR::RISCVISA opcode,RISCVMOperand* def){
    auto newinst=new RISCVSSAInstruction(RISCVType2TypePtr(def->GetType()));
    newinst->setOpcode(opcode);
    newinst->setAlias(def);
    MemoryManager.push_back(std::make_unique<Value*>(newinst));
    return newinst;
}

RISCVSSAInstruction* RISCVSSABasicBlock::getSSAInstruction(RISCVMIR::RISCVISA opcode,Type* tp){
    auto newinst=new RISCVSSAInstruction(tp);
    newinst->setOpcode(opcode);
    MemoryManager.push_back(std::make_unique<Value*>(newinst));
    return newinst;
}

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
        if(minst!=nullptr)
            curbb->push_back(minst);
    }
}

RISCVSSABasicBlock::RISCVSSABasicBlock(RISCVBasicBlock* bb){
    setAlias(bb);
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

            /// @todo 把 stagereg 的内容看作 use 扔进去
            assert(0&&"Not Impl");

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