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

User* Use::GetUser(){return fat;}

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
    else
        std::cout<<"%"<<GetName();
}

//replace all uses with transferred value
void Value::RAUW(Value* val){
    UserList list=this->userlist;
    /*tranverse the userlist and replace value*/
    for(auto use=list.begin();use!=list.end();++use){
        User *user=(*use)->GetUser();

        auto uselist=user->Getuselist();
        using UsePtr=decltype(uselist[0]);

        auto it=std::find_if(uselist.begin(),uselist.end(),[this](UsePtr& tmp)->bool{
            return tmp.get()->GetValue()==this;
        });
        //this 一定在他的User的uselist value中，不用判断是否来到end
        //在User的uselist中删除掉it
        uselist.erase(it);

        Use *tmp=new Use(user,val);
        val->add_user(tmp);
        user->add_use(val);
    }
}

void User::add_use(Value* __data){
    uselist.push_back(std::make_unique<Use>(this,__data));
}

User::User():Value(VoidType::NewVoidTypeGet()){
}

User::User(Type* _tp):Value(_tp){
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