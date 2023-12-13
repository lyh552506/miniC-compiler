#pragma once
#include "SymbolTable.hpp"
#include "Singleton.hpp"
#include "BaseCFG.hpp"
/// @brief 真正意义上变量，在内存里反应为alloca指令，寄存器应该只要Value级就够了
class BasicBlock;
class Function;
class Variable
{
    std::string name;
    std::shared_ptr<Type> tp;
    public:
    Variable(std::string _id);
    Variable(std::shared_ptr<Type> tp,std::string _id);
    Variable(InnerDataType tp,std::string _id);
    std::string get_name();
    std::shared_ptr<Type> CopyType();
};
/// @brief AllocaInst接受一个Value*(Variable)，产生一个PTR，指向Value*的Type类型
class AllocaInst:public User
{
    public:
    /// @brief Alloca语句要Type的结构,所以是Value*
    AllocaInst(std::shared_ptr<Type>);
};
/// @brief src->des
/// @note inst use %src %des
/// @param src Operand
/// @param des Value* 必须是个指针类型
class StoreInst:public User
{
    Operand des;
    Operand src;
    public:
    StoreInst(Operand,Operand);
    Operand GetDef()final;
};
class LoadInst:public User
{
    public:
    LoadInst(Operand __src);
};
/// @brief float to int
class FPTSI:public User
{
    public:
    FPTSI(Operand __src);
};
/// @brief int to float
class SITFP:public User
{
    public:
    SITFP(Operand __src);
};
class UnCondInst:public User
{
    public:
    UnCondInst(BasicBlock*);
    Operand GetDef()final;
};
class CondInst:public User
{
    public:
    CondInst(Operand,BasicBlock*,BasicBlock*);
    Operand GetDef()final;
};
class CallInst:public User
{
    public:
    CallInst(Function*,std::vector<Operand>&);
};
/// @brief Ret, maybe has return value
class RetInst:public User
{
    public:
    RetInst();
    RetInst(Operand);
    Operand GetDef()final;
};
/// @brief BinaryInst use A B,def C
/// @param A operand
/// @param op define inside class
/// @param B operand
/// @param C operand
class BinaryInst:public User
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
    public:
    BinaryInst(Operand _A,Operation __op,Operand _B);
};
class GetElementPtrInst:public User
{
    public:
    GetElementPtrInst(Operand,std::vector<Operand>&);
};
class BasicBlock:public Value
{
    List<User> insts;
    Function& master;
    public:
    BasicBlock(Function& __master);
    void print()final;
    void push_front(User* ptr);
    void push_back(User* ptr);
    Operand push_alloca(std::shared_ptr<Type>);
    Operand GenerateSITFP(Operand _A);
    Operand GenerateFPTSI(Operand _B);
    Operand GenerateBinaryInst(Operand _A,BinaryInst::Operation op,Operand _B);
    static Operand GenerateBinaryInst(BasicBlock*,Operand,BinaryInst::Operation,Operand);
    Operand GenerateLoadInst(Operand);
    Operand GenerateGEPInst(Operand,std::vector<Operand>&);
    void GenerateCondInst(Operand,BasicBlock*,BasicBlock*);
    void GenerateUnCondInst(BasicBlock*);
    void GenerateRetInst(Operand);
    void GenerateRetInst();
    Operand GenerateCallInst(std::string,std::vector<Operand> args);
    void GenerateStoreInst(Operand,Operand);
    void GenerateAlloca(Variable*);
    BasicBlock* GenerateNewBlock();
    bool EndWithBranch();
};
/// @brief 以function为最大单元生成CFG
//其实function本质是就是CFG了
class Function:public Value
{
    std::string name;
    using ParamPtr=std::unique_ptr<Value>;
    using BasicBlockPtr=std::unique_ptr<BasicBlock>;
    std::vector<ParamPtr> params;//存放形式参数
    std::vector<BasicBlockPtr> bbs;
    void InsertAlloca(AllocaInst* ptr);
    public:
    Function(InnerDataType _tp,std::string _id);
    BasicBlock* front_block();
    void print()final;
    void add_block(BasicBlock*);
    void push_param(Variable*);
    void push_alloca(Variable*);
    BasicBlock* front();
    std::vector<ParamPtr>& GetParams();
};
/// @brief 编译单元
class Module:public SymbolTable
{
    using GlobalVariblePtr=std::unique_ptr<Variable>;
    using FunctionPtr=std::unique_ptr<Function>;
    std::vector<FunctionPtr> ls;
    std::vector<GlobalVariblePtr> globalvaribleptr;
    public:
    Module()=default;
    Function& GenerateFunction(InnerDataType _tp,std::string _id);
    void GenerateGlobalVariable(Variable* ptr);
    void Test();
};