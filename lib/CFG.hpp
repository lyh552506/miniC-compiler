#pragma once
#include "SymbolTable.hpp"
class BaseInst:public User
{
};
class BranchInst:public BaseInst
{
};
class BinaryInst:public BaseInst
{
    enum Operation
    {
        Op_Add,Op_Sub,Op_Mul,Op_Div,Op_And,Op_Or,Op_Mod,
        //what's below should be translate to cmp inst in llvm
        Op_E,Op_NE,Op_GE,Op_L,Op_LE,Op_G
    }op;
    public:
    BinaryInst(Value* A,Value* B){
        
    }
};
/// @brief allocainst 什么都没有use
class AllocaInst:public BaseInst
{
    Value* data;
    public:
    /// @brief Alloca语句要Type的结构,所以是Value*
    AllocaInst(Value* __data):data(__data){
        /// @note 注意__data的实际类型一定是Varible或者数组，所以Type在里面找
    }
};
/// @brief src->des
class StoreInst:public BaseInst
{
    Value* des;
    Value* src;
    public:
    StoreInst(Value* __src,Value* __des):src(__src),des(__des){
        add_use(src);
        add_use(des);
    }
};
/// @brief BasicBlock会作为CFG中的最小节点出现，要有一个访问所有出边的方法
class BasicBlock:public Value
{
    List<BaseInst> insts;
    public:
    void push_front(BaseInst* ptr){
        insts.push_front(ptr);
    }
    void push_back(BaseInst* ptr){
        insts.push_back(ptr);
    }
};
/// @brief 真正意义上变量，在内存里反应为alloca指令，寄存器应该只要Value级就够了
class Variable:public Value
{
    std::string name;
    public:
    Variable(std::string _id):name(_id),Value(Singleton<InnerDataType>()){}
    std::string get_name(){
        return name;
    }
};
/// @brief 源代码中显示字面量的处理等同于const int a=10;
/// @tparam T float/int 
template<typename T>
class ConstantVariable:public Variable
{

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
    std::vector<BasicBlock> bbs;
    public:
    BasicBlock& entry_block(){
        return bbs.front();
    }
    BasicBlock& cur_building(){
        return bbs.back();
    }
};
/// @brief 编译单元
class Module:public SymbolTable
{
    /// @todo Module中需要一个Factory类似的东西来确保自动析构一些指针指向的对象
    std::vector<Function> ls;
    public:
    Module()=default;
    /// @brief Generate函数组，Module会符号表注册，生成Alloca语句并放在正确的位置
    // void Generate(IRArray* __data){
    //     SymbolTable::Register(__data->get_name(),__data);
    //     if(SymbolTable::rec.empty()){
    //         /// @todo Global Alloca
    //     }
    // }
    void Place(AllocaInst* alloca,StoreInst* store){
        /// @note global declaration
        if(rec.empty()){
            /// @todo impl global decl
            assert(0);
        }
        /// @note local declaration
        else{
            ls.back().entry_block().push_front(alloca);
            ls.back().cur_building().push_back(store);
        }
    }
    void Place(BinaryInst* bs){

    }
};