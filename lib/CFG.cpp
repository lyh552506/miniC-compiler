#include "CFG.hpp"
#include <string>
#include <memory>
#include <iostream>
Value* InstWithDef::GetDef(){
    return def;
}
AllocaInst::AllocaInst(Value* __data):data(__data){
    /// @note 注意__data的实际类型一定是Varible或者数组，所以Type在里面找
}
StoreInst::StoreInst(Operand __src,Variable* __des):src(__src),des(__des){
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

UnCondInst::UnCondInst(BasicBlock* __des):des(__des){
    add_use(__des);
}

CondInst::CondInst(Operand __cond,BasicBlock* __istrue,BasicBlock* __isfalse):condition(__cond),istrue(__istrue),isfalse(__isfalse){
    if(std::holds_alternative<Value*>(condition))add_use(std::get<Value*>(condition));
    add_use(istrue);
    add_use(isfalse);
}

CallInst::CallInst(Function* _func,std::vector<Operand> _args):call_handle(_func),args(_args){}

bool CallInst::HasDef(){
    if(call_handle->GetType()!=IR_Value_VOID)return true;
    else return false;
}

Value* CallInst::GetDef(){
    assert(HasDef());
    return def;
}

RetInst::RetInst():ret_val(nullptr){}

RetInst::RetInst(Operand op):ret_val(op){}

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
BasicBlock::BasicBlock(Function& __master):Value(IR_Value_VOID),master(__master){};
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
void BasicBlock::GenerateStoreInst(Operand src,Variable* des){
    if(des->GetType()!=src.GetType()){
        if(des->GetType()==IR_Value_INT)this->GenerateFPTSI(src);
        else this->GenerateSITFP(src);
    }
    auto storeinst=new StoreInst(src,des);
    this->push_back(storeinst);
}
BasicBlock* BasicBlock::GenerateNewBlock(){
    BasicBlock* tmp=new BasicBlock(master);
    master.add_block(tmp);
    return tmp;
}
void Function::InsertAlloca(AllocaInst* ptr){
    bbs.front()->push_back(ptr);
}
Function::Function(InnerDataType _tp,std::string _id):Value(_tp),name(_id){
    //至少有一个bbs
    bbs.push_back(BasicBlockPtr(new BasicBlock(*this)));
}
BasicBlock* Function::front_block(){
    return bbs.front().get();
}
bool BasicBlock::EndWithBranch(){
    if(auto data=dynamic_cast<UnCondInst*>(insts.back().get()))return 1;
    else if(auto data=dynamic_cast<CondInst*>(insts.back().get()))return 1;
    else if(auto data=dynamic_cast<RetInst*>(insts.back().get()))return 1;
    else return 0;
}
void BasicBlock::GenerateCondInst(Operand condi,BasicBlock* is_true,BasicBlock* is_false){
    auto inst=new CondInst(condi,is_true,is_false);
    insts.push_back(inst);
}
void BasicBlock::GenerateUnCondInst(BasicBlock* des){
    auto inst=new UnCondInst(des);
    insts.push_back(inst);
}
void BasicBlock::GenerateRetInst(Operand ret_val){
    if(master.GetType()!=ret_val.GetType()){
        if(ret_val.GetType()==IR_Value_INT)
            ret_val=GenerateSITFP(ret_val);
        else
            ret_val=GenerateFPTSI(ret_val);
    }
    auto inst=new RetInst(ret_val);
    insts.push_back(inst);
}
void BasicBlock::GenerateRetInst(){
    auto inst=new RetInst();
    insts.push_back(inst);
}
void BasicBlock::GenerateCallInst(std::string id,std::vector<Operand> args){
    if(auto func=dynamic_cast<Function*>(Singleton<Module>().GetValueByName(id))){
        auto inst=new CallInst(func,args);
        insts.push_back(inst);
    }
    else{
        std::cerr<<"No Such Function!\n";
        assert(0);
    }
}
void BasicBlock::GenerateAlloca(Variable* var){
    master.push_alloca(var);
}
void Function::push_alloca(Variable* ptr){
    alloca_variables.push_back(VarPtr(ptr));
    Singleton<Module>().Register(ptr->get_name(),ptr);
}
void Function::push_param(Variable* var){
    params.push_back(ParamPtr(var));
    Singleton<Module>().Register(var->get_name(),var);
}
void Function::add_block(BasicBlock* __block){
    bbs.push_back(BasicBlockPtr(__block));
}
Function& Module::GenerateFunction(InnerDataType _tp,std::string _id){
    ls.push_back(FunctionPtr(new Function(_tp,_id)));
    return *ls.back();
}
void Module::GenerateGlobalVariable(Variable* ptr){
    SymbolTable::Register(ptr->get_name(),ptr);
    globalvaribleptr.push_back(GlobalVariblePtr(ptr));
}