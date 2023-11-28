#include "CFG.hpp"
#include <string>
#include <memory>
Value* InstWithDef::GetDef(){
    return def;
}
AllocaInst::AllocaInst(Value* __data):data(__data){
    /// @note 注意__data的实际类型一定是Varible或者数组，所以Type在里面找
}
StoreInst::StoreInst(Operand __src,Value* __des):src(__src),des(__des){
    if(std::holds_alternative<Value*>(src))add_use(std::get<Value*>(src));
    add_use(des);
}
LoadInst::LoadInst(Value* __src):src(__src){
    add_use(src);
    def=new Value(src->GetType());
}
FPTSI::FPTSI(Operand __src):src(__src){
    if(std::holds_alternative<Value*>(src))add_use(std::get<Value*>(src));
    def=new Value(IR_Value_INT);
}
SITFP::SITFP(Operand __src):src(__src){
    if(std::holds_alternative<Value*>(src))add_use(std::get<Value*>(src));
    def=new Value(IR_Value_Float);
}
BinaryInst::BinaryInst(Operand _A,Operation __op,Operand _B):A(_A),op(__op),B(_B){
    if(std::holds_alternative<Value*>(A))add_use(std::get<Value*>(A));
    if(std::holds_alternative<Value*>(B))add_use(std::get<Value*>(B));
    def=new Value(_A.GetType());
}
Variable::Variable(std::string _id):name(_id),Value(Singleton<InnerDataType>()){}
Variable::Variable(InnerDataType tp,std::string _id):Value(tp),name(_id){}
std::string Variable::get_name(){
    return name;
}
BasicBlock::BasicBlock():Value(IR_Value_VOID){};
void BasicBlock::push_front(User* ptr){
    insts.push_front(ptr);
}
void BasicBlock::push_back(User* ptr){
    insts.push_back(ptr);
}
Operand BasicBlock::GenerateSITFP(Operand _A){
    auto tmp=new SITFP(_A);
    push_back(tmp);
    return Operand(tmp->GetDef());
}
Operand BasicBlock::GenerateFPTSI(Operand _B){
    auto tmp=new FPTSI(_B);
    push_back(tmp);
    return Operand(tmp->GetDef());
}
Operand BasicBlock::GenerateBinaryInst(Operand _A,BinaryInst::Operation op,Operand _B){
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
void Function::InsertAlloca(AllocaInst* ptr){
    bbs.front()->push_back(ptr);
}
Function::Function(InnerDataType _tp,std::string _id):Value(_tp),name(_id){
    //至少有一个bbs
    bbs.push_back(BasicBlockPtr(new BasicBlock()));
}
BasicBlock* Function::front_block(){
    return bbs.front().get();
}
void Function::push_alloca(Variable* ptr){
    alloca_variables.push_back(VarPtr(ptr));
    Singleton<Module>().Register(ptr->get_name(),ptr);
}
void Function::push_param(Variable* var){
    params.push_back(ParamPtr(var));
    Singleton<Module>().Register(var->get_name(),var);
}
Function& Module::GenerateFunction(InnerDataType _tp,std::string _id){
    ls.push_back(Function(_tp,_id));
    return ls.back();
}
void Module::GenerateGlobalVariable(Variable* ptr){
    SymbolTable::Register(ptr->get_name(),ptr);
    globalvaribleptr.push_back(GlobalVariblePtr(ptr));
}