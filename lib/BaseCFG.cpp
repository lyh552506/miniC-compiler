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

InnerDataType Value::GetType(){
    return tp->GetType();
}


Value::Value(std::shared_ptr<Type> _tp):tp(_tp){}
Value::Value(InnerDataType _tp){tp=std::make_shared<Type>(_tp);}

void Value::SetNum(int &cnt){if(GetNum()<0)number=cnt++;}
int Value::GetNum(){return number;}

std::shared_ptr<Type> Value::CopyType(){return tp;}
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
User::User():Value(std::make_shared<Type>(IR_Value_VOID)){}
User::User(std::shared_ptr<Type> _tp):Value(_tp){}
std::vector<std::unique_ptr<Use>>& User::Getuselist() {return uselist;}
Value* User::GetDef(){return static_cast<Value*>(this);}

ConstIRInt::ConstIRInt(int _val):Value(IR_Value_INT),val(_val){};

int ConstIRInt::GetVal(){
    return val;
}

ConstIRFloat::ConstIRFloat(float _val):Value(IR_Value_Float),val(_val){};

float ConstIRFloat::GetVal(){
    return val;
}