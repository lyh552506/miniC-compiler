#include "AST_NODE.hpp"
/// @brief 最基础的AST_NODE，所有基础特性都应该放里面
void AST_NODE::codegen(){
    std::cerr<<"In AST some nodes are forbidden to call codegen()\n";
    assert(0);
};
void AST_NODE::print(int x)
{
    for(int i=0;i<x;i++)std::cout<<"  ";
    
    int status;
    char* demangled_name = abi::__cxa_demangle(typeid(*this).name(), 0, 0, &status);
    assert(status==0);
    std::cout<<demangled_name;
    free(demangled_name);
}
InnerBaseExps::InnerBaseExps(AddExp* _data){
    push_front(_data);
}
void InnerBaseExps::push_front(AddExp* _data){
    ls.push_front(_data);
}
void InnerBaseExps::push_back(AddExp* _data){
    ls.push_back(_data);
}
void InnerBaseExps::print(int x){
    AST_NODE::print(x);
    std::cout<<'\n';
    for(auto &i:ls)i->print(x+1);
}

Exps::Exps(AddExp* _data):InnerBaseExps(_data){}
std::vector<Operand> GetArrayDescripter(){
    std::cerr<<"Array Not Impl\n";
    assert(0);
}

CallParams::CallParams(AddExp* _data):InnerBaseExps(_data){}
std::vector<Operand> CallParams::GetParams(BasicBlock* block){
    std::vector<Operand> params;
    for(auto &i:ls)
        params.push_back(i->GetOperand(block));
    return params;
}
InitVals::InitVals(InitVal* _data){
    ls.push_back(_data);
}
void InitVals::push_back(InitVal* _data){
    ls.push_back(_data);
}
void InitVals::print(int x){
    AST_NODE::print(x);
    std::cout<<'\n';
    for(auto &i:ls)((AST_NODE*)i.get())->print(x+1);
}
InitVal::InitVal(AST_NODE* _data){
    val.reset(_data);
}
void InitVal::print(int x){
    AST_NODE::print(x);
    if(val==nullptr)
        std::cout<<":empty{}\n";
    else
        std::cout<<'\n',val->print(x+1);
}
void InitVal::DealInitVal(Variable* structure){
    if(val==nullptr){
        ///@todo notice it's a empty initialize
        assert(0);
    }
    else if(InitVals* ivs=dynamic_cast<InitVals*>(val.get())){
        ///@todo 是个数组的初始化
        assert(0);
    }
    else if(AddExp* exp=dynamic_cast<AddExp*>(val.get())){
        assert(0);
    }
    else{
        assert(0);
    }
}

BaseDef::BaseDef(std::string _id,Exps* _ad=nullptr,InitVal* _iv=nullptr):ID(_id),array_descripters(_ad),civ(_iv){}

void BaseDef::codegen(){
    if(array_descripters!=nullptr)
    {
        std::cerr<<"Array Not Implenmented!\n";
        assert(0);
    }
    else
    {
        if(civ!=nullptr)std::cerr<<"InitVal not implemented!n";
        assert(civ==nullptr);
        auto tmp=new Variable(ID);
        Singleton<Module>().GenerateGlobalVariable(tmp);
    }
}
void BaseDef::print(int x){
    AST_NODE::print(x);
    std::cout<<":"<<ID<<'\n';
    if(array_descripters!=nullptr)array_descripters->print(x+1);
    if(civ!=nullptr)civ->print(x+1);
}

VarDef::VarDef(std::string _id,Exps* _ad,InitVal* _iv):BaseDef(_id,_ad,_iv){}
BasicBlock* VarDef::GetInst(BasicBlock* block,BasicBlock* break_block,BasicBlock* continue_block){
    assert(0);
}

ConstDef::ConstDef(std::string _id,Exps* _ad=nullptr,InitVal* _iv=nullptr):BaseDef(_id,_ad,_iv){}
BasicBlock* ConstDef::GetInst(BasicBlock* block,BasicBlock* break_block,BasicBlock* continue_block){
    assert(0);
}

CompUnit::CompUnit(AST_NODE* __data){
    push_back(__data);
}
void CompUnit::push_front(AST_NODE* __data){
    ls.push_front(__data);
}
void CompUnit::push_back(AST_NODE* __data){
    ls.push_back(__data);
}
void CompUnit::codegen(){
    for(auto&i:ls)
        i->codegen();
}
void CompUnit::print(int x){
    AST_NODE::print(x);
    std::cout<<'\n';
    for(auto &i:ls){
        i->print(x+1);
    }
}

ConstDefs::ConstDefs(ConstDef* __data){
    push_back(__data);
}
void ConstDefs::push_back(ConstDef* __data){
    ls.push_back(__data);
}
void ConstDefs::codegen(){
    for(auto &i:ls)i->codegen();
}
void ConstDefs::print(int x){
    for(auto &i:ls)i->print(x);
}
BasicBlock* ConstDefs::GetInst(BasicBlock* block,BasicBlock* break_block,BasicBlock* continue_block){
    assert(0);
}

ConstDecl::ConstDecl(AST_Type tp,ConstDefs* content):type(tp),cdfs(content){
}
BasicBlock* ConstDecl::GetInst(BasicBlock* block,BasicBlock* break_block,BasicBlock* continue_block){
    assert(0);
}
void ConstDecl::codegen(){
    /// @warning copy from VarDecl
    switch (type)
    {
    case AST_INT:
        Singleton<InnerDataType>()=IR_Value_INT;
        break;
    case AST_FLOAT:
        Singleton<InnerDataType>()=IR_Value_Float;
        break;
    case AST_VOID:
    default:
        std::cerr<<"void as variable is not allowed!\n";
        assert(0);
    }
    cdfs->codegen();
}
void ConstDecl::print(int x){
    AST_NODE::print(x);
    std::cout<<":TYPE:"<<magic_enum::enum_name(type)<<'\n';
    cdfs->print(x+1);
}

VarDefs::VarDefs(VarDef* vdf){
    push_back(vdf);
}
void VarDefs::push_back(VarDef* _data){
    ls.push_back(_data);
}
void VarDefs::codegen(){
    for(auto&i:ls)
        i->codegen();
}
void VarDefs::print(int x){
    for(auto &i:ls)i->print(x);
}
BasicBlock* VarDefs::GetInst(BasicBlock* block,BasicBlock* break_block,BasicBlock* continue_block){
    assert(0);
}

VarDecl::VarDecl(AST_Type tp,VarDefs* ptr):type(tp),vdfs(ptr){}
BasicBlock* VarDecl::GetInst(BasicBlock* block,BasicBlock* break_block,BasicBlock* continue_block){
    assert(0);
}
void VarDecl::codegen(){
    switch (type)
    {
    case AST_INT:
        Singleton<InnerDataType>()=IR_Value_INT;
        break;
    case AST_FLOAT:
        Singleton<InnerDataType>()=IR_Value_Float;
        break;
    case AST_VOID:
    default:
        std::cerr<<"void as variable is not allowed!\n";
        assert(0);
    }
    vdfs->codegen();
}

void VarDecl::print(int x){
    AST_NODE::print(x);
    std::cout<<":"<<magic_enum::enum_name(type)<<'\n';
    vdfs->print(x+1);
}

FuncParam::FuncParam(AST_Type _tp,std::string _id,bool is_empty,Exps* ptr):tp(_tp),ID(_id),emptySquare(is_empty),array_subscripts(ptr){}
void FuncParam::GetVariable(Function& tmp){
    auto get_type=[](AST_Type _tp){
        switch(_tp)
        {
            case AST_INT:
                return InnerDataType::IR_Value_INT;
            case AST_FLOAT:
                return InnerDataType::IR_Value_Float;
            default:
                std::cerr<<"Wrong Type\n";
                assert(0);
        }
    };
    tmp.push_param(new Variable(get_type(tp),ID));
}
void FuncParam::print(int x){
    AST_NODE::print(x);
    std::cout<<":"<<magic_enum::enum_name(tp);
    if(emptySquare==1)std::cout<<"ptr";
    std::cout<<ID;
    if(array_subscripts!=nullptr)array_subscripts->print(x+1);
}

FuncParams::FuncParams(FuncParam* ptr){
    ls.push_back(ptr);
}
void FuncParams::push_back(FuncParam* ptr){
    ls.push_back(ptr);
}
void FuncParams::GetVariable(Function& tmp){
    for(auto &i:ls)
        i->GetVariable(tmp);
    return;
}
void FuncParams::print(int x){
    for(auto &i:ls)i->print(x);
}

BlockItems::BlockItems(Stmt* ptr){
    push_back(ptr);
}
void BlockItems::push_back(Stmt* ptr){
    ls.push_back(ptr);
}
BasicBlock* BlockItems::GetInst(BasicBlock* block,BasicBlock* break_block,BasicBlock* continue_block){
    // for(auto &i:ls)
        // block=i->GetInst(block,exit);
}
void BlockItems::print(int x){
    AST_NODE::print(x);
    std::cout<<'\n';
    // for(auto &i:ls)i->print(x+1);
}

Block::Block(BlockItems* ptr):items(ptr){}
BasicBlock* Block::GetInst(BasicBlock* block,BasicBlock* break_block,BasicBlock* continue_block){
    // items->GetInst(tmp);
}
void Block::print(int x){
    items->print(x);
}

FuncDef::FuncDef(AST_Type _tp,std::string _id,FuncParams* ptr,Block* fb):tp(_tp),ID(_id),params(ptr),function_body(fb){}
void FuncDef::codegen(){
    auto get_type=[](AST_Type _tp){
        switch(_tp)
        {
            case AST_INT:
                return InnerDataType::IR_Value_INT;
            case AST_FLOAT:
                return InnerDataType::IR_Value_Float;
            case AST_VOID:
                return InnerDataType::IR_Value_VOID;
            default:
                std::cerr<<"Wrong Type\n";
                assert(0);
        }
    };
    auto& f=Singleton<Module>().GenerateFunction(get_type(tp),ID);
    Singleton<Module>().layer_increase();
    if(params!=nullptr)params->GetVariable(f);
    assert(function_body!=nullptr);
    // function_body->GetInst(f.front_block());
    Singleton<Module>().layer_decrease();
}
void FuncDef::print(int x){
    AST_NODE::print(x);
    std::cout<<":"<<ID<<":"<<magic_enum::enum_name(tp)<<'\n';
    if(params!=nullptr)params->print(x+1);
    function_body->print(x+1);
}

LVal::LVal(std::string _id,Exps* ptr):ID(_id),array_descripters(ptr){}
Operand LVal::GetOperand(BasicBlock* block){
    assert(0);
}
void LVal::print(int x){
    AST_NODE::print(x);
    if(array_descripters!=nullptr)std::cout<<":with array descripters";
    std::cout<<":"<<ID<<'\n';
    if(array_descripters!=nullptr)array_descripters->print(x+1);
}
AssignStmt::AssignStmt(LVal* p1,AddExp* p2):lv(p1),exp(p2){}
BasicBlock* AssignStmt::GetInst(BasicBlock* block,BasicBlock* break_block,BasicBlock* continue_block){
    Operand tmp=exp->GetOperand(block);
    // block->GenerateStoreInst(block,);
    auto valueptr=Singleton<Module>().GetValueByName(lv->GetName());
    
    /// @warning design of StoreInst is not mature enough for ptr, be careful
    if(auto variable=dynamic_cast<Variable*>(valueptr))
        block->GenerateStoreInst(tmp,variable);
    else
        assert(0);
}
void AssignStmt::print(int x){
    AST_NODE::print(x);
    std::cout<<'\n';
    assert(lv!=nullptr);
    lv->print(x+1);
    exp->print(x+1);   
}

ExpStmt::ExpStmt(AddExp* ptr):exp(ptr){}
BasicBlock* ExpStmt::GetInst(BasicBlock* block,BasicBlock* break_block,BasicBlock* continue_block){
    Operand tmp=exp->GetOperand(block);
}
void ExpStmt::print(int x){
    if(exp==nullptr)AST_NODE::print(x);
    else exp->print(x);
}

WhileStmt::WhileStmt(LOrExp* p1,Stmt* p2):condition(p1),stmt(p2){}
BasicBlock* WhileStmt::GetInst(BasicBlock* block,BasicBlock* break_block,BasicBlock* continue_block){
    auto condition_part=block->GenerateNewBlock();
    auto inner_part=block->GenerateNewBlock();
    
    ///@note condition_part is a real part
    Operand condi_judge=condition->GetOperand(condition_part);
    // block->GenerateCondInst(condi_judge,is_true,is_false);

}
void WhileStmt::print(int x){
    AST_NODE::print(x);
    std::cout<<'\n';
    assert(condition!=nullptr&&stmt!=nullptr);
    condition->print(x+1);
    stmt->print(x+1);
}

IfStmt::IfStmt(LOrExp* p0,Stmt* p1,Stmt* p2):condition(p0),t(p1),f(p2){}
BasicBlock* IfStmt::GetInst(BasicBlock* block,BasicBlock* break_block,BasicBlock* continue_block){
    assert(0);
}
void IfStmt::print(int x){
    AST_NODE::print(x);
    std::cout<<'\n';
    assert(t!=nullptr);
    t->print(x+1);
    if(f!=nullptr)f->print(x+1);
}
BasicBlock* BreakStmt::GetInst(BasicBlock* block,BasicBlock* break_block,BasicBlock* continue_block){
    assert(0);
}
void BreakStmt::print(int x){
    AST_NODE::print(x);std::cout<<'\n';
}

BasicBlock* ContinueStmt::GetInst(BasicBlock* block,BasicBlock* break_block,BasicBlock* continue_block){
    assert(0);
}
void ContinueStmt::print(int x){
    AST_NODE::print(x);std::cout<<'\n';
}

ReturnStmt::ReturnStmt(AddExp* ptr):return_val(ptr){}
BasicBlock* ReturnStmt::GetInst(BasicBlock* block,BasicBlock* break_block,BasicBlock* continue_block){
    assert(0);
}
void ReturnStmt::print(int x){
    AST_NODE::print(x);std::cout<<'\n';
    if(return_val!=nullptr)return_val->print(x+1);
}

FunctionCall::FunctionCall(std::string _id,CallParams* ptr):id(_id),cp(ptr){}
Operand FunctionCall::GetOperand(BasicBlock* block){
    assert(0);
}
void FunctionCall::print(int x){
    AST_NODE::print(x);
    std::cout<<id;
    if(cp!=nullptr)cp->print(x+1);
}
