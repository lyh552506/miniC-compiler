// #include "ConstantFold.hpp"

class ConstantProp
{  
    void RunOnFunc(Function* func);
    void RunOnBlock(BasicBlock* block);
    ConstantData* SetDefVal(ConstantData* v1, Value* v2);
    ConstantData* GetDefVal(Value* val);

private:
    ConstantFolding* ConstFold;
    Function* _func;
public:
    void Pass();
    void Test(BasicBlock* block);

    ConstantProp(Function* func) : _func(func) {}
};
