#include "Type.hpp"

Type::Type(InnerDataType _tp):tp(_tp){}
int Type::layer(){return indirect_layer;}

InnerDataType Type::GetType(){return tp;}

IntType::IntType():Type(IR_Value_INT){
    indirect_layer=0;
}

FloatType::FloatType():Type(IR_Value_Float){
    indirect_layer=0;
}

std::shared_ptr<Type> HasSubType::GetSubType(){return subtype;}
HasSubType::HasSubType(InnerDataType _tp,std::shared_ptr<Type> __tp):Type(_tp),subtype(__tp){}

PointerType::PointerType(std::shared_ptr<Type> ptr):HasSubType(IR_PTR,ptr){
    indirect_layer=subtype->layer()+1;
}
InnerDataType PointerType::GetInnerType(){return subtype->GetType();}

ArrayType::ArrayType(int _num_elements,std::shared_ptr<Type> ptr):HasSubType(IR_ARRAY,ptr),NumEle(_num_elements){
    indirect_layer=subtype->layer()+1;
}
