#include "CFG.hpp"
#include "dominant.hpp"
#include "ConstantFold.hpp"

static inline int getint(Value* val) { return dynamic_cast<ConstIRInt*>(val)->GetVal(); }
static inline float getfloat(Value* val) { return dynamic_cast<ConstIRFloat*>(val)->GetVal(); }
static inline bool getbool(Value* val) { return dynamic_cast<ConstIRBoolean*>(val)->GetVal(); }

struct ValueStatus
{
    enum Status { BOT, CONST, TOP};
    Status status;
    Value* val;
    bool is_bot() const { return status == BOT; }
    bool is_const() const { return status == CONST; }
    bool is_top() const { return status == TOP; }
};

class ValueMap
{
    private:
    std::map<Value*, ValueStatus> value_map;

    public:
    void clear() { value_map.clear(); }
    void set(Value* val, ValueStatus statu) { value_map[val] = statu; }
    ValueStatus get(Value* val)
    {
        if(ConstantData* Const = dynamic_cast<ConstantData*>(val))
            return {ValueStatus::CONST, Const};
        else
            return value_map[val];
    }
};

class SCCP
{
    protected:
    ValueMap val_map;
    std::vector<std::pair<BasicBlock*, BasicBlock*>> cfg_worklist;
    std::vector<User*> SSA_worklist;
    private:
    Function* func;
    dominance* dom;
    ConstantFolding* ConstFold;

    public:
    SCCP(Function* func, dominance* dom): func(func), dom(dom) {}
    void RunOnFunction();
};

class InstVisitor
{
    SCCP& sccp;
    ValueMap& value_map;
    std::vector<std::pair<BasicBlock*, BasicBlock*>>& cfg_worklist;
};