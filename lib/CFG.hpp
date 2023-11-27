#pragma once
#include "SymbolTable.hpp"
#include "Singleton.hpp"
/// @brief BasicBlock会作为CFG中的最小节点出现，要有一个访问所有出边的方法
class User;
class InstWithDef:public User
{
    protected:
    Value* def;
    public:
    virtual Value* GetDef(){
        return def;
    }
};
/// @brief %1=alloca i32
/// @note inst def %1, but no ultra def
/// @param data Value* with structure reference
class AllocaInst:public User
{
    Value* data;
    public:
    /// @brief Alloca语句要Type的结构,所以是Value*
    AllocaInst(Value* __data):data(__data){
        /// @note 注意__data的实际类型一定是Varible或者数组，所以Type在里面找
    }
};
/// @brief src->des
/// @note inst use %src %des
/// @param src Operand
/// @param des Value*
class StoreInst:public User
{
    Value* des;
    Operand src;
    public:
    StoreInst(Operand __src,Value* __des):src(__src),des(__des){
        if(std::holds_alternative<Value*>(src))add_use(std::get<Value*>(src));
        add_use(des);
    }
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
    LoadInst(Value* __src):src(__src){
        add_use(src);
        def=new Value(src->GetType());
    }
};
/// @brief float to int
class FPTSI:public InstWithDef
{
    Operand src;
    public:
    FPTSI(Operand __src):src(__src){
        if(std::holds_alternative<Value*>(src))add_use(std::get<Value*>(src));
        def=new Value(IR_Value_INT);
    }
};
/// @brief int to float
class SITFP:public InstWithDef
{
    Operand src;
    public:
    SITFP(Operand __src):src(__src){
        if(std::holds_alternative<Value*>(src))add_use(std::get<Value*>(src));
        def=new Value(IR_Value_Float);
    }
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
    BinaryInst(Operand _A,Operation __op,Operand _B):op(__op){
        if(std::holds_alternative<Value*>(A))add_use(std::get<Value*>(A));
        if(std::holds_alternative<Value*>(B))add_use(std::get<Value*>(B));
        def=new Value(_A.GetType());
    }
};
/// @brief 真正意义上变量，在内存里反应为alloca指令，寄存器应该只要Value级就够了
class Variable:public Value
{
    std::string name;
    public:
    Variable(std::string _id):name(_id),Value(Singleton<InnerDataType>()){
        Singleton<Module>().Register(name,this);
    }
    Variable(InnerDataType tp,std::string _id):Value(tp),name(_id){}
    std::string get_name(){
        return name;
    }
};
class BasicBlock:public Value
{
    List<User> insts;
    public:
    BasicBlock():Value(IR_Value_VOID){};
    void push_front(User* ptr){
        insts.push_front(ptr);
    }
    void push_back(User* ptr){
        insts.push_back(ptr);
    }
    Operand GenerateSITFP(Operand _A){
        auto tmp=new SITFP(_A);
        push_back(tmp);
        return Operand(tmp->GetDef());
    }
    Operand GenerateFPTSI(Operand _B){
        auto tmp=new FPTSI(_B);
        push_back(tmp);
        return Operand(tmp->GetDef());
    }
    Operand GenerateBinaryInst(Operand _A,BinaryInst::Operation op,Operand _B){
        bool tpA=(_A.GetType()==InnerDataType::IR_Value_INT);
        bool tpB=(_B.GetType()==InnerDataType::IR_Value_INT);
        // 一个int一个float
        BinaryInst* tmp;
        if(tpA^tpB){
            assert(op!=BinaryInst::Op_And&&op!=BinaryInst::Op_Or&&op!=BinaryInst::Op_Mod);
            if(tpA==1){
                ///@todo 改变成float
                tmp=new BinaryInst(GenerateSITFP(_A),op,_B);

            }
            else{
                ///@todo 改变成float
                tmp=new BinaryInst(_A,op,GenerateSITFP(_B));
            }
        }
        else tmp=new BinaryInst(_A,op,_B);
        push_back(tmp);
        return Operand(tmp->GetDef());
    }
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
    void InsertAlloca(AllocaInst* ptr){
        bbs.front()->push_back(ptr);
    }
    public:
    Function(InnerDataType _tp,std::string _id):Value(_tp),name(_id){
        //至少有一个bbs
        bbs.push_back(BasicBlockPtr(new BasicBlock()));
    }
    BasicBlock* front_block(){
        return bbs.front().get();
    }
    void push_param(Variable* var){
        params.push_back(ParamPtr(var));
        Singleton<Module>().Register(var->get_name(),var);
    }
    void push_alloca(Variable* ptr){
        alloca_variables.push_back(VarPtr(ptr));
        Singleton<Module>().Register(ptr->get_name(),ptr);
    }
};
/// @brief 编译单元
class Module:public SymbolTable
{
    using GlobalVariblePtr=std::unique_ptr<Variable>;
    std::vector<Function> ls;
    std::vector<GlobalVariblePtr> globalvaribleptr;
    public:
    Module()=default;
    Function& GenerateFunction(InnerDataType _tp,std::string _id){
        ls.push_back(Function(_tp,_id));
        return ls.back();
    }
    void GenerateGlobalVariable(Variable* ptr){
        SymbolTable::Register(ptr->get_name(),ptr);
        globalvaribleptr.push_back(GlobalVariblePtr(ptr));
    }
};