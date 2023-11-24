#pragma once
#include "SymbolTable.hpp"
/// @brief BasicBlock会作为CFG中的最小节点出现，要有一个访问所有出边的方法
class User;
class BasicBlock:public Value
{
    List<User> insts;
    public:
    void push_front(User* ptr){
        insts.push_front(ptr);
    }
    void push_back(User* ptr){
        insts.push_back(ptr);
    }
};
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
// /// @brief 数组类型，在这个语言里const array纯属烂活
// class IRArray:public Value
// {
//     /// @brief 比如说int a[1025][12][2];因为只有float和int类型，所以按4字节=32位编址
//     /// 同时实现方法中可以空掉第一位（1025），因为访存只需要后续位置，在统一ir中GEP指令要方便一点
//     /// 同时struct的实现可以类似当成一个复用结构的Array
//     /// 同时ptr类型至少在IR层面等同于GEP指令
//     /// 如果第一个是-1，则是指针类型的
//     std::string name;
//     std::vector<size_t> size_tables;
//     public:
//     std::string get_name(){
//         return name;
//     }
//     IRArray(std::string _id,std::vector<size_t> __table){
//         name=_id;
//         size_tables=__table;
//     }
// };
/// @brief 以function为最大单元生成CFG
//其实function本质是就是CFG了
class Function:public Value
{
    //Contains BasicBlock
    //Function used by CallInst
    std::string name;
    std::vector<Variable> params;
    std::vector<BasicBlock> bbs;
    public:
    Function(InnerDataType _tp,std::string _id):Value(_tp),name(_id){}
    BasicBlock& entry_block(){
        return bbs.front();
    }
    BasicBlock& cur_building(){
        return bbs.back();
    }
    void push_param(Variable var){
        params.push_back(var);
    }
};
/// @brief 编译单元
class Module:public SymbolTable
{
    /// @todo Module中需要一个Factory类似的东西来确保自动析构一些指针指向的对象
    std::vector<Function> ls;
    void append(User* __data){
        ls.back().cur_building().push_back(__data);
    }
    public:
    Module()=default;
    /// @brief Generate函数组，Module会符号表注册，生成Alloca语句并放在正确的位置
    // void Generate(IRArray* __data){
    //     SymbolTable::Register(__data->get_name(),__data);
    //     if(SymbolTable::rec.empty()){
    //         /// @todo Global Alloca
    //     }
    // }
    /// @warning 这个在有初值和数值的时候有问题
    Function& GenerateFunction(InnerDataType _tp,std::string _id){
        ls.push_back(Function(_tp,_id));
    }
    void Place(AllocaInst* alloca){
        /// @note global declaration
        if(rec.empty()){
            /// @todo impl global decl
            assert(0);
        }
        /// @note local declaration
        else{
            ls.back().entry_block().push_front(alloca);
        }
    }
    Operand GenerateSITFP(Operand _A){
        auto tmp=new SITFP(_A);
        append(tmp);
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

            }
        }
        else tmp=new BinaryInst(_A,op,_B);
        append(tmp);
        return Operand(tmp->GetDef());
    }
};