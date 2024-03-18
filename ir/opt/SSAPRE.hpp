/*--------------------------------------------------------------------------------------------------
                                         GVN-PRE
the details can be found in "Value-Based Partial Redundancy Elimination" written
by Thomas VanDrunen and Antony L. Hosking
----------------------------------------------------------------------------------------------------*/
#pragma once
#include "GVN.hpp"
#include "IDF.hpp"
#include "dominant.hpp"

enum RetStats { Delay, Changed, Unchanged };

struct Expression {
  enum ExpOpration {
    Op_Add,
    Op_Sub,
    Op_Mul,
    Op_Div,
    Op_And,
    Op_Or,
    Op_Mod,
    Op_E,
    Op_NE,
    Op_GE,
    Op_L,
    Op_LE,
    Op_G,
    Gep
  };

  std::vector<Value *> args;
  Type *type;
  //都是以valueNumer来表示
  int firVal;
  int SecVal;
  int ThirdVal;
  ExpOpration op;

  Expression() = default;

  //因为后续使用find寻找相同的exp，这里需要增加一个判断两个exp是否相同
  bool operator==(Expression &other) {
    if (firVal != other.firVal)
      return false;
    if (SecVal != other.SecVal)
      return false;
    if (ThirdVal != other.ThirdVal)
      return false;
    if (type != other.type)
      return false;
    if (op != other.op)
      return false;
    if (args.size() != other.args.size())
      return false;
    for (int i = 0; i < args.size(); i++)
      if (args[i] != other.args[i])
        return false;
    return true;
  }
  // Expression();
};

struct ValueTable {
  std::map<Value *, int> ValueNumber; // value* to kind number
  std::vector<std::pair<Expression, int>>
      ExpNumber; // expression to kind number
  int valuekinds = 0;

  int LookupOrAdd(Value *val);
  void erase(Value *val) { ValueNumber.erase(val); }

  Expression CreatExp(BinaryInst *bin);
  Expression CreatExp(GetElementPtrInst *gep);
  void Add(Value *val) {
    if (ValueNumber.find(val) != ValueNumber.end())
      ValueNumber.erase(val);
    ValueNumber.insert(std::make_pair(val, LookupOrAdd(val)));
  }
  ValueTable() : ValueNumber{} {}
};

struct ValueNumberedSet {
  std::vector<int> Record; //判断是否插入
  std::set<Value *> contents;

  void insert_val(Value *val) { contents.insert(val); }
  void erase_val(Value *val) { contents.erase(val); }
  void set_hash(int hash) {
    if (Record.size() < hash+1)
      Record.resize(hash + 5);
    Record[hash] = 1;
  }
  void clear_hash(int hash) {
    if (Record.size() < hash+1)
      assert(0 && "hash can't bigger than Record size!");
    if (Record[hash] == 0)
      return;
    Record[hash] = 0;
  }

  void init() {
    Record.clear();
    contents.clear();
  }
  /// @brief return true if is inserted
  bool IsAlreadyInsert(int hash) {
    if (Record.size() < hash+1)
      return false;
    return Record[hash] == 0 ? false : true;
  }
};

class PRE {
public:
  void init_pass();
  /// @brief
  void BuildSets();
  /// @brief
  void Insert();
  /// @brief
  void Eliminate();
  /// @brief
  void DfsDT(int pos);
  void PostOrderCFG(BasicBlock *root);
  void BuidTopuSet(ValueNumberedSet &set);
  BasicBlock *GetChild(BasicBlock *BB, int flag);
  /// @brief 传入一个BasicBlock，统计他的所有前驱
  void CalculatePredBB(BasicBlock *bb);
  RetStats
  IdentyPartilRedundancy(BasicBlock *cur,
                         std::map<BasicBlock *, ValueNumberedSet> &insert_set);
  void
  FixPartialRedundancy(BasicBlock *cur,
                       std::map<BasicBlock *, Value *> &predAvail,
                       std::map<BasicBlock *, ValueNumberedSet> &insert_set);
  void CalculateAvailOut(User *inst, ValueNumberedSet &avail,
                         ValueNumberedSet &genexp, ValueNumberedSet &gentemp,
                         ValueNumberedSet &genphis);
  RetStats CalculateAnticIn(BasicBlock *bb, ValueNumberedSet &AnticOut,
                            std::set<BasicBlock *> &visited,
                            ValueNumberedSet &genexp);
  RetStats CalculateAnticOut(BasicBlock *bb, ValueNumberedSet &AnticOut,
                             std::set<BasicBlock *> &visited);
  Value *phi_translate(BasicBlock *pred, BasicBlock *succ, Value *val);
  void clean(ValueNumberedSet &val);
  //在一个set中找到val的leader
  Value *Find_Leader(ValueNumberedSet &set, Value *val);

  PRE(dominance *dom, Function *func) : m_dom(dom), m_func(func) {
    BasicBlock *Entry = m_func->front();
    VN = new ValueTable();
    auto entrynode = &(m_dom->GetNode(Entry->num));
    m_func->init_visited_block();
    DfsDT(0);
    m_func->init_visited_block();
    PostOrderCFG(m_func->front());
    init_pass();
    std::cout << "--------pre--------" << std::endl;
    Singleton<Module>().Test();
  }

private:
  dominance *m_dom;
  Function *m_func;
  ValueTable *VN;
  std::map<BasicBlock *, ValueNumberedSet> AvailOut;
  std::map<BasicBlock *, ValueNumberedSet> AnticipatedIn;
  std::map<BasicBlock *, ValueNumberedSet> GeneratedPhis;
  std::vector<BasicBlock *> Dfs; //记录深度遍历支配树信息
  std::vector<BasicBlock *> PostOrder;
  std::vector<Value *> TopuOrder;
  std::vector<BasicBlock *> Preds;
  std::vector<Value *> gen_exp; //原来的block中没有，属于是自己创建的exp
  std::map<BasicBlock *, ValueNumberedSet> GeneratedTemp;
};
