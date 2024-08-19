#include "../include/lib/CFG.hpp"
#include "../include/lib/BaseCFG.hpp"
#include "../include/lib/MagicEnum.hpp"
#include "../util/my_stl.hpp"
#include <algorithm>
#include <cassert>
#include <iostream>
#include <map>
#include <memory>
#include <queue>
#include <string>
#include <tuple>
#include <utility>
#include <vector>
#define BaseEnumNum 8
template <typename T>
T *normal_clone(T *from, std::unordered_map<Operand, Operand> &mapping) {
  if (mapping.find(from) != mapping.end())
    return dynamic_cast<T *>(mapping[from]);
  auto tmp = new T(from->GetType());
  mapping[from] = tmp;
  return dynamic_cast<T *>(from->User::clone(mapping));
}

Initializer::Initializer(Type *_tp) : Value(_tp) {}

void Initializer::Var2Store(BasicBlock *bb, const std::string &name,
                            std::vector<int> &gep_data) {
  for (int i = 0; i < this->size(); i++) {
    auto &handle = (*this)[i];
    gep_data.push_back(i);
    if (auto inits = dynamic_cast<Initializer *>(handle)) {
      inits->Var2Store(bb, name, gep_data);
    } else {
      if (!handle->isConst()) {
        auto gep = dynamic_cast<GetElementPtrInst *>(
            bb->GenerateGEPInst(Singleton<Module>().GetValueByName(name)));
        gep->add_use(ConstIRInt::GetNewConstant());
        for (auto &j : gep_data)
          gep->add_use(ConstIRInt::GetNewConstant(j));
        bb->GenerateStoreInst(handle, gep);
        if (handle->GetType()->GetTypeEnum() == IR_Value_INT)
          handle = ConstIRInt::GetNewConstant();
        else
          handle = ConstIRFloat::GetNewConstant();
      }
    }
    gep_data.pop_back();
  }
}

void Initializer::print() {
  // tp->print();
  if (size() == 0) {
    std::cout << "zeroinitializer";
    return;
  }
  std::cout << " [";
  int limi = dynamic_cast<ArrayType *>(tp)->GetNumEle();
  for (int i = 0; i < limi; i++) {
    dynamic_cast<ArrayType *>(tp)->GetSubType()->print();
    if (i < this->size()) {
      std::cout << " ";
      if (auto inits = dynamic_cast<Initializer *>((*this)[i]))
        inits->print();
      else
        (*this)[i]->print();
    } else
      std::cout << " zeroinitializer";
    if (i != limi - 1)
      std::cout << ", ";
  }
  std::cout << "]";
}

Operand Initializer::getInitVal(std::vector<int> &index, int dep) {
  auto getZero = [&]() -> Operand {
    auto basetp = dynamic_cast<HasSubType *>(GetType())->get_baseType();
    if (basetp == IntType::NewIntTypeGet()) {
      return ConstIRInt::GetNewConstant();
    } else if (basetp == FloatType::NewFloatTypeGet()) {
      return ConstIRFloat::GetNewConstant();
    } else {
      return ConstIRBoolean::GetNewConstant();
    }
  };

  if (size() == 0) {
    return getZero();
  }
  int limi = dynamic_cast<ArrayType *>(tp)->GetNumEle();
  auto i = index[dep];
  assert(i < limi);
  auto thissize = size();
  if (i >= thissize)
    return getZero();
  else if (auto inits = dynamic_cast<Initializer *>((*this)[i])) {
    return inits->getInitVal(index, dep + 1);
  } else {
    return (*this)[i];
  }
}

AllocaInst::AllocaInst(std::string str, Type *_tp)
    : User(PointerType::NewPointerTypeGet(_tp)) {
  id = OpID::Alloca;
  // name=str;
  // name+="_";
  // name+=std::to_string(Singleton<Module>().IR_number(str));
}

void AllocaInst::print() {
  Value::print();
  std::cout << " = alloca ";
  dynamic_cast<PointerType *>(tp)->GetSubType()->print();
  std::cout << "\n";
}

bool AllocaInst::IsUsed() {
  auto &list = GetUserlist();
  if (list.is_empty())
    return false;
  return true;
}

AllocaInst *AllocaInst::clone(std::unordered_map<Operand, Operand> &mapping) {
  return normal_clone<AllocaInst>(this, mapping);
}

StoreInst::StoreInst(Operand __src, Operand __des) {
  add_use(__src);
  add_use(__des);
  name = "StoreInst";
  id = OpID::Store;
}

Operand StoreInst::GetDef() { return nullptr; }

void StoreInst::print() {
  std::cout << "store ";
  for (auto &i : uselist) {
    i->GetValue()->GetType()->print();
    std::cout << " ";
    i->GetValue()->print();
    if (i.get() != uselist.back().get())
      std::cout << ", ";
  }
  std::cout << '\n';
}

StoreInst *StoreInst::clone(std::unordered_map<Operand, Operand> &mapping) {
  return normal_clone<StoreInst>(this, mapping);
}

LoadInst::LoadInst(Value *__src)
    : User(dynamic_cast<PointerType *>(__src->GetType())->GetSubType()) {
  assert(GetTypeEnum() == IR_Value_INT || GetTypeEnum() == IR_Value_Float ||
         GetTypeEnum() == IR_PTR);
  add_use(__src);
  id = OpID::Load;
}

LoadInst *LoadInst::clone(std::unordered_map<Operand, Operand> &mapping) {
  return normal_clone<LoadInst>(this, mapping);
}

// Value* LoadInst::GetLoadTarget(){
//     auto& list=Getuselist();
//     return list[0]->GetValue();
// }

void LoadInst::print() {
  Value::print();
  std::cout << " = load ";
  tp->print();
  std::cout << ", ";
  for (auto &i : uselist) {
    i->GetValue()->GetType()->print();
    std::cout << " ";
    i->GetValue()->print();
    if (i.get() != uselist.back().get())
      std::cout << ", ";
  }
  std::cout << '\n';
}

void FPTSI::print() {
  Value::print();
  std::cout << " = fptosi ";
  for (auto &i : uselist) {
    i->GetValue()->GetType()->print();
    std::cout << " ";
    i->GetValue()->print();
    std::cout << " ";
  }
  std::cout << "to ";
  tp->print();
  std::cout << "\n";
}

FPTSI::FPTSI(Operand __src) : User(IntType::NewIntTypeGet()) {
  add_use(__src);
  id = OpID::FP2SI;
}

FPTSI *FPTSI::clone(std::unordered_map<Operand, Operand> &mapping) {
  return normal_clone<FPTSI>(this, mapping);
}

void SITFP::print() {
  Value::print();
  std::cout << " = sitofp ";
  for (auto &i : uselist) {
    i->GetValue()->GetType()->print();
    std::cout << " ";
    i->GetValue()->print();
    std::cout << " ";
  }
  std::cout << "to ";
  tp->print();
  std::cout << '\n';
}

SITFP *SITFP::clone(std::unordered_map<Operand, Operand> &mapping) {
  return normal_clone<SITFP>(this, mapping);
}

SITFP::SITFP(Operand __src) : User(FloatType::NewFloatTypeGet()) {
  add_use(__src);
  id = OpID::SI2FP;
}

Operand UnCondInst::GetDef() { return nullptr; }

UnCondInst::UnCondInst(BasicBlock *__des) {
  add_use(__des);
  id = OpID::UnCond;
}

UnCondInst *UnCondInst::clone(std::unordered_map<Operand, Operand> &mapping) {
  return normal_clone<UnCondInst>(this, mapping);
}

void UnCondInst::print() {
  std::cout << "br ";
  for (auto &i : uselist) {
    std::cout << "label ";
    i->GetValue()->print();
    std::cout << " ";
  }
  std::cout << '\n';
}

CondInst::CondInst(Operand __cond, BasicBlock *__istrue,
                   BasicBlock *__isfalse) {
  add_use(__cond);
  add_use(__istrue);
  add_use(__isfalse);
  id = OpID::Cond;
}

CondInst *CondInst::clone(std::unordered_map<Operand, Operand> &mapping) {
  return normal_clone<CondInst>(this, mapping);
}

void CondInst::print() {
  std::cout << "br ";
  bool flag = 0;
  for (auto &i : uselist) {
    if (flag == 0) {
      i->GetValue()->GetType()->print();
      std::cout << " ";
      flag = 1;
    } else
      std::cout << "label ";
    i->GetValue()->print();
    if (i.get() != uselist.back().get())
      std::cout << ", ";
  }
  std::cout << '\n';
}

Operand CondInst::GetDef() { return nullptr; }

CallInst::CallInst(Value *_func, std::vector<Operand> &_args,
                   std::string appendix)
    : User(_func->GetType()) {
  name += appendix;
  add_use(_func);
  for (auto &i : _args)
    add_use(i);
  id = OpID::Call;
}

CallInst *CallInst::clone(std::unordered_map<Operand, Operand> &mapping) {
  return normal_clone<CallInst>(this, mapping);
}

void CallInst::print() {
  if (tp != VoidType::NewVoidTypeGet()) {
    Value::print();
    std::cout << " = ";
  }
  std::cout << "call ";
  for (auto &i : uselist) {
    i->GetValue()->GetType()->print();
    std::cout << " ";
    i->GetValue()->print();
    if (i.get() == uselist.front().get())
      std::cout << "(";
    else if (i.get() != uselist.back().get())
      std::cout << ", ";
  }
  std::cout << ")\n";
}

RetInst::RetInst() { id = OpID::Ret; }

RetInst::RetInst(Operand op) {
  add_use(op);
  id = OpID::Ret;
}

RetInst *RetInst::clone(std::unordered_map<Operand, Operand> &mapping) {
  return normal_clone<RetInst>(this, mapping);
}

void RetInst::print() {
  std::cout << "ret ";
  for (auto &i : uselist) {
    i->GetValue()->GetType()->print();
    std::cout << " ";
    i->GetValue()->print();
    std::cout << " ";
  }
  if (uselist.empty())
    std::cout << "void";
  std::cout << '\n';
}

Operand RetInst::GetDef() { return nullptr; }

bool check_binary_boolean(BinaryInst::Operation op) {
  switch (op) {
  case BinaryInst::Op_E:
  case BinaryInst::Op_NE:
  case BinaryInst::Op_G:
  case BinaryInst::Op_GE:
  case BinaryInst::Op_L:
  case BinaryInst::Op_LE:
    return true;
  default:
    return false;
  }
}

BinaryInst::BinaryInst(Operand _A, Operation __op, Operand _B, bool Atom)
    : User(check_binary_boolean(__op) ? BoolType::NewBoolTypeGet()
                                      : _A->GetType()) {
  op = __op;
  // 与User中的OpID对应
  id = static_cast<User::OpID>(__op + BaseEnumNum);
  add_use(_A);
  add_use(_B);
  Atomic = Atom;
}

std::string BinaryInst::GetOperation() {
  std::string opcode = magic_enum::enum_name(op).data();
  return opcode;
}

BinaryInst *BinaryInst::clone(std::unordered_map<Operand, Operand> &mapping) {
  auto tmp = normal_clone<BinaryInst>(this, mapping);
  tmp->op = op;
  tmp->id = static_cast<User::OpID>(op + BaseEnumNum);
  tmp->Atomic = Atomic;
  return tmp;
}

BinaryInst::Operation BinaryInst::getopration() { return op; }
BinaryInst::Operation
BinaryInst::GetReversedOperation(BinaryInst::Operation op) {
  switch (op) {
  case BinaryInst::Op_E:
    return BinaryInst::Op_E;
  case BinaryInst::Op_NE:
    return BinaryInst::Op_NE;
  case BinaryInst::Op_G:
    return BinaryInst::Op_L;
  case BinaryInst::Op_GE:
    return BinaryInst::Op_LE;
  case BinaryInst::Op_L:
    return BinaryInst::Op_G;
  case BinaryInst::Op_LE:
    return BinaryInst::Op_GE;
  default:
    return static_cast<BinaryInst::Operation>(-1);
  }
}
BinaryInst::Operation
BinaryInst::GetInvertedOperation(BinaryInst::Operation op) {
  switch (op) {
  case BinaryInst::Op_E:
    return BinaryInst::Op_NE;
  case BinaryInst::Op_NE:
    return BinaryInst::Op_E;
  case BinaryInst::Op_G:
    return BinaryInst::Op_LE;
  case BinaryInst::Op_GE:
    return BinaryInst::Op_L;
  case BinaryInst::Op_L:
    return BinaryInst::Op_GE;
  case BinaryInst::Op_LE:
    return BinaryInst::Op_G;
  default:
    return static_cast<BinaryInst::Operation>(-1);
  }
}
BinaryInst *BinaryInst::CreateInst(Operand _A, Operation __op, Operand _B,
                                   User *place) {

  BinaryInst *bin = new BinaryInst(_A, __op, _B);
  if (place != nullptr) {
    BasicBlock *instbb = place->GetParent();
    for (auto iter = instbb->begin(); iter != instbb->end(); ++iter)
      if (*iter == place) {
        iter.insert_before(bin);
        break;
      }
  }
  return bin;
}

void BinaryInst::print() {
  Value::print();
  InnerDataType tp = uselist[0]->GetValue()->GetTypeEnum();
  std::cout << " = ";
  switch (op) {
  case BinaryInst::Op_Add:
    if (!this->Atomic) {
      if (uselist[0]->GetValue()->GetTypeEnum() == IR_Value_INT)
        std::cout << "add ";
      else
        std::cout << "fadd ";
    } else {
      std::cout << "atomicadd ";
    }
    break;
  case BinaryInst::Op_Sub:
    if (tp == IR_Value_INT || tp == IR_INT_64)
      std::cout << "sub ";
    else
      std::cout << "fsub ";
    break;
  case BinaryInst::Op_Mul:
    if (tp == IR_Value_INT || tp == IR_INT_64)
      std::cout << "mul ";
    else
      std::cout << "fmul ";
    break;
  case BinaryInst::Op_Div:
    if (tp == IR_Value_INT || tp == IR_INT_64)
      std::cout << "sdiv ";
    else
      std::cout << "fdiv ";
    break;
  case BinaryInst::Op_Mod:
    if (tp == IR_Value_INT || tp == IR_INT_64)
      std::cout << "srem ";
    else
      std::cout << "frem "; ///应该不存在
    break;
  case BinaryInst::Op_And:
    std::cout << "and ";
    break;
  case BinaryInst::Op_Or:
    std::cout << "or ";
    break;
  case BinaryInst::Op_Xor:
    std::cout << "xor ";
    break;
  case BinaryInst::Op_E:
    if (tp == IR_Value_INT || tp == IR_INT_64)
      std::cout << "i";
    else
      std::cout << "f";
    std::cout << "cmp ";
    if (uselist[0]->GetValue()->GetTypeEnum() == IR_Value_Float)
      std::cout << "u";
    std::cout << "eq ";
    break;
  case BinaryInst::Op_NE:
    if (tp == IR_Value_INT || tp == IR_INT_64)
      std::cout << "i";
    else
      std::cout << "f";
    std::cout << "cmp ";
    if (uselist[0]->GetValue()->GetTypeEnum() == IR_Value_Float)
      std::cout << "u";
    std::cout << "ne ";
    break;
  case BinaryInst::Op_G:
    if (tp == IR_Value_INT || tp == IR_INT_64)
      std::cout << "i";
    else
      std::cout << "f";
    std::cout << "cmp ";
    if (uselist[0]->GetValue()->GetTypeEnum() == IR_Value_Float)
      std::cout << "ugt ";
    else
      std::cout << "sgt ";
    break;
  case BinaryInst::Op_GE:
    if (tp == IR_Value_INT || tp == IR_INT_64)
      std::cout << "i";
    else
      std::cout << "f";
    std::cout << "cmp ";
    if (uselist[0]->GetValue()->GetTypeEnum() == IR_Value_Float)
      std::cout << "uge ";
    else
      std::cout << "sge ";
    break;
  case BinaryInst::Op_L:
    if (tp == IR_Value_INT || tp == IR_INT_64)
      std::cout << "i";
    else
      std::cout << "f";
    std::cout << "cmp ";
    if (uselist[0]->GetValue()->GetTypeEnum() == IR_Value_Float)
      std::cout << "ult ";
    else
      std::cout << "slt ";
    break;
  case BinaryInst::Op_LE:
    if (tp == IR_Value_INT || tp == IR_INT_64)
      std::cout << "i";
    else
      std::cout << "f";
    std::cout << "cmp ";
    if (uselist[0]->GetValue()->GetTypeEnum() == IR_Value_Float)
      std::cout << "ule ";
    else
      std::cout << "sle ";
    break;
  default:
    break;
  }
  if (this->Atomic) {
    uselist[0]->GetValue()->GetType()->print();
    std::cout << " ";
    uselist[0]->GetValue()->print();
    std::cout << ", ";
    uselist[1]->GetValue()->GetType()->print();
    std::cout << " ";
    uselist[1]->GetValue()->print();
    std::cout << '\n';
  } else {
    uselist[0]->GetValue()->GetType()->print();
    std::cout << " ";
    uselist[0]->GetValue()->print();
    std::cout << ", ";
    uselist[1]->GetValue()->print();
    std::cout << '\n';
  }
}

void BinaryInst::SetOperand(int index, Value *val) {
  assert(index < this->uselist.size());
  this->RSUW(index, val);
  // uselist[index].reset();
  // uselist.erase(uselist.begin() + index);
  // uselist.insert(uselist.begin() + index, std::make_unique<Use>(this, val));
}

Variable::Variable(UsageTag tag, Type *_tp, std::string _id)
    : User(tag == Param ? _tp : PointerType::NewPointerTypeGet(_tp)),
      usage(tag) {
  /// @warning FIXME: checkout which use name as condition
  if (usage == Param)
    return;
  if (usage == GlobalVariable) {
    name = ".G." + _id;
    Singleton<Module>().Register(_id, this);
  } else if (usage == Constant)
    name = ".C." + name;
  Singleton<Module>().PushVariable(this);
}

Value *Variable::clone(std::unordered_map<Operand, Operand> &mapping) {
  if (this->usage == Variable::Constant ||
      this->usage == Variable::GlobalVariable)
    return this;
  else {
    assert(mapping.find(this) != mapping.end() && "variable not copied!");
    return mapping[this];
  }
}
void Variable::print() {
  Value::print();
  if (usage == GlobalVariable)
    std::cout << " = global ";
  else if (usage == Constant)
    std::cout << " = constant ";
  else /* if(usage==Param) */
    return;
  auto tp = dynamic_cast<PointerType *>(GetType());
  assert(tp != nullptr && "Variable Must Be a Pointer Type to Inner Content!");
  tp->GetSubType()->print();
  std::cout << " ";
  if (uselist.size() != 0) {
    auto init = GetOperand(0);
    if (auto array_init = dynamic_cast<Initializer *>(init))
      array_init->print();
    else
      // a simple const, like int x=3;
      // can't be Constant
      init->print();
  } else
    std::cout << "zeroinitializer";
  std::cout << '\n';
}

bool Variable::isGlobal() {
  if (usage == Param)
    return false;
  else
    return true;
}

bool Variable::isParam() {
  if (usage == Param)
    return true;
  else
    return false;
}

GetElementPtrInst::GetElementPtrInst(Operand base_ptr) {
  add_use(base_ptr);
  id = OpID::Gep;
}

GetElementPtrInst::GetElementPtrInst(Operand base_ptr,
                                     std::vector<Operand> &args) {
  add_use(base_ptr);
  for (auto &&i : args)
    add_use(i);
  id = OpID::Gep;
}

GetElementPtrInst *
GetElementPtrInst::clone(std::unordered_map<Operand, Operand> &mapping) {
  return normal_clone<GetElementPtrInst>(this, mapping);
}

Type *GetElementPtrInst::GetType() {
  int limi = uselist.size() - 1;
  tp = uselist[0]->GetValue()->GetType();
  for (int i = 1; i <= limi; i++)
    tp = dynamic_cast<HasSubType *>(tp)->GetSubType();
  return tp = PointerType::NewPointerTypeGet(tp);
}

void GetElementPtrInst::print() {
  Value::print();
  std::cout << " = getelementptr inbounds ";
  dynamic_cast<HasSubType *>(uselist[0]->GetValue()->GetType())
      ->GetSubType()
      ->print();
  for (int i = 0; i < uselist.size(); i++) {
    std::cout << ", ";
    uselist[i]->GetValue()->GetType()->print();
    std::cout << " ";
    uselist[i]->GetValue()->print();
  }
  std::cout << '\n';
}
std::vector<Operand> GetElementPtrInst::GetIndexs() {
  std::vector<Operand> indexs;
  for (int i = 1; i < uselist.size(); i++)
    indexs.push_back(uselist[i]->GetValue());
  return indexs;
}

ZextInst::ZextInst(Operand ptr) : User(IntType::NewIntTypeGet()) {
  add_use(ptr);
  id = OpID::Zext;
}

ZextInst *ZextInst::clone(std::unordered_map<Operand, Operand> &mapping) {
  return normal_clone<ZextInst>(this, mapping);
}

void ZextInst::print() {
  Value::print();
  std::cout << " = zext i1 ";
  uselist[0]->GetValue()->print();
  std::cout << " to i32\n";
}

SextInst::SextInst(Operand ptr) : User(Int64Type::NewInt64TypeGet()) {
  add_use(ptr);
  id = OpID::Sext;
}
SextInst *SextInst::clone(std::unordered_map<Operand, Operand> &mapping) {
  return normal_clone<SextInst>(this, mapping);
}
void SextInst::print() {
  Value::print();
  std::cout << " = sext i32 ";
  uselist[0]->GetValue()->print();
  std::cout << " to i64\n";
}

TruncInst::TruncInst(Operand ptr) : User(IntType::NewIntTypeGet()) {
  add_use(ptr);
  id = OpID::Trunc;
}

TruncInst *TruncInst::clone(std::unordered_map<Operand, Operand> &mapping) {
  return normal_clone<TruncInst>(this, mapping);
}

void TruncInst::print() {
  Value::print();
  std::cout << " = trunc i64 ";
  uselist[0]->GetValue()->print();
  std::cout << " to i32\n";
}

MaxInst::MaxInst(Operand _A, Operand _B) : User(_A->GetType()) {
  add_use(_A);
  add_use(_B);
  id = OpID::Max;
}

void MaxInst::print() {
  Value::print();
  std::cout << " = call ";
  this->tp->print();
  if (this->tp->GetTypeEnum() == IR_Value_INT)
    std::cout << " @max(";
  else if (this->tp->GetTypeEnum() == IR_Value_Float)
    std::cout << " @fmax(";
  uselist[0]->GetValue()->GetType()->print();
  std::cout << " ";
  uselist[0]->GetValue()->print();
  std::cout << ", ";
  uselist[1]->GetValue()->GetType()->print();
  std::cout << " ";
  uselist[1]->GetValue()->print();
  std::cout << ")\n";
}

MaxInst *MaxInst::clone(std::unordered_map<Operand, Operand> &mapping) {
  return normal_clone<MaxInst>(this, mapping);
}

MinInst::MinInst(Operand _A, Operand _B) : User(_A->GetType()) {
  add_use(_A);
  add_use(_B);
  id = OpID::Min;
}

void MinInst::print() {
  Value::print();
  std::cout << " = call ";
  this->tp->print();
  if (this->tp->GetTypeEnum() == IR_Value_INT)
    std::cout << " @min(";
  else if (this->tp->GetTypeEnum() == IR_Value_Float)
    std::cout << " @fmin(";
  uselist[0]->GetValue()->GetType()->print();
  std::cout << " ";
  uselist[0]->GetValue()->print();
  std::cout << ", ";
  uselist[1]->GetValue()->GetType()->print();
  std::cout << " ";
  uselist[1]->GetValue()->print();
  std::cout << ")\n";
}

MinInst *MinInst::clone(std::unordered_map<Operand, Operand> &mapping) {
  return normal_clone<MinInst>(this, mapping);
}

SelectInst::SelectInst(Operand _cond, Operand _A, Operand _B)
    : User(_A->GetType()) {
  add_use(_cond);
  add_use(_A);
  add_use(_B);
  id = OpID::Select;
}

SelectInst *SelectInst::clone(std::unordered_map<Operand, Operand> &mapping) {
  return normal_clone<SelectInst>(this, mapping);
}

void SelectInst::print() {
  Value::print();
  std::cout << " = select ";
  uselist[0]->GetValue()->GetType()->print();
  std::cout << " ";
  uselist[0]->GetValue()->print();
  std::cout << ", ";
  uselist[1]->GetValue()->GetType()->print();
  std::cout << " ";
  uselist[1]->GetValue()->print();
  std::cout << ", ";
  uselist[2]->GetValue()->GetType()->print();
  std::cout << " ";
  uselist[2]->GetValue()->print();
  std::cout << '\n';
}

BasicBlock::BasicBlock() : Value(VoidType::NewVoidTypeGet()){};
Operand BasicBlock::GenerateLoadInst(Operand data) {
  auto tmp = new LoadInst(data);
  push_back(tmp);
  return tmp->GetDef();
}
Operand BasicBlock::GenerateSITFP(Operand _A) {
  auto tmp = new SITFP(_A);
  push_back(tmp);
  return Operand(tmp->GetDef());
}
Operand BasicBlock::GenerateFPTSI(Operand _B) {
  auto tmp = new FPTSI(_B);
  push_back(tmp);
  return Operand(tmp->GetDef());
}
Operand BasicBlock::GenerateBinaryInst(Operand _A, BinaryInst::Operation op,
                                       Operand _B) {
  bool tpA = (_A->GetTypeEnum() == InnerDataType::IR_Value_INT);
  bool tpB = (_B->GetTypeEnum() == InnerDataType::IR_Value_INT);
  // 一个int一个float
  BinaryInst *tmp;
  if (tpA ^ tpB) {
    assert(op != BinaryInst::Op_And && op != BinaryInst::Op_Or &&
           op != BinaryInst::Op_Mod);
    if (tpA == 1) {
      ///@todo 改变成float
      tmp = new BinaryInst(GenerateSITFP(_A), op, _B);
    } else {
      ///@todo 改变成float
      tmp = new BinaryInst(_A, op, GenerateSITFP(_B));
    }
  } else {
    if (_A->GetTypeEnum() == IR_Value_INT) {
      bool isbooleanA = (_A->GetType() == IntType::NewIntTypeGet());
      bool isbooleanB = (_B->GetType() == IntType::NewIntTypeGet());
      if (isbooleanA ^ isbooleanB) {
        if (isbooleanA == false)
          _A = GenerateZextInst(_A);
        else
          _B = GenerateZextInst(_B);
      }
    }
    tmp = new BinaryInst(_A, op, _B);
  }
  push_back(tmp);
  return Operand(tmp->GetDef());
}
Operand BasicBlock::GenerateBinaryInst(BasicBlock *bb, Operand _A,
                                       BinaryInst::Operation op, Operand _B) {
  if (_A->isConst() && _B->isConst()) {
    if (op == BinaryInst::Op_Div && _B->isConstZero()) {
      assert(_A->GetType() != BoolType::NewBoolTypeGet() &&
             _B->GetType() != BoolType::NewBoolTypeGet() && "InvalidType");
      if (_A->GetType() == IntType::NewIntTypeGet() &&
          _B->GetType() == IntType::NewIntTypeGet())
        return UndefValue::get(IntType::NewIntTypeGet());
      else
        return UndefValue::get(FloatType::NewFloatTypeGet());
    }
    auto calc = [](auto a, BinaryInst::Operation op,
                   auto b) -> std::variant<float, int> {
      switch (op) {
      case BinaryInst::Op_Add:
        return a + b;
      case BinaryInst::Op_Sub:
        return a - b;
      case BinaryInst::Op_Mul:
        return a * b;
      case BinaryInst::Op_Div:
        return a / b;
      case BinaryInst::Op_And:
        return (a != 0) && (b != 0);
      case BinaryInst::Op_Or:
        return (a != 0) || (b != 0);
      case BinaryInst::Op_Mod:
        return (int)a % (int)b;
      case BinaryInst::Op_E:
        return a == b;
      case BinaryInst::Op_NE:
        return a != b;
      case BinaryInst::Op_G:
        return a > b;
      case BinaryInst::Op_GE:
        return a >= b;
      case BinaryInst::Op_L:
        return a < b;
      case BinaryInst::Op_LE:
        return a <= b;
      default:
        assert(0);
        break;
      }
    };
    std::variant<float, int> fuc;
    if (auto A = dynamic_cast<ConstIRInt *>(_A)) {
      if (auto B = dynamic_cast<ConstIRInt *>(_B))
        fuc = calc(A->GetVal(), op, B->GetVal());
      else if (auto B = dynamic_cast<ConstIRFloat *>(_B))
        fuc = calc(A->GetVal(), op, B->GetVal());
      else if (auto B = dynamic_cast<ConstIRBoolean *>(_B))
        fuc = calc(A->GetVal(), op, B->GetVal());
      else
        assert(0);
    } else if (auto A = dynamic_cast<ConstIRFloat *>(_A)) {
      if (auto B = dynamic_cast<ConstIRInt *>(_B))
        fuc = calc(A->GetVal(), op, B->GetVal());
      else if (auto B = dynamic_cast<ConstIRFloat *>(_B))
        fuc = calc(A->GetVal(), op, B->GetVal());
      else if (auto B = dynamic_cast<ConstIRBoolean *>(_B))
        fuc = calc(A->GetVal(), op, B->GetVal());
      else
        assert(0);
    } else if (auto A = dynamic_cast<ConstIRBoolean *>(_A)) {
      if (auto B = dynamic_cast<ConstIRInt *>(_B))
        fuc = calc(A->GetVal(), op, B->GetVal());
      else if (auto B = dynamic_cast<ConstIRFloat *>(_B))
        fuc = calc(A->GetVal(), op, B->GetVal());
      else if (auto B = dynamic_cast<ConstIRBoolean *>(_B))
        fuc = calc(A->GetVal(), op, B->GetVal());
      else
        assert(0);
    } else
      assert(0);
    if (check_binary_boolean(op))
      return ConstIRBoolean::GetNewConstant(std::get<int>(fuc));
    else if (std::holds_alternative<int>(fuc))
      return ConstIRInt::GetNewConstant(std::get<int>(fuc));
    else
      return ConstIRFloat::GetNewConstant(std::get<float>(fuc));
  } else {
    assert(bb != nullptr);
    return bb->GenerateBinaryInst(_A, op, _B);
  }
}

void BasicBlock::GenerateStoreInst(Operand src, Operand des) {
  assert(des->GetType()->GetTypeEnum() == IR_PTR);
  auto tmp = dynamic_cast<PointerType *>(des->GetType());

  if (tmp->GetSubType()->GetTypeEnum() != src->GetTypeEnum()) {
    if (tmp->GetSubType()->GetTypeEnum() == IR_Value_INT)
      src = this->GenerateFPTSI(src);
    else
      src = this->GenerateSITFP(src);
  }
  auto storeinst = new StoreInst(src, des);
  this->push_back(storeinst);
}

BasicBlock *BasicBlock::GenerateNewBlock() {
  BasicBlock *tmp = new BasicBlock();
  GetParent()->add_block(tmp);
  return tmp;
}

BasicBlock *BasicBlock::SplitAt(User *inst) {
  // auto call_inst = dynamic_cast<CallInst *>(inst);
  // assert(call_inst != nullptr && "CallInst Is Expected Here");
  auto tmp = new BasicBlock();

  // other block:
  // %xx= phi [%??, this block]
  // should be transferred to
  // %xx=phi [%??, tmp]
  std::vector<BasicBlock *> succ;
  if (auto cond = back()->as<CondInst>()) {
    for (int i = 1; i < 3; i++)
      succ.push_back(cond->GetOperand(i)->as<BasicBlock>());
  } else if (auto uncond = back()->as<UnCondInst>()) {
    succ.push_back(uncond->GetOperand(0)->as<BasicBlock>());
  }
  for (auto bb : succ) {
    for (auto inst : *bb) {
      if (auto phi = inst->as<PhiInst>()) {
        for (auto &[ind, rec] : phi->PhiRecord) {
          if (rec.second == this)
            rec.second = tmp;
        }
      } else
        break;
    }
  }

  auto [left, right] = split(inst, back());
  tmp->collect(left, right);
  return tmp;
}

BasicBlock *BasicBlock::GenerateNewBlock(std::string name) {
  BasicBlock *tmp = new BasicBlock();
  tmp->name += name;
  GetParent()->add_block(tmp);
  return tmp;
}

void BasicBlock::print() {
  std::cout << GetName() << ":\n";
  for (auto i : (*this)) {
    std::cout << "  ";
    i->print();
  }
}

void Function::print() {
  std::cout << "define ";
  tp->print();
  std::cout << " @" << name << "(";
  for (auto &i : params) {
    i->GetType()->print();
    std::cout << " %" << i->GetName();
    // Singleton<IR_MARK>().GetNum(i.get());
    if (i.get() != params.back().get())
      std::cout << ", ";
  }
  std::cout << "){\n";
  for (auto i : (*this))
    i->print();
  std::cout << "}\n";
}

void Function::push_bb(BasicBlock *bb) {
  bbs.push_back(bb);
  push_back(bb);
}

void Function::InsertAlloca(AllocaInst *ptr) { front()->push_back(ptr); }

void Function::InsertBlock(BasicBlock *pred, BasicBlock *succ,
                           BasicBlock *insert) {
  if (auto condition = pred->back()) {
    if (auto cond = dynamic_cast<CondInst *>(condition)) {
      for (int i = 1; i <= 2; i++) {
        if (cond->Getuselist()[i]->GetValue() == succ) {
          cond->RSUW(i, insert);
          insert->GenerateUnCondInst(succ);
          break;
        }
      }
      assert("Not connected on CFG");
      return;
    } else if (auto uncond = dynamic_cast<UnCondInst *>(condition)) {
      assert(uncond->Getuselist()[0]->GetValue() == succ &&
             "Not connected on CFG");
      uncond->RSUW(0, insert);
      insert->GenerateUnCondInst(succ);
      return;
    }
  }
  assert("Null BasicBlock Or Invalid Branch Inst");
}

void Function::InsertBlock(BasicBlock *curr, BasicBlock *insert) {
  insert->GenerateUnCondInst(curr);
  // this->push_back(insert);
  insert->num = this->bb_num++;
  this->push_bb(insert);
}

std::pair<Value *, BasicBlock *>
Function::InlineCall(CallInst *inst,
                     std::unordered_map<Operand, Operand> &OperandMapping) {
  std::pair<Value *, BasicBlock *> tmp{nullptr, nullptr};
  BasicBlock *block = inst->GetParent();
  User *Jump = block->back();
  Function *func = block->GetParent();
  Function *inlined_func = inst->GetOperand(0)->as<Function>();
  BasicBlock *SplitBlock = block->SplitAt(inst);
  tmp.second = SplitBlock;
  BasicBlock::mylist<Function, BasicBlock>::iterator Block_Pos(block);
  Block_Pos.insert_after(SplitBlock);
  ++Block_Pos;
  std::vector<BasicBlock *> blocks;
  int num = 1;
  for (auto &param : inlined_func->GetParams()) {
    Value *Param = param.get();
    if (OperandMapping.find(inst->Getuselist()[num]->usee) !=
        OperandMapping.end())
      OperandMapping[Param] = OperandMapping[inst->Getuselist()[num]->usee];
    else
      OperandMapping[Param] = inst->Getuselist()[num]->usee;
    num++;
  }
  for (BasicBlock *block : *inlined_func)
    blocks.push_back(block->clone(OperandMapping));
  UnCondInst *Br = new UnCondInst(blocks[0]);
  block->push_back(Br);
  for (auto it = blocks[0]->begin(); it != blocks[0]->end();) {
    auto shouldmvinst = dynamic_cast<AllocaInst *>(*it);
    ++it;
    if (shouldmvinst) {
      BasicBlock *front_block = func->front();
      shouldmvinst->EraseFromParent();
      front_block->push_front(shouldmvinst);
    }
  }
  for (BasicBlock *block_ : blocks)
    Block_Pos.insert_before(block_);
  if (inlined_func->GetUserListSize() == 0)
    Singleton<Module>().EraseFunction(inlined_func);
  Value *Ret_Val = nullptr;
  if (inst->GetTypeEnum() != InnerDataType::IR_Value_VOID) {
    for (BasicBlock *block : blocks) {
      User *inst = block->back();
      if (dynamic_cast<RetInst *>(inst)) {
        if (auto val = inst->GetOperand(0)) {
          tmp.first = val;
        }
        UnCondInst *Br = new UnCondInst(SplitBlock);
        inst->ClearRelation();
        inst->EraseFromParent();
        block->push_back(Br);
      }
    }
  } else {
    for (BasicBlock *block : blocks) {
      User *inst = block->back();
      if (dynamic_cast<RetInst *>(inst)) {
        UnCondInst *Br = new UnCondInst(SplitBlock);
        inst->ClearRelation();
        inst->EraseFromParent();
        block->push_back(Br);
      }
    }
  }
  if (dynamic_cast<UnCondInst *>(Jump)) {
    BasicBlock *bb = Jump->GetOperand(0)->as<BasicBlock>();
    auto iter = bb->begin();
    while (auto phi = dynamic_cast<PhiInst *>(*iter)) {
      phi->ModifyBlock(block, SplitBlock);
      ++iter;
    }
  } else if (dynamic_cast<CondInst *>(Jump)) {
    BasicBlock *bb = Jump->GetOperand(1)->as<BasicBlock>();
    auto iter = bb->begin();
    while (auto phi = dynamic_cast<PhiInst *>(*iter)) {
      phi->ModifyBlock(block, SplitBlock);
      ++iter;
    }
    BasicBlock *bb1 = Jump->GetOperand(2)->as<BasicBlock>();
    auto iter1 = bb1->begin();
    while (auto phi = dynamic_cast<PhiInst *>(*iter1)) {
      phi->ModifyBlock(block, SplitBlock);
      ++iter1;
    }
  }
  return tmp;
}

BuildInFunction::BuildInFunction(Type *tp, std::string _id) : Value(tp) {
  name = _id;
  if (name == "starttime" || name == "stoptime")
    name = "_sysy_" + name;
}

BuildInFunction *BuildInFunction::GetBuildInFunction(std::string _id) {
  static std::map<std::string, BuildInFunction *> mp;
  auto get_type = [&_id]() -> Type * {
    if (_id == "getint")
      return IntType::NewIntTypeGet();
    if (_id == "getfloat")
      return FloatType::NewFloatTypeGet();
    if (_id == "getch")
      return IntType::NewIntTypeGet();
    if (_id == "getarray")
      return IntType::NewIntTypeGet();
    if (_id == "getfarray")
      return IntType::NewIntTypeGet();
    if (_id == "putint")
      return VoidType::NewVoidTypeGet();
    if (_id == "putch")
      return VoidType::NewVoidTypeGet();
    if (_id == "putarray")
      return VoidType::NewVoidTypeGet();
    if (_id == "putfloat")
      return VoidType::NewVoidTypeGet();
    if (_id == "putfarray")
      return VoidType::NewVoidTypeGet();
    if (_id == "starttime")
      return VoidType::NewVoidTypeGet();
    if (_id == "stoptime")
      return VoidType::NewVoidTypeGet();
    if (_id == "putf")
      return VoidType::NewVoidTypeGet();
    if (_id == "llvm.memcpy.p0.p0.i32")
      return VoidType::NewVoidTypeGet();
    if (_id == "memcpy@plt")
      return VoidType::NewVoidTypeGet();
    if (_id == "buildin_NotifyWorkerLE")
      return VoidType::NewVoidTypeGet();
    if (_id == "buildin_NotifyWorkerLT")
      return VoidType::NewVoidTypeGet();
    if (_id == "buildin_FenceArgLoaded")
      return VoidType::NewVoidTypeGet();
    if (_id == "buildin_AtomicF32add")
      return VoidType::NewVoidTypeGet();
    if(_id == "CacheLookUp")
      return VoidType::NewVoidTypeGet();
  
    assert(0);
  };
  if (mp.find(_id) == mp.end()) {
    mp[_id] = new BuildInFunction(get_type(), _id);
  }
  return mp[_id];
}

Function::Function(InnerDataType _tp, std::string _id)
    : Value(Type::NewTypeByEnum(_tp)) {
  name = _id;
  //至少有一个bbs
  push_back(new BasicBlock());
}

bool BasicBlock::EndWithBranch() {
  if (auto data = dynamic_cast<UnCondInst *>(back()))
    return 1;
  else if (auto data = dynamic_cast<CondInst *>(back()))
    return 1;
  else if (auto data = dynamic_cast<RetInst *>(back()))
    return 1;
  else
    return 0;
}

void BasicBlock::RemovePredBB(BasicBlock *pred) {
  //不能自己删除自己
  if (pred == this) {
    for (auto iter = pred->begin();
         iter != pred->end() && dynamic_cast<PhiInst *>(*iter);) {
      auto phi = dynamic_cast<PhiInst *>(*iter);
      ++iter;
      phi->EraseRecordByBlock(pred);
      if (phi->PhiRecord.size() == 1) {
        BasicBlock *b = phi->PhiRecord.begin()->second.second;
        if (b == this) {
          phi->RAUW(UndefValue::get(phi->GetType()));
          delete phi;
        } else {
          Value *repl = (*(phi->PhiRecord.begin())).second.first;
          if (repl == phi)
            phi->RAUW(UndefValue::get(phi->GetType()));
          phi->RAUW(repl);
          delete phi;
        }
      }
    }
    return;
  }
  for (auto iter = this->begin(); iter != this->end(); ++iter) {
    auto inst = *iter;
    if (auto phi = dynamic_cast<PhiInst *>(this->front())) {
      auto tmp = std::find_if(
          phi->PhiRecord.begin(), phi->PhiRecord.end(),
          [pred](const std::pair<int, std::pair<Value *, BasicBlock *>> &ele) {
            return ele.second.second == pred;
          });
      if (tmp != phi->PhiRecord.end()) {
        phi->Del_Incomes(tmp->first);
        phi->FormatPhi();
      }
      if (phi->PhiRecord.size() == 1) {
        //如果删除后还剩一个operand,检查是否是循环
        BasicBlock *b = phi->PhiRecord.begin()->second.second;
        if (b == this) {
          phi->RAUW(UndefValue::get(phi->GetType()));
          delete phi;
        } else {
          Value *repl = (*(phi->PhiRecord.begin())).second.first;
          if (repl == phi)
            phi->RAUW(UndefValue::get(phi->GetType()));
          phi->RAUW(repl);
          delete phi;
        }
      }
    } else
      return;
  }
}
void BasicBlock::GenerateCondInst(Operand condi, BasicBlock *is_true,
                                  BasicBlock *is_false) {
  auto inst = new CondInst(condi, is_true, is_false);
  push_back(inst);
}
void BasicBlock::GenerateUnCondInst(BasicBlock *des) {
  auto inst = new UnCondInst(des);
  push_back(inst);
}
void BasicBlock::GenerateRetInst(Operand ret_val) {
  if (GetParent()->GetTypeEnum() != ret_val->GetTypeEnum()) {
    if (ret_val->GetTypeEnum() == IR_Value_INT)
      ret_val = GenerateSITFP(ret_val);
    else
      ret_val = GenerateFPTSI(ret_val);
  }
  auto inst = new RetInst(ret_val);
  push_back(inst);
}
void BasicBlock::GenerateRetInst() {
  auto inst = new RetInst();
  push_back(inst);
}

Operand BasicBlock::GenerateCallInst(std::string id, std::vector<Operand> args,
                                     int run_time) {
  auto check_builtin = [](std::string _id) {
    if (_id == "getint")
      return true;
    if (_id == "getfloat")
      return true;
    if (_id == "getch")
      return true;
    if (_id == "getarray")
      return true;
    if (_id == "getfarray")
      return true;
    if (_id == "putint")
      return true;
    if (_id == "putch")
      return true;
    if (_id == "putarray")
      return true;
    if (_id == "putfloat")
      return true;
    if (_id == "putfarray")
      return true;
    if (_id == "starttime")
      return true;
    if (_id == "stoptime")
      return true;
    if (_id == "putf")
      return true;
    if (_id == "llvm.memcpy.p0.p0.i32")
      return true;
    return false;
  };

  if (check_builtin(id)) {
    if (id == "starttime" || id == "stoptime") {
      assert(args.size() == 0);
      args.push_back(ConstIRInt::GetNewConstant(run_time));
    }
    /*
    int as first arg
    putint
    putch
    putarray
    putfarray

    float as first arg
    putfloat
    */
    if (id == "putint" || id == "putch" || id == "putarray" ||
        id == "putfarray") {
      if (args[0]->GetTypeEnum() == IR_Value_Float)
        args[0] = GenerateFPTSI(args[0]);
    }
    if (id == "putfloat") {
      if (args[0]->GetTypeEnum() == IR_Value_INT)
        args[0] = GenerateSITFP(args[0]);
    }
    auto tmp = new CallInst(BuildInFunction::GetBuildInFunction(id), args,
                            "at" + std::to_string(run_time));
    push_back(tmp);
    return tmp->GetDef();
  }
  if (auto func =
          dynamic_cast<Function *>(Singleton<Module>().GetValueByName(id))) {
    auto &params = func->GetParams();
    assert(args.size() == params.size());
    auto i = args.begin();
    for (auto j = params.begin(); j != params.end(); j++, i++) {
      auto &ii = *i;
      auto jj = j->get();
      if (jj->GetType() != ii->GetType()) {
        auto a = ii->GetType()->GetTypeEnum(), b = jj->GetType()->GetTypeEnum();
        // if(a!=IR_Value_INT&&a!=IR_Value_Float)
        // {
        //     std::cerr<<"Error\n";
        //     ii->GetType()->print();//float
        //     jj->GetType()->print();//i32
        //     std::cout.flush();
        //     assert(0);
        // }
        assert(a == IR_Value_INT || a == IR_Value_Float);
        assert(b == IR_Value_INT || b == IR_Value_Float);
        if (b == IR_Value_Float)
          ii = GenerateSITFP(ii);
        else
          ii = GenerateFPTSI(ii);
      }
    }
    auto inst = new CallInst(func, args, "at" + std::to_string(run_time));
    push_back(inst);
    return inst->GetDef();
  } else {
    std::cerr << "No Such Function!\n";
    assert(0);
  }
}

void BasicBlock::Delete() {
  // assert(GetUserlist().is_empty() && "It should not be used when human
  // delete");
  this->~BasicBlock();
}

Operand BasicBlock::GenerateGEPInst(Operand ptr) {
  auto tmp = new GetElementPtrInst(ptr);
  push_back(tmp);
  return tmp->GetDef();
}
Operand BasicBlock::GenerateZextInst(Operand ptr) {
  auto tmp = new ZextInst(ptr);
  push_back(tmp);
  return tmp->GetDef();
}

AllocaInst *BasicBlock::GenerateAlloca(Type *_tp, std::string ID) {
  auto tp = PointerType::NewPointerTypeGet(_tp);
  auto alloca = new AllocaInst(tp);
  Singleton<Module>().Register(ID, alloca);
  GetParent()->front()->push_front(alloca);
  return alloca;
}

BasicBlock *BasicBlock::clone(std::unordered_map<Operand, Operand> &mapping) {
  if (mapping.find(this) != mapping.end())
    return dynamic_cast<BasicBlock *>(mapping[this]);
  auto tmp = new BasicBlock();
  mapping[this] = tmp;
  for (auto i : (*this))
    tmp->push_back(dynamic_cast<User *>(i->clone(mapping)));
  return tmp;
}

int BasicBlock::GetSuccNum() {
  if (dynamic_cast<CondInst *>(this->back()))
    return 2;
  else if (dynamic_cast<UnCondInst *>(this->back()))
    return 1;
  else
    return 0;
}

void BasicBlock::clear() {
  for (auto inst : *this)
    assert(inst->GetUserListSize() == 0 && "Check No User Fail");
  mylist<BasicBlock, User>::clear();
}

PhiInst *PhiInst::NewPhiNode(User *BeforeInst, BasicBlock *currentBB,
                             std::string Name) {
  PhiInst *tmp = new PhiInst{BeforeInst};
  for (auto iter = currentBB->begin(); iter != currentBB->end(); ++iter) {
    if (*iter == BeforeInst)
      iter.insert_before(tmp);
  }
  if (!Name.empty())
    tmp->SetName(Name);
  tmp->id = OpID::Phi;
  return tmp;
}

PhiInst *PhiInst::NewPhiNode(User *BeforeInst, BasicBlock *currentBB, Type *ty,
                             std::string Name) {
  PhiInst *tmp = new PhiInst(BeforeInst, ty);

  for (auto iter = currentBB->begin(); iter != currentBB->end(); ++iter) {
    if (*iter == BeforeInst) {
      iter.insert_before(tmp);
      break;
    }
  }
  if (!Name.empty())
    tmp->SetName(Name);
  tmp->id = OpID::Phi;
  return tmp;
}

PhiInst *PhiInst::NewPhiNode(Type *ty) {
  assert(ty);
  PhiInst *tmp = new PhiInst(ty);
  tmp->id = OpID::Phi;
  return tmp;
}

void PhiInst::updateIncoming(Value *Income, BasicBlock *BB) {
  add_use(Income);
  auto &use = uselist.back();
  PhiRecord[oprandNum] = std::make_pair(Income, BB);
  UseToRecord[use.get()] = oprandNum;
  oprandNum++;
}
/// @brief 找到当前phi函数bb块所对应的数据流
Value *PhiInst::ReturnValIn(BasicBlock *bb) {
  auto it = std::find_if(
      PhiRecord.begin(), PhiRecord.end(),
      [bb](const std::pair<const int, std::pair<Value *, BasicBlock *>> &ele) {
        return ele.second.second == bb;
      });
  if (it == PhiRecord.end())
    return nullptr;
  return it->second.first;
}

BasicBlock *PhiInst::ReturnBBIn(Use *use) {
  int num = UseToRecord[use];
  return PhiRecord[num].second;
}

std::vector<Value *> &PhiInst::GetAllPhiVal() {
  Incomings.clear();
  Blocks.clear();
  for (const auto &[_1, value] : PhiRecord) {
    Incomings.push_back(value.first);
    Blocks.push_back(value.second);
  }
  IsGetIncomings = true;
  return Incomings;
}

//将原来的origin值替换为newval
void PhiInst::Phiprop(Value *origin, Value *newval) {
  auto iter = std::find_if(
      PhiRecord.begin(), PhiRecord.end(),
      [=](const std::pair<int, std::pair<Value *, BasicBlock *>> &ele) {
        return ele.second.first == origin;
      });
  if (iter == PhiRecord.end())
    assert(0);
  BasicBlock *block = iter->second.second;
  int Num = iter->first;
  PhiRecord[Num] = std::make_pair(newval, block);
}

void PhiInst::ReplaceVal(Use *use, Value *new_val) {
  assert(UseToRecord.find(use) != UseToRecord.end());
  auto index = UseToRecord[use];
  RSUW(use, new_val);
  PhiRecord[index].first = new_val;
}

void PhiInst::Del_Incomes(int CurrentNum) {
  if (PhiRecord.find(CurrentNum) != PhiRecord.end()) {
    auto iter = std::find_if(
        uselist.begin(), uselist.end(), [=](const std::unique_ptr<Use> &ele) {
          return ele->GetValue() == PhiRecord[CurrentNum].first;
        });
    auto &vec = Getuselist();
    // (*iter)->RemoveFromUserList((*iter)->GetUser());
    for (int i = 0; i < vec.size(); i++)
      if (vec[i].get() == (*iter).get())
        vec.erase(std::remove(vec.begin(), vec.end(), (*iter)));
    PhiRecord.erase(CurrentNum);
    auto i = std::find_if(
        UseToRecord.begin(), UseToRecord.end(),
        [CurrentNum](auto &ele) { return ele.second == CurrentNum; });
    if (i != UseToRecord.end()) {
      UseToRecord.erase(i);
    }
  } else
    std::cerr << "No such PhiRecord" << std::endl;
}

void PhiInst::FormatPhi() {
  std::vector<std::pair<int, std::pair<Value *, BasicBlock *>>> assist;
  std::queue<std::pair<Value *, BasicBlock *>> defend;
  UseToRecord.clear();
  oprandNum = 0;
  for (auto &[_1, v] : PhiRecord) {
    assist.push_back(std::make_pair(_1, v));
    // defend.push(std::make_pair(v.first, v.second));
  }
  std::sort(assist.begin(), assist.end(),
            [](const auto &p1, const auto &p2) { return p1.first < p2.first; });
  PhiRecord.clear();
  for (int i = 0; i < assist.size(); i++) {
    defend.push(
        std::make_pair(assist[i].second.first, assist[i].second.second));
  }
  while (!defend.empty()) {
    auto &[v_fir, v_sec] = defend.front();
    defend.pop();
    PhiRecord[oprandNum++] = std::make_pair(v_fir, v_sec);
  }
  int tmp = 0;
  for (auto &use : uselist) {
    UseToRecord[use.get()] = tmp++;
  }
}

bool PhiInst::IsSame(PhiInst *phi) {
  if (this->oprandNum != phi->oprandNum)
    return false;
  for (auto &[_1, v] : PhiRecord) {
    Value *val = v.first;
    BasicBlock *bb = v.second;
    if (phi->ReturnValIn(bb) == nullptr || phi->ReturnValIn(bb) != val)
      return false;
  }
  return true;
}

BasicBlock *PhiInst::GetBlock(int index) {
  auto &[v, bb] = PhiRecord[index];
  return bb;
}

Value *PhiInst::GetVal(int index) {
  auto &[v, bb] = PhiRecord[index];
  return v;
}

void PhiInst::ModifyBlock(BasicBlock *Old, BasicBlock *New) {
  auto it1 = std::find_if(
      PhiRecord.begin(), PhiRecord.end(),
      [Old](const std::pair<int, std::pair<Value *, BasicBlock *>> &ele) {
        return ele.second.second == Old;
      });
  if (it1 == PhiRecord.end())
    return;
  //将value对应的块信息更改
  it1->second.second = New;
}

void PhiInst::EraseRecordByBlock(BasicBlock *block) {
  for (auto [index, record] : PhiRecord) {
    if (record.second == block) {
      this->Del_Incomes(index);
      this->FormatPhi();
      return;
    }
  }
}
void PhiInst::ModifyBlock_CheckSame(BasicBlock *Old, BasicBlock *New) {
  bool flag = false;
  Value *old_val = nullptr;
  int index = -1;
  for (auto &[key, val] : PhiRecord) {
    if (val.second == Old) {
      old_val = val.first;
      index = key;
      break;
    }
  }

  std::pair<Value *, BasicBlock *> Pair{old_val, New};
  for (auto &[key, val] : PhiRecord) {
    if (val.second == New) {
      flag = true;
      PhiRecord.erase(index);
      oprandNum--;
      break;
    }
  }
  if (flag)
    return;
  PhiRecord[index] = Pair;
  return;
}

std::pair<size_t, size_t> &Function::GetInlineInfo() {
  // codesize,framesize
  if (inlineinfo.first == 0) {
    for (auto bb : *this) {
      for (auto inst : *bb) {
        inlineinfo.first++;
        if (auto alloca = dynamic_cast<AllocaInst *>(inst))
          inlineinfo.second += dynamic_cast<PointerType *>(alloca->GetType())
                                   ->GetSubType()
                                   ->get_size();
      }
    }
  }
  return inlineinfo;
}

bool Function::isRecursive(bool useMem) {
  static std::unordered_map<Function *, bool> visited;

  auto calcOnce = [&]() {
    auto usrlist = GetUserlist();
    bool suc = false;
    for (auto use : usrlist) {
      if (auto call = use->GetUser()->as<CallInst>()) {
        if (call->GetParent()->GetParent() == this) {
          suc = true;
          break;
        }
      }
    }
    return suc;
  };

  if (!useMem || visited.find(this) == visited.end())
    visited[this] = calcOnce();
  return visited[this];
}

void Function::push_param(std::string realname, Variable *var) {
  auto alloca = new AllocaInst(PointerType::NewPointerTypeGet(var->GetType()));
  auto store = new StoreInst(var, alloca);
  front()->push_front(alloca);
  front()->push_back(store);
  Singleton<Module>().Register(realname, alloca);
  params.emplace_back(var);
}

void Function::PushMyParam(Variable *var) { params.emplace_back(var); }

void Function::init_visited_block() {
  for (auto bb : bbs)
    bb->visited = false;
}
void Function::init_reach_block() {
  for (auto bb : bbs)
    bb->reachable = true;
}

void Function::add_block(BasicBlock *bb) { push_back(bb); }

std::vector<std::unique_ptr<Value>> &Function::GetParams() { return params; }

bool Function::MemWrite() {
  for (auto bb : *this)
    for (auto inst : *bb) {
      if (dynamic_cast<StoreInst *>(inst))
        return true;
    }
  return false;
}

bool Function::MemRead() {
  for (auto bb : *this)
    for (auto inst : *bb) {
      if (dynamic_cast<LoadInst *>(inst) ||
          dynamic_cast<GetElementPtrInst *>(inst))
        return true;
    }
  return false;
}

std::vector<BasicBlock *> Function::GetRetBlock() {
  std::vector<BasicBlock *> tmp;
  for (const auto bb : *this) {
    auto inst = bb->back();
    if (dynamic_cast<RetInst *>(inst)) {
      tmp.push_back(bb);
      continue;
    }
  }
  return tmp;
}

void Module::Test() {
  for (auto &i : globalvaribleptr)
    i->print();
  for (auto &i : ls)
    i->print();
}

Function &Module::GenerateFunction(InnerDataType _tp, std::string _id) {
  auto tmp = new Function(_tp, _id);
  Register(_id, tmp);
  ls.push_back(FunctionPtr(tmp));
  return *ls.back();
}

void Module::Push_Func(Function *func) {
  Register(func->GetName(), func);
  ls.push_back(FunctionPtr(func));
}

void Module::EraseFunction(Function *func) {
  for (auto iter = ls.begin(); iter != ls.end(); iter++) {
    auto &Ptr = *iter;
    auto Func = Ptr.get();
    if (Func == func) {
      ls.erase(iter);
      break;
    }
  }
}

bool Module::EraseDeadFunc() {
  std::vector<Function *> erase;
  bool changed = false;
  for (auto &func : ls) {
    if (func->GetUserListSize() == 0 && func->GetName() != "main") {
      erase.push_back(func.get());
      changed = true;
    }
  }
  if (!erase.empty())
    for (auto func : erase) {
      EraseFunction(func);
    }
  return changed;
}

Function *Module::GetMainFunction() {
  for (auto &i : ls) {
    if (i->GetName() == "main")
      return i.get();
  }
  return nullptr;
}

std::string Module::GetFuncNameEnum(std::string name) {
  for (int i = 0;; i++) {
    bool HaveSameName = false;
    for (auto &func : ls) {
      if (func->GetName() == (name + "_" + std::to_string(i))) {
        HaveSameName = true;
        break;
      }
    }
    if (!HaveSameName)
      return (name + "_" + std::to_string(i));
  }
}

std::vector<std::unique_ptr<Function>> &Module::GetFuncTion() { return ls; }

std::vector<std::unique_ptr<Variable>> &Module::GetGlobalVariable() {
  return globalvaribleptr;
}

UndefValue *UndefValue::get(Type *Ty) {
  static std::map<Type *, UndefValue *> Undefs;
  UndefValue *&UV = Undefs[Ty];
  if (!UV)
    UV = new UndefValue(Ty);
  return UV;
}

UndefValue *UndefValue::clone(std::unordered_map<Operand, Operand> &mapping) {
  return this;
}

void UndefValue::print() {
  dynamic_cast<Value *>(this)->print();
  return;
}

void PhiInst::print() {
  int cnt = 0;
  dynamic_cast<Value *>(this)->print();
  std::cout << " = phi ";
  this->GetType()->print();
  std::cout << " ";
  for (auto &[_1, val] : PhiRecord) {
    std::cout << "[";
    val.first->print();
    std::cout << ", ";
    dynamic_cast<Value *>(val.second)->print();
    std::cout << "]";
    if (cnt != PhiRecord.size() - 1)
      std::cout << ", ";
    cnt++;
  }
  std::cout << "\n";
  return;
}

PhiInst *PhiInst::clone(std::unordered_map<Operand, Operand> &mapping) {
  if (mapping.find(this) != mapping.end())
    return dynamic_cast<PhiInst *>(mapping[this]);
  auto to = new PhiInst(GetType());
  mapping[this] = to;
  for (auto &[i, data] : PhiRecord) {
    to->updateIncoming(data.first->clone(mapping), data.second->clone(mapping));
  }
  to->FormatPhi();
  return to;
}