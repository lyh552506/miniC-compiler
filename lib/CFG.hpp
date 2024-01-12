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
    Type* tp;
    public:
    Variable(std::string);
    Variable(Type*,std::string);
    Variable(InnerDataType,std::string);
    std::string get_name();
    Type* GetType();
};
/// @brief AllocaInst接受一个Value*(Variable)，产生一个PTR，指向Value*的Type类型
class AllocaInst:public User
{
    public:
    /// @brief Alloca语句要Type的结构,所以是Value*
    AllocaInst(Type*);
    void print()final;
};
/// @brief src->des
/// @note inst use %src %des
/// @param src Operand
/// @param des Value* 必须是个指针类型
class StoreInst:public User
{
    public:
    StoreInst(Operand,Operand);
    Operand GetDef()final;
    void print()final;
    void ir_mark();
};
class LoadInst:public User
{
    public:
    LoadInst(Operand __src);
    void print()final;
};
/// @brief float to int
class FPTSI:public User
{
    public:
    FPTSI(Operand __src);
    void print()final;
};
/// @brief int to float
class SITFP:public User
{
    public:
    SITFP(Operand __src);
    void print()final;
};
class UnCondInst:public User
{
    public:
    UnCondInst(BasicBlock*);
    Operand GetDef()final;
    void print()final;
    void ir_mark();
};
class CondInst:public User
{
    public:
    CondInst(Operand,BasicBlock*,BasicBlock*);
    Operand GetDef()final;
    void print()final;
    void ir_mark();
};
class CallInst:public User
{
    public:
    CallInst(Function*,std::vector<Operand>&);
    void print()final;
    void ir_mark();
};
/// @brief Ret, maybe has return value
class RetInst:public User
{
    public:
    RetInst();
    RetInst(Operand);
    Operand GetDef()final;
    void print()final;
    void ir_mark();
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
    void print()final;
};
class GetElementPtrInst:public User
{
    public:
    GetElementPtrInst(Operand);
    Type* GetType();
    void print()final;
};
class BasicBlock:public Value
{
    List<User> insts;
    Function& master;
    public:
    BasicBlock(Function& __master);
    void print();
    void push_front(User* ptr);
    void push_back(User* ptr);
    Operand push_alloca(Type*);
    Operand GenerateSITFP(Operand _A);
    Operand GenerateFPTSI(Operand _B);
    Operand GenerateBinaryInst(Operand _A,BinaryInst::Operation op,Operand _B);
    static Operand GenerateBinaryInst(BasicBlock*,Operand,BinaryInst::Operation,Operand);
    Operand GenerateLoadInst(Operand);
    Operand GenerateGEPInst(Operand);
    void GenerateCondInst(Operand,BasicBlock*,BasicBlock*);
    void GenerateUnCondInst(BasicBlock*);
    void GenerateRetInst(Operand);
    void GenerateRetInst();
    Operand GenerateCallInst(std::string,std::vector<Operand> args);
    void GenerateStoreInst(Operand,Operand);
    void GenerateAlloca(Variable*);
    BasicBlock* GenerateNewBlock();
    //todo
    List<User>& getInstList();
    bool EndWithBranch();
    void ir_mark();
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
    
    //todo
    // std::string getFuncName();
    std::vector<ParamPtr>& getParams();
    std::vector<BasicBlockPtr>& getBlockList();
    // std::vector<VarPtr>& getAllocaVariables();
    
    void print();
    void add_block(BasicBlock*);
    void push_param(Variable*);
    void push_alloca(Variable*);
    BasicBlock* front();
    std::string GetName();
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
    
    //todo
    std::vector <FunctionPtr> &getFuncList();
    
    void Test();
};