#pragma once
#include <memory>
enum InnerDataType
{
    IR_Value_INT,IR_Value_VOID,IR_Value_Float,IR_PTR,IR_ARRAY,BACKEND_PTR, IR_INT_64
};
class Type
{
    InnerDataType tp;
    protected:
    size_t size;
    Type(InnerDataType);
    public:
    static Type* NewTypeByEnum(InnerDataType);
    virtual ~Type()=default;
    virtual void print()=0;
    virtual int get_layer();
    size_t get_size();
    InnerDataType GetTypeEnum();
};

class Int64Type:public Type
{
    Int64Type();
    public:
    static Int64Type* NewInt64TypeGet();
    void print()final;
};
class IntType:public Type
{
    IntType();
    public:
    static IntType* NewIntTypeGet();
    void print()final;
};
class FloatType:public Type
{
    FloatType();
    public:
    static FloatType* NewFloatTypeGet();
    void print()final;
};
class VoidType:public Type
{
    VoidType();
    public:
    static VoidType* NewVoidTypeGet();
    void print()final;
};
class BoolType:public Type
{
    BoolType();
    public:
    static BoolType* NewBoolTypeGet();
    void print()final;
};
class HasSubType:public Type
{
    protected:
    Type* subtype;
    int layer;
    public:
    HasSubType(InnerDataType,Type*);
    Type* GetSubType();
    int get_layer()final;
    Type* get_baseType();
};
class PointerType:public HasSubType
{
    PointerType(Type*);
    public:
    static PointerType* NewPointerTypeGet(Type*);
    void print()final;
};
class ArrayType:public HasSubType
{
    /// @warning prepare for 32 bits machine, int is enough for the number of elements 
    int NumEle;
    ArrayType(int,Type*);
    public:
    static ArrayType* NewArrayTypeGet(int,Type*);
    int GetNumEle();
    void print()final;
};
class BackendPtr:public Type {
    public:
    BackendPtr();
    void print()final;
};