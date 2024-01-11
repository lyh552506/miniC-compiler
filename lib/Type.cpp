#include "Type.hpp"
#include <iostream>
#include <cassert>

Type::Type(InnerDataType _tp):tp(_tp){}
int Type::layer(){return indirect_layer;}
void Type::print(){
    switch (tp)
    {
    case IR_Value_INT:
        std::cout<<"i32";
        break;
    case IR_Value_Float:
        std::cout<<"float";
        break;
    case IR_Value_VOID:
        std::cout<<"void";
        break;
    case IR_PTR:
        std::cout<<"ptr";
        break;
    case IR_ARRAY:
        std::cout<<"array";
        break;
    default:
        assert(1);
    }
}

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
