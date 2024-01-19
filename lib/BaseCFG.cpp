#include "BaseCFG.hpp"
#include "CFG.hpp"
Use::Use(User* __fat,Value* __usee):fat(__fat),usee(__usee){
    usee->add_user(this);
}
void Use::RemoveFromUserList(User* is_valid){
    assert(is_valid==fat);
    (*prev)=nxt;
    nxt->prev=prev;
}
void UserList::push_front(Use* _data){
    _data->nxt=head;
    if(head!=nullptr)head->prev=&(_data->nxt);
    _data->prev=&head;
    head=_data;
}
Value* Use::GetValue(){return usee;}

User* Use::GetUser(){return fat;}

User*& Use::SetUser(){return fat;}

Value*& Use::SetValue(){return usee;}

Type* Value::GetType(){
    return tp;
}

InnerDataType Value::GetTypeEnum(){return tp->GetTypeEnum();}



Value::Value(Type* _tp):tp(_tp){
    name=".";
    name+=std::to_string(Singleton<Module>().IR_number("."));
}

void Value::add_user(Use* __data){
    userlist.push_front(__data);
}

std::string Value::GetName(){
    return name;
}

void Value::print(){
    if(auto tmp=dynamic_cast<Function*>(this))
        std::cout<<"@"<<tmp->GetName();
    else if(auto tmp=dynamic_cast<BuildInFunction*>(this))
        std::cout<<"@"<<tmp->GetName();
    else if(auto tmp=dynamic_cast<ConstIRInt*>(this))
        std::cout<<tmp->GetVal();
    else if(auto tmp=dynamic_cast<ConstIRFloat*>(this))
        std::cout<<tmp->GetVal();
    else if(GetName()[1]=='g')
        std::cout<<"@"<<GetName();
    else if(GetName()=="undef")
        std::cout<<GetName();
    else 
        std::cout<<"%"<<GetName();
}

//replace all uses with transferred value
void Value::RAUW(Value* val){
    UserList& list=this->userlist;
    Use*& Head=list.Front();
    while(Head){
        Head->usee=val;
        Use* tmp=Head->nxt;
        val->userlist.push_front(Head);
        Head=tmp;
    }
}

void User::add_use(Value* __data){
    uselist.push_back(std::make_unique<Use>(this,__data));
}

User::User():Value(VoidType::NewVoidTypeGet()){
}

User::User(Type* _tp):Value(_tp){
}

void User::ClearRelation(){
    assert(this->GetUserlist().is_empty()&&"the head must be nullptr!");
    for(auto& use:uselist){
        (*use->prev)=use->nxt;
        if(use->nxt!=nullptr)
          use->nxt->prev=use->prev;
    }
}

Value* User::GetDef(){return static_cast<Value*>(this);}

ConstIRInt::ConstIRInt(int _val):Value(IntType::NewIntTypeGet()),val(_val){};

int ConstIRInt::GetVal(){
    return val;
}

void ConstIRInt::ir_mark(){
    return;
}

ConstIRFloat::ConstIRFloat(float _val):Value(FloatType::NewFloatTypeGet()),val(_val){};

float ConstIRFloat::GetVal(){
    return val;
}

void ConstIRFloat::ir_mark(){
    return;
}