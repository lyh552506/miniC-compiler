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
}
Value* Use::GetValue(){return usee;}

Type* Value::GetType(){
    return tp;
}

InnerDataType Value::GetTypeEnum(){return tp->GetTypeEnum();}


Value::Value(Type* _tp):tp(_tp){}

void Value::SetNum(int &cnt){if(GetNum()<0)number=cnt++;}
int Value::GetNum(){return number;}

void Value::add_user(Use* __data){
    userlist.push_front(__data);
}
void Value::print(int& cnt){
    if(auto tmp=dynamic_cast<Function*>(this))
        std::cout<<"@"<<tmp->GetName();
    else if(auto tmp=dynamic_cast<ConstIRInt*>(this))
        std::cout<<tmp->GetVal();
    else if(auto tmp=dynamic_cast<ConstIRFloat*>(this))
        std::cout<<tmp->GetVal();
    else{
        SetNum(cnt);
        std::cout<<"%"<<GetNum();
    }
}

void User::add_use(Value* __data){
    uselist.push_back(std::make_unique<Use>(this,__data));
}
User::User():Value(VoidType::NewVoidTypeGet()){}
User::User(Type* _tp):Value(_tp){}
Value* User::GetDef(){return static_cast<Value*>(this);}

ConstIRInt::ConstIRInt(int _val):Value(IntType::NewIntTypeGet()),val(_val){};

int ConstIRInt::GetVal(){
    return val;
}

ConstIRFloat::ConstIRFloat(float _val):Value(FloatType::NewFloatTypeGet()),val(_val){};

float ConstIRFloat::GetVal(){
    return val;
}