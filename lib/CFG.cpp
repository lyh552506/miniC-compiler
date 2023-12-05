#include "CFG.hpp"
#include <string>
#include <memory>
#include <iostream>
AllocaInst::AllocaInst(std::shared_ptr<Type> _tp){
    auto tmp=std::make_shared<PointerType>(_tp);
    def=std::make_unique<Value>(tmp);
}
StoreInst::StoreInst(Operand __src,Operand __des){
    add_use(__src);
    add_use(__des);
}
LoadInst::LoadInst(Value* __src){
    add_use(__src);
    auto tmp=dynamic_cast<PointerType*>(__src->CopyType().get());
    def=std::make_unique<Value>(tmp->GetInnerType());
}
FPTSI::FPTSI(Operand __src){
    add_use(__src);
    def=std::make_unique<Value>(IR_Value_INT);
}
SITFP::SITFP(Operand __src){
    add_use(__src);
    def=std::make_unique<Value>(IR_Value_Float);
}

UnCondInst::UnCondInst(BasicBlock* __des){
    add_use(__des);
}

CondInst::CondInst(Operand __cond,BasicBlock* __istrue,BasicBlock* __isfalse){
    add_use(__cond);
    add_use(__istrue);
    add_use(__isfalse);
}

CallInst::CallInst(Function* _func,std::vector<Operand>& _args){
    add_use(_func);
    for(auto&i:_args)
        add_use(i);
}

RetInst::RetInst(){}

RetInst::RetInst(Operand op){add_use(op);}

BinaryInst::BinaryInst(Operand _A,Operation __op,Operand _B){
    add_use(_A);
    add_use(_B);
    def=std::make_unique<Value>(_A->GetType());
}

Variable::Variable(std::string _id):name(_id){
    tp=std::make_shared<Type>(Singleton<InnerDataType>());
}
Variable::Variable(std::shared_ptr<Type> _tp,std::string _id):name(_id),tp(_tp){}
Variable::Variable(InnerDataType _tp,std::string _id):name(_id){
    tp=std::make_shared<Type>(_tp);
}
void Variable::SetObj(Operand _data){obj=_data;}
std::string Variable::get_name(){
    return name;
}
Operand Variable::GetObj(){return obj;}

std::shared_ptr<Type> Variable::CopyType(){return tp;}

GetElementPtrInst::GetElementPtrInst(Operand base_ptr,std::vector<Operand>& offs){
    add_use(base_ptr);
    for(auto &i:offs)add_use(i);
}

BasicBlock::BasicBlock(Function& __master):Value(IR_Value_VOID),master(__master){};
void BasicBlock::push_front(User* ptr){
    insts.push_front(ptr);
}
void BasicBlock::push_back(User* ptr){
    insts.push_back(ptr);
}
Operand BasicBlock::GenerateLoadInst(Operand data){
    auto tmp=new LoadInst(data);
    insts.push_back(tmp);
    return tmp->GetDef();
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
    bool tpA=(_A->GetType()==InnerDataType::IR_Value_INT);
    bool tpB=(_B->GetType()==InnerDataType::IR_Value_INT);
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
Operand BasicBlock::GenerateBinaryInst(BasicBlock* bb,Operand _A,BinaryInst::Operation op,Operand _B)
{
    if(_A->isConst()&&_B->isConst())
    {
        auto calc=[](auto a,BinaryInst::Operation op,auto b)->std::variant<float,int>{
            switch (op)
            {
            case BinaryInst::Op_Add:return a+b;
            case BinaryInst::Op_Sub:return a-b;
            case BinaryInst::Op_Mul:return a*b;
            case BinaryInst::Op_Div:return a/b;
            case BinaryInst::Op_And:return (a!=0)&&(b!=0);
            case BinaryInst::Op_Or:return (a!=0)||(b!=0);
            case BinaryInst::Op_Mod:return (int)a%(int)b;
            case BinaryInst::Op_E:return a==b;
            case BinaryInst::Op_NE:return a!=b;
            case BinaryInst::Op_G:return a>b;
            case BinaryInst::Op_GE:return a>=b;
            case BinaryInst::Op_L:return a<b;
            case BinaryInst::Op_LE:return a<=b;
            default:
                assert(0);
                break;
            }
        };
        std::variant<float,int> fuc;
        if(auto A=dynamic_cast<ConstIRInt*>(_A))
        {
            if(auto B=dynamic_cast<ConstIRInt*>(_B))
                fuc=calc(A->GetVal(),op,B->GetVal());
            else if(auto B=dynamic_cast<ConstIRFloat*>(_B))
                fuc=calc(A->GetVal(),op,B->GetVal());
            else assert(0);
        }
        else if(auto A=dynamic_cast<ConstIRFloat*>(_A))
        {
            if(auto B=dynamic_cast<ConstIRInt*>(_B))
                fuc=calc(A->GetVal(),op,B->GetVal());
            else if(auto B=dynamic_cast<ConstIRFloat*>(_B))
                fuc=calc(A->GetVal(),op,B->GetVal());
            else assert(0);
        }
        else assert(0);
        if(std::holds_alternative<int>(fuc))
            return new ConstIRInt(std::get<int>(fuc));
        else
            return new ConstIRFloat(std::get<float>(fuc));
    }
    else
    {
        assert(bb!=nullptr);
        return bb->GenerateBinaryInst(_A,op,_B);
    }
}
void BasicBlock::GenerateStoreInst(Operand src,Operand des){
    assert(des->GetType()==IR_PTR);
    auto tmp=dynamic_cast<PointerType*>(des->CopyType().get());
    
    if(tmp->GetInnerType()!=src->GetType()){
        if(tmp->GetInnerType()==IR_Value_INT)src=this->GenerateFPTSI(src);
        else src=this->GenerateSITFP(src);
    }
    auto storeinst=new StoreInst(src,des);
    this->push_back(storeinst);
}
BasicBlock* BasicBlock::GenerateNewBlock(){
    BasicBlock* tmp=new BasicBlock(master);
    master.add_block(tmp);
    return tmp;
}
void BasicBlock::print(){
    std::cout<<"---BasicBlock---\n";
    for(auto &i:insts)
        i->print();
    std::cout<<"---EndBasicBlock\n";
}
void Function::print(){
    std::cout<<"---Function---:"<<name<<"\n";
    for(auto &i:bbs)
        i->print();
    std::cout<<"---EndFunction---\n";
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
    if(master.GetType()!=ret_val->GetType()){
        if(ret_val->GetType()==IR_Value_INT)
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
Operand BasicBlock::GenerateCallInst(std::string id,std::vector<Operand> args){
    if(auto func=dynamic_cast<Function*>(Singleton<Module>().GetValueByName(id))){
        auto inst=new CallInst(func,args);
        insts.push_back(inst);
        return inst->GetDef();
    }
    else{
        std::cerr<<"No Such Function!\n";
        assert(0);
    }
}
void BasicBlock::GenerateAlloca(Variable* var){
    master.push_alloca(var);
}
Operand BasicBlock::GenerateGEPInst(Operand ptr,std::vector<Operand>& offs){
    auto tmp=new GetElementPtrInst(ptr,offs);
    insts.push_back(tmp);
    return tmp->GetDef();
}
Operand BasicBlock::push_alloca(std::shared_ptr<Type> _tp){
    auto tmp=new AllocaInst(_tp);
    insts.push_front(tmp);
    return tmp->GetDef();
}

void Function::push_alloca(Variable* ptr){
    alloca_variables.push_back(VarPtr(ptr));
    auto obj=bbs.front()->push_alloca(ptr->CopyType());
    Singleton<Module>().Register(ptr->get_name(),obj);
    ptr->SetObj(obj);
}
void Function::push_param(Variable* var){
    params.push_back(ParamPtr(var));
    /// @warning RNM这个new没人回收
    auto tmp=std::make_shared<PointerType>(var->CopyType());
    Singleton<Module>().Register(var->get_name(),new Value(tmp));
}
void Function::add_block(BasicBlock* __block){
    bbs.push_back(BasicBlockPtr(__block));
}
// void Module::visit(std::function<void(Function*)> call_back){
//     for(auto&i:ls)
//         call_back(i.get());
// }
void Module::Test(){
    for(auto&i:ls)
        i->print();
}
Function& Module::GenerateFunction(InnerDataType _tp,std::string _id){
    ls.push_back(FunctionPtr(new Function(_tp,_id)));
    return *ls.back();
}
void Module::GenerateGlobalVariable(Variable* ptr){
    auto obj=new Value(std::make_shared<PointerType>(ptr->CopyType()));
    ptr->SetObj(obj);
    SymbolTable::Register(ptr->get_name(),obj);
    globalvaribleptr.push_back(GlobalVariblePtr(ptr));
}