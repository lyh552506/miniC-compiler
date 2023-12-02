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
    return tp;
}
Value::Value(InnerDataType _tp):tp(_tp){}
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
User::User():Value(InnerDataType::IR_Value_VOID){}
User::User(InnerDataType tp):Value(tp){}
void User::print(){
    int status;
    char* demangled_name = abi::__cxa_demangle(typeid(*this).name(), 0, 0, &status);
    assert(status==0);
    std::cout<<demangled_name<<'\n';
    free(demangled_name);
}

Operand::Operand(int num):InnerOperand(num){}
Operand::Operand(Value* num):InnerOperand(num){}
Operand::Operand(float num):InnerOperand(num){}
InnerDataType Operand::GetType(){
    auto fat=*static_cast<InnerOperand*>(this);
    if(std::holds_alternative<Value*>(fat)){
        return std::get<Value*>(fat)->GetType();
    }
    else if(std::holds_alternative<int>(fat)){
        return InnerDataType::IR_Value_INT;
    }
    else return InnerDataType::IR_Value_Float;
}