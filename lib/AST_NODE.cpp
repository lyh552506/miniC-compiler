#include "AST_NODE.hpp"

LocType::LocType():begin(0),end(0){
}

LocType::LocType(int _line):begin(_line),end(_line){}

void LocType::SET(const LocType& _){
    *this=_;
}

void TypeForward(AST_Type type)
{
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
}

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
Type* Exps::GetDeclDescipter(){
    auto tmp=Type::NewTypeByEnum(Singleton<InnerDataType>());
    for(auto i=ls.rbegin();i!=ls.rend();i++)
    {
        auto con=(*i)->GetOperand(nullptr);
        if(auto fuc=dynamic_cast<ConstIRInt*>(con)){
            tmp=ArrayType::NewArrayTypeGet(fuc->GetVal(),tmp);
        }
        else if(auto fuc=dynamic_cast<ConstIRFloat*>(con)){
            tmp=ArrayType::NewArrayTypeGet(fuc->GetVal(),tmp);
        }
        else assert(0);
    }
    return tmp;
}

std::vector<Operand> Exps::GetVisitDescripter(BasicBlock* cur){
    std::vector<Operand> tmp;
    for(auto&i:ls)tmp.push_back(i->GetOperand(cur));
    return tmp;
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
Operand InitVal::GetFirst(BasicBlock* cur){
    if(auto fuc=dynamic_cast<AddExp*>(val.get())){
        return fuc->GetOperand(cur);
    }
    else assert(0);
}


BaseDef::BaseDef(std::string _id,Exps* _ad=nullptr,InitVal* _iv=nullptr):ID(_id),array_descripters(_ad),civ(_iv){}

void BaseDef::codegen(){
    if(array_descripters!=nullptr)
    {
        if(civ!=nullptr)std::cerr<<"InitVal not implemented!n";
        assert(civ==nullptr);
        auto tmp=array_descripters->GetDeclDescipter();
        auto var=new Variable(tmp,ID);
        Singleton<Module>().GenerateGlobalVariable(var);
    }
    else
    {
        auto tmp=new Variable(ID);
        if(Singleton<IR_CONSTDECL_FLAG>().flag==1){
            Operand var;
            if(civ==nullptr)
            {
                if(Singleton<InnerDataType>()==IR_Value_INT)
                    var=new ConstIRInt(0);
                else if(Singleton<InnerDataType>()==IR_Value_Float)
                    var=new ConstIRFloat(0.0);
                else assert(0);
            }
            else var=civ->GetFirst(nullptr);
            Singleton<Module>().Register(ID,var);
        }
        else
        {
            if(civ!=nullptr)tmp->attach(civ->GetFirst(nullptr));
            Singleton<Module>().GenerateGlobalVariable(tmp);
        }
    }
}
void BaseDef::print(int x){
    AST_NODE::print(x);
    std::cout<<":"<<ID<<'\n';
    if(array_descripters!=nullptr)array_descripters->print(x+1);
    if(civ!=nullptr)civ->print(x+1);
}

VarDef::VarDef(std::string _id,Exps* _ad,InitVal* _iv):BaseDef(_id,_ad,_iv){}

BasicBlock* BaseDef::GetInst(GetInstState state){
    if(array_descripters!=nullptr)
    {
        if(civ!=nullptr)std::cerr<<"InitVal not implemented!n";
        assert(civ==nullptr);
        auto tmp=array_descripters->GetDeclDescipter();
        auto var=new Variable(tmp,ID);
        state.current_building->GenerateAlloca(var);
    }
    else
    {
        auto tmp=new Variable(ID);
        if(Singleton<IR_CONSTDECL_FLAG>().flag==1){
            Operand var;
            if(civ==nullptr)
            {
                if(Singleton<InnerDataType>()==IR_Value_INT)
                    var=new ConstIRInt(0);
                else if(Singleton<InnerDataType>()==IR_Value_Float)
                    var=new ConstIRFloat(0.0);
                else assert(0);
            }
            else var=civ->GetFirst(nullptr);
            Singleton<Module>().Register(ID,var);
        }
        else{
            state.current_building->GenerateAlloca(tmp);
            if(civ!=nullptr){
                state.current_building->GenerateStoreInst(civ->GetFirst(state.current_building),Singleton<Module>().GetValueByName(ID));
            }
        }
    }
    return state.current_building;
}

ConstDef::ConstDef(std::string _id,Exps* _ad=nullptr,InitVal* _iv=nullptr):BaseDef(_id,_ad,_iv){}

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
    for(auto &i:ls)
        i->print(x+1);
    std::cout<<'\n';
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
BasicBlock* ConstDefs::GetInst(GetInstState state){
    for(auto&i:ls)
        state.current_building=i->GetInst(state);
    return state.current_building;
}

ConstDecl::ConstDecl(AST_Type tp,ConstDefs* content):type(tp),cdfs(content){}
BasicBlock* ConstDecl::GetInst(GetInstState state){
    TypeForward(type);
    Singleton<IR_CONSTDECL_FLAG>().flag=1;
    return cdfs->GetInst(state);
}
void ConstDecl::codegen(){
    /// @warning copy from VarDecl
    TypeForward(type);
    Singleton<IR_CONSTDECL_FLAG>().flag=1;
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
BasicBlock* VarDefs::GetInst(GetInstState state){
    for(auto&i:ls)
        state.current_building=i->GetInst(state);
    return state.current_building;
}

VarDecl::VarDecl(AST_Type tp,VarDefs* ptr):type(tp),vdfs(ptr){}
BasicBlock* VarDecl::GetInst(GetInstState state){
    Singleton<IR_CONSTDECL_FLAG>().flag=0;
    TypeForward(type);
    return vdfs->GetInst(state);
}
void VarDecl::codegen(){
    Singleton<IR_CONSTDECL_FLAG>().flag=0;
    TypeForward(type);
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
    if(array_subscripts!=nullptr)
    {
        auto vec=array_subscripts->GetDeclDescipter();
        if(emptySquare)vec=PointerType::NewPointerTypeGet(vec);
        else
        {
            auto inner=dynamic_cast<HasSubType*>(vec);
            vec=PointerType::NewPointerTypeGet(inner->GetSubType());
        }
        tmp.push_param(new Variable(vec,ID));
    }
    else
    {
        if(emptySquare)tmp.push_param(new Variable(PointerType::NewPointerTypeGet(Type::NewTypeByEnum(get_type(tp))),ID));
        else tmp.push_param(new Variable(get_type(tp),ID));
    }
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
BasicBlock* BlockItems::GetInst(GetInstState state){
    for(auto &i:ls)
    {
        state.current_building=i->GetInst(state);
        ///@warning 已经是一个basicblock了，后面的肯定访问不到
        if(state.current_building->EndWithBranch())
            return state.current_building;
    }
    return state.current_building;
}
void BlockItems::print(int x){
    AST_NODE::print(x);
    std::cout<<'\n';
    for(auto &i:ls)i->print(x+1);
}

Block::Block(BlockItems* ptr):items(ptr){}
BasicBlock* Block::GetInst(GetInstState state){
    Singleton<Module>().layer_increase();
    auto tmp=items->GetInst(state);
    Singleton<Module>().layer_decrease();
    return tmp;
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
    GetInstState state={f.front_block(),nullptr,nullptr};
    auto end_block=function_body->GetInst(state);
    if(!end_block->EndWithBranch()){
        assert(f.GetType()->GetTypeEnum()==IR_Value_VOID);
        end_block->GenerateRetInst();
    }
    Singleton<Module>().layer_decrease();
}
void FuncDef::print(int x){
    AST_NODE::print(x);
    std::cout<<":"<<ID<<":"<<magic_enum::enum_name(tp)<<'\n';
    if(params!=nullptr)params->print(x+1);
    function_body->print(x+1);
}

LVal::LVal(std::string _id,Exps* ptr):ID(_id),array_descripters(ptr){}

Operand LVal::GetPointer(BasicBlock* block){
    auto ptr=Singleton<Module>().GetValueByName(ID);
    if(ptr->isConst())return ptr;
    std::vector<Operand> tmp;
    if(array_descripters!=nullptr)tmp=array_descripters->GetVisitDescripter(block);

    Operand handle;
    if(dynamic_cast<PointerType*>(ptr->GetType())->GetSubType()->GetTypeEnum()==IR_ARRAY){
        handle=block->GenerateGEPInst(ptr);
        dynamic_cast<GetElementPtrInst*>(handle)->add_use(new ConstIRInt(0));
    }
    else if(dynamic_cast<PointerType*>(ptr->GetType())->GetSubType()->GetTypeEnum()==IR_PTR)
        handle=block->GenerateLoadInst(ptr);
    else{
        assert(tmp.empty());
        return ptr;
    }

    for(auto &i:tmp){
        auto tp=dynamic_cast<PointerType*>(handle->GetType())->GetSubType();
        if(tp->GetTypeEnum()==IR_ARRAY)
            dynamic_cast<GetElementPtrInst*>(handle)->add_use(i);
        else
        {
            handle=block->GenerateLoadInst(handle);
            handle=block->GenerateGEPInst(handle);
            dynamic_cast<GetElementPtrInst*>(handle)->add_use(i);
        }
    }
    return handle;
}

Operand LVal::GetOperand(BasicBlock* block){
    auto ptr=GetPointer(block);
    if(auto gep=dynamic_cast<GetElementPtrInst*>(ptr)){
        if(dynamic_cast<PointerType*>(gep->GetType())->GetSubType()->GetTypeEnum()==IR_ARRAY){
            gep->add_use(new ConstIRInt(0));
            return gep;
        }
    }
    return block->GenerateLoadInst(ptr);
}

std::string LVal::GetName(){return ID;}

void LVal::print(int x){
    AST_NODE::print(x);
    if(array_descripters!=nullptr)std::cout<<":with array descripters";
    std::cout<<":"<<ID<<'\n';
    if(array_descripters!=nullptr)array_descripters->print(x+1);
}
AssignStmt::AssignStmt(LVal* p1,AddExp* p2):lv(p1),exp(p2){}
BasicBlock* AssignStmt::GetInst(GetInstState state){
    Operand tmp=exp->GetOperand(state.current_building);
    auto valueptr=lv->GetPointer(state.current_building);
    state.current_building->GenerateStoreInst(tmp,valueptr);
    return state.current_building;
}
void AssignStmt::print(int x){
    AST_NODE::print(x);
    std::cout<<'\n';
    assert(lv!=nullptr);
    lv->print(x+1);
    exp->print(x+1);   
}

ExpStmt::ExpStmt(AddExp* ptr):exp(ptr){}
BasicBlock* ExpStmt::GetInst(GetInstState state){
    if(exp!=nullptr)Operand tmp=exp->GetOperand(state.current_building);
    return state.current_building;
}
void ExpStmt::print(int x){
    if(exp==nullptr)AST_NODE::print(x);
    else exp->print(x);
}

WhileStmt::WhileStmt(LOrExp* p1,Stmt* p2):condition(p1),stmt(p2){}
BasicBlock* WhileStmt::GetInst(GetInstState state){
    auto condition_part=state.current_building->GenerateNewBlock("wc"+std::to_string(begin));
    auto inner_loop=state.current_building->GenerateNewBlock("wloop."+std::to_string(begin)+"."+std::to_string(end));
    auto nxt_building=state.current_building->GenerateNewBlock("wn"+std::to_string(end));

    state.current_building->GenerateUnCondInst(condition_part);

    condition->GetOperand(condition_part,inner_loop,nxt_building);
    GetInstState loop_state={inner_loop,nxt_building,condition_part};
    inner_loop=stmt->GetInst(loop_state);
    if(!inner_loop->EndWithBranch())inner_loop->GenerateUnCondInst(condition_part);
    return nxt_building;
}
void WhileStmt::print(int x){
    AST_NODE::print(x);
    std::cout<<'\n';
    assert(condition!=nullptr&&stmt!=nullptr);
    condition->print(x+1);
    stmt->print(x+1);
}

IfStmt::IfStmt(LOrExp* p0,Stmt* p1,Stmt* p2):condition(p0),t(p1),f(p2){}
BasicBlock* IfStmt::GetInst(GetInstState state){
    BasicBlock* nxt_building=state.current_building->GenerateNewBlock();
    auto istrue=state.current_building->GenerateNewBlock();
    BasicBlock* isfalse=nullptr;
    GetInstState t_state=state;t_state.current_building=istrue;
    if(f!=nullptr)
        isfalse=state.current_building->GenerateNewBlock();

    if(isfalse!=nullptr)condition->GetOperand(state.current_building,istrue,isfalse);
    else condition->GetOperand(state.current_building,istrue,nxt_building);

    auto make_uncond=[&](BasicBlock* tmp){
        if(!tmp->EndWithBranch()){
            if(nxt_building==nullptr)nxt_building=state.current_building->GenerateNewBlock();
            tmp->GenerateUnCondInst(nxt_building);
        }
    };

    istrue=t->GetInst(t_state);
    make_uncond(istrue);
    if(isfalse!=nullptr){
        GetInstState f_state=state;f_state.current_building=isfalse;
        isfalse=f->GetInst(f_state);
        make_uncond(isfalse);
    }
    
    return nxt_building;
}

void IfStmt::print(int x){
    AST_NODE::print(x);
    std::cout<<'\n';
    assert(t!=nullptr);
    t->print(x+1);
    if(f!=nullptr)f->print(x+1);
}
BasicBlock* BreakStmt::GetInst(GetInstState state){
    state.current_building->GenerateUnCondInst(state.break_block);
    return state.current_building;
}
void BreakStmt::print(int x){
    AST_NODE::print(x);std::cout<<'\n';
}

BasicBlock* ContinueStmt::GetInst(GetInstState state){
    state.current_building->GenerateUnCondInst(state.continue_block);
    return state.current_building;
}
void ContinueStmt::print(int x){
    AST_NODE::print(x);std::cout<<'\n';
}

ReturnStmt::ReturnStmt(AddExp* ptr):return_val(ptr){}
BasicBlock* ReturnStmt::GetInst(GetInstState state){
    if(return_val!=nullptr){
        auto ret_val=return_val->GetOperand(state.current_building);
        state.current_building->GenerateRetInst(ret_val);
    }
    else state.current_building->GenerateRetInst();
    return state.current_building;
}
void ReturnStmt::print(int x){
    AST_NODE::print(x);std::cout<<'\n';
    if(return_val!=nullptr)return_val->print(x+1);
}

FunctionCall::FunctionCall(std::string _id,CallParams* ptr):id(_id),cp(ptr){}
Operand FunctionCall::GetOperand(BasicBlock* block){
    std::vector<Operand> args;
    if(cp!=nullptr)args=cp->GetParams(block);
    return block->GenerateCallInst(id,args,LocType::begin);
}
void FunctionCall::print(int x){
    AST_NODE::print(x);
    std::cout<<id;
    if(cp!=nullptr)cp->print(x+1);
}
