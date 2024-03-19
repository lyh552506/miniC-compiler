#include "BaseCFG.hpp"
#include "CFG.hpp"
#include <sstream>

Use::Use(User *__fat, Value *__usee) : fat(__fat), usee(__usee) {
  usee->add_user(this);
}
void Use::RemoveFromUserList(User *is_valid) {
  assert(is_valid == fat);
  GetValue()->GetUserlist().GetSize()--;
  (*prev) = nxt;
  if(nxt!=nullptr)nxt->prev = prev;
}
void UserList::push_front(Use *_data) {
  // manage the size of the userlist
  size++;
  
  _data->nxt = head;
  if (head != nullptr)
    head->prev = &(_data->nxt);
  _data->prev = &head;
  head = _data;
}
Value *Use::GetValue() { return usee; }

User *Use::GetUser() { return fat; }

User *&Use::SetUser() { return fat; }

Value *&Use::SetValue() { return usee; }

Type *Value::GetType() { return tp; }

InnerDataType Value::GetTypeEnum() { return GetType()->GetTypeEnum(); }

Value::Value(Type *_tp) : tp(_tp) {
  name = ".";
  name += std::to_string(Singleton<Module>().IR_number("."));
}

void Value::add_user(Use *__data) { userlist.push_front(__data); }
void Value::SetName(std::string newname) { this->name = newname; }
std::string Value::GetName() { return name; }

void Value::print() {
  if (isConst())
    std::cout << GetName();
  else if (auto tmp = dynamic_cast<Function *>(this))
    std::cout << "@" << tmp->GetName();
  else if (auto tmp = dynamic_cast<BuildInFunction *>(this))
    std::cout << "@" << tmp->GetName();
  else if (auto tmp = dynamic_cast<MemcpyHandle *>(this))
    std::cout << "@" << tmp->GetName();
  else if (GetName().substr(0, 2) == ".g")
    std::cout << "@" << GetName();
  else if (GetName() == "undef")
    std::cout << GetName();
  else
    std::cout << "%" << GetName();
}

//replace all uses with transferred value
void Value::RAUW(Value* val){
    UserList& list=this->userlist;
    // manage user size in value
    list.GetSize()=0;
    Use*& Head=list.Front();
    while(Head){
        if(auto phi=dynamic_cast<PhiInst*>(Head->fat))
          phi->Phiprop(Head->usee,val);
        Head->usee=val;
        Use* tmp=Head->nxt;
        val->userlist.push_front(Head);
        Head=tmp;
    }
}

bool Value::isUndefVal()
{
    if(dynamic_cast<UndefValue*>(this))
        return true;
    else
        return false;
}

bool Value::isGlobVal(){
  if(dynamic_cast<User*>(this))
    return false;
  if(dynamic_cast<ConstantData*>(this))
    return false;
}

bool Value::isConstZero()
{
    if(auto num = dynamic_cast<ConstIRInt*>(this))
        return num->GetVal() == 0;
    else if(auto num = dynamic_cast<ConstIRFloat*>(this))
        return num->GetVal() == 0;
    else
        return false;
}

bool Value::isConstOne()
{
    if(auto num = dynamic_cast<ConstIRInt*>(this))
        return num->GetVal() == 1;
    else 
        return false;
}

void User::add_use(Value *__data) {
  uselist.push_back(std::make_unique<Use>(this, __data));
}

User::User() : Value(VoidType::NewVoidTypeGet()) {}

User::User(Type *_tp) : Value(_tp) {}

void User::ClearRelation() {
  assert(this->GetUserlist().is_empty() && "the head must be nullptr!");
  for (auto &use : uselist)
    use->RemoveFromUserList(use->GetUser());
}
bool User::IsTerminateInst()
{
  if(dynamic_cast<UnCondInst*>(this))
    return true;
  else if(dynamic_cast<CondInst*>(this))
    return true;
  else if(dynamic_cast<RetInst*>(this))
    return true;
  else
    return false;
}

bool User::HasSideEffect()
{
  if(dynamic_cast<StoreInst*>(this))
  {
    Value* op = this->Getuselist()[1]->usee;
    if(op->isGlobVal())
      return true;
    if(op->GetTypeEnum() == InnerDataType::IR_PTR)
      return true;
  }
  if(dynamic_cast<CallInst*>(this))
  {
    Function* func = dynamic_cast<Function*>(this->Getuselist()[0]->GetValue());
    auto& params = func->GetParams();
    for(auto& param : params)
    {
      if(param->GetTypeEnum() == InnerDataType::IR_PTR)
        return true;
    }
    for(auto it = func->begin(); it != func->end(); ++it)
    {
      BasicBlock* block = *it;
      for(auto iter = block->begin(); iter != block->end(); ++iter)
      {
        if(dynamic_cast<CallInst*>(*iter))
          return true;
        else
        {
          if((*iter)->HasSideEffect())
            return true;
          else
            return false;
        }
      }
    }
  }
  if(dynamic_cast<GetElementPtrInst*>(this))
  {
    auto &users = this->GetUserlist();
    for(auto user_ : users)
    {
      User* user = user_->GetUser();
      if(user->HasSideEffect())
        return true;
      else
        return false;
    }
  }
  if(this->GetUserlist().is_empty())
    return false;
}

Value *User::GetDef() { return dynamic_cast<Value *>(this); }

// change uselist[num] to val while manage use-def relation
void User::RSUW(int num,Operand val){
  auto& uselist=Getuselist();
  assert(0<=num&&num<uselist.size()&&"Invalid Location!");
  uselist[num]->usee=val;
  uselist[num]->RemoveFromUserList(this);
  val->add_user(uselist[num].get());
}

ConstantData::ConstantData(Type *_tp) : Value(_tp) {}

ConstIRBoolean::ConstIRBoolean(bool _val)
    : ConstantData(BoolType::NewBoolTypeGet()), val(_val) {
  if (val)
    name = "true";
  else
    name = "false";
};

ConstIRInt::ConstIRInt(int _val)
    : ConstantData(IntType::NewIntTypeGet()), val(_val) {
  name = std::to_string(val);
};

int ConstIRInt::GetVal() { return val; }

ConstIRFloat::ConstIRFloat(float _val)
    : ConstantData(FloatType::NewFloatTypeGet()), val(_val) {
  double tmp = val;
  std::stringstream ss;
  ss << "0x" << std::hex << *(reinterpret_cast<long long *>(&tmp));
  name = ss.str();
};

float ConstIRFloat::GetVal() { return val; }

ConstIRBoolean *ConstIRBoolean::GetNewConstant(bool _val) {
  static ConstIRBoolean *true_const = new ConstIRBoolean(true);
  static ConstIRBoolean *false_const = new ConstIRBoolean(false);
  if (_val)
    return true_const;
  else
    return false_const;
}

bool ConstIRBoolean::GetVal() { return val; }

ConstIRInt *ConstIRInt::GetNewConstant(int _val) {
  static std::map<int, ConstIRInt *> int_const_map;
  if (int_const_map.find(_val) == int_const_map.end())
    int_const_map[_val] = new ConstIRInt(_val);
  return int_const_map[_val];
}

ConstIRFloat *ConstIRFloat::GetNewConstant(float _val) {
  static std::map<float, ConstIRFloat *> float_const_map;
  if (float_const_map.find(_val) == float_const_map.end())
    float_const_map[_val] = new ConstIRFloat(_val);
  return float_const_map[_val];
}

ConstPtr::ConstPtr(Type *_tp) : ConstantData(_tp) {}

ConstPtr *ConstPtr::GetNewConstant(Type *_tp) {
  static ConstPtr *const_ptr = new ConstPtr(_tp);
  return const_ptr;
}