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

PointerType::PointerType(std::shared_ptr<Type> ptr):Type(IR_PTR),subtype(ptr){
    indirect_layer=subtype->layer()+1;
}
InnerDataType PointerType::GetInnerType(){return subtype->GetType();}

ArrayType::ArrayType(int _num_elements,std::shared_ptr<Type> ptr):Type(IR_ARRAY),NumEle(_num_elements),subtype(ptr){
    indirect_layer=subtype->layer()+1;
}
