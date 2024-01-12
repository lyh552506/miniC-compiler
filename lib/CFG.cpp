#include "CFG.hpp"
#include <string>
#include <memory>
#include <iostream>
#include "MagicEnum.hpp"
AllocaInst::AllocaInst(Type* _tp):User(PointerType::NewPointerTypeGet(_tp)){}
void AllocaInst::print(){
    Value::print();
    /// @todo typesystem 
    std::cout<<" = alloca ";
    dynamic_cast<PointerType*>(tp)->GetSubType()->print();
    std::cout<<"\n";
}
StoreInst::StoreInst(Operand __src,Operand __des){
    add_use(__src);
    add_use(__des);
}
Operand StoreInst::GetDef(){return nullptr;}
void StoreInst::print(){
    std::cout<<"store ";
    for(auto&i:uselist){
        i->GetValue()->GetType()->print();
        std::cout<<" ";
        i->GetValue()->print();
        if(i.get()!=uselist.back().get())std::cout<<", ";
    }
    std::cout<<'\n';
}
void StoreInst::ir_mark(){
    return;
}

LoadInst::LoadInst(Value* __src):User(dynamic_cast<PointerType*>(__src->GetType())->GetSubType()){
    assert(GetTypeEnum()==IR_Value_INT||GetTypeEnum()==IR_Value_Float);
    add_use(__src);
}

void LoadInst::print(){
    Value::print();
    std::cout<<" = load ";
    tp->print();
    std::cout<<", ";
    for(auto&i:uselist){
        i->GetValue()->GetType()->print();
        std::cout<<" ";
        i->GetValue()->print();
        if(i.get()!=uselist.back().get())std::cout<<", ";
    }
    std::cout<<'\n';
}



void FPTSI::print(){
    Value::print();
    std::cout<<" = fptosi ";
    for(auto&i:uselist){
        i->GetValue()->GetType()->print();
        std::cout<<" ";
        i->GetValue()->print();
        std::cout<<" ";
    }
    std::cout<<"to ";
    tp->print();
    std::cout<<"\n";
}

FPTSI::FPTSI(Operand __src):User(IntType::NewIntTypeGet()){
    add_use(__src);
}

void SITFP::print(){
    Value::print();
    std::cout<<" = sitofp ";
    for(auto&i:uselist){
        i->GetValue()->GetType()->print();
        std::cout<<" ";
        i->GetValue()->print();
        std::cout<<" ";
    }
    std::cout<<"to ";
    tp->print();
    std::cout<<'\n';
}

SITFP::SITFP(Operand __src):User(FloatType::NewFloatTypeGet()){
    add_use(__src);
}

Operand UnCondInst::GetDef(){return nullptr;}

UnCondInst::UnCondInst(BasicBlock* __des){
    add_use(__des);
}

void UnCondInst::print(){
    std::cout<<"br ";
    for(auto&i:uselist){
        std::cout<<"label ";
        i->GetValue()->print();
        std::cout<<" ";
    }
    std::cout<<"\n\n";
    dynamic_cast<BasicBlock*>(uselist[0]->GetValue())->print();
}

void UnCondInst::ir_mark(){
    uselist[0]->GetValue()->ir_mark();
}

void CondInst::ir_mark(){
    for(int i=1;i<uselist.size();i++)
        uselist[i]->GetValue()->ir_mark();
}

CondInst::CondInst(Operand __cond,BasicBlock* __istrue,BasicBlock* __isfalse){
    add_use(__cond);
    add_use(__istrue);
    add_use(__isfalse);
}

void CondInst::print(){
    std::cout<<"br ";
    bool flag=0;
    for(auto&i:uselist){
        if(flag==0){
            i->GetValue()->GetType()->print();
            std::cout<<" ";
            flag=1;
        }
        else std::cout<<"label ";
        i->GetValue()->print();
        if(i.get()!=uselist.back().get())
            std::cout<<", ";
    }
    std::cout<<"\n\n";
    for(int i=1;i<=2;i++)dynamic_cast<BasicBlock*>(uselist[i]->GetValue())->print();
}

Operand CondInst::GetDef(){return nullptr;}

CallInst::CallInst(Function* _func,std::vector<Operand>& _args):User(_func->GetType()){
    add_use(_func);
    for(auto&i:_args)
        add_use(i);
}

void CallInst::print(){
    Value::print();
    std::cout<<" = call ";
    for(auto&i:uselist){
        i->GetValue()->GetType()->print();
        std::cout<<" ";
        i->GetValue()->print();
        if(i.get()==uselist.front().get())
            std::cout<<"(";
        else if(i.get()!=uselist.back().get())
            std::cout<<", ";
    }
    std::cout<<")\n";
}

RetInst::RetInst(){}

RetInst::RetInst(Operand op){add_use(op);}

void RetInst::ir_mark(){
    return;
}

void RetInst::print(){
    std::cout<<"ret ";
    for(auto&i:uselist){
        i->GetValue()->GetType()->print();
        std::cout<<" ";
        i->GetValue()->print();
        std::cout<<" ";
    }
    if(uselist.empty())std::cout<<"void";
    std::cout<<'\n';
}

Operand RetInst::GetDef(){return nullptr;}

BinaryInst::BinaryInst(Operand _A,Operation __op,Operand _B):User(_A->GetType()){
    op=__op;
    add_use(_A);
    add_use(_B);
}

void BinaryInst::print(){
    Value::print();
    std::cout<<" = ";
    switch (op)
    {
    case BinaryInst::Op_Add:
        if(uselist[0]->GetValue()->GetTypeEnum()==IR_Value_INT)std::cout<<"add ";
        else std::cout<<"fadd ";
        break;
    case BinaryInst::Op_Sub:
        if(uselist[0]->GetValue()->GetTypeEnum()==IR_Value_INT)std::cout<<"sub ";
        else std::cout<<"fsub ";
        break;
    case BinaryInst::Op_Mul:
        if(uselist[0]->GetValue()->GetTypeEnum()==IR_Value_INT)std::cout<<"mul ";
        else std::cout<<"fmul ";
        break;
    case BinaryInst::Op_Div:
        if(uselist[0]->GetValue()->GetTypeEnum()==IR_Value_INT)std::cout<<"sdiv ";
        else std::cout<<"fdiv ";
        break;
    case BinaryInst::Op_Mod:
        if(uselist[0]->GetValue()->GetTypeEnum()==IR_Value_INT)std::cout<<"srem ";
        else std::cout<<"frem ";///应该不存在
        break;
    case BinaryInst::Op_And:
        std::cout<<"and ";
        break;
    case BinaryInst::Op_Or:
        std::cout<<"Or ";
        break;
    case BinaryInst::Op_E:
        if(uselist[0]->GetValue()->GetTypeEnum()==IR_Value_INT)std::cout<<"i";
        else std::cout<<"f";
        std::cout<<"cmp ";
        if(uselist[0]->GetValue()->GetTypeEnum()==IR_Value_Float)std::cout<<"u";
        std::cout<<"eq ";
        break;
    case BinaryInst::Op_NE:
        if(uselist[0]->GetValue()->GetTypeEnum()==IR_Value_INT)std::cout<<"i";
        else std::cout<<"f";
        std::cout<<"cmp ";
        if(uselist[0]->GetValue()->GetTypeEnum()==IR_Value_Float)std::cout<<"u";
        std::cout<<"ne ";
        break;
    case BinaryInst::Op_G:
        if(uselist[0]->GetValue()->GetTypeEnum()==IR_Value_INT)std::cout<<"i";
        else std::cout<<"f";
        std::cout<<"cmp ";
        if(uselist[0]->GetValue()->GetTypeEnum()==IR_Value_Float)std::cout<<"ugt ";
        else std::cout<<"sgt ";
        break;
    case BinaryInst::Op_GE:
        if(uselist[0]->GetValue()->GetTypeEnum()==IR_Value_INT)std::cout<<"i";
        else std::cout<<"f";
        std::cout<<"cmp ";
        if(uselist[0]->GetValue()->GetTypeEnum()==IR_Value_Float)std::cout<<"uge ";
        else std::cout<<"sge ";
        break;
    case BinaryInst::Op_L:
        if(uselist[0]->GetValue()->GetTypeEnum()==IR_Value_INT)std::cout<<"i";
        else std::cout<<"f";
        std::cout<<"cmp ";
        if(uselist[0]->GetValue()->GetTypeEnum()==IR_Value_Float)std::cout<<"ult ";
        else std::cout<<"slt ";
        break;
    case BinaryInst::Op_LE:
        if(uselist[0]->GetValue()->GetTypeEnum()==IR_Value_INT)std::cout<<"i";
        else std::cout<<"f";
        std::cout<<"cmp ";
        if(uselist[0]->GetValue()->GetTypeEnum()==IR_Value_Float)std::cout<<"uge ";
        else std::cout<<"sge ";
        break;
    default:
        break;
    }
    uselist[0]->GetValue()->GetType()->print();
    std::cout<<" ";
    uselist[0]->GetValue()->print();
    std::cout<<", ";
    uselist[1]->GetValue()->print();
    std::cout<<'\n';
}

Variable::Variable(std::string _id):name(_id){
    tp=Type::NewTypeByEnum(Singleton<InnerDataType>());
}
Variable::Variable(Type* _tp,std::string _id):name(_id),tp(_tp){}
Variable::Variable(InnerDataType _tp,std::string _id):name(_id){
    tp=Type::NewTypeByEnum(Singleton<InnerDataType>());
}
std::string Variable::get_name(){
    return name;
}

Type* Variable::GetType(){return tp;}

GetElementPtrInst::GetElementPtrInst(Operand base_ptr){
    add_use(base_ptr);
}

Type* GetElementPtrInst::GetType(){
    int limi=uselist.size()-1;
    tp=uselist[0]->GetValue()->GetType();
    for(int i=1;i<=limi;i++)
        tp=dynamic_cast<HasSubType*>(tp)->GetSubType();
    return tp=PointerType::NewPointerTypeGet(tp);
}


void GetElementPtrInst::print(){
    Value::print();
    std::cout<<" = getelementptr inbounds ";
    dynamic_cast<HasSubType*>(uselist[0]->GetValue()->GetType())->GetSubType()->print();
    std::cout<<", ";
    for(int i=0;i<uselist.size();i++){
        std::cout<<", ";
        uselist[i]->GetValue()->GetType()->print();
        std::cout<<" ";
        uselist[i]->GetValue()->print();
    }
    std::cout<<'\n';
}

BasicBlock::BasicBlock(Function& __master):Value(VoidType::NewVoidTypeGet()),master(__master){};
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
    bool tpA=(_A->GetTypeEnum()==InnerDataType::IR_Value_INT);
    bool tpB=(_B->GetTypeEnum()==InnerDataType::IR_Value_INT);
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

void BasicBlock::ir_mark(){
    if(!Singleton<IR_MARK>().mark(this))return;
    Value::ir_mark();
    for(auto&i:insts)
        i->ir_mark();
}

void BasicBlock::GenerateStoreInst(Operand src,Operand des){
    assert(des->GetTypeEnum()==IR_PTR);
    auto tmp=dynamic_cast<PointerType*>(des->GetType());
    
    if(tmp->GetSubType()->GetTypeEnum()!=src->GetTypeEnum()){
        if(tmp->GetSubType()->GetTypeEnum()==IR_Value_INT)src=this->GenerateFPTSI(src);
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
    if(Singleton<IR_MARK>().isprint(this)==1)return;
    Singleton<IR_MARK>().isprint(this)=1;
    if(master.front_block()!=this)
        std::cout<<Singleton<IR_MARK>().GetNum(this)<<":\n";
    for(auto &i:insts){
        std::cout<<"  ";
        i->print();
    }
}
void Function::print(){
    Singleton<IR_MARK>().Reset();
    for(auto&i:bbs)i->ir_mark();
    std::cout<<"define i32 @"<<name<<"(";
    for(auto &i:params){
        i->GetType()->print();
        Singleton<IR_MARK>().GetNum(i.get());
        if(i.get()!=params.back().get())std::cout<<", ";
    }
    std::cout<<"){\n";
    // for(auto &i:bbs)
    // {
    //     if(i.get()!=bbs.front().get()){
    //         std::cout<<Singleton<IR_MARK>().GetNum(i.get())<<":\n";
    //     }
    //     else{
    //         Singleton<IR_MARK>().GetNum(i.get());
    //     } 
    //     i->print();
    //     if(i.get()!=bbs.back().get())std::cout<<"\n";
    // }
    bbs.front()->print();
    std::cout<<"}\n";
}
std::string Function::GetName(){return name;}
void Function::InsertAlloca(AllocaInst* ptr){
    bbs.front()->push_back(ptr);
}
Function::Function(InnerDataType _tp,std::string _id):Value(Type::NewTypeByEnum(_tp)),name(_id){
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
    if(master.GetTypeEnum()!=ret_val->GetTypeEnum()){
        if(ret_val->GetTypeEnum()==IR_Value_INT)
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
        auto& params=func->GetParams();
        assert(args.size()==params.size());
        auto i=args.begin();
        for(auto j=params.begin();j!=params.end();j++,i++){
            auto& ii=*i;auto& jj=*j;
            assert(ii->GetType()==jj->GetType());
        }
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
Operand BasicBlock::GenerateGEPInst(Operand ptr){
    auto tmp=new GetElementPtrInst(ptr);
    insts.push_back(tmp);
    return tmp->GetDef();
}
Operand BasicBlock::push_alloca(Type* _tp){
    auto tmp=new AllocaInst(_tp);
    insts.push_front(tmp);
    return tmp->GetDef();
}

void Function::push_alloca(Variable* ptr){
    auto obj=bbs.front()->push_alloca(ptr->GetType());
    Singleton<Module>().Register(ptr->get_name(),obj);
}
void Function::push_param(Variable* var){
    push_alloca(var);
    /// @brief 实参
    params.push_back(ParamPtr(new Value(var->GetType())));
    bbs.front()->GenerateStoreInst(params.back().get(),Singleton<Module>().GetValueByName(var->get_name()));
}
void Function::add_block(BasicBlock* __block){
    bbs.push_back(BasicBlockPtr(__block));
}
std::vector<std::unique_ptr<Value>>& Function::GetParams(){
    return params;
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
    auto tmp=new Function(_tp,_id);
    Register(_id,tmp);
    ls.push_back(FunctionPtr(tmp));
    return *ls.back();
}
void Module::GenerateGlobalVariable(Variable* ptr){
    /// @todo 初始化单元
    auto obj=new Value(PointerType::NewPointerTypeGet(ptr->GetType()));
    SymbolTable::Register(ptr->get_name(),obj);
    globalvaribleptr.push_back(GlobalVariblePtr(ptr));
}