#pragma once
#include "dominant.hpp"
#include "passManagerBase.hpp"
class LoopInfo : public PassManagerBase {
public:
  LoopInfo(Function *func, dominance *dom)
      : dfs(func->GetBasicBlock().size()), low(func->GetBasicBlock().size()),
        m_func(func), m_dom(dom), Dest(m_dom->GetDest()),
        in_stack(func->GetBasicBlock().size()) {}

  void Find_SSC(int u);
  void setBBs() { bbs = m_func->GetBasicBlock(); }
  void FindLoopHeader(std::vector<int> &&tmp);
  // only for test
  void PrintPass();
  void RunOnFunction() {
    m_func->init_visited_block();
    setBBs();
    BasicBlock *entry = m_func->front();
    Find_SSC(entry->num);
    AlreadyGetInfo = true;
  }

private:
  Function *m_func;
  dominance *m_dom;
  std::vector<int> dfs;
  std::vector<int> low;
  std::vector<BasicBlock *> bbs; //提供num to bb map
  std::stack<int> st;
  std::vector<int> in_stack;
  std::vector<std::vector<int>> &Dest; // CFG中的后继
  std::vector<std::pair<int, std::vector<int>>> Loops;
  bool AlreadyGetInfo = false;
  int index = 0;
};