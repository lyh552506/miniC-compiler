#include "../include/lib/TypeTrans.hpp"

Operand Floater(Operand op,BasicBlock* bb){
    if(op->GetType()==FloatType::NewFloatTypeGet())
        return op;
    if(op->isConst()){
        if(auto op_int=dynamic_cast<ConstIRInt*>(op))
            return ConstIRFloat::GetNewConstant((float)op_int->GetVal());
        else if(auto op_float=dynamic_cast<ConstIRBoolean*>(op))
            return ConstIRFloat::GetNewConstant((float)op_float->GetVal());
        else
            assert(false);
    }
    else{
        assert(bb!=nullptr);
        if(op->GetType()==IntType::NewIntTypeGet())
            return bb->GenerateSITFP(op);
        else
            assert(false);
    }
}

Operand Inter(Operand op,BasicBlock* bb){
    if(op->GetType()==IntType::NewIntTypeGet())
        return op;
    if(op->isConst()){
        if(auto op_int=dynamic_cast<ConstIRBoolean*>(op))
            return ConstIRInt::GetNewConstant((int)op_int->GetVal());
        else if(auto op_float=dynamic_cast<ConstIRFloat*>(op))
            return ConstIRInt::GetNewConstant((int)op_float->GetVal());
        else
            assert(false);
    }
    else{
        assert(bb!=nullptr);
        if(op->GetType()==FloatType::NewFloatTypeGet())
            return bb->GenerateFPTSI(op);
        else
            assert(false);
    }
}