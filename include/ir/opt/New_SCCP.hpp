#include "CFG.hpp"
#include "dominant.hpp"
#include "ConstantFold.hpp"

class LatticeVal
{
    enum LatticeValueTy
    {
        unknown,
        constant,
        forcedconstant,
        overdefined
    };
    std::pair<Value*, LatticeValueTy> Val;
    LatticeValueTy getLatticeValue() const { return Val.second; }

public:
    LatticeVal() : Val(nullptr, unknown) {}
    bool isUnknown() const { return getLatticeValue() == unknown; }
    bool isConstant() const
    {
        return getLatticeValue() == constant ||
        getLatticeValue() == forcedconstant;
    }
    bool isOverdefined() const { return getLatticeValue() == overdefined; }
    
    Value* Getval() const { return Val.first; }
    
    // markOverdefined - Return true if this is a change in status.
    bool markOverdefined()
    {
        if(isOverdefined())
            return false;
        
        Val.second = overdefined;
        return true;
    }

    // markConstant - Return true if this is a change in status.
    bool markConstant(ConstantData* val)
    {
        if(getLatticeValue() == constant){
            assert(Getval() == val && "Marking constant with different value");
            return false;
        }

        if(isUnknown())
        {
            Val.second = constant;
            assert(val && "Marking constant with nullptr");
            Val.first = val;
        }
        else
        {
            assert(getLatticeValue() == forcedconstant &&
            "Cannot move from overdefined to constant!");

            // Stay at forcedconstant if the constant is the same.
            if(val == Getval())
                return false;
            Val.second = overdefined;
        }
        return true;
    }

    // getConstantInt - If this is aconstant with a ConstantInt value
    // return it otherwise return nullptr.
    ConstantData* getConstantInt() const
    {
        if(isConstant())
            return dynamic_cast<ConstantData*>(Getval());
        return nullptr;
    }

    void markForcedConstant(ConstantData* val)
    {
        assert(isUnknown() && "Cannot force a defined value");
        Val.first = val;
        Val.second = forcedconstant;
    }
}; 