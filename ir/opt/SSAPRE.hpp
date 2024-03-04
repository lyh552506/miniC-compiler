#pragma once
#include "GVN.hpp"
#include "IDF.hpp"
#include "dominant.hpp"

class PRE {
public:
  void phi_insertion();

  void init_pass();

  void set_var_phis();

  /// @brief 全局gvn，找到等价的occurance
  void gvn_walk();

  void caculateRPO(BasicBlock *bb);
  /// @brief 直接根据vn表查找是否有等价
  Value* Find_Equal(Value *val);
  /// @brief 寻找特别的等价
  Value* Find_Equal(BinaryInst *bin);

  PRE(dominance *dom, Function *func) : m_dom(dom), m_func(func) {}

private:
  dominance *m_dom;
  Function *m_func;
  std::vector<BasicBlock *> RPO;
  std::map<int,std::vector<Value *>> E_occurance;
  std::vector<std::pair<Value *, Value *>> ValueNumber;
  std::unordered_set<BasicBlock *> visited; // RPO下的辅助数据结构
  int exp_nums = 0;                         //记录一共有多少表达式
};