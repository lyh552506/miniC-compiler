#include "CFG.hpp"
#include "dominant.hpp"
#include "ConstantFold.hpp"

static inline int getint(Value* val) { return dynamic_cast<ConstIRInt*>(val)->GetVal(); }
static inline float getfloat(Value* val) { return dynamic_cast<ConstIRFloat*>(val)->GetVal(); }
static inline bool getbool(Value* val) { return dynamic_cast<ConstIRBoolean*>(val)->GetVal(); }

class InstVisitor;
struct ValueStatus
{
    enum Status { BOT = 0, CONST, TOP};
    Status status;
    Value* val;
    bool is_bot() const { return status == BOT; }
    bool is_const() const { return status == CONST; }
    bool is_top() const { return status == TOP; }

    bool operator!=(ValueStatus& other) const
    {
        if(status != other.status)
            return true;
        if(status != CONST)
            return false;
        if(dynamic_cast<ConstIRInt*>(val))
        {
            int val1 = getint(val);
            int val2 = getint(other.val);
            return val1 != val2;
        }
        else if(dynamic_cast<ConstIRFloat*>(val))
        {
            float val1 = getfloat(val);
            float val2 = getfloat(other.val);
            return val1 != val2;
        }
        else if(dynamic_cast<ConstIRBoolean*>(val))
        {
            bool val1 = getbool(val);
            bool val2 = getbool(other.val);
            return val1 != val2;
        }
        else
            return false;
    }
    void operator^=(ValueStatus& other)
    {
        if(other.status < status)
        {
            status = other.status;
            val = other.val;
        }
        else if(status == other.status && status == CONST)
        {
            if(dynamic_cast<ConstIRInt*>(val))
            {
                int val1 = getint(val);
                int val2 = getint(other.val);
                if(val1 != val2)
                {
                    status = BOT;
                    val = nullptr;
                }
            }
            else if(dynamic_cast<ConstIRFloat*>(val))
            {
                float val1 = getfloat(val);
                float val2 = getfloat(other.val);
                if(val1 != val2)
                {
                    status = BOT;
                    val = nullptr;
                }
            }
            else if(dynamic_cast<ConstIRBoolean*>(val))
            {
                bool val1 = getbool(val);
                bool val2 = getbool(other.val);
                if(val1 != val2)
                {
                    status = BOT;
                    val = nullptr;
                }
            }
        }
    }
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
    const std::string name = "SCCP";
    ValueMap val_map;
    std::vector<std::pair<BasicBlock*, BasicBlock*>> cfg_worklist;
    std::vector<User*> SSA_worklist;
    std::set<std::pair<BasicBlock*, BasicBlock*>> marked;
    private:
    Function* func;
    dominance* dom;

    void ReplaceConst();
    public:
    SCCP(Function* func, dominance* dom): func(func), dom(dom) {}
    void RunOnFunction();
    ConstantFolding* ConstFolding;
    std::set<std::pair<BasicBlock*, BasicBlock*>>& getmarked() { return marked; }
    ValueStatus getval_status(Value* val) { return val_map.get(val); }  //getmapped
    ValueMap& getvalue_map() { return val_map; } 
    std::vector<std::pair<BasicBlock*, BasicBlock*>>& getcfg_worklist() { return cfg_worklist; }
    std::vector<User*>& getSSA_worklist() { return SSA_worklist; }
    std::unique_ptr<InstVisitor> visitor;
    ConstantData* ConstFold(User* inst);
};

class InstVisitor
{
    private:
    SCCP& sccp;
    ValueMap& value_map;
    std::vector<std::pair<BasicBlock*, BasicBlock*>>& cfg_worklist;
    std::vector<User*>& SSA_worklist;

    User* inst;
    BasicBlock* block;
    ValueStatus prev_statu;
    ValueStatus cur_statu;

    void visit_Phi(PhiInst* phi);
    void visit_Branch(CondInst* br);
    void visit_Branch(UnCondInst* br);
    void visit_canfold(User* inst);

    public:
    explicit InstVisitor(SCCP& Sccp) : sccp(Sccp), value_map(Sccp.getvalue_map()), 
            cfg_worklist(Sccp.getcfg_worklist()), SSA_worklist(Sccp.getSSA_worklist()) {}
    void visit(User* inst);
};