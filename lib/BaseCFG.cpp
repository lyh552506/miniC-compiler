#include "BaseCFG.hpp"
#include "CFG.hpp"
#include <sstream>

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
void Value::SetName(std::string newname) {this->name = newname;}
std::string Value::GetName(){
    return name;
}

void Value::print(){
    if(isConst())
        std::cout<<GetName();
    else if(auto tmp=dynamic_cast<Function*>(this))
        std::cout<<"@"<<tmp->GetName();
    else if(auto tmp=dynamic_cast<BuildInFunction*>(this))
        std::cout<<"@"<<tmp->GetName();
    else if(GetName().substr(0,2)==".g")
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

ConstantData::ConstantData(Type* _tp):Value(_tp){}

ConstIRBoolean::ConstIRBoolean(bool _val):ConstantData(BoolType::NewBoolTypeGet()),val(_val){
    if(val)name="true";
    else name="false";
};

ConstIRInt::ConstIRInt(int _val):ConstantData(IntType::NewIntTypeGet()),val(_val){name=std::to_string(val);};    

int ConstIRInt::GetVal(){
    return val;
}

ConstIRFloat::ConstIRFloat(float _val):ConstantData(FloatType::NewFloatTypeGet()),val(_val){
    double tmp=val;
    std::stringstream ss;
    ss<<"0x"<<std::hex<<*(reinterpret_cast<long long*>(&tmp));
    name=ss.str();
};

float ConstIRFloat::GetVal(){
    return val;
}

ConstIRBoolean* ConstIRBoolean::GetNewConstant(bool _val){
    static ConstIRBoolean* true_const=new ConstIRBoolean(true);
    static ConstIRBoolean* false_const=new ConstIRBoolean(false);
    if(_val)return true_const;
    else return false_const;
}

bool ConstIRBoolean::GetVal(){
    return val;
}

ConstIRInt* ConstIRInt::GetNewConstant(int _val){
    static std::map<int,ConstIRInt*> int_const_map;
    if(int_const_map.find(_val)==int_const_map.end())
        int_const_map[_val]=new ConstIRInt(_val);
    return int_const_map[_val];
}

ConstIRFloat* ConstIRFloat::GetNewConstant(float _val){
    static std::map<float,ConstIRFloat*> float_const_map;
    if(float_const_map.find(_val)==float_const_map.end())
        float_const_map[_val]=new ConstIRFloat(_val);
    return float_const_map[_val];
}

ConstPtr::ConstPtr(Type* _tp):ConstantData(_tp){}

ConstPtr* ConstPtr::GetNewConstant(Type* _tp){
    static ConstPtr* const_ptr=new ConstPtr(_tp);
    return const_ptr;
}