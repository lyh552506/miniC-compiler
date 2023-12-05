#include <memory>
enum InnerDataType
{
    IR_Value_INT,IR_Value_VOID,IR_Value_Float,IR_PTR,IR_ARRAY
};
class Type
{
    InnerDataType tp;
    protected:
    int indirect_layer;
    public:
    Type(InnerDataType);
    InnerDataType GetType();
    virtual ~Type()=default;
    virtual int layer();
};
class IntType:public Type
{
    public:
    IntType();
};
class FloatType:public Type
{
    public:
    FloatType();
};
class PointerType:public Type
{
    std::shared_ptr<Type> subtype;
    public:
    PointerType(std::shared_ptr<Type>);
    InnerDataType GetInnerType();
};
class ArrayType:public Type
{
    /// @warning prepare for 32 bits machine, int is enough for the number of elements 
    int NumEle;
    std::shared_ptr<Type> subtype;
    public:
    ArrayType(int,std::shared_ptr<Type>);
};