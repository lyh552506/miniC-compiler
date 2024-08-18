#include "../include/lib/Type.hpp"
#include <iostream>
#include <cassert>
#include <map>

/*Type*/
Type::Type(InnerDataType _tp):tp(_tp){}
InnerDataType Type::GetTypeEnum(){return tp;}
int Type::get_layer(){return 0;}
size_t Type::get_size(){return size;}
Type* Type::NewTypeByEnum(InnerDataType _tp){
    switch (_tp)
    {
    case IR_Value_INT:return IntType::NewIntTypeGet(); 
    case IR_Value_VOID:return VoidType::NewVoidTypeGet();
    case IR_Value_Float:return FloatType::NewFloatTypeGet();
    case IR_PTR:return PointerType::NewPointerTypeGet(Type::NewTypeByEnum(IR_Value_INT));
    default:assert(0);
    }
}
/*Int64Type*/
Int64Type::Int64Type():Type(IR_INT_64){size = 8;}
Int64Type* Int64Type::NewInt64TypeGet()
{
    static Int64Type single;
    return &single;
}
void Int64Type::print(){
    std::cout<<"i64";
}

/*IntType*/
IntType::IntType():Type(IR_Value_INT){size = 4;}
IntType* IntType::NewIntTypeGet(){
    static IntType single;
    return &single;
}
void IntType::print(){
    std::cout<<"i32";
}

/*FloatType*/
FloatType::FloatType():Type(IR_Value_Float){size = 4;}
FloatType* FloatType::NewFloatTypeGet(){
    static FloatType single;
    return &single;
}
void FloatType::print(){
    std::cout<<"float";
}

/*Bool*/
BoolType::BoolType():Type(IR_Value_INT){size = 4;}
BoolType* BoolType::NewBoolTypeGet(){
    static BoolType single;
    return &single;
}
void BoolType::print(){
    std::cout<<"i1";
}

/*Void*/
VoidType::VoidType():Type(IR_Value_VOID){size = 0;}
VoidType* VoidType::NewVoidTypeGet(){
    static VoidType single;
    return &single;
}
void VoidType::print(){
    std::cout<<"void";
}

/*HasSubType*/
HasSubType::HasSubType(InnerDataType tp_enum,Type* _subtype):Type(tp_enum),subtype(_subtype),layer(_subtype->get_layer()+1){}
int HasSubType::get_layer(){return layer;}
Type* HasSubType::get_baseType() {
    Type* basetype = nullptr;
    basetype = this;
    for(int i=0; i<layer; i++) {
        if(HasSubType* hassubtype = dynamic_cast<HasSubType*>(basetype)) {
            basetype = hassubtype->GetSubType();
        }
    }
    return basetype;
}


Type* HasSubType::GetSubType(){
    return subtype;
}

/*PointerType*/
PointerType* PointerType::NewPointerTypeGet(Type* _subtype){
    static std::map<Type*,PointerType*> single;
    auto& tmp=single[_subtype];
    if(tmp==nullptr)tmp=new PointerType(_subtype);
    return tmp;
}
PointerType::PointerType(Type* _subtype):HasSubType(IR_PTR,_subtype){size = 8;}
void PointerType::print(){
    subtype->print();
    std::cout<<"*";
}

/*ArrayType*/
ArrayType* ArrayType::NewArrayTypeGet(int NumEle,Type* _subtype){
    using Key=std::pair<int,Type*>;
    static std::map<Key,ArrayType*> single;
    auto& tmp = single[Key(NumEle, _subtype)];
    if(tmp==nullptr)tmp=new ArrayType(NumEle, _subtype);
    return tmp;
}
ArrayType::ArrayType(int _numEle,Type* _subtype):NumEle(_numEle),HasSubType(IR_ARRAY,_subtype){
    size = _subtype->get_size() * _numEle;
}
int ArrayType::GetNumEle(){return NumEle;}
void ArrayType::print(){
    std::cout<<"["<<NumEle<<" x ";
    subtype->print();
    std::cout<<"]";
}

BackendPtr::BackendPtr ():Type(BACKEND_PTR) {size=8;}
void BackendPtr::print() {return;}