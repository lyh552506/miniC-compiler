#include "CFG.hpp"
#include <string>
#include <memory>
#include <iostream>
#include "MagicEnum.hpp"
AllocaInst::AllocaInst(std::shared_ptr<Type> _tp):User(std::make_shared<PointerType>(_tp)){}
void AllocaInst::print(int &cnt){
    Value::print(cnt);
    /// @todo typesystem 
    std::cout<<" = alloca ";
    dynamic_cast<PointerType*>(tp.get())->GetSubType()->print();
    std::cout<<"\n";
}
StoreInst::StoreInst(Operand __src,Operand __des){
    add_use(__src);
    add_use(__des);
}
Operand StoreInst::GetDef(){return nullptr;}
void StoreInst::print(int &cnt){
    std::cout<<"store ";
    for(auto&i:uselist){
        i->GetValue()->CopyType()->print();
        std::cout<<" ";
        i->GetValue()->print(cnt);
        std::cout<<" ";
    }
    std::cout<<'\n';
}

LoadInst::LoadInst(Value* __src):User(dynamic_cast<PointerType*>(__src->CopyType().get())->GetSubType()){
    assert(GetType()==IR_Value_INT||GetType()==IR_Value_Float);
    add_use(__src);
}

void LoadInst::print(int &cnt){
    Value::print(cnt);
    std::cout<<" = load ";
    for(auto&i:uselist){
        i->GetValue()->CopyType()->print();
        std::cout<<" ";
        i->GetValue()->print(cnt);
        std::cout<<" ";
    }
    std::cout<<'\n';
}



void FPTSI::print(int &cnt){
    Value::print(cnt);
    std::cout<<" = fptosi ";
    for(auto&i:uselist){
        i->GetValue()->CopyType()->print();
        std::cout<<" ";
        i->GetValue()->print(cnt);
        std::cout<<" ";
    }
    std::cout<<'\n';
}

FPTSI::FPTSI(Operand __src):User(std::make_shared<Type>(IR_Value_INT)){
    add_use(__src);
}

void SITFP::print(int &cnt){
    Value::print(cnt);
    std::cout<<" = sitofp ";
    for(auto&i:uselist){
        i->GetValue()->CopyType()->print();
        std::cout<<" ";
        i->GetValue()->print(cnt);
        std::cout<<" ";
    }
    std::cout<<'\n';
}

SITFP::SITFP(Operand __src):User(std::make_shared<Type>(IR_Value_Float)){
    add_use(__src);
}

Operand UnCondInst::GetDef(){return nullptr;}

UnCondInst::UnCondInst(BasicBlock* __des){
    add_use(__des);
}

void UnCondInst::print(int &cnt){
    std::cout<<"br ";
    for(auto&i:uselist){
        std::cout<<"label ";
        i->GetValue()->print(cnt);
        std::cout<<" ";
    }
    std::cout<<'\n';
}

CondInst::CondInst(Operand __cond,BasicBlock* __istrue,BasicBlock* __isfalse){
    add_use(__cond);
    add_use(__istrue);
    add_use(__isfalse);
}

void CondInst::print(int &cnt){
    std::cout<<"br ";
    bool flag=0;
    for(auto&i:uselist){
        if(flag==0){
            i->GetValue()->CopyType()->print();
            std::cout<<" ";
            flag=1;
        }
        else std::cout<<"label ";
        i->GetValue()->print(cnt);
        std::cout<<" ";
    }
    std::cout<<'\n';
}

Operand CondInst::GetDef(){return nullptr;}

CallInst::CallInst(Function* _func,std::vector<Operand>& _args):User(_func->CopyType()){
    add_use(_func);
    for(auto&i:_args)
        add_use(i);
}

void CallInst::print(int &cnt){
    Value::print(cnt);
    std::cout<<" = call ";
    for(auto&i:uselist){
        i->GetValue()->CopyType()->print();
        std::cout<<" ";
        i->GetValue()->print(cnt);
        std::cout<<" ";
    }
    std::cout<<'\n';
}

RetInst::RetInst(){}

RetInst::RetInst(Operand op){add_use(op);}

void RetInst::print(int &cnt){
    std::cout<<"ret ";
    for(auto&i:uselist){
        i->GetValue()->CopyType()->print();
        std::cout<<" ";
        i->GetValue()->print(cnt);
        std::cout<<" ";
    }
    std::cout<<'\n';
}

Operand RetInst::GetDef(){return nullptr;}

BinaryInst::BinaryInst(Operand _A,Operation __op,Operand _B):User(_A->CopyType()){
    op=__op;
    add_use(_A);
    add_use(_B);
}

void BinaryInst::print(int &cnt){
    Value::print(cnt);
    std::cout<<" = ";
    bool flag=false;
    for(auto&i:uselist){
        i->GetValue()->CopyType()->print();
        std::cout<<" ";
        i->GetValue()->print(cnt);
        std::cout<<" ";
        if(flag==false){
            flag=true;
            std::cout<<magic_enum::enum_name(op)<<" ";
        }
    }
    std::cout<<'\n';
}

Variable::Variable(std::string _id):name(_id){
    tp=std::make_shared<Type>(Singleton<InnerDataType>());
}
Variable::Variable(std::shared_ptr<Type> _tp,std::string _id):name(_id),tp(_tp){}
Variable::Variable(InnerDataType _tp,std::string _id):name(_id){
    tp=std::make_shared<Type>(_tp);
}
std::string Variable::get_name(){
    return name;
}

std::shared_ptr<Type> Variable::CopyType(){return tp;}

GetElementPtrInst::GetElementPtrInst(Operand base_ptr,std::vector<Operand>& offs){
    std::shared_ptr<Type> fuc=nullptr;
    for(auto &i:offs){
        auto select=(fuc==nullptr?base_ptr->CopyType():fuc);
        if(auto _tp=dynamic_cast<HasSubType*>(select.get()))fuc=_tp->GetSubType();
        else assert("Not a valid type");
    }
    tp=std::make_shared<PointerType>(fuc);
    add_use(base_ptr);
    for(auto &i:offs)add_use(i);
}

void GetElementPtrInst::print(int &cnt){
    Value::print(cnt);
    std::cout<<" = ";
    for(auto&i:uselist){
        i->GetValue()->CopyType()->print();
        std::cout<<" ";
        i->GetValue()->print(cnt);
        std::cout<<" ";
    }
    std::cout<<'\n';
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
void BasicBlock::print(int &cnt){
    Value::print(cnt);
    std::cout<<":\n";
    for(auto &i:insts)
    {
        std::cout<<"  ";
        i->print(cnt);
    }
}
void Function::print(){
    std::cout<<"define dso_local i32 @"<<name<<"{\n";
    int cnt=0;
    for(auto &i:bbs)
    {
        i->print(cnt);
        std::cout<<"\n";
    }
    std::cout<<"}\n";
}
std::string Function::GetName(){return name;}
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
        /// @note match the type of param and arg
        auto& params=func->GetParams();
        assert(args.size()==params.size());
        /// @warning 这里肯定是有bug的,但是实际我只要保证他指针地址没错，肯定能跑
        /// @note llvm对于类型的处理感觉有点傻逼，好像新版本在弱化ptr类型的子类型，有一种只要它地址是对的，你就别管的美（实际我也想这样），评价是初衷是好的，但是执行错了
        /// 支持情况 1 
        /// 形参:int crr[][10] 
        /// int arr[10];func(arr) 完全不进行类型的转换
        /// 因为实际ir的处理就是crr是指向[i32x10]的指针,arr也是指向[i32x10]的指针，就是这么jb怪
        /// 支持情况 2
        /// 形参:int crr[][10]
        /// 实参:int arr[10][10]，填func(arr[2])
        /// arr[2]自动调用GEP 0 2，转换为[i32x10]*
        /// 支持情况 3
        /// 形参:int crr[][10]
        /// 实参:int arr[10][10][10]，填func(arr)
        /// arr会在本函数中调用 GEP 0 0 0转化成正确类型
        /// 支持情况 4
        /// 形参:int crr[10]
        /// 实参:int arr[10]
        /// 其实crr在ir中的类型是i32*...
        /// arr会在本函数中调用GEP 0 0
        auto i=args.begin();
        for(auto j=params.begin();j!=params.end();j++,i++){
            auto& ii=*i;auto& jj=*j;
            int dif=ii->CopyType()->layer()-jj->CopyType()->layer();
            assert(dif>=0);
            if(dif>0)
            {
                std::vector<Operand>gep_args(dif+1,new ConstIRInt(0));
                ii=this->GenerateGEPInst(ii,gep_args);
            }
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
    auto obj=bbs.front()->push_alloca(ptr->CopyType());
    Singleton<Module>().Register(ptr->get_name(),obj);
}
void Function::push_param(Variable* var){
    /// @note 形参类型是var->CopyType()
    /// @note 需要alloca和store
    push_alloca(var);
    params.push_back(ParamPtr(new Value(var->CopyType())));
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
    auto obj=new Value(std::make_shared<PointerType>(ptr->CopyType()));
    SymbolTable::Register(ptr->get_name(),obj);
    globalvaribleptr.push_back(GlobalVariblePtr(ptr));
}