#include "BaseCFG.hpp"
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

InnerDataType Value::GetType(){
    return tp->GetType();
}


Value::Value(std::shared_ptr<Type> _tp):tp(_tp){}
Value::Value(InnerDataType _tp){tp=std::make_shared<Type>(_tp);}
std::shared_ptr<Type> Value::CopyType(){return tp;}
void Value::add_user(Use* __data){
    userlist.push_front(__data);
}
void Value::print(){
    // only to use dynamic_cast
    assert(0);
}

void User::add_use(Value* __data){
    uselist.push_back(Use(this,__data));
}
User::User():Value(std::make_shared<Type>(IR_Value_VOID)){}
User::User(std::shared_ptr<Type> _tp):Value(_tp){}
void User::print(){
    int status;
    char* demangled_name = abi::__cxa_demangle(typeid(*this).name(), 0, 0, &status);
    assert(status==0);
    std::cout<<demangled_name<<'\n';
    free(demangled_name);
}
Value* User::GetDef(){return def.get();}

ConstIRInt::ConstIRInt(int _val):Value(IR_Value_INT),val(_val){};
ConstIRFloat::ConstIRFloat(float _val):Value(IR_Value_Float),val(_val){};