#include "CFG.hpp"
#include <string>
#include <memory>
#include <iostream>
#include "MagicEnum.hpp"
#include <map>

Initializer::Initializer(Type* _tp):Value(_tp){}

void Initializer::Var2Store(BasicBlock* bb,const std::string& name,std::vector<int>& gep_data){
    for(int i=0;i<this->size();i++){
        auto& handle=(*this)[i];
        gep_data.push_back(i);
        if(auto inits=dynamic_cast<Initializer*>(handle)){
            inits->Var2Store(bb,name,gep_data);
        }
        else{
            if(!handle->isConst()){
                auto gep=dynamic_cast<GetElementPtrInst*>(bb->GenerateGEPInst(Singleton<Module>().GetValueByName(name)));
                gep->add_use(ConstIRInt::GetNewConstant());
                for(auto&j:gep_data)
                    gep->add_use(ConstIRInt::GetNewConstant(j));
                bb->GenerateStoreInst(handle,gep);
                if(handle->GetType()->GetTypeEnum()==IR_Value_INT)
                    handle=ConstIRInt::GetNewConstant();
                else
                    handle=ConstIRFloat::GetNewConstant();
            }
        }
        gep_data.pop_back();
    }
}

void Initializer::print(){
    // tp->print();
    if(size()==0){
        std::cout<<"zeroinitializer";
        return;
    }
    std::cout<<" [";
    int limi=dynamic_cast<ArrayType*>(tp)->GetNumEle();
    for(int i=0;i<limi;i++){
        dynamic_cast<ArrayType*>(tp)->GetSubType()->print();
        if(i<this->size()){
            std::cout<<" ";
            if(auto inits=dynamic_cast<Initializer*>((*this)[i]))
                inits->print();
            else
                (*this)[i]->print();
        }
        else
            std::cout<<" zeroinitializer";
        if(i!=limi-1)std::cout<<", ";
    }
    std::cout<<"]";
}

MemcpyHandle::MemcpyHandle(Type* _tp,Operand _src):User(_tp){
    add_use(_src);
    name="__constant."+name;
}

void MemcpyHandle::print(){
    Value::print();
    std::cout<<" = constant ";
    dynamic_cast<PointerType*>(tp)->GetSubType()->print();
    std::cout<<" ";
    dynamic_cast<Initializer*>(uselist[0]->GetValue())->print();
    std::cout<<"\n";
}

AllocaInst::AllocaInst(std::string str,Type* _tp):User(PointerType::NewPointerTypeGet(_tp)){
    // name=str;
    // name+="_";
    // name+=std::to_string(Singleton<Module>().IR_number(str));
}

void AllocaInst::print(){
    Value::print();
    std::cout<<" = alloca ";
    dynamic_cast<PointerType*>(tp)->GetSubType()->print();
    std::cout<<"\n";
}

bool AllocaInst::IsUsed(){
    auto& list=GetUserlist();
    if(list.is_empty())
      return false;
    return true;
}

std::map<Type*,UndefValue*> Undefs;

StoreInst::StoreInst(Operand __src,Operand __des){
    add_use(__src);
    add_use(__des);
    name="StoreInst";
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

LoadInst::LoadInst(Value* __src):User(dynamic_cast<PointerType*>(__src->GetType())->GetSubType()){
    assert(GetTypeEnum()==IR_Value_INT||GetTypeEnum()==IR_Value_Float||GetTypeEnum()==IR_PTR);
    add_use(__src);
}

// Value* LoadInst::GetLoadTarget(){
//     auto& list=Getuselist();
//     return list[0]->GetValue();
// }

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
    std::cout<<'\n';
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
    std::cout<<'\n';
}

Operand CondInst::GetDef(){return nullptr;}

CallInst::CallInst(Value* _func,std::vector<Operand>& _args,std::string appendix):User(_func->GetType()){
    name+=appendix;
    add_use(_func);
    for(auto&i:_args)
        add_use(i);
}

void CallInst::print(){
    if(tp!=VoidType::NewVoidTypeGet()){
        Value::print();
        std::cout<<" = ";
    }
    std::cout<<"call ";
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

bool check_binary_boolean(BinaryInst::Operation op){
    switch (op)
    {
    case BinaryInst::Op_E:
    case BinaryInst::Op_NE:
    case BinaryInst::Op_G:
    case BinaryInst::Op_GE:
    case BinaryInst::Op_L:
    case BinaryInst::Op_LE:
        return true;
    default:
        return false;
    }
}

BinaryInst::BinaryInst(Operand _A,Operation __op,Operand _B):User(check_binary_boolean(__op)?BoolType::NewBoolTypeGet():_B->GetType()){
    op=__op;
    add_use(_A);
    add_use(_B);
}

std::string BinaryInst:: GetOperation() {
    std::string opcode = magic_enum::enum_name(op).data();
    return opcode;
}

BinaryInst::Operation BinaryInst::getopration(){
    return op;
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
        if(uselist[0]->GetValue()->GetTypeEnum()==IR_Value_Float)std::cout<<"ule ";
        else std::cout<<"sle ";
        break;
    default:
        break;
    }
    uselist[1]->GetValue()->GetType()->print();
    std::cout<<" ";
    uselist[0]->GetValue()->print();
    std::cout<<", ";
    uselist[1]->GetValue()->print();
    std::cout<<'\n';
}

void Variable::attach(Operand _init){attached_initializer=_init;}

Variable::Variable(std::string _id):name(_id){
    tp=Type::NewTypeByEnum(Singleton<InnerDataType>());
}
Variable::Variable(Type* _tp,std::string _id):name(_id),tp(_tp){}
Variable::Variable(InnerDataType _tp,std::string _id):name(_id){
    tp=Type::NewTypeByEnum(_tp);
}
std::string Variable::get_name(){
    return name;
}

Type* Variable::GetType(){return tp;}

void Variable::print(){
    std::cout<<"@.g."<<get_name()<<" = global ";
    GetType()->print();
    if(attached_initializer){
        std::cout<<" ";
        if(auto array_init=dynamic_cast<Initializer*>(attached_initializer))array_init->print();
        else attached_initializer->print();
    }
    else std::cout<<" zeroinitializer";
    std::cout<<'\n';
} 

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
    for(int i=0;i<uselist.size();i++){
        std::cout<<", ";
        uselist[i]->GetValue()->GetType()->print();
        std::cout<<" ";
        uselist[i]->GetValue()->print();
    }
    std::cout<<'\n';
}

ZextInst::ZextInst(Operand ptr):User(IntType::NewIntTypeGet()){
    add_use(ptr);
}

void ZextInst::print(){
    Value::print();
    std::cout<<" = zext i1 ";
    uselist[0]->GetValue()->print();
    std::cout<<" to i32";
}

BasicBlock::BasicBlock(Function& __master):Value(VoidType::NewVoidTypeGet()),master(__master){};
Operand BasicBlock::GenerateLoadInst(Operand data){
    auto tmp=new LoadInst(data);
    push_back(tmp);
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
    else{
        if(_A->GetTypeEnum()==IR_Value_INT){
            bool isbooleanA=(_A->GetType()==IntType::NewIntTypeGet());
            bool isbooleanB=(_B->GetType()==IntType::NewIntTypeGet());
            if(isbooleanA^isbooleanB){
                if(isbooleanA==false)
                    _A=GenerateZextInst(_A);
                else
                    _B=GenerateZextInst(_B);
            }
        }
        tmp=new BinaryInst(_A,op,_B);
    }
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
            else if(auto B=dynamic_cast<ConstIRBoolean*>(_B))
                fuc=calc(A->GetVal(),op,B->GetVal());
            else assert(0);
        }
        else if(auto A=dynamic_cast<ConstIRFloat*>(_A))
        {
            if(auto B=dynamic_cast<ConstIRInt*>(_B))
                fuc=calc(A->GetVal(),op,B->GetVal());
            else if(auto B=dynamic_cast<ConstIRFloat*>(_B))
                fuc=calc(A->GetVal(),op,B->GetVal());
            else if(auto B=dynamic_cast<ConstIRBoolean*>(_B))
                fuc=calc(A->GetVal(),op,B->GetVal());
            else assert(0);
        }
        else if(auto A=dynamic_cast<ConstIRBoolean*>(_A))
        {
            if(auto B=dynamic_cast<ConstIRInt*>(_B))
                fuc=calc(A->GetVal(),op,B->GetVal());
            else if(auto B=dynamic_cast<ConstIRFloat*>(_B))
                fuc=calc(A->GetVal(),op,B->GetVal());
            else if(auto B=dynamic_cast<ConstIRBoolean*>(_B))
                fuc=calc(A->GetVal(),op,B->GetVal());
            else assert(0);
        }
        else assert(0);
        if(check_binary_boolean(op))
            return ConstIRBoolean::GetNewConstant(std::get<int>(fuc));
        else if(std::holds_alternative<int>(fuc))
            return ConstIRInt::GetNewConstant(std::get<int>(fuc));
        else
            return ConstIRFloat::GetNewConstant(std::get<float>(fuc));
    }
    else
    {
        assert(bb!=nullptr);
        return bb->GenerateBinaryInst(_A,op,_B);
    }
}

void BasicBlock::GenerateStoreInst(Operand src,Operand des){
    assert(des->GetType()->GetTypeEnum()==IR_PTR);
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

BasicBlock* BasicBlock::GenerateNewBlock(std::string name){
    BasicBlock* tmp=new BasicBlock(master);
    tmp->name+=name;
    master.add_block(tmp);
    return tmp;
}

void BasicBlock::print(){
    std::cout<<GetName()<<":\n";
    for(auto i:(*this)){
        std::cout<<"  ";
        i->print();
    }
}

void Function::print(){
    std::cout<<"define ";
    tp->print();
    std::cout<<" @"<<name<<"(";
    for(auto &i:params){
        i->GetType()->print();
        std::cout<<" %"<<i->GetName();
        // Singleton<IR_MARK>().GetNum(i.get());
        if(i.get()!=params.back().get())std::cout<<", ";
    }
    std::cout<<"){\n";
    for(auto i:(*this))
        i->print();
    std::cout<<"}\n";
}

void Function::InsertAlloca(AllocaInst* ptr){
    front()->push_back(ptr);
}

BuildInFunction::BuildInFunction(Type* tp,std::string _id):Value(tp){
    name=_id;
    if(name=="starttime"||name=="stoptime")name="_sysy_"+name;
}

BuildInFunction* BuildInFunction::GetBuildInFunction(std::string _id){
    static std::map<std::string,BuildInFunction*> mp;
    auto get_type=[&_id]()->Type* {
        if(_id=="getint")return IntType::NewIntTypeGet();
        if(_id=="getfloat")return FloatType::NewFloatTypeGet();
        if(_id=="getch")return IntType::NewIntTypeGet();
        if(_id=="getarray")return IntType::NewIntTypeGet();
        if(_id=="getfarray")return IntType::NewIntTypeGet();        
        if(_id=="putint")return VoidType::NewVoidTypeGet();
        if(_id=="putch")return VoidType::NewVoidTypeGet();
        if(_id=="putarray")return VoidType::NewVoidTypeGet();
        if(_id=="putfloat")return VoidType::NewVoidTypeGet();
        if(_id=="putfarray")return VoidType::NewVoidTypeGet();
        if(_id=="starttime")return VoidType::NewVoidTypeGet();
        if(_id=="stoptime")return VoidType::NewVoidTypeGet();
        if(_id=="putf")return VoidType::NewVoidTypeGet();
        if(_id=="llvm.memcpy.p0.p0.i32")return VoidType::NewVoidTypeGet();
        assert(0);
    };
    if(mp.find(_id)==mp.end()){
        mp[_id]=new BuildInFunction(get_type(),_id);
    }
    return mp[_id];
}

Function::Function(InnerDataType _tp,std::string _id):Value(Type::NewTypeByEnum(_tp)){
    name=_id;
    //至少有一个bbs
    push_back(new BasicBlock(*this));
}

bool BasicBlock::EndWithBranch(){
    if(auto data=dynamic_cast<UnCondInst*>(back()))return 1;
    else if(auto data=dynamic_cast<CondInst*>(back()))return 1;
    else if(auto data=dynamic_cast<RetInst*>(back()))return 1;
    else return 0;
}
void BasicBlock::GenerateCondInst(Operand condi,BasicBlock* is_true,BasicBlock* is_false){
    auto inst=new CondInst(condi,is_true,is_false);
    push_back(inst);
}
void BasicBlock::GenerateUnCondInst(BasicBlock* des){
    auto inst=new UnCondInst(des);
    push_back(inst);
}
void BasicBlock::GenerateRetInst(Operand ret_val){
    if(master.GetTypeEnum()!=ret_val->GetTypeEnum()){
        if(ret_val->GetTypeEnum()==IR_Value_INT)
            ret_val=GenerateSITFP(ret_val);
        else
            ret_val=GenerateFPTSI(ret_val);
    }
    auto inst=new RetInst(ret_val);
    push_back(inst);
}
void BasicBlock::GenerateRetInst(){
    auto inst=new RetInst();
    push_back(inst);
}

Operand BasicBlock::GenerateCallInst(std::string id,std::vector<Operand> args,int run_time){
    auto check_builtin=[](std::string _id){
        if(_id=="getint")return true;
        if(_id=="getfloat")return true;
        if(_id=="getch")return true;
        if(_id=="getarray")return true;
        if(_id=="getfarray")return true;        
        if(_id=="putint")return true;
        if(_id=="putch")return true;
        if(_id=="putarray")return true;
        if(_id=="putfloat")return true;
        if(_id=="putfarray")return true;
        if(_id=="starttime")return true;
        if(_id=="stoptime")return true;
        if(_id=="putf")return true;
        if(_id=="llvm.memcpy.p0.p0.i32")return true;
        return false;
    };
    
    if(check_builtin(id)){
        if(id=="starttime"||id=="stoptime"){
            assert(args.size()==0);
            args.push_back(ConstIRInt::GetNewConstant(run_time));
        }
        /*
        int as first arg
        putint
        putch
        putarray
        putfarray

        float as first arg
        putfloat
        */
        if(id=="putint"||id=="putch"||id=="putarray"||id=="putfarray"){
            if(args[0]->GetTypeEnum()==IR_Value_Float)
                args[0]=GenerateFPTSI(args[0]);
        }
        if(id=="putfloat"){
            if(args[0]->GetTypeEnum()==IR_Value_INT)
                args[0]=GenerateSITFP(args[0]);
        }
        auto tmp=new CallInst(BuildInFunction::GetBuildInFunction(id),args,"at"+std::to_string(run_time));
        push_back(tmp);
        return tmp->GetDef();
    }
    if(auto func=dynamic_cast<Function*>(Singleton<Module>().GetValueByName(id))){
        auto& params=func->GetParams();
        assert(args.size()==params.size());
        auto i=args.begin();
        for(auto j=params.begin();j!=params.end();j++,i++){
            auto& ii=*i;auto jj=j->get();
            if(jj->GetType()!=ii->GetType())
            {
                auto a=ii->GetType()->GetTypeEnum(),b=jj->GetType()->GetTypeEnum();
                // if(a!=IR_Value_INT&&a!=IR_Value_Float)
                // {
                //     std::cerr<<"Error\n";
                //     ii->GetType()->print();//float
                //     jj->GetType()->print();//i32
                //     std::cout.flush();
                //     assert(0);
                // }
                assert(a==IR_Value_INT||a==IR_Value_Float);
                assert(b==IR_Value_INT||b==IR_Value_Float);
                if(b==IR_Value_Float)ii=GenerateSITFP(ii);
                else ii=GenerateFPTSI(ii);
            }
        }
        auto inst=new CallInst(func,args,"at"+std::to_string(run_time));
        push_back(inst);
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
    push_back(tmp);
    return tmp->GetDef();
}
Operand BasicBlock::GenerateZextInst(Operand ptr){
    auto tmp=new ZextInst(ptr);
    push_back(tmp);
    return tmp->GetDef();
}
Operand BasicBlock::push_alloca(std::string name,Type* _tp){
    auto tmp=new AllocaInst(name,_tp);
    push_front(tmp);
    return tmp->GetDef();
}

PhiInst* PhiInst::NewPhiNode(User *BeforeInst, BasicBlock *currentBB){
    PhiInst *tmp = new PhiInst{BeforeInst};
    currentBB->push_front(tmp);
    return tmp;
}

PhiInst* PhiInst::NewPhiNode(User *BeforeInst, BasicBlock *currentBB,Type* ty){
    PhiInst *tmp = new PhiInst(BeforeInst,ty);
    currentBB->push_front(tmp);
    return tmp;
}

void PhiInst::updateIncoming(Value* Income,BasicBlock* BB){
    PhiRecord[oprandNum++]=std::make_pair(Income,BB);
}

std::vector<Value*>& PhiInst::GetAllPhiVal(){
    for(const auto &[_1,value]:PhiRecord){
        Incomings.push_back(value.first);
    }
    return Incomings;
}

void Function::push_alloca(Variable* ptr){
    auto obj=front()->push_alloca(ptr->get_name(),ptr->GetType());
    Singleton<Module>().Register(ptr->get_name(),obj);
}

void Function::push_param(Variable* var){
    push_alloca(var);
    /// @brief 实参
    params.push_back(ParamPtr(new Value(var->GetType())));
    front()->GenerateStoreInst(params.back().get(),Singleton<Module>().GetValueByName(var->get_name()));
}

void Function::add_block(BasicBlock* __block){
    push_back(__block);
}

std::vector<std::unique_ptr<Value>>& Function::GetParams(){
    return params;
}

// void Module::visit(std::function<void(Function*)> call_back){
//     for(auto&i:ls)
//         call_back(i.get());
// }
void Module::Test(){
    for(auto &i:globalvaribleptr)i->print();
    for(auto &i:constants_handle)i->print();
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
    obj->name=".g."+ptr->get_name();
    SymbolTable::Register(ptr->get_name(),obj);
    globalvaribleptr.push_back(GlobalVariblePtr(ptr));
}

std::vector<std::unique_ptr<Function>> &Module::GetFuncTion() {
    return ls;
}

Operand Module::GenerateMemcpyHandle(Type* _tp,Operand oper){
    constants_handle.push_back(new MemcpyHandle(_tp,oper));
    return constants_handle.back();
}


UndefValue* UndefValue::get(Type *Ty){
    UndefValue *& UV=Undefs[Ty];
    if(!UV)
      UV=new UndefValue(Ty);
    return UV;    
}

void UndefValue::print(){
    dynamic_cast<Value*>(this)->print();
    return;
}

void PhiInst::print() {
  dynamic_cast<Value*>(this)->print();
  std::cout << " = Phi ";
  this->GetType()->print();
  std::cout << " ";
  for (int i = 0; i < oprandNum; i++) {
    std::cout<<"[";
    PhiRecord[i].first->print();
    std::cout<<", ";
    dynamic_cast<Value*>(PhiRecord[i].second)->print();
    std::cout<<"]";
    if(i!=oprandNum-1)
      std::cout<<", ";
  }
  std::cout << "\n";
  return;
}