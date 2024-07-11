#include "../../include/ir/opt/SSAPRE.hpp"

#include <algorithm>
#include <cstddef>
#include <cstdlib>
#include <iostream>
#include <utility>
#include <vector>

#include "../../include/lib/BaseCFG.hpp"
#include "../../include/lib/CFG.hpp"
#include "../../include/lib/Singleton.hpp"

/// @brief flag=1 -->GetLeftChild
///        flag=0 -->GetRightChild
BasicBlock *PRE::GetChild(BasicBlock *BB, int flag) {
  if (flag == 1) {
    if (auto tmp = dynamic_cast<UnCondInst *>(BB->back()))
      return dynamic_cast<BasicBlock *>(tmp->Getuselist()[0]->GetValue());
    else if (auto tmp = dynamic_cast<CondInst *>(BB->back()))
      return dynamic_cast<BasicBlock *>(tmp->Getuselist()[1]->GetValue());
    else
      return nullptr;
  } else {
    if (auto tmp = dynamic_cast<CondInst *>(BB->back()))
      return dynamic_cast<BasicBlock *>(tmp->Getuselist()[2]->GetValue());
    else
      return nullptr;
  }
}

void PRE::CalculatePredBB(BasicBlock *bb) {
  for (auto node : m_dom->GetNode(bb->num).rev)
    if (m_dom->GetNode(node).thisBlock->visited == false) {
      m_dom->GetNode(node).thisBlock->visited = true;
      Preds.push_back(m_dom->GetNode(node).thisBlock);
      CalculatePredBB(m_dom->GetNode(node).thisBlock);
    }
}

void PRE::CleanMemory() {
  for (int i = 0; i < gen_exp.size(); i++) {
    auto tmp = gen_exp[i];
    gen_exp[i] = gen_exp[gen_exp.size() - 1];
    gen_exp.pop_back();
    i--;
    if (tmp.second == false)
      delete tmp.first;
  }
}

void PRE::init_pass() {
  BuildSets();

  Insert();

  Elimination();

  CleanMemory();
}

void PRE::BuildSets() {
  std::map<BasicBlock *, ValueNumberedSet> GeneratedExps;
  // First-Part---topdown traversal of the dominator tree
  for (BasicBlock *bb : Dfs) {
    auto &availout = AvailOut[bb];
    auto &genPhis = GeneratedPhis[bb];
    auto &genExps = GeneratedExps[bb];
    auto &genTemp = GeneratedTemp[bb];
    auto node = m_dom->GetNode(bb->num);

    BasicBlock *idomBB = m_dom->GetNode(node.idom).thisBlock;
    if (idomBB != bb) //当前BB在支配树上没有父亲
      availout = AvailOut[idomBB];

    for (auto it = bb->begin(); it != bb->end(); ++it)
      CalculateAvailOut(*it, availout, genExps, genTemp, genPhis);
  }
  // Second Part
  bool changed = true;
  //记录需要计算AnticIn的block集合
  std::set<BasicBlock *> CalculateAntic;
  std::set<BasicBlock *> visited;
  for (auto I = m_func->begin(); I != m_func->end(); ++I)
    CalculateAntic.insert(*I);
  //迭代数据流
  while (changed) {
    changed = false;
    ValueNumberedSet AnticOut;
    //此处采用后续遍历CFG,因为没有采用后支配树的遍历，所以添加Delay标志
    for (BasicBlock *post : PostOrder) {
      auto it = CalculateAntic.find(post);
      if (it == CalculateAntic.end())
        continue;
      RetStats stat =
          CalculateAnticIn(post, AnticOut, visited, GeneratedExps[post]);
      //如果为delay代表当前需要延迟求这个block，循环需要继续进行
      if (stat == Delay) {
        changed = true;
        continue;
      } else if (stat == Changed) { //对于change的block，因为数据流有更新，
        changed = true; //所以需要重新将他的前驱块加入进来
        visited.insert(post);
        m_func->init_visited_block();
        Preds.clear();
        CalculatePredBB(post);
        for (BasicBlock *bb : Preds)
          CalculateAntic.insert(bb);
      } else { // stat == unchanged
        visited.insert(post);
        CalculateAntic.erase(it);
      }
    }
  }
}

void PRE::Insert() {
  bool changed = true;
  while (changed) {
    changed = false;
    for (auto bb : Dfs) {
      std::map<BasicBlock *, ValueNumberedSet> insert_set;
      if (m_dom->GetNode(bb->num).idom != bb->num) {
        BasicBlock *idom =
            m_dom->GetNode(m_dom->GetNode(bb->num).idom).thisBlock;
        ValueNumberedSet &set = insert_set[idom];
        for (auto tmp = set.contents.begin(); tmp != set.contents.end();
             tmp++) {
          if (!insert_set[bb].IsAlreadyInsert(VN->LookupOrAdd(*tmp))) {
            Value *lead = Find_Leader(insert_set[bb], *tmp);
            if (lead != nullptr) {
              insert_set[bb].insert_val(*tmp);
              insert_set[bb].set_hash(VN->LookupOrAdd(*tmp));
            }
          }
          if (!AvailOut[bb].IsAlreadyInsert(VN->LookupOrAdd(*tmp))) {
            Value *lead = Find_Leader(AvailOut[bb], *tmp);
            if (lead != nullptr) {
              AvailOut[bb].insert_val(*tmp);
              AvailOut[bb].set_hash(VN->LookupOrAdd(*tmp));
            }
          }
        }
      }
      int PredNum = std::distance(m_dom->GetNode(bb->num).rev.begin(),
                                  m_dom->GetNode(bb->num).rev.end());
      // Insertions happen only at merge points,即需要当前块有多个前驱
      if (PredNum > 1) {
        //此处选择AnticIn集合而不是AvailIn集合进行处理的原因：
        // AnticIn集合表示程序点p出发的所有路径最终都会计算表达式`b+c`的值
        //             A
        //           /   \
        //          B     C
        //           \   /
        //             D
        //此时处理D的AnticIn集合，并选择能提升(hoist)到他的所有前驱的exp
        BuidTopuSet(AnticipatedIn[bb]);
        RetStats stat = IdentyPartilRedundancy(bb, insert_set);
        if (stat == Changed)
          changed = true;
      }
    }
  }
}

void PRE::Elimination() {
  std::vector<std::pair<User *, User *>> replace;
  for (auto bb : Dfs)
    for (auto iter = bb->begin(); iter != bb->end(); ++iter) {
      User *tmp = *iter;
      if (dynamic_cast<GetElementPtrInst *>(tmp) ||
          dynamic_cast<BinaryInst *>(tmp)) {
        if (AvailOut[bb].IsAlreadyInsert(VN->LookupOrAdd(tmp)) &&
            !AvailOut[bb].contents.count(tmp)) {
          Value *leader = Find_Leader(AvailOut[bb], tmp);
          auto user = dynamic_cast<User *>(leader);
          if (user && user->GetParent() != nullptr)
            replace.push_back(std::make_pair(tmp, user));
        }
      }
    }
  while (replace.size() > 0) {
    auto &val = replace.back();
    replace.pop_back();
#ifdef DEBUG
    std::cerr << "Erase Value: " << val.first->GetName() << std::endl;
#endif
    val.first->RAUW(val.second);
    val.first->EraseFromParent();
  }
}

bool PRE::Run() {
  m_dom = AM.get<dominance>(m_func);
  BasicBlock *Entry = m_func->front();
  auto entrynode = &(m_dom->GetNode(Entry->num));
  m_func->init_visited_block();
  DfsDT(0);
  m_func->init_visited_block();
  PostOrderCFG(m_func->front());
  init_pass();
  return false;
}

RetStats PRE::IdentyPartilRedundancy(
    BasicBlock *cur, std::map<BasicBlock *, ValueNumberedSet> &insert_set) {
  for (auto val : TopuOrder) {
    // For a non-simple expression, we consider the equivalent expressions in
    // the predecessors
    if (dynamic_cast<GetElementPtrInst *>(val) ||
        dynamic_cast<BinaryInst *>(val)) {
      //遍历所有的前驱
      bool AllPathSame = true;
      bool SomePathSame = false;
      std::map<BasicBlock *, Value *> predAvail;
      for (auto p : m_dom->GetNode(cur->num).rev) {
        BasicBlock *pred = m_dom->GetNode(p).thisBlock;
        Value *newval = phi_translate(pred, cur, val);
        Value *v = Find_Leader(AvailOut[pred], newval);
        //如果在其中一个前驱没有该表达式，则在此处不是available
        //代表后续我们需要在这个块添加一条指令，在当前块添加phi
        if (v == nullptr) {
          if (predAvail.find(pred) != predAvail.end())
            predAvail.erase(pred);
          AllPathSame = false;
          predAvail.insert(std::make_pair(pred, newval));
        } else {
          if (predAvail.find(pred) != predAvail.end())
            predAvail.erase(pred);
          SomePathSame = true;
          predAvail.insert(std::make_pair(pred, v));
        }
      }
      //存在至少一条路径可用并且不是所有路径可用时，识别为部分冗余
      if (!AllPathSame && SomePathSame &&
          !GeneratedPhis[cur].IsAlreadyInsert(VN->LookupOrAdd(val)) &&
          CanBeElim(val)) {
        if (FixPartialRedundancy(val, cur, predAvail, insert_set))
          return Unchanged;
        return Changed;
      }
    }
  }
  return Unchanged;
}

bool PRE::CanBeElim(Value *val) {
  if (auto user = dynamic_cast<User *>(val)) {
    for (auto &use : user->Getuselist()) {
      if (dynamic_cast<LoadInst *>(use->GetValue()) ||
          dynamic_cast<CallInst *>(use->GetValue())) {
        return false;
      }
    }
  }
  return true;
}

/// @brief 将识别出的部分冗余改写
bool PRE::FixPartialRedundancy(
    Value *val, BasicBlock *cur, std::map<BasicBlock *, Value *> &predAvail,
    std::map<BasicBlock *, ValueNumberedSet> &insert_set) {
  Type *ty = nullptr;
  User *ready2Relp = nullptr;
  int nul = 0; //初始为0，无效为2
  for (auto p : m_dom->GetNode(cur->num).rev) {
    BasicBlock *pred = m_dom->GetNode(p).thisBlock;
    Value *v = predAvail[pred];
    if (!AvailOut[pred].IsAlreadyInsert(VN->LookupOrAdd(v))) {
      //因为后续需要创建一条新的指令，此时需要查看inst的各个操作数是否出现过
      User *inst = dynamic_cast<User *>(v);
      Value *op_1 = nullptr, *op_2 = nullptr;
      ready2Relp = inst;
      if (inst->GetUserlist().is_empty() && inst->GetParent() == nullptr)
        return true;
      if (dynamic_cast<BinaryInst *>(GetOperand(inst, 0)) ||
          dynamic_cast<GetElementPtrInst *>(GetOperand(inst, 0)))
        op_1 = Find_Leader(AvailOut[pred], GetOperand(inst, 0));
      else
        op_1 = GetOperand(inst, 0);
      if (op_1 == nullptr)
        nul = 2;
      if (dynamic_cast<BinaryInst *>(inst)) {
        if (dynamic_cast<BinaryInst *>(GetOperand(inst, 1)) ||
            dynamic_cast<GetElementPtrInst *>(GetOperand(inst, 1)))
          op_2 = Find_Leader(AvailOut[pred], GetOperand(inst, 1));
        else
          op_2 = GetOperand(inst, 1);
        if (op_2 == nullptr)
          nul = 2;
      }
      std::vector<Value *> args;
      if (dynamic_cast<GetElementPtrInst *>(inst))
        for (int i = 1; i < inst->Getuselist().size(); i++) {
          Value *arg = GetOperand(inst, i);
          if (dynamic_cast<BinaryInst *>(arg) ||
              dynamic_cast<GetElementPtrInst *>(arg))
            args.push_back(Find_Leader(AvailOut[pred], arg));
          else
            args.push_back(arg);
        }
      for (auto arg : args) {
        if (arg == nullptr) {
          nul = 2;
          break;
        }
      }
      if (nul == 2) {
        int a = 0;
        return nul;
      }
      User *newval = nullptr;
      if (auto bin = dynamic_cast<BinaryInst *>(inst))
        newval = new BinaryInst(op_1, bin->getopration(), op_2);
      else if (auto gep = dynamic_cast<GetElementPtrInst *>(inst))
        newval = new GetElementPtrInst(op_1, args);
      else
        assert(0);

      auto tmp = pred->rbegin();
      tmp.insert_before(newval);
#ifdef DEBUG
      std::cerr << "insert:" << newval->GetName() << "  at  "
                << newval->GetParent()->GetName() << std::endl;
#endif
      VN->Add(newval, VN->LookupOrAdd(inst));
      if (ty == nullptr && dynamic_cast<BinaryInst *>(newval))
        ty = dynamic_cast<Type *>(newval->GetType());
      else if (ty == nullptr && dynamic_cast<GetElementPtrInst *>(newval))
        ty = dynamic_cast<Type *>(newval->GetType());
      // replace val in leader set
      ValueNumberedSet &newi = insert_set[pred];
      ValueNumberedSet &oldi = AvailOut[pred];

      if (!newi.contents.count(newval)) {
        Value *lead = Find_Leader(newi, newval);
        if (lead != nullptr)
          newi.erase_val(lead);
        newi.insert_val(newval);
        newi.set_hash(VN->LookupOrAdd(newval));
      }

      if (!oldi.contents.count(newval)) {
        Value *lead = Find_Leader(oldi, newval);
        if (lead != nullptr)
          oldi.erase_val(lead);
        oldi.insert_val(newval);
        oldi.set_hash(VN->LookupOrAdd(newval));
      }
      predAvail[pred] = newval;
    }
  }

  //在此处创建phiNode
  PhiInst *phi = PhiInst::NewPhiNode(cur->front(), cur, ty);
#ifdef DEBUG
  std::cerr << "insert phi:" << phi->GetName() << "  at  "
            << phi->GetParent()->GetName() << std::endl;
#endif
  for (auto p : m_dom->GetNode(cur->num).rev) {
    BasicBlock *pred = m_dom->GetNode(p).thisBlock;
    phi->updateIncoming(predAvail[pred], pred);
  }
  VN->Add(phi, VN->LookupOrAdd(val));
  AvailOut[cur].insert_val(phi);
  AvailOut[cur].set_hash(VN->LookupOrAdd(phi));
  GeneratedPhis[cur].insert_val(phi);
  GeneratedPhis[cur].set_hash(VN->LookupOrAdd(phi));
  insert_set[cur].insert_val(phi);
  insert_set[cur].set_hash(VN->LookupOrAdd(phi));
  return nul;
}

void PRE::check(const Value *val) {
  auto iter = std::find_if(
      gen_exp.begin(), gen_exp.end(),
      [val](const std::pair<Value *, bool> &ele) { return ele.first == val; });
  if (iter != gen_exp.end())
    iter->second = true;
}

// ANTIC IN[b] = clean(canone(ANTIC OUT[b] ∪ EXP GEN[b]−TMP GEN(b)))
RetStats PRE::CalculateAnticIn(BasicBlock *bb, ValueNumberedSet &AnticOut,
                               std::set<BasicBlock *> &visited,
                               ValueNumberedSet &genexp) {
  //要计算Antic_In set首先需要求出Antic_Out
  auto &gen_tmp = GeneratedTemp[bb];
  auto &anticin = AnticipatedIn[bb];
  int o_size = anticin.contents.size(); //记录下原来的size大小，看后续是否有变化
  anticin.init();

  RetStats stat = CalculateAnticOut(bb, AnticOut, visited);
  if (stat == Delay)
    return stat;
  // ANTIC OUT[b] ,其中已经保证了Anticout的元素都是leader
  for (auto it = AnticOut.contents.begin(); it != AnticOut.contents.end();
       ++it) {
    anticin.insert_val(*it);
    anticin.set_hash(VN->LookupOrAdd(*it));
  }
  // ∪ EXP GEN[b]
  for (auto it = genexp.contents.begin(); it != genexp.contents.end(); it++) {
    if (!anticin.IsAlreadyInsert(VN->LookupOrAdd(*it))) {
      anticin.insert_val(*it);
      anticin.set_hash(VN->LookupOrAdd(*it));
    }
  }
  // −TMP GEN(b)
  for (auto it = gen_tmp.contents.begin(); it != gen_tmp.contents.end(); it++) {
    if (anticin.IsAlreadyInsert(VN->LookupOrAdd(*it))) {
      anticin.erase_val(*it);
      anticin.clear_hash(VN->LookupOrAdd(*it));
    }
  }

  clean(anticin);
  AnticOut.init();
  if (anticin.contents.size() == o_size)
    return Unchanged;
  else
    return Changed;
}

/*
  ANTIC_OUT[b]={e|e
  ∈ANTIC_IN[succ0(b)]∧∀b∈succ(b),∃e∈ANTIC_IN[b]|lookup(e)=lookup(e)},if|succ(b)|>1

  ANTIC_OUT[b]=phi_translate(A[succ(b)], b,succ(b)), if |succ(b)|=1
*/
RetStats PRE::CalculateAnticOut(BasicBlock *bb, ValueNumberedSet &AnticOut,
                                std::set<BasicBlock *> &visited) {
  int SuccNum = std::distance(m_dom->GetNode(bb->num).des.begin(),
                              m_dom->GetNode(bb->num).des.end());
  if (SuccNum == 1) {
    BasicBlock *succ =
        m_dom->GetNode(*(m_dom->GetNode(bb->num).des.begin())).thisBlock;
    // 如果后继还没有被visit，那么信息可能不齐全,此时delay
    if (succ != bb && visited.count(succ) == 0)
      return Delay;
    else {
      for (auto x = AnticipatedIn[succ].contents.begin();
           x != AnticipatedIn[succ].contents.end(); x++) {
        Value *V = phi_translate(bb, succ, *x);
        if (V != nullptr && !AnticOut.IsAlreadyInsert(VN->LookupOrAdd(V))) {
          AnticOut.insert_val(V);
          AnticOut.set_hash(VN->LookupOrAdd(V));
        }
      }
    }
  } else if (SuccNum > 1) { // the back of BB must be CondInst
    // ANTIC_IN[succ0(b)]
    BasicBlock *succ0 =
        dynamic_cast<BasicBlock *>(bb->back()->Getuselist()[1]->GetValue());
    BasicBlock *succ1 =
        dynamic_cast<BasicBlock *>(bb->back()->Getuselist()[2]->GetValue());
    for (auto tmp = AnticipatedIn[succ0].contents.begin();
         tmp != AnticipatedIn[succ0].contents.end(); ++tmp) {
      AnticOut.insert_val(*tmp);
      AnticOut.set_hash(VN->LookupOrAdd(*tmp));
    }

    std::vector<Value *> Erase;
    for (auto tmp = AnticOut.contents.begin(); tmp != AnticOut.contents.end();
         ++tmp) {
      // ∀ b∈succ(b),∃ e∈ANTIC_IN[b]|lookup(e)=lookup(e)}
      if (!AnticipatedIn[succ1].IsAlreadyInsert(VN->LookupOrAdd(*tmp)))
        Erase.push_back(*tmp);
    }

    for (auto e : Erase) {
      AnticOut.erase_val(e);
      AnticOut.clear_hash(VN->LookupOrAdd(e));
    }
  }
  return Changed;
}

//论文中的canno单个实现过于复杂，我们通过保持相关VNset不变量的方式
//逐个遍历指令加入各个value leader
void PRE::CalculateAvailOut(User *inst, ValueNumberedSet &avail,
                            ValueNumberedSet &genexp, ValueNumberedSet &gentemp,
                            ValueNumberedSet &genphis) {
  if (auto phi = dynamic_cast<PhiInst *>(inst)) {
    int hash = VN->LookupOrAdd(phi);

    genphis.insert_val(inst);
    genphis.set_hash(hash);
  } else if (auto bin = dynamic_cast<BinaryInst *>(inst)) {
    int hash_inst = VN->LookupOrAdd(inst);

    if (!genexp.IsAlreadyInsert(hash_inst)) {
      genexp.insert_val(inst);
      genexp.set_hash(hash_inst);
    }
    if (dynamic_cast<User *>(bin->Getuselist()[0]->GetValue())) {
      int hash_left = VN->LookupOrAdd(bin->Getuselist()[0]->GetValue());
      if (!genexp.IsAlreadyInsert(hash_left)) {
        genexp.insert_val(bin->Getuselist()[0]->GetValue());
        genexp.set_hash(hash_left);
      }
    }
    if (dynamic_cast<User *>(bin->Getuselist()[1]->GetValue())) {
      int hash_right = VN->LookupOrAdd(bin->Getuselist()[1]->GetValue());
      if (!genexp.IsAlreadyInsert(hash_right)) {
        genexp.insert_val(bin->Getuselist()[1]->GetValue());
        genexp.set_hash(hash_right);
      }
    }
  } else if (auto gep = dynamic_cast<GetElementPtrInst *>(inst)) {
    int hash_inst = VN->LookupOrAdd(inst);
    if (!genexp.IsAlreadyInsert(hash_inst)) {
      genexp.insert_val(inst);
      genexp.set_hash(hash_inst);
    }
    Value *ArrayPtr = gep->Getuselist()[0]->GetValue();
    if (dynamic_cast<User *>(ArrayPtr)) {
      int hash_ptr = VN->LookupOrAdd(ArrayPtr);
      if (!genexp.IsAlreadyInsert(hash_ptr)) {
        genexp.insert_val(ArrayPtr);
        genexp.set_hash(hash_inst);
      }
    }
    //处理args vector
    for (int i = 1; i < gep->Getuselist().size(); i++) {
      Value *args = gep->Getuselist()[i]->GetValue();
      if (dynamic_cast<User *>(args)) {
        int hash_arg = VN->LookupOrAdd(args);
        if (!genexp.IsAlreadyInsert(hash_arg)) {
          genexp.insert_val(args);
          genexp.set_hash(hash_inst);
        }
      }
    }
  } else if (!inst->IsTerminateInst()) { /// @note 这里为什么会这样？
    VN->LookupOrAdd(inst);
    gentemp.insert_val(inst);
  }

  if (!inst->IsTerminateInst()) {
    int num = VN->LookupOrAdd(inst);
    if (!avail.IsAlreadyInsert(num)) {
      avail.insert_val(inst);
      avail.set_hash(num);
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
    Expression e = CreatExp(bin);
    // auto it = ExpNumber.find(e);
    auto it = std::find_if(
        ExpNumber.begin(), ExpNumber.end(),
        [&e](std::pair<Expression, int> &ele) { return ele.first == e; });
    if (it != ExpNumber.end()) {
      ValueNumber.insert(std::make_pair(val, it->second));
      return it->second;
    } else {
      ValueNumber.insert(std::make_pair(val, valuekinds));
      ExpNumber.push_back(std::make_pair(e, valuekinds));
      return valuekinds++;
    }
  } else if (auto gep = dynamic_cast<GetElementPtrInst *>(val)) {
    Expression e = CreatExp(gep);
    auto it = std::find_if(
        ExpNumber.begin(), ExpNumber.end(),
        [&e](std::pair<Expression, int> &ele) { return ele.first == e; });
    if (it != ExpNumber.end()) {
      ValueNumber.insert(std::make_pair(val, it->second));
      return it->second;
    } else {
      ValueNumber.insert(std::make_pair(val, valuekinds));
      ExpNumber.push_back(std::make_pair(e, valuekinds));
      return valuekinds++;
    }
  } else { //不是任何语句
    ValueNumber.insert(std::make_pair(val, valuekinds));
    return valuekinds++;
  }
}

//包含了binary和cmp
Expression ValueTable::CreatExp(BinaryInst *bin) {
  Expression e;
  e.firVal = LookupOrAdd(bin->Getuselist()[0]->GetValue());
  e.SecVal = LookupOrAdd(bin->Getuselist()[1]->GetValue());
  e.ThirdVal = 0;
  e.type = bin->GetType();
  e.op = static_cast<Expression::ExpOpration>(
      static_cast<int>(bin->getopration()));
  return e;
}

Expression ValueTable::CreatExp(GetElementPtrInst *gep) {
  Expression e;
  e.firVal = LookupOrAdd(gep->Getuselist()[0]->GetValue());
  e.SecVal = 0;
  e.ThirdVal = 0;
  e.op = Expression::Gep;
  e.type = gep->GetType();
  for (int i = 1; i < gep->Getuselist().size(); i++)
    e.args.emplace_back(gep->Getuselist()[i]->GetValue());
  return e;
}

void PRE::PostOrderCFG(BasicBlock *root) {
  if (root->visited)
    return;
  root->visited = true;
  for (int tmp : m_dom->GetNode(root->num).des) {
    PostOrderCFG(m_dom->GetNode(tmp).thisBlock);
  }
  PostOrder.push_back(root);
}

Value *PRE::phi_translate(BasicBlock *pred, BasicBlock *succ, Value *val) {
  //对于phi函数，返回来自pred块的数据流
  if (auto phi = dynamic_cast<PhiInst *>(val)) {
    if (phi->GetParent() == succ)
      return phi->ReturnValIn(pred);
  } else if (auto bin = dynamic_cast<BinaryInst *>(val)) {
    Value *op_1 = bin->Getuselist()[0]->GetValue();
    Value *op_2 = bin->Getuselist()[1]->GetValue();
    if (dynamic_cast<User *>(op_1))
      op_1 = phi_translate(pred, succ, op_1);
    if (dynamic_cast<User *>(op_2))
      op_2 = phi_translate(pred, succ, op_2);
    //如果操作数中出现phi函数，会将phi转换为对应的数据流，此时我们检查是否有转换
    if (op_1 != bin->Getuselist()[0]->GetValue() ||
        op_2 != bin->Getuselist()[1]->GetValue()) {
      BinaryInst *newbin = new BinaryInst(op_1, bin->getopration(), op_2);
      int hash = VN->LookupOrAdd(newbin);
      if (!AvailOut[pred].IsAlreadyInsert(hash)) {
        gen_exp.push_back(std::make_pair(newbin, false));
        return newbin;
      } else {
        VN->erase(newbin);
        newbin->ClearRelation();
        check(newbin);
        delete newbin;
        for (auto x = AvailOut[pred].contents.begin();
             x != AvailOut[pred].contents.end(); x++)
          if (hash == VN->LookupOrAdd(*x))
            return *x;
      }
    }
  } else if (auto gep = dynamic_cast<GetElementPtrInst *>(val)) {
    bool change = false;
    std::vector<Value *> args;
    Value *ptr = gep->Getuselist()[0]->GetValue();
    if (dynamic_cast<User *>(ptr))
      ptr = phi_translate(pred, succ, ptr);
    //接下来处理args
    for (int i = 1; i < gep->Getuselist().size(); i++) {
      Value *arg = gep->Getuselist()[i]->GetValue();
      if (dynamic_cast<User *>(arg))
        arg = phi_translate(pred, succ, arg);
      if (arg != gep->Getuselist()[i]->GetValue())
        change = true;
      args.push_back(arg);
    }

    if (ptr != gep->Getuselist()[0]->GetValue() || change) {
      GetElementPtrInst *newgep = new GetElementPtrInst(ptr, args);
      int hash = VN->LookupOrAdd(newgep);
      if (!AvailOut[pred].IsAlreadyInsert(hash)) {
        gen_exp.push_back(std::make_pair(newgep, false));
        return newgep;
      } else {
        VN->erase(newgep);
        delete newgep;
        for (auto x = AvailOut[pred].contents.begin();
             x != AvailOut[pred].contents.end(); x++)
          if (hash == VN->LookupOrAdd(*x))
            return *x;
      }
    }
  }

  return val;
}

void PRE::clean(ValueNumberedSet &val) {}

void PRE::BuidTopuSet(ValueNumberedSet &set) {
  TopuOrder.clear();
  std::set<Value *> visited;
  std::vector<Value *> topuSt;
  for (auto it = set.contents.begin(); it != set.contents.end(); it++) {
    //此处不能直接插入，还需要看他的操作数是否是inst，递归调用
    if (!visited.count(*it))
      topuSt.push_back(*it);
    while (!topuSt.empty()) {
      Value *val = topuSt.back();

      if (auto bin = dynamic_cast<BinaryInst *>(val)) {
        Value *op1 = bin->Getuselist()[0]->GetValue();
        Value *op2 = bin->Getuselist()[1]->GetValue();
        op1 = Find_Leader(set, op1);
        op2 = Find_Leader(set, op2);
        if (op1 != nullptr && dynamic_cast<User *>(op1) &&
            visited.count(op1) == 0)
          topuSt.push_back(op1);
        else if (op2 != nullptr && dynamic_cast<User *>(op2) &&
                 visited.count(op2) == 0)
          topuSt.push_back(op2);
        else { //来到边缘点，加入到topu排序栈
          TopuOrder.push_back(bin);
          visited.insert(bin);
          topuSt.pop_back();
        }
      } else if (auto gep = dynamic_cast<GetElementPtrInst *>(val)) {
        Value *ptr = gep->Getuselist()[0]->GetValue();
        ptr = Find_Leader(set, ptr);
        if (ptr != nullptr && dynamic_cast<User *>(ptr) &&
            visited.count(ptr) == 0)
          topuSt.push_back(ptr);
        else {
          bool chan = false;
          for (int i = 1; i < gep->Getuselist().size(); i++) {
            Value *arg = gep->Getuselist()[i]->GetValue();
            arg = Find_Leader(set, arg);
            if (arg != nullptr && dynamic_cast<User *>(arg) &&
                visited.count(arg) == 0) {
              chan = true;
              topuSt.push_back(arg);
            }
          }
          if (!chan) {
            TopuOrder.push_back(gep);
            visited.insert(gep);
            topuSt.pop_back();
          }
        }
      } else {
        TopuOrder.push_back(val);
        visited.insert(val);
        topuSt.pop_back();
      }
    }
  }
}

Value *PRE::Find_Leader(ValueNumberedSet &set, Value *val) {
  if (!set.IsAlreadyInsert(VN->LookupOrAdd(val)))
    return nullptr;
  int hash = VN->LookupOrAdd(val);
  for (auto tmp = set.contents.begin(); tmp != set.contents.end(); tmp++)
    if (hash == VN->LookupOrAdd(*tmp))
      return *tmp;
  assert(0 && "Unreachable");
}