#include "Type.hpp"

Type::Type(InnerDataType _tp):tp(_tp){}

InnerDataType Type::GetType(){return tp;}

IntType::IntType():Type(IR_Value_INT){}

FloatType::FloatType():Type(IR_Value_Float){}

PointerType::PointerType(std::shared_ptr<Type> ptr):Type(IR_PTR),subtype(ptr){}
InnerDataType PointerType::GetInnerType(){return subtype->GetType();}

ArrayType::ArrayType(int _num_elements,std::shared_ptr<Type> ptr):Type(IR_ARRAY),NumEle(_num_elements),subtype(ptr){}
