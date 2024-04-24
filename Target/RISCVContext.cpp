#include "RISCVContext.hpp"
RISCVMOperand* RISCVLoweringContext::Create(Value* val){
    if(auto inst=dynamic_cast<User*>(val)){
        if(auto alloca=dynamic_cast<User*>(inst)){
            auto& frameobjs=cur_func->GetFrameObjects();
            frameobjs.emplace_back(std::make_unique<RISCVFrameObject>(alloca->GetType(),alloca->GetName()));
            return frameobjs.back().get();
        }
        else if(auto store=dynamic_cast<StoreInst*>(inst))
            assert("Can't be Used");
        else if(auto cond=dynamic_cast<CondInst*>(inst))
            assert("Can't be Used");
        else if(auto uncond=dynamic_cast<UnCondInst*>(inst))
            assert("Can't be Used");
        else{
            return createVReg(RISCVTyper(inst->GetType()));
        }
    }
    else if(auto bb=dynamic_cast<BasicBlock*>(val))
        return new RISCVBasicBlock(bb->GetName());
    else if(val->isConst())
        return Imm::GetImm(val->as<ConstantData>());
    else if(auto func=dynamic_cast<Function*>(val))
        return new RISCVFunction(func);
    assert(0&&"Can't be Used");
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

void RISCVLoweringContext::print(){
    /// @todo print global variables
    for(auto& mfunc:functions)
        mfunc->printfull();
}