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
    ADD,
    SUB,
    MUL,
    DIV,
    MOD,
    EQ,
    NEQ,
    GEP,
    AND,
    OR,
    GE,
    LE,
    G,
    L
  };

  std::vector<Value *> args;
  Type *type;
  //都是以valueNumer来表示
  int firVal;
  int SecVal;
  int ThirdVal;
  ExpOpration op;
};

struct ValueTable {
  std::map<Value *, int> ValueNumber;  // value* to hash number
  std::map<Expression, int> ExpNumber; // expression to hash number
  int valuekinds = 0;

  int LookupOrAdd();
};

struct ValueNumberedSet {
  std::map<int, int> Record;
  std::set<Value *> contents;
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
  PRE(dominance *dom, Function *func) : m_dom(dom), m_func(func) {
    BasicBlock* Entry=m_func->front();
    auto entrynode=&(m_dom->GetNode(Entry->num));
    m_func->init_visited_block();
    DfsDT(0);
  }
  

private:
  dominance *m_dom;
  Function *m_func;
  ValueTable *VN;
  std::map<BasicBlock*,ValueNumberedSet> AvailOut;
  std::map<BasicBlock*,ValueNumberedSet> AnticipatedIn;
  std::map<BasicBlock*,ValueNumberedSet> GeneratedPhis;
  std::vector<BasicBlock*> Dfs;
};

