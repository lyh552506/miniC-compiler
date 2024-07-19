#include "../include/backend/RISCVContext.hpp"
#include "../include/backend/RISCVAsmPrinter.hpp"
RISCVMOperand* RISCVLoweringContext::Create(Value* val){
    if(auto inst=dynamic_cast<User*>(val)){
        if(auto alloca=dynamic_cast<AllocaInst*>(inst)){
            auto& frameobjs=cur_func->GetFrame()->GetFrameObjs();
            frameobjs.emplace_back(new RISCVFrameObject(inst));
            auto subtype=dynamic_cast<HasSubType*>(inst->GetType())->GetSubType();
            if(dynamic_cast<ArrayType*>(subtype)){
                // 是个数组，加载首地址到一个虚拟寄存器
                return cur_func->GetUsedGlobalMapping(frameobjs.back().get());
            }
            return frameobjs.back().get(); 
        }
        else if(auto store=dynamic_cast<StoreInst*>(inst))
            assert(0&&"Can't be Used");
        else if(auto cond=dynamic_cast<CondInst*>(inst))
            assert(0&&"Can't be Used");
        else if(auto uncond=dynamic_cast<UnCondInst*>(inst))
            assert(0&&"Can't be Used");
        else if(auto ret=dynamic_cast<RetInst*>(inst))
            assert(0&&"Can't be Used");
        // else if(auto call=dynamic_cast<CallInst*>(inst))
            // assert("Can't be Used");
        else{
            return createVReg(RISCVTyper(inst->GetType()));
        }
    }
    else if(auto bb=dynamic_cast<BasicBlock*>(val))
        return RISCVBasicBlock::CreateRISCVBasicBlock();
    else if(val->isConst()){
        // change bool const to int const
        if(auto boolval=val->as<ConstIRBoolean>()){
            auto imm=boolval->GetVal();
            return Imm::GetImm(ConstIRInt::GetNewConstant(imm));
        }
        return Imm::GetImm(val->as<ConstantData>());
    }
    else if(auto func=dynamic_cast<Function*>(val))
        return new RISCVFunction(func);
    else if(auto buildin=dynamic_cast<BuildInFunction*>(val)){
        return new RISCVFunction(buildin);
    }
    assert(0&&"Can't be Used");
}
void RISCVLoweringContext::insert_val2mop(Value* val, RISCVMOperand* mop) {
    val2mop.insert(std::make_pair(val, mop));
}

void RISCVLoweringContext::change_mapping(RISCVMOperand* old, RISCVMOperand* new_mop ) {
    for(auto it=val2mop.begin();it!=val2mop.end();it++){
        if(it->second==old){
            it->second=new_mop;
        }
    }
}

RISCVMOperand* RISCVLoweringContext::mapping(Value* val){
    // If the value is a global value, we should refer to the local version.
    if(val->isGlobal()){
        assert(cur_func!=nullptr&&val2mop.find(val)!=val2mop.end());
        return cur_func->GetUsedGlobalMapping(val2mop[val]);
    }
    if(val->isConst()&&val->GetType()==FloatType::NewFloatTypeGet()){
        assert(cur_func!=nullptr&&val->as<ConstantData>()!=nullptr);
        auto imm=Imm::GetImm(val->as<ConstantData>());
        return cur_func->GetUsedGlobalMapping(imm);
    }
    if(val2mop.find(val)==val2mop.end())
        val2mop[val]=Create(val);
    return val2mop[val];
}

void RISCVLoweringContext::operator()(RISCVMIR* minst){
    cur_mbb->push_back(minst);
}

void RISCVLoweringContext::operator()(RISCVBasicBlock* mbb){
    cur_func->push_back(mbb);
    cur_mbb=mbb;
}

void RISCVLoweringContext::operator()(RISCVFunction* mfunc){
    functions.emplace_back(mfunc);
    cur_func=mfunc;
}

VirRegister* RISCVLoweringContext::createVReg(RISCVType type){
    return new VirRegister(type);
}

Value* RISCVLoweringContext::GetValue(RISCVMOperand* mop) {
    for(const auto& pair : val2mop) {
        if(pair.second==mop) {
            return pair.first;
        }
    }
    return nullptr;
}

std::vector<std::unique_ptr<RISCVFunction>>& RISCVLoweringContext::GetFunctions() {return this->functions;}
RISCVFunction*& RISCVLoweringContext::GetCurFunction() {return cur_func;}
RISCVBasicBlock*& RISCVLoweringContext::GetCurBasicBlock() {return cur_mbb;}

extern RISCVAsmPrinter* asmprinter;
void RISCVLoweringContext::print(){
    /// @todo print global variables
    for(auto& mfunc:functions)
        mfunc->printfull();
}