/*--------------------------------------------------------------------------------------------------
                                         GVN-PRE
the details can be found in "Value-Based Partial Redundancy Elimination" written
by Thomas VanDrunen and Antony L. Hosking
----------------------------------------------------------------------------------------------------*/
#pragma once
#include "GVN.hpp"
#include "IDF.hpp"
#include "dominant.hpp"

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
  // Expression();
};

struct ValueTable {
  std::map<Value *, int> ValueNumber;    // value* to kind number
  std::map<Expression *, int> ExpNumber; // expression to kind number
  int valuekinds = 0;

  int LookupOrAdd(Value *val);

  Expression *CreatExp(BinaryInst *bin);
  Expression *CreatExp(GetElementPtrInst *gep);
  Expression *CreatExp(CondInst *cond);
  Expression *CreatExp(UnCondInst *uncond);
  // Expression* CreatExp();
};

struct ValueNumberedSet {
  std::vector<int> Record; //判断是否插入
  std::set<Value *> contents;

  void insert_val(Value *val) { contents.insert(val); }
  void set(int hash) {
    if (Record.size() < hash)
      Record.resize(hash + 5);
    Record[hash] = 1;
  }
  bool IsAlreadyInsert(int hash) {
    if (Record.size() < hash)
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

  void CaculateAvailOut(User *inst, ValueNumberedSet &avail,
                        ValueNumberedSet &genexp, ValueNumberedSet &gentemp,
                        ValueNumberedSet &genphis);
  PRE(dominance *dom, Function *func) : m_dom(dom), m_func(func) {
    BasicBlock *Entry = m_func->front();
    auto entrynode = &(m_dom->GetNode(Entry->num));
    m_func->init_visited_block();
    DfsDT(0);
  }

private:
  dominance *m_dom;
  Function *m_func;
  ValueTable *VN;
  std::map<BasicBlock *, ValueNumberedSet> AvailOut;
  std::map<BasicBlock *, ValueNumberedSet> AnticipatedIn;
  std::map<BasicBlock *, ValueNumberedSet> GeneratedPhis;
  std::vector<BasicBlock *> Dfs;
  std::map<BasicBlock *, ValueNumberedSet> GeneratedExps;
  std::map<BasicBlock *, ValueNumberedSet> GeneratedTemp;
};
