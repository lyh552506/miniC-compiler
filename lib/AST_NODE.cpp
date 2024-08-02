#include "../include/lib/AST_NODE.hpp"
#include "../include/lib/TypeTrans.hpp"
#include <algorithm>
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

Type* Exps::GetDeclDescipter(Type* tmp){
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
Operand InitVals::GetOperand(Type* tp,BasicBlock* cur){
    assert(tp->GetTypeEnum()==IR_ARRAY);
    auto ret=new Initializer(tp);
    size_t offs=0;
    std::map<Type*,Type*> type_map;//找上级Type
    [&type_map](ArrayType* tp){
        while(tp!=nullptr){
            type_map[tp->GetSubType()]=tp;
            tp=dynamic_cast<ArrayType*>(tp->GetSubType());
        }
    }(dynamic_cast<ArrayType*>(tp));
    auto max_type=[&](Type* tp){
        while(offs%tp->get_size()!=0)tp=dynamic_cast<ArrayType*>(tp)->GetSubType();
        return tp;
    };
    auto sub=dynamic_cast<ArrayType*>(tp)->GetSubType();
    for(auto &i:ls){
        auto type_expect=max_type(sub);
        auto tmp=i->GetOperand(type_expect,cur);
        if(tmp->GetType()!=type_expect){
            if(Singleton<InnerDataType>()==IR_Value_INT)tmp=Inter(tmp,cur);
            else if(Singleton<InnerDataType>()==IR_Value_Float)tmp=Floater(tmp,cur);
            else assert(0);
        }
        offs+=tmp->GetType()->get_size();
        ret->push_back(tmp);
        while(ret->back()->GetType()!=max_type(sub)){
            auto upper=dynamic_cast<ArrayType*>(type_map[ret->back()->GetType()]);
            int ele=upper->GetNumEle();
            auto omit=new Initializer(upper);
            for(int i=0;i<ele;i++)
            {
                omit->push_back(ret->back());
                ret->pop_back();
            }
            std::reverse(omit->begin(),omit->end());
            ret->push_back(omit);
        }
    }
    //fix: 解决一下没有初始化完的问题
    while(ret->back()->GetType()!=sub){
        auto upper=dynamic_cast<ArrayType*>(type_map[ret->back()->GetType()]);
        int ele=upper->GetNumEle();
        auto omit=new Initializer(upper);
        for(int i=0;i<ele&&!ret->empty()&&ret->back()->GetType()==upper->GetSubType();i++)
        {
            omit->push_back(ret->back());
            ret->pop_back();
        }
        std::reverse(omit->begin(),omit->end());
        ret->push_back(omit);
    }
    return ret;
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
    if(auto fuc=dynamic_cast<AddExp*>(val.get()))
        return fuc->GetOperand(cur);
    else assert(0);
}
/// @param tp Must be an Array Type 
/// @param cur if cur is not nullptr, memcpy will be generated
/// @return return Initializer*
Operand InitVal::GetOperand(Type* tp,BasicBlock* cur){
    if(auto fuc=dynamic_cast<AddExp*>(val.get()))
        return fuc->GetOperand(cur);
    else if(auto fuc=dynamic_cast<InitVals*>(val.get())){
        return fuc->GetOperand(tp,cur);
    }
    else return new Initializer(tp);
}

BaseDef::BaseDef(std::string _id,Exps* _ad=nullptr,InitVal* _iv=nullptr):ID(_id),array_descripters(_ad),civ(_iv){}

void BaseDef::codegen(){
    if(array_descripters!=nullptr)
    {
        auto tmp=array_descripters->GetDeclDescipter();
        auto var=new Variable(Variable::GlobalVariable,tmp,ID);
        if(civ!=nullptr)var->add_use(civ->GetOperand(tmp,nullptr));
    }
    else
    {
        auto decl_type=Type::NewTypeByEnum(Singleton<InnerDataType>());
        auto tmp=new Variable(Variable::GlobalVariable,decl_type,ID);
        if(Singleton<IR_CONSTDECL_FLAG>().flag==1){
            Operand var;
            if(civ==nullptr)
            {
                if(Singleton<InnerDataType>()==IR_Value_INT)
                    var=ConstIRInt::GetNewConstant();
                else if(Singleton<InnerDataType>()==IR_Value_Float)
                    var=ConstIRFloat::GetNewConstant();
                else assert(0);
            }
            else var=civ->GetFirst(nullptr);
            if(Singleton<InnerDataType>()==IR_Value_INT)
                var=Inter(var,nullptr);
            else if(Singleton<InnerDataType>()==IR_Value_Float)
                var=Floater(var,nullptr);
            else assert(0);
            Singleton<Module>().Register(ID,var);
        }
        else
        {
            if(civ!=nullptr)tmp->add_use(civ->GetFirst(nullptr));
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
        auto tmp=array_descripters->GetDeclDescipter();
        auto alloca=state.current_building->GenerateAlloca(tmp,ID);
        if(civ!=nullptr)
        {
            Operand init=civ->GetOperand(tmp,state.current_building);
            // if(init==nullptr)return state.current_building;
            std::vector<Operand> args;
            auto src=new Variable(Variable::Constant,tmp,"");
            src->add_use(init);
            args.push_back(alloca);//des
            args.push_back(src);
            args.push_back(ConstIRInt::GetNewConstant(tmp->get_size()));
            args.push_back(ConstIRBoolean::GetNewConstant(false));
            /*call void @llvm.memcpy.p0.p0.i32(ptr <1>, ptr <2>, i64 <num_bytes>, i1 false)*/
            state.current_building->GenerateCallInst("llvm.memcpy.p0.p0.i32",args,0);
            std::vector<int> temp;
            dynamic_cast<Initializer*>(init)->Var2Store(state.current_building,ID,temp);
        }
    }
    else
    {
        auto decl_type=Type::NewTypeByEnum(Singleton<InnerDataType>());
        // auto tmp=new Variable(Variable::GlobalVariable,decl_type,ID);
        if(Singleton<IR_CONSTDECL_FLAG>().flag==1){
            Operand var;
            if(civ==nullptr)
            {
                if(Singleton<InnerDataType>()==IR_Value_INT)
                    var=ConstIRInt::GetNewConstant();
                else if(Singleton<InnerDataType>()==IR_Value_Float)
                    var=ConstIRFloat::GetNewConstant();
                else assert(0);
            }
            else var=civ->GetFirst(nullptr);
            if(Singleton<InnerDataType>()==IR_Value_INT)
                var=Inter(var,nullptr);
            else if(Singleton<InnerDataType>()==IR_Value_Float)
                var=Floater(var,nullptr);
            Singleton<Module>().Register(ID,var);
        }
        else{
            auto alloca=state.current_building->GenerateAlloca(decl_type,ID);
            if(civ!=nullptr){
                state.current_building->GenerateStoreInst(civ->GetFirst(state.current_building),alloca);
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
    auto get_type=[](AST_Type _tp)->Type* {
        switch(_tp)
        {
            case AST_INT:
                return IntType::NewIntTypeGet();
            case AST_FLOAT:
                return FloatType::NewFloatTypeGet();
            default:
                std::cerr<<"Wrong Type\n";
                assert(0);
        }
    };
    if(array_subscripts!=nullptr)
    {
        auto vec=array_subscripts->GetDeclDescipter(get_type(tp));
        if(emptySquare)vec=PointerType::NewPointerTypeGet(vec);
        else
        {
            auto inner=dynamic_cast<HasSubType*>(vec);
            vec=PointerType::NewPointerTypeGet(inner->GetSubType());
        }
        tmp.push_param(ID,new Variable(Variable::Param,vec,ID));
    }
    else
    {
        if(emptySquare)tmp.push_param(ID,new Variable(Variable::Param, PointerType::NewPointerTypeGet(get_type(tp)),ID));
        else tmp.push_param(ID,new Variable(Variable::Param,get_type(tp),ID));
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
    if(items==nullptr)return state.current_building;
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
    GetInstState state={f.front(),nullptr,nullptr};
    auto end_block=function_body->GetInst(state);
    if(!end_block->EndWithBranch()){
        if(f.GetType()->GetTypeEnum()==IR_Value_VOID)end_block->GenerateRetInst();
        else{
            if(f.GetName()=="main")
                end_block->GenerateRetInst(ConstIRInt::GetNewConstant(0));
            else end_block->GenerateRetInst(UndefValue::get(f.GetType()));
        }
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
        dynamic_cast<GetElementPtrInst*>(handle)->add_use(ConstIRInt::GetNewConstant());
    }
    else if(dynamic_cast<PointerType*>(ptr->GetType())->GetSubType()->GetTypeEnum()==IR_PTR){
        if(array_descripters==nullptr)return ptr;
        handle=block->GenerateLoadInst(ptr);
    }
    else{
        assert(tmp.empty());
        return ptr;
    }

    for(auto &i:tmp){
        if(auto gep=dynamic_cast<GetElementPtrInst*>(handle))
            gep->add_use(i);
        else{
            handle=block->GenerateGEPInst(handle);
            dynamic_cast<GetElementPtrInst*>(handle)->add_use(i);
        }
        if(i!=tmp.back()&&dynamic_cast<PointerType*>(handle->GetType())->GetSubType()->GetTypeEnum()==IR_PTR)
            block->GenerateLoadInst(handle);
    }
    return handle;
}

Operand LVal::GetOperand(BasicBlock* block){
    auto ptr=GetPointer(block);
    if(ptr->isConst())return ptr;
    if(auto gep=dynamic_cast<GetElementPtrInst*>(ptr)){
        if(dynamic_cast<PointerType*>(gep->GetType())->GetSubType()->GetTypeEnum()==IR_ARRAY){
            gep->add_use(ConstIRInt::GetNewConstant());
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
    
    //auto do_while_cond=state.current_building->GenerateNewBlock("do_while_cond."+std::to_string(begin)+"."+std::to_string(end));
    /// @note 考虑while true和while false的情况
    if(!inner_loop->GetUserlist().is_empty()){
        //condition->GetOperand(do_while_cond,inner_loop,nxt_building);
        GetInstState loop_state={inner_loop,nxt_building,condition_part};
        inner_loop=stmt->GetInst(loop_state);
    }
    else{
        delete inner_loop;
        //delete do_while_cond;
        inner_loop=nullptr;
    };
    if(inner_loop!=nullptr&&!inner_loop->EndWithBranch())inner_loop->GenerateUnCondInst(condition_part);
    if(nxt_building->GetUserlist().is_empty()){
        delete nxt_building;
        return state.current_building;
    }
    else return nxt_building;
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
    BasicBlock* nxt_building=nullptr;
    auto istrue=state.current_building->GenerateNewBlock();
    BasicBlock* isfalse=nullptr;
    GetInstState t_state=state;t_state.current_building=istrue;
    if(f!=nullptr)
        isfalse=state.current_building->GenerateNewBlock();

    if(isfalse!=nullptr)condition->GetOperand(state.current_building,istrue,isfalse);
    else{
        nxt_building=state.current_building->GenerateNewBlock();
        condition->GetOperand(state.current_building,istrue,nxt_building);
    }

    auto reset_unuse=[](BasicBlock*& tmp){
        if(tmp==nullptr)return;
        if(tmp->GetUserlist().is_empty()){
            delete tmp;
            tmp=nullptr;
        }
    };
    /// @note 考虑条件语句都是常量的情况
    reset_unuse(istrue);
    reset_unuse(isfalse);
    reset_unuse(nxt_building);

    auto make_uncond=[&](BasicBlock* tmp){
        if(!tmp->EndWithBranch()){
            if(nxt_building==nullptr)nxt_building=state.current_building->GenerateNewBlock();
            tmp->GenerateUnCondInst(nxt_building);
        }
    };

    /// @note if(false)的情况
    if(istrue!=nullptr){
        istrue=t->GetInst(t_state);
        make_uncond(istrue);
    }
    if(isfalse!=nullptr){
        GetInstState f_state=state;f_state.current_building=isfalse;
        isfalse=f->GetInst(f_state);
        make_uncond(isfalse);
    }
    
    return (nxt_building==nullptr?state.current_building:nxt_building);
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

void Module::PushVariable(Variable* ptr){
    assert(ptr->usage!=Variable::Param&&"Wrong API Usage");
    globalvaribleptr.emplace_back(ptr);
}
