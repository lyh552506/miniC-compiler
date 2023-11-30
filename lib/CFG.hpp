#pragma once
#include "SymbolTable.hpp"
#include "Singleton.hpp"
/// @brief BasicBlock会作为CFG中的最小节点出现，要有一个访问所有出边的方法
class InstWithDef:public User
{
    protected:
    Value* def;
    public:
    virtual Value* GetDef();
};
/// @brief %1=alloca i32
/// @note inst def %1, but no ultra def
/// @param data Value* with structure reference
class AllocaInst:public User
{
    Value* data;
    public:
    /// @brief Alloca语句要Type的结构,所以是Value*
    AllocaInst(Value* __data);
};
/// @brief src->des
/// @note inst use %src %des
/// @param src Operand
/// @param des Value*
class StoreInst:public User
{
    Variable* des;
    Operand src;
    public:
    StoreInst(Operand,Variable*);
};
/// @brief load src to def
/// @note inst use src;def def
/// @param src Value*
class LoadInst:public InstWithDef
{
    Value* src;
    public:
    /// @brief 一般都是只有src,def是load产生的
    /// @param __src 
    LoadInst(Value* __src);
};
/// @brief float to int
class FPTSI:public InstWithDef
{
    Operand src;
    public:
    FPTSI(Operand __src);
};
/// @brief int to float
class SITFP:public InstWithDef
{
    Operand src;
    public:
    SITFP(Operand __src);
};
class UnCondInst:public User
{
    BasicBlock* des;
    public:
    UnCondInst(BasicBlock*);
};
class CondInst:public User
{
    Operand condition;
    BasicBlock *istrue,*isfalse;
    public:
    CondInst(Operand,BasicBlock*,BasicBlock*);
};
/// @brief Maybe don't has Def if it calls void function
class CallInst:public InstWithDef
{
    Function* call_handle;
    std::vector<Operand> args;
    public:
    CallInst(Function*,std::vector<Operand>);
    bool HasDef();
    Value* GetDef()final;
};
/// @brief Ret, maybe has return value
class RetInst:public User
{
    Operand ret_val;
    public:
    RetInst();
    RetInst(Operand);
};
/// @brief BinaryInst use A B,def C
/// @param A operand
/// @param op define inside class
/// @param B operand
/// @param C operand
class BinaryInst:public InstWithDef
{
    public:
    enum Operation
    {
        Op_Add,Op_Sub,Op_Mul,Op_Div,Op_And,Op_Or,Op_Mod,
        //what's below should be translate to cmp inst in llvm
        Op_E,Op_NE,Op_GE,Op_L,Op_LE,Op_G
    };//卧槽，原批
    private:
    Operation op;
    Operand A,B;
    public:
    BinaryInst(Operand _A,Operation __op,Operand _B);
};
/// @brief 真正意义上变量，在内存里反应为alloca指令，寄存器应该只要Value级就够了
class Variable:public Value
{
    std::string name;
    public:
    Variable(std::string _id);
    Variable(InnerDataType tp,std::string _id);
    std::string get_name();
};
class BasicBlock:public Value
{
    List<User> insts;
    Function& master;
    public:
    BasicBlock(Function& __master);
    void push_front(User* ptr);
    void push_back(User* ptr);
    Operand GenerateSITFP(Operand _A);
    Operand GenerateFPTSI(Operand _B);
    Operand GenerateBinaryInst(Operand _A,BinaryInst::Operation op,Operand _B);
    void GenerateCondInst(Operand,BasicBlock*,BasicBlock*);
    void GenerateUnCondInst(BasicBlock*);
    void GenerateRetInst(Operand);
    void GenerateRetInst();
    void GenerateCallInst(std::string,std::vector<Operand> args);
    void GenerateStoreInst(Operand,Variable*);
    BasicBlock* GenerateNewBlock();
    bool EndWithBranch();
};
/// @brief 以function为最大单元生成CFG
//其实function本质是就是CFG了
class Function:public Value
{
    std::string name;
    using ParamPtr=std::unique_ptr<Variable>;
    using VarPtr=std::unique_ptr<Variable>;
    using BasicBlockPtr=std::unique_ptr<BasicBlock>;
    std::vector<ParamPtr> params;
    std::vector<VarPtr> alloca_variables;
    std::vector<BasicBlockPtr> bbs;
    void InsertAlloca(AllocaInst* ptr);
    public:
    Function(InnerDataType _tp,std::string _id);
    BasicBlock* front_block();
    void add_block(BasicBlock*);
    void push_param(Variable*);
    void push_alloca(Variable*);
};
/// @brief 编译单元
class Module:public SymbolTable
{
    using GlobalVariblePtr=std::unique_ptr<Variable>;
    std::vector<Function> ls;
    std::vector<GlobalVariblePtr> globalvaribleptr;
    public:
    Module()=default;
    Function& GenerateFunction(InnerDataType _tp,std::string _id);
    void GenerateGlobalVariable(Variable* ptr);
};