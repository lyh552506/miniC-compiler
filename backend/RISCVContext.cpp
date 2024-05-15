#include "RISCVContext.hpp"
#include "RISCVAsmPrinter.hpp"
RISCVMOperand* RISCVLoweringContext::Create(Value* val){
    if(auto inst=dynamic_cast<User*>(val)){
        if(auto alloca=dynamic_cast<AllocaInst*>(inst)){
            // this->insert_val2mop(inst, new VirRegister(RISCVTyper(inst->GetType())));
            auto& frameobjs=cur_func->GetFrame()->GetFrameObjs();
            frameobjs.emplace_back(new RISCVFrameObject(inst));
            // frameobjs.emplace_back(std::make_unique<RISCVFrameObject>(inst));
            // frameobjs.emplace_back(std::make_unique<RISCVFrameObject>(alloca->GetType(),alloca->GetName()));
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
    else if(val->isConst())
        return Imm::GetImm(val->as<ConstantData>());
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

RISCVMOperand* RISCVLoweringContext::mapping(Value* val){
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