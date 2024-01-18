#pragma once
#include "SymbolTable.hpp"
#include "Singleton.hpp"
#include "BaseCFG.hpp"
class BasicBlock;
class Function;
class Variable
{
    Operand attached_initializer;
    std::string name;
    Type* tp;
    public:
    Variable(std::string);
    Variable(Type*,std::string);
    Variable(InnerDataType,std::string);
    void attach(Operand);
    std::string get_name();
    Type* GetType();
    void print();
};

class UndefValue:public User{
  UndefValue(Type* Ty){}
public:
  static UndefValue* get(Type *Ty);
  void print();
};

class AllocaInst:public User
{
    public:
    AllocaInst(std::string,Type*);
    void print()final;
    bool IsUsed();//TODO 返回当前alloca出来的对象后续有没有被使用过
    // std::vector<User*> GetUsers(); //返回使用过alloca分配出的虚拟寄存器的指令
};

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
    Value* GetSrc();
    void ReplaceAllUsersWith(Value* val);
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
};
class CondInst:public User
{
    public:
    CondInst(Operand,BasicBlock*,BasicBlock*);
    Operand GetDef()final;
    void print()final;
};
class CallInst:public User
{
    public:
    CallInst(Value*,std::vector<Operand>&,std::string);
    void print()final;
};
class RetInst:public User
{
    public:
    RetInst();
    RetInst(Operand);
    Operand GetDef()final;
    void print()final;
};
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
    std::string GetOperation();
};
class GetElementPtrInst:public User
{
    public:
    GetElementPtrInst(Operand);
    Type* GetType();
    void print()final;
};

// class PhiInst : public User {
// public:
//   PhiInst(User *BeforeInst,Type *ty):oprandNum(0),User{ty} {}

//   PhiInst(User *BeforeInst):oprandNum(0) {}

//   void print() final;
//   static PhiInst *NewPhiNode(User *BeforeInst, BasicBlock *currentBB);
//   static PhiInst *NewPhiNode(User *BeforeInst, BasicBlock *currentBB,Type* ty);
//   void updateIncoming(Value* Income,BasicBlock* BB);//phi i32 [ 0, %7 ], [ %9, %8 ]

// public:
//   std::map<int,std::pair<Value*,BasicBlock*>> PhiRecord;
//   int oprandNum;
// };
class BasicBlock:public Value,public mylist<BasicBlock,User>
{
    Function& master;
    public:
    BasicBlock(Function& __master);
    void print();
    Operand push_alloca(std::string,Type*);
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
    Operand GenerateCallInst(std::string,std::vector<Operand>,int);
    void GenerateStoreInst(Operand,Operand);
    void GenerateAlloca(Variable*);
    BasicBlock* GenerateNewBlock();
    BasicBlock* GenerateNewBlock(std::string);
    bool EndWithBranch();
    int dfs;
    int num;
};

class ExternFunction:public Value
{
    public:
    ExternFunction(std::string);
    void print();
    std::string GetName();
};

class BuildInFunction:public Value
{
    BuildInFunction(Type*,std::string);
    public:
    static BuildInFunction* GetBuildInFunction(std::string);
};

class Function:public Value
{
    using ParamPtr=std::unique_ptr<Value>;
    using BasicBlockPtr=std::unique_ptr<BasicBlock>;
    std::vector<ParamPtr> params;//存放形式参数
    std::vector<BasicBlockPtr> bbs;
    void InsertAlloca(AllocaInst* ptr);
    public:
    Function(InnerDataType _tp,std::string _id);
    BasicBlock* front_block();
    virtual void print();
    void add_block(BasicBlock*);
    void push_param(Variable*);
    void push_alloca(Variable*);
    std::vector<ParamPtr>& GetParams();
    std::vector<BasicBlockPtr>& GetBasicBlock();
};
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
    std::vector<FunctionPtr>& GetFuncTion();
    void Test();
};