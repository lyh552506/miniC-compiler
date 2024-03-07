#include "SSAPRE.hpp"

void PRE::init_pass() {
  BuildSets();

  //
  // Insert();

  // Eliminate();
}

//论文的第一步：构建AnticOut/AnticIn/AvailIn/AvailOut
void PRE::BuildSets() {
  //First-Part---topdown traversal of the dominator tree
  for (BasicBlock *bb : Dfs) {
    auto &availout = AvailOut[bb];
    auto &genPhis = GeneratedPhis[bb];
    auto &genExps = GeneratedExps[bb];
    auto &genTemp = GeneratedTemp[bb];

    auto node = m_dom->GetNode(bb->num);
    //  Since the value leader set for the dominator
    //  will have already been determined, we can conveniently build the leader
    //  set for the current block by initializing it to the leader set of the
    //  dominator
    BasicBlock *idomBB = m_dom->GetNode(node.idom).thisBlock;
    if (idomBB != bb) //当前BB在支配树上没有父亲
      availout = AvailOut[idomBB];

    for (auto it = bb->begin(); it != bb->end(); ++it)
      CaculateAvailOut(*it, availout, genExps, genTemp, genPhis);
  }
  //Second Part
  bool changed=true;

  while(changed){
    changed=false;
    
  }


}

//论文中的canno单个实现过于复杂，我们通过保持相关VNset不变量的方式
//逐个遍历指令加入各个value leader
void PRE::CaculateAvailOut(User *inst, ValueNumberedSet &avail,
                           ValueNumberedSet &genexp, ValueNumberedSet &gentemp,
                           ValueNumberedSet &genphis) {
  if (auto phi = dynamic_cast<PhiInst *>(inst)) {
    int hash = VN->LookupOrAdd(phi);

    genphis.insert_val(inst);
    genphis.set(hash);
  } else if (auto bin = dynamic_cast<BinaryInst *>(inst)) {
    int hash_inst = VN->LookupOrAdd(inst);

    if (!genexp.IsAlreadyInsert(hash_inst)) {
      genexp.insert_val(inst);
      genexp.set(hash_inst);
    }
    if (dynamic_cast<User *>(bin->Getuselist()[0]->GetValue())) {
      int hash_left = VN->LookupOrAdd(bin->Getuselist()[0]->GetValue());
      if (!genexp.IsAlreadyInsert(hash_left)) {
        genexp.insert_val(bin->Getuselist()[0]->GetValue());
        genexp.set(hash_left);
      }
    }
    if (dynamic_cast<User *>(bin->Getuselist()[1]->GetValue())) {
      int hash_right = VN->LookupOrAdd(bin->Getuselist()[1]->GetValue());
      if (!genexp.IsAlreadyInsert(hash_right)) {
        genexp.insert_val(bin->Getuselist()[1]->GetValue());
        genexp.set(hash_right);
      }
    }
  } else if (auto gep = dynamic_cast<GetElementPtrInst *>(inst)) {
    int hash_inst = VN->LookupOrAdd(inst);
    if (!genexp.IsAlreadyInsert(hash_inst)) {
      genexp.insert_val(inst);
      genexp.set(hash_inst);
    }
    Value *ArrayPtr = gep->Getuselist()[0]->GetValue();
    if (dynamic_cast<User *>(ArrayPtr)) {
      int hash_ptr = VN->LookupOrAdd(ArrayPtr);
      if (!genexp.IsAlreadyInsert(hash_ptr)) {
        genexp.insert_val(ArrayPtr);
        genexp.set(hash_inst);
      }
    }
    //处理args vector
    for (int i = 1; i < gep->Getuselist().size(); i++) {
      Value *args = gep->Getuselist()[i]->GetValue();
      if (dynamic_cast<User *>(args)) {
        int hash_arg = VN->LookupOrAdd(args);
        if (!genexp.IsAlreadyInsert(hash_arg)) {
          genexp.insert_val(args);
          genexp.set(hash_inst);
        }
      }
    }
  } else if(!inst->IsTerminateInst()){/// @note 这里为什么会这样？
    VN->LookupOrAdd(inst);
    gentemp.insert_val(inst);
  }

  if(!inst->IsTerminateInst()){
    int num=VN->LookupOrAdd(inst);
    if(!avail.IsAlreadyInsert(num)){
      avail.insert_val(inst);
      avail.set(num);
    }
  }
}

void PRE::DfsDT(int pos) {
  Dfs.emplace_back(m_dom->node[pos].thisBlock);
  for (auto des : m_dom->node[pos].idom_child)
    if (m_dom->node[des].thisBlock->visited == false) {
      m_dom->node[des].thisBlock->visited = true;
      DfsDT(des);
    }
}

int ValueTable::LookupOrAdd(Value *val) {
  //首先查找VN是否有传入的目标value
  auto iter = ValueNumber.find(val);
  if (iter != ValueNumber.end())
    return iter->second;

  //在VN中没有找到目标value，依次枚举Value*，创建Exp
  if (auto bin = dynamic_cast<BinaryInst *>(val)) {
    Expression *e = CreatExp(bin);
    auto it = ExpNumber.find(e);
    if (it != ExpNumber.end()) {
      ValueNumber.insert(std::make_pair(val, it->second));
      return it->second;
    } else {
      ValueNumber.insert(std::make_pair(val, valuekinds));
      ExpNumber.insert(std::make_pair(e, valuekinds));
      return valuekinds++;
    }
  } else if (auto gep = dynamic_cast<GetElementPtrInst *>(val)) {
    Expression *e = CreatExp(gep);
    auto it = ExpNumber.find(e);
    if (it != ExpNumber.end()) {
      ValueNumber.insert(std::make_pair(val, it->second));
      return it->second;
    } else {
      ValueNumber.insert(std::make_pair(val, valuekinds));
      ExpNumber.insert(std::make_pair(e, valuekinds));
      return valuekinds++;
    }
  } else { //不是任何语句
    ValueNumber.insert(std::make_pair(val, valuekinds));
    return valuekinds++;
  }
}

//包含了binary和cmp
Expression *ValueTable::CreatExp(BinaryInst *bin) {
  Expression *e = new Expression();
  e->firVal = LookupOrAdd(bin->Getuselist()[0]->GetValue());
  e->SecVal = LookupOrAdd(bin->Getuselist()[1]->GetValue());
  e->ThirdVal = 0;
  e->type = bin->GetType();
  e->op = static_cast<Expression::ExpOpration>(
      static_cast<int>(bin->GetOpcode(bin)));
  return e;
}

Expression *ValueTable::CreatExp(GetElementPtrInst *gep) {
  Expression *e = new Expression();
  e->firVal = LookupOrAdd(gep->Getuselist()[0]->GetValue());
  e->SecVal = 0;
  e->ThirdVal = 0;
  e->op = Expression::Gep;
  e->type = gep->GetType();
  for (int i = 1; i < gep->Getuselist().size(); i++)
    e->args.emplace_back(gep->Getuselist()[i]->GetValue());
  return e;
}