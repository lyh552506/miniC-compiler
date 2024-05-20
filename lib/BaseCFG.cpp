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

Value* Value::clone(std::unordered_map<Operand,Operand>& mapping){
  // if this is called it must be a param
  if(mapping.find(this)!=mapping.end())
    return mapping[this];
  Value* newval=new Value(this->GetType());
  mapping[this]=newval;
  return newval;
}

Value::~Value(){
  while(!userlist.is_empty())
    delete userlist.Front()->fat;
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
std::vector<BasicBlock*> BasicBlock::GetSuccBlock()
{   
    if(!Succ_Block.empty())
        return this->Succ_Block;
    else
    {
        std::cerr << "There is no Succ Block." << std::endl;
        return std::vector<BasicBlock*>{};
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
  return true;
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

User* User::clone(std::unordered_map<Operand,Operand>& mapping){
  // this method is responsible for copying uselist
  assert(mapping.find(this)!=mapping.end()&&"User not copied!");
  auto to=dynamic_cast<User*>(mapping[this]);
  assert(to!=nullptr&&"It is not a User!Impossible");
  for(auto& use:uselist)
    to->add_use(use->GetValue()->clone(mapping));
  return to;
}

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

bool User::IsCondInst(){
  if(dynamic_cast<CondInst*>(this))
    return true;
  return false;
}

bool User::IsUncondInst(){
  if(dynamic_cast<UnCondInst*>(this))
    return true;
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
    std::string name = this->Getuselist()[0]->usee->GetName();
    if(name =="getint" || name == "getch" || name == "getfloat" \
    || name == "getfarray" || name == "putint" || name == "putfloat" \
    || name == "putarray" || name == "putfarray" || name == "putf" || name == "getarray" \
    || name == "putch" || name == "_sysy_starttime" || name == "_sysy_stoptime" \
    || name == "llvm.memcpy.p0.p0.i32")
      return true;
    Function* func = dynamic_cast<Function*>(this->Getuselist()[0]->GetValue());
    if(func){
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
        }
      }
    }}
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
  return false;
}
int User::GetUseIndex(Use* Op)
{
  for(int i = 0; i < uselist.size(); i++)
  {
    if(uselist[i].get() == Op)
      return i;
  }
}
Value *User::GetDef() { return dynamic_cast<Value *>(this); }

// change uselist[num] to val while manage use-def relation
void User::RSUW(int num,Operand val){
  auto& uselist=Getuselist();
  assert(0<=num&&num<uselist.size()&&"Invalid Location!");
  uselist[num]->RemoveFromUserList(this);
  uselist[num]->usee=val;
  val->add_user(uselist[num].get());
}

ConstantData::ConstantData(Type *_tp) : Value(_tp) {}

ConstantData* ConstantData::clone(std::unordered_map<Operand,Operand>& mapping){
  return this;
}

ConstantData* ConstantData::getNullValue(Type* tp)
{
  InnerDataType type = tp->GetTypeEnum();
  if(type == InnerDataType::IR_Value_INT)
    return ConstIRInt::GetNewConstant(0);
  else if(type == InnerDataType::IR_Value_Float)
    return ConstIRFloat::GetNewConstant(0);
  else
    return nullptr;
}
bool ConstantData::isZero()
{
  if(auto Int = dynamic_cast<ConstIRInt*>(this))
    return Int->GetVal() == 0;
  else if(auto Float = dynamic_cast<ConstIRFloat*>(this))
    return Float->GetVal() == 0;
  else if(auto Bool = dynamic_cast<ConstIRBoolean*>(this))
    return Bool->GetVal() == false;
  else
    return false;
}
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
  static ConstIRBoolean true_const(true);
  static ConstIRBoolean false_const(false);
  if (_val)
    return &true_const;
  else
    return &false_const;
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