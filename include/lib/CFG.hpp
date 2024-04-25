#pragma once
#include "SymbolTable.hpp"
#include "Singleton.hpp"
#include "BaseCFG.hpp"
#include <set>
class BasicBlock;
class Function;

class InitVal;
class InitVals;

class Initializer:public Value,public std::vector<Operand>
{
    public:
    Initializer(Type*);
    void Var2Store(BasicBlock*,const std::string&,std::vector<int>&);
    /// @brief 打印
    /// <Type> [<Content_0>,<Content1>,...]
    /// Content:= <Type> <Content>
    void print();
};

class Variable
{
    Operand attached_initializer=nullptr;
    std::string name;
    Type* tp;
    public:
    Variable(std::string);
    Variable(Type*,std::string);
    Variable(InnerDataType,std::string);
    void attach(Operand);
    std::string get_name();
    Type* GetType();
    Operand& GetInitializer();
    void print();
    bool isFunction(){ return false; }
};

class UndefValue:public ConstantData{
  UndefValue(Type* Ty):ConstantData(Ty){name="undef";}
public:
  virtual UndefValue* clone(std::unordered_map<Operand,Operand>&) override;
  static UndefValue* get(Type *Ty);
  void print();
};

class MemcpyHandle:public User{
    public:
    MemcpyHandle* clone(std::unordered_map<Operand,Operand>&)override;
    MemcpyHandle(Type*,Operand);
    void print();
};

class AllocaInst:public User
{
    public:
    AllocaInst(Type* _tp):User(_tp){};
    AllocaInst(std::string,Type*);
    AllocaInst* clone(std::unordered_map<Operand,Operand>&)override;
    void print()final;
    bool IsUsed();
};

class StoreInst:public User
{
    public:
    StoreInst(Type* _tp):User(_tp){};
    StoreInst(Operand,Operand);
    StoreInst* clone(std::unordered_map<Operand,Operand>&)override;
    Operand GetDef()final;
    void print()final;
};
class LoadInst:public User
{
    public:
    LoadInst(Type* _tp):User(_tp){};
    LoadInst(Operand __src);
    LoadInst* clone(std::unordered_map<Operand,Operand>&)override;
    void print()final;
    Value* GetSrc();
};
/// @brief float to int
class FPTSI:public User
{
    public:
    FPTSI(Type* _tp):User(_tp){};
    FPTSI(Operand __src);
    FPTSI* clone(std::unordered_map<Operand,Operand>&)override;
    void print()final;
};
/// @brief int to float
class SITFP:public User
{
    public:
    SITFP(Type* _tp):User(_tp){};
    SITFP(Operand __src);
    SITFP* clone(std::unordered_map<Operand,Operand>&)override;
    void print()final;
};
class UnCondInst:public User
{
    public:
    UnCondInst(Type* _tp):User(_tp){};
    UnCondInst(BasicBlock*);
    UnCondInst* clone(std::unordered_map<Operand,Operand>&)override;
    Operand GetDef()final;
    void print()final;
};
class CondInst:public User
{
    public:
    CondInst(Type* _tp):User(_tp){};
    CondInst(Operand,BasicBlock*,BasicBlock*);
    CondInst* clone(std::unordered_map<Operand,Operand>&)override;
    Operand GetDef()final;
    void print()final;
};
class CallInst:public User
{
    public:
    CallInst(Type* _tp):User(_tp){};
    CallInst(Value*,std::vector<Operand>&,std::string);
    CallInst* clone(std::unordered_map<Operand,Operand>&)override;
    void print()final;
};
class RetInst:public User
{
    public:
    RetInst();
    RetInst(Type* _tp):User(_tp){};
    RetInst(Operand);
    RetInst* clone(std::unordered_map<Operand,Operand>&)override;
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
    BinaryInst(Type* _tp):User(_tp){};
    BinaryInst(Operand _A,Operation __op,Operand _B);
    BinaryInst* clone(std::unordered_map<Operand,Operand>&)override;
    void print()final;
    std::string GetOperation();
    Operation getopration();
    static BinaryInst* CreateInst(Operand _A,Operation __op,Operand _B,User* place=nullptr);
};
class GetElementPtrInst:public User
{
    public:
    GetElementPtrInst(Type* _tp):User(_tp){};
    GetElementPtrInst(Operand);
    GetElementPtrInst(Operand,std::vector<Operand>&);
    GetElementPtrInst* clone(std::unordered_map<Operand,Operand>&)override;
    Type* GetType()final;
    void print()final;
    std::vector<Operand>& GetIndexs();
};
//zext i1 to i32
class ZextInst:public User
{
    public:
    ZextInst(Type* _tp):User(_tp){};
    ZextInst(Operand);
    ZextInst* clone(std::unordered_map<Operand,Operand>&)override;
    void print()final;
};

class PhiInst : public User {
public:
  PhiInst(Type *ty) : User{ty} {}
  PhiInst(User *BeforeInst,Type *ty):oprandNum(0),User{ty} {}

  PhiInst(User *BeforeInst):oprandNum(0) {}

  void print() final;
  static PhiInst *NewPhiNode(User *BeforeInst, BasicBlock *currentBB);
  static PhiInst *NewPhiNode(User *BeforeInst, BasicBlock *currentBB,Type* ty);
  void updateIncoming(Value* Income,BasicBlock* BB);//phi i32 [ 0, %7 ], [ %9, %8 ]
  std::vector<Value*>& GetAllPhiVal();
  Value* ReturnValIn(BasicBlock* bb);
  void Phiprop(Value* origin,Value* newval);
public:
  PhiInst* clone(std::unordered_map<Operand,Operand>&)override;
  std::map<int,std::pair<Value*,BasicBlock*>> PhiRecord; //记录不同输入流的value和block
  std::vector<Value*> Incomings;
  void Del_Incomes(int CurrentNum);
  bool IsSame(PhiInst* phi);
  std::vector<BasicBlock*> Blocks;
  int oprandNum;
  bool IsGetIncomings=false;
};
class BasicBlock:public Value,public mylist<BasicBlock,User>,public list_node<Function,BasicBlock>
{
    public:
    virtual ~BasicBlock()=default;
    void Delete();
    BasicBlock();
    void print();
    int GetSuccNum();
    BasicBlock* clone(std::unordered_map<Operand,Operand>&) override;
    Operand push_alloca(std::string,Type*);
    Operand GenerateSITFP(Operand _A);
    Operand GenerateFPTSI(Operand _B);
    Operand GenerateBinaryInst(Operand _A,BinaryInst::Operation op,Operand _B);
    static Operand GenerateBinaryInst(BasicBlock*,Operand,BinaryInst::Operation,Operand);
    Operand GenerateLoadInst(Operand);
    Operand GenerateGEPInst(Operand);
    Operand GenerateZextInst(Operand);
    void GenerateCondInst(Operand,BasicBlock*,BasicBlock*);
    void GenerateUnCondInst(BasicBlock*);
    void GenerateRetInst(Operand);
    void GenerateRetInst();
    Operand GenerateCallInst(std::string,std::vector<Operand>,int);
    void GenerateStoreInst(Operand,Operand);
    void GenerateAlloca(Variable*);
    BasicBlock* GenerateNewBlock();
    BasicBlock* GenerateNewBlock(std::string);
    BasicBlock* SplitAt(User*);
    std::vector<BasicBlock*> Succ_Block;
    std::vector<BasicBlock*> GetSuccBlock();
    void AddSuccBlock(BasicBlock* block){this->Succ_Block.push_back(block);}
    bool EndWithBranch();
    void RemovePredBB(BasicBlock* pred);
    virtual void clear()override;
    int LoopDepth=0;
    int num=0;
    bool visited=false;
};

class BuildInFunction:public Value
{
    BuildInFunction(Type*,std::string);
    public:
    virtual BuildInFunction* clone(std::unordered_map<Operand,Operand>&) override{return this;};
    static BuildInFunction* GetBuildInFunction(std::string);
};

class Function:public Value,public mylist<Function,BasicBlock>
{
    friend class InlineCost;
    enum InlineLevel
    {
        AlwaysInline,
        NeverInline,
        VaiableInline
    };
    using ParamPtr=std::unique_ptr<Value>;
    using BasicBlockPtr=std::unique_ptr<BasicBlock>;
    std::vector<ParamPtr> params;//存放形式参数
    std::vector<BasicBlock*> bbs;
    public:
    std::set<Function*> CalleeFuncs; // The Function who calls this
    std::set<Function*> CallingFuncs; // The Function that the func calls
    void InsertAlloca(AllocaInst* ptr);
    public:
    virtual Function* clone(std::unordered_map<Operand,Operand>&) override{return this;};
    Function(InnerDataType _tp,std::string _id);
    void print();
    void add_block(BasicBlock*);
    void push_param(Variable*);
    void init_bbs(){ bbs.clear();}
    void push_alloca(Variable*);
    void push_bb(BasicBlock* bb);
    std::vector<ParamPtr>& GetParams();
    std::vector<BasicBlock*>& GetBasicBlock(){return bbs;}
    void InsertBlock(BasicBlock* pred,BasicBlock* succ,BasicBlock* insert);
    void init_visited_block();
    int bb_num=0;
};
class Module:public SymbolTable
{
    using GlobalVariblePtr=std::unique_ptr<Variable>;
    using FunctionPtr=std::unique_ptr<Function>;
    std::vector<FunctionPtr> ls;
    std::vector<GlobalVariblePtr> globalvaribleptr;
    std::vector<MemcpyHandle*> constants_handle;
    public:
    std::set<Function*> hasInlinedFunc; // Func that has done inlined pass
    std::set<Function*> inlinedFunc; // Func who is inlined by pass
    Module()=default;
    Function& GenerateFunction(InnerDataType _tp,std::string _id);
    void GenerateGlobalVariable(Variable* ptr);
    Operand GenerateMemcpyHandle(Type*,Operand);
    std::vector<FunctionPtr>& GetFuncTion();
    std::vector<GlobalVariblePtr>& GetGlobalVariable();
    void Test();
    void EraseFunction(Function* func);
    Function* GetMainFunction();
};
